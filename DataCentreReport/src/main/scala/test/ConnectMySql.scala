package test

import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession

object ConnectMySql {
  def main(args: Array[String]): Unit = {
//    Class.forName("com.mysql.jdbc.Driver").newInstance

    val warehousePath = "/tmp/mysql"
    val conf = new SparkConf().setMaster("local")
    val spark = SparkSession
      .builder()
      .appName("MySql Example")
      .config("spark.sql.warehouse.dir", warehousePath)
      .config(conf)
      //      .config("spark.master","yarn")
      .getOrCreate()

    val data = spark.read
      .format("jdbc")
      .option("driver", "com.mysql.cj.jdbc.Driver")
      .option("url", "jdbc:mysql://192.168.0.243:3306/DataCentre")
      .option("user", "xf")
        .option("password", "xiefei")
          .option("dbtable", " (select * from CacheItem limit 1 ) tmp")
          .load()
//        .load().sqlContext.sql("show databases")
    data.show()
//    data.sqlContext.sql("select * from CacheItem limit 1 ").show()

//    data.createGlobalTempView("ontime")



//    data.collect().foreach(f=>println(f.getString(0)))
  }

}
