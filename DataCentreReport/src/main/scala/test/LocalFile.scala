package test

import org.apache.spark.{SparkConf, SparkContext}

object LocalFile {

  def main(args: Array[String]): Unit = {
    val logFile = "hdfs://ld1:8020/datacentre/datacentre/cacheitem/part-r-00000"
    val conf = new SparkConf().setAppName("ambari-agent")
      .setMaster("local[2]")
      .set("spark.executor.memory", "1g");
    val sc = new SparkContext(conf)
    val logData = sc.textFile(logFile, 2)
    val numAs = logData.filter(line => line.contains("You")).foreach((str: String) => {
      println(str.split('\u0001').foreach(f => println(f)))
    })
    val numBs = logData.filter(line => line.contains("1")).count()

    println("Lines with a: %s, Lines with b: %s".format(numAs, numBs))
  }

}
