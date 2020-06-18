package report

import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession

object WordBookDetailReport {

  def main(args: Array[String]): Unit = {

    val warehousePath = "hdfs://s2:8020/warehouse/tablespace/managed/hive"
    val conf = new SparkConf().setMaster("local")
    val spark = SparkSession.builder()
      .appName("Hive Example")
      .config("spark.sql.warehouse.dir", warehousePath)
      .config("hive.metastore.uris", "thrift://s5:9083")
      .config(conf)
      //      .config("spark.master","yarn")
      .config("metastore.catalog.default", "hive")
      .config("spark.sql.hive.hiveserver2.jdbc.url", "jdbc:hive2://ld1:2181,s3:2181,s4:2181/;serviceDiscoveryMode=zooKeeper;zooKeeperNamespace=hiveserver2")
      .enableHiveSupport()
      .getOrCreate()


    spark.sql( "select a.Id,a.ConsumeTotalCount,b.ConsumeTotalCount from DataCentre.FileLib as a  , (SELECT FileLibId,sum(ConsumeWordsCount) as ConsumeTotalCount FROM DataCentre.FileItem GROUP BY  FileLibId)b\nwhere a.Id=b.FileLibId and a.ConsumeTotalCount<>b.ConsumeTotalCount ").show()
  }
}
