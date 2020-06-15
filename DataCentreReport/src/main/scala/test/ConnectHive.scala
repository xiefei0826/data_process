package test

import org.apache.spark.SparkConf
import org.apache.spark.sql.SparkSession

object ConnectHive {

  def main(args: Array[String]): Unit = {

    val warehousePath = "hdfs://ld1:8020/warehouse/tablespace/managed/hive"
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


    spark.sql("show databases").collect().foreach(f => println(f.getString(0)))
  }

}
