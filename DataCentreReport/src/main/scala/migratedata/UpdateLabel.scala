package migratedata

import config.MySqlConfig

object UpdateLabel {
  def main(args: Array[String]): Unit = {
    val config = MySqlConfig("tdb", 3306, "xf", "xiefei", _driver = "com.mysql.cj.jdbc.Driver")

  }

}
