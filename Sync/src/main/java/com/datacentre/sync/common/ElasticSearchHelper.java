package com.datacentre.sync.common;

import com.alibaba.fastjson.JSON;
import com.datacentre.sync.model.ColumnInfo;
import org.apache.http.HttpHost;
import org.elasticsearch.action.admin.indices.delete.DeleteIndexRequest;
import org.elasticsearch.action.bulk.BulkRequest;
import org.elasticsearch.action.bulk.BulkRequestBuilder;
import org.elasticsearch.action.delete.DeleteRequest;
import org.elasticsearch.action.get.GetRequest;
import org.elasticsearch.action.index.IndexRequest;
import org.elasticsearch.client.Client;
import org.elasticsearch.client.RequestOptions;
import org.elasticsearch.client.RestClient;
import org.elasticsearch.client.RestHighLevelClient;
import org.elasticsearch.client.indices.CreateIndexRequest;
import org.elasticsearch.client.indices.CreateIndexResponse;
import org.elasticsearch.client.indices.GetIndexRequest;
import org.elasticsearch.common.settings.Settings;
import org.elasticsearch.common.xcontent.XContentType;
import org.elasticsearch.index.query.BoolQueryBuilder;
import org.elasticsearch.index.query.TermQueryBuilder;
import org.elasticsearch.index.reindex.DeleteByQueryRequest;
import org.springframework.context.annotation.Configuration;
import org.yaml.snakeyaml.events.Event;

import java.io.IOException;
import java.util.Dictionary;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ElasticSearchHelper {

    private String Host;
    private int Port;
    private String Mode;

    public ElasticSearchHelper(String host, int port, String mode) {
        Host = host;
        Port = port;
        Mode = mode;
    }


    public void CreateIndex(List<ColumnInfo> columnInfos, String indexName) {

        var restClient = CreateConnect();

        CreateIndexRequest createIndexRequest = new CreateIndexRequest(indexName);
        createIndexRequest.settings(Settings.builder().put("index.number_of_shards", 3).put("index.number_of_replicas", 2));


        Map<String, Object> properties = new HashMap<>();
        columnInfos.forEach(f -> {
            Map<String, Object> type = new HashMap<>();

            switch (f.getColumnType()) {
                case "varchar":
                case "char":
                case "text":
                    type.put("type", "keyword");
                    break;
                case "bigint":
                    type.put("type", "long");
                    break;
                case "int":
                case "tinyint":
                    type.put("type", "integer");
                    break;
                case "timestamp":
                case "datetime":
                    type.put("type", "date");
                    break;
            }

            properties.put(f.getColumnName(), type);

        });
        Map<String, Object> mapping = new HashMap<>();
        mapping.put("properties", properties);
        createIndexRequest.mapping(mapping);
        try {
            CreateIndexResponse createIndexResponse = restClient.indices().create(createIndexRequest, RequestOptions.DEFAULT);

        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
        CloseConnect(restClient);
    }

    public void InsertOrUpdateData(String index, List<Dictionary<String, Object>> documents) {

        var restClient = CreateConnect();
        BulkRequest bulkRequest = new BulkRequest();

        documents.forEach(f -> {
            IndexRequest indexRequest = new IndexRequest();
            indexRequest.index(index);
            indexRequest.id(f.get("Id").toString());
            indexRequest.source(JSON.toJSONString(f), XContentType.JSON);
            bulkRequest.add(indexRequest);
        });
        try {
            restClient.bulk(bulkRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
        CloseConnect(restClient);
    }

    public void DeleteData(String index, String id) {
        var restClient = CreateConnect();
        DeleteRequest deleteRequest = new DeleteRequest();
        deleteRequest.index(index);
        deleteRequest.id(id);

        try {
            restClient.delete(deleteRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }

        CloseConnect(restClient);
    }

    public void DeleteData(String index) {
        var restClient = CreateConnect();
        DeleteByQueryRequest deleteRequest = new DeleteByQueryRequest(index);

        deleteRequest.setQuery(new TermQueryBuilder("Status", "0"));

        try {
            restClient.deleteByQuery(deleteRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }

        CloseConnect(restClient);
    }

    public boolean ExistIndex(String index) {
        var restClient = CreateConnect();
        GetIndexRequest getRequest = new GetIndexRequest(index);
        boolean value = false;
        try {
            value = restClient.indices().exists(getRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
        CloseConnect(restClient);
        return value;
    }

    public void DeleteIndex(String index) {
        var restClient = CreateConnect();
        DeleteIndexRequest getRequest = new DeleteIndexRequest(index);
        try {
            restClient.indices().delete(getRequest, RequestOptions.DEFAULT);
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
        CloseConnect(restClient);
    }


    private RestHighLevelClient CreateConnect() {
        return new RestHighLevelClient(RestClient.builder(new HttpHost(Host, Port, Mode)));
    }

    private static String toLowerCaseFirstOne(String s) {
        if (Character.isLowerCase(s.charAt(0)))
            return s;
        else
            return (new StringBuilder()).append(Character.toLowerCase(s.charAt(0))).append(s.substring(1)).toString();
    }

    private void CloseConnect(RestHighLevelClient restClient) {
        try {
            restClient.close();
        } catch (IOException e) {
            e.printStackTrace();
            System.exit(1);
        }
    }
}
