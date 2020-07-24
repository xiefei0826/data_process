package sqoop

import java.sql.{Connection, DriverManager}

import scala.collection.immutable
import scala.collection.immutable.List
import scala.collection.mutable.{ListBuffer, Map}


object GetSqoopScript {
  val host = "backdb"
  val port = "3306"
  val userName = "xf"
  val password = "xiefei"
  val driver = "com.mysql.cj.jdbc.Driver"
  val hdfsHost = "hdfs://s2:8020"
  val needDbInfo = immutable.Map("BaseData" -> List("WordsBook", "SystemUser", "AppUser"), "DataCentre" -> List("FileItem", "FileLib", "FileType", "Label", "LanguageType", "MemoryItem", "MemoryLabel", "MemoryLib"))


  def main(args: Array[String]): Unit = {

    val baseUrl = "jdbc:mysql://" + host + ":" + port + "/"


    var queryResult: Map[String, Map[String, ListBuffer[String]]] = Map()

    var connection: Connection=null
    needDbInfo.foreach(f = daName => {
      try {
        val url = baseUrl + daName._1
        Class.forName(driver)
        connection = DriverManager.getConnection(url, userName, password)
        val statement = connection.createStatement
        val sql = "select  TABLE_NAME,COLUMN_NAME from information_schema.COLUMNS where TABLE_SCHEMA ='" + daName._1 + "' and TABLE_NAME in (" + daName._2.mkString("'", "','", "'") + ") order by  ORDINAL_POSITION asc;"
        val result = statement.executeQuery(sql);

        var tableInfo: Map[String, ListBuffer[String]] = Map()
        while (result.next()) {

          val tableName = result.getString("TABLE_NAME")
          var columnName = result.getString("COLUMN_NAME")
          if (!tableInfo.keys.exists(f => f.equals(tableName))) {
            tableInfo += (tableName -> ListBuffer())
          }
          tableInfo.foreach(f => {
            if (f._1.equals(tableName))
              f._2 += columnName;
          })
        }

        queryResult += (daName._1 -> tableInfo)
      }
      catch {
        case e => e.printStackTrace()
      }
      finally {
        connection.close()
      }
    })


    var CreateHiveTableStr = ""
    //    组装sqoop job str
    queryResult.foreach(db => {
      //      创建hive数据库
      CreateHiveTableStr += "hive -e \"  create database if not exists  " + db._1.toLowerCase() + " \" >>create-table-info.log 2>&1 \n"
      db._2.foreach(table => {
        //        创建hive表
        CreateHiveTableStr += "sqoop-import --connect 'jdbc:mysql://" +
          host + ":" +
          port + "/" +
          db._1 + "?characterEncoding%3dutf8mb4' -e \'select " +
          table._2.mkString(",") + " from " +
          table._1 + " where Id <1 and  $CONDITIONS  \' --hive-import --as-parquetfile --create-hive-table --hive-database " +
          db._1.toLowerCase() + " --hive-table " +
          table._1.toLowerCase() + " --incremental append --check-column UpdateTime --target-dir '/datacentre/" +
          db._1.toLowerCase() +
          "/" +
          table._1.toLowerCase() + "' --password '" +
          password + "' --username '" +
          userName + "' --split-by 'Id' --merge-key 'Id' >>create-table-info.log 2>&1 \n "

        //        修改hive存储地址
        CreateHiveTableStr += "hive -e \"ALTER TABLE " +
          db._1.toLowerCase() + "." +
          table._1.toLowerCase() + " SET LOCATION '" + hdfsHost + "/datacentre/" + db._1 + "/" + table._1 + "';\" >>create-table-info.log 2>&1 \n"

        // 创建任务
        CreateHiveTableStr += "sqoop-job --create " +
          db._1.toLowerCase() + "." + table._1.toLowerCase() + " -- import --connect 'jdbc:mysql://" +
          host + ":" +
          port + "/" +
          db._1 + "?characterEncoding%3dutf8mb4' --as-parquetfile  -e ' select " +
          table._2.mkString(",") + " from " + table._1 + " WHERE $CONDITIONS ' -m 10 --password " +
          password + " --username " +
          userName + " --split-by Id --merge-key Id --check-column UpdateTime --incremental lastmodified --target-dir '/datacentre/" +
          db._1 + "/" +
          table._1 + "' --fields-terminated-by '\\0001' --lines-terminated-by '\\n' --last-value '1970-01-01 00:00:01.0' >>create-table-info.log 2>&1 \n"
        //        删除java文件
        CreateHiveTableStr += "rm -f ./*.java \n"
      })
    })
    println(CreateHiveTableStr)
  }
}
