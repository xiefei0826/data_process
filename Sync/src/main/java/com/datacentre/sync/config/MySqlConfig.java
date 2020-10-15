package com.datacentre.sync.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class MySqlConfig {
    @Value("${sync.mysql.host}")
    private String Host;
    @Value("${sync.mysql.port}")
    private int Port;

    @Value("${sync.mysql.db}")
    private String DbName;

    @Value("${sync.mysql.user}")
    private String User;
    @Value("${sync.mysql.password}")
    private String Password;

    @Value("${sync.mysql.driver}")
    private String Driver;

    public String getHost() {
        return Host;
    }

    public int getPort() {
        return Port;
    }

    public String getDbName() {
        return DbName;
    }

    public String getUser() {
        return User;
    }

    public String getPassword() {
        return Password;
    }

    public String getDriver() {
        return Driver;
    }
}
