package com.datacentre.sync;

import com.datacentre.sync.common.ElasticSearchHelper;
import com.datacentre.sync.common.MySqlHelper;
import com.datacentre.sync.config.ElasticSearchConfig;
import com.datacentre.sync.config.MySqlConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.stereotype.Component;

import java.math.BigInteger;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

@Component
public class MySqlToEs {

    private final MySqlConfig mySqlConfig;
    private final ElasticSearchConfig elasticSearchConfig;

    public MySqlToEs(MySqlConfig mySqlConfig, ElasticSearchConfig elasticSearchConfig) {
        this.mySqlConfig = mySqlConfig;
        this.elasticSearchConfig = elasticSearchConfig;
    }

    @Bean
    public void Work() {

        ExecutorService singleThreadExecutor = Executors.newSingleThreadExecutor();
        singleThreadExecutor.execute(() -> {
                    while (true) {

                        var mysql = new MySqlHelper(mySqlConfig.getDriver(), mySqlConfig.getDbName(), mySqlConfig.getPort(), mySqlConfig.getHost(), mySqlConfig.getUser(), mySqlConfig.getPassword());

                        var syncInfos = mysql.GetSyncInfo();
                        List<ExecutorService> threadPool = new ArrayList<>();
                        syncInfos.forEach(f -> {
                            ExecutorService workThread = Executors.newSingleThreadExecutor();

                            workThread.execute(() -> {
                                if (f.getStatus() != 1) {
                                    workThread.shutdown();
                                    try {
                                        Thread.sleep(100);
                                    } catch (InterruptedException e) {
                                        e.printStackTrace();
                                    }
                                    return;
                                }

                                var es = new ElasticSearchHelper(elasticSearchConfig.getHost(), elasticSearchConfig.getPort(), elasticSearchConfig.getMode());

                                if (f.getIsInit() == 0) {
                                    if (es.ExistIndex(f.getTableName().toLowerCase()))
                                        es.DeleteIndex(f.getTableName().toLowerCase());
                                    es.CreateIndex(mysql.ReadMySqlColumns(f.getTableName()), f.getTableName().toLowerCase());
                                    mysql.UpdateInitStatus(f.getId());
                                    f.setLastTime(0);
                                    f.setIsInit((byte) 1);
                                } else if (f.getIsInit() == 1) {
                                    if (!es.ExistIndex(f.getTableName().toLowerCase()))
                                        es.CreateIndex(mysql.ReadMySqlColumns(f.getTableName()), f.getTableName().toLowerCase());
                                }
                                var tableData = mysql.GetTableData(f.getTableName(), f.getLastTime(), f.getTake(),f.getLastId());
                                if (tableData.stream().count() == 0) {
                                    workThread.shutdown();
                                    return;
                                }


                                es.InsertOrUpdateData(f.getTableName().toLowerCase(), tableData);


                                var lastTime = ((Timestamp) tableData.get((int) tableData.stream().count() - 1).get("updateTime")).getTime();
                                var lastId = ((BigInteger) tableData.get((int) tableData.stream().count() - 1).get("id")).longValue();
                                mysql.UpdateSyncInfo(f.getId(), lastTime,lastId);
                                es.DeleteData(f.getTableName().toLowerCase());
                                workThread.shutdown();
                            });
                            threadPool.add(workThread);

                        });
                        threadPool.forEach(thread -> {

                            while (true) {
                                if (thread.isShutdown()) {
                                    break;
                                }
                                try {
                                    Thread.sleep(50);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                        });
                        try {
                            Thread.sleep(100);
                        } catch (InterruptedException e) {
                            e.printStackTrace();
                        }
                    }
                }
        );


    }
}
