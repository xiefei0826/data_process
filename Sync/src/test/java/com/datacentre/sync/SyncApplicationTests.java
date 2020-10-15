package com.datacentre.sync;

import com.alibaba.fastjson.JSON;
import com.datacentre.sync.common.ElasticSearchHelper;
import com.datacentre.sync.common.MySqlHelper;
import com.datacentre.sync.config.ElasticSearchConfig;
import com.datacentre.sync.config.MySqlConfig;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

@SpringBootTest
class SyncApplicationTests {

	@Autowired
	private MySqlConfig mySqlConfig;
	@Autowired
	private ElasticSearchConfig elasticSearchConfig;
	@Test
	void contextLoads() {
		var tableName="CacheItem";
		var mysql=new MySqlHelper(mySqlConfig.getDriver(),mySqlConfig.getDbName(),mySqlConfig.getPort(),mySqlConfig.getHost(),mySqlConfig.getUser(),mySqlConfig.getPassword());

		System.out.println(JSON.toJSONString(mysql.GetSyncInfo()));
		mysql.GetInitBinlog();
		var es=new ElasticSearchHelper(elasticSearchConfig.getHost(),elasticSearchConfig.getPort(),elasticSearchConfig.getMode());
//		es.CreateIndex(mysql.getColumnInfos(),tableName.toLowerCase());
//		es.InsertOrUpdate(tableName.toLowerCase(),mysql.GetTableData(0,10));

//		es.DeleteData(tableName.toLowerCase(),"1");

		System.out.println(es.ExistIndex(tableName.toLowerCase()));
	}

}
