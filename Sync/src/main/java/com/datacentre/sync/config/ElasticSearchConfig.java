package com.datacentre.sync.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class ElasticSearchConfig {

    @Value("${sync.es.host}")
    private String Host;

    @Value("${sync.es.port}")
    private int Port;

    public String getMode() {
        return Mode;
    }

    @Value("${sync.es.mode}")
    private String Mode;
    public String getHost() {
        return Host;
    }

    public int getPort() {
        return Port;
    }
}
