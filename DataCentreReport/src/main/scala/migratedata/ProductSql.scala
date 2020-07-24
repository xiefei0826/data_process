package migratedata

import scala.collection.mutable.{ListBuffer, Map}

object ProductSql {



  def main(args: Array[String]): Unit = {
    var LabelMap: Map[String, ListBuffer[String]] = Map()
    val list = ListBuffer("石油天然气", "化工", "电力能源", "建筑", "冶金", "地矿", "环保", "市政路桥")

    list.foreach(f=>println(f))
    LabelMap += ("国际工程版" -> list)

    LabelMap += ("轻工纺织版" -> ListBuffer("农林牧渔", "食品", "服装皮革", "材料", "家具", "造纸印刷"))


    LabelMap.foreach(f => println(f._1))


  }
}
