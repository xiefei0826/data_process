package com.datacentre.sync.model;

import java.sql.Timestamp;

public class SyncMySqlToEs {

    private long Id;
    private String TableName;
    private long Skip;
    private int Take;
    private byte Status;

    public byte getIsInit() {
        return IsInit;
    }

    public void setIsInit(byte isInit) {
        IsInit = isInit;
    }

    private byte IsInit;

    public long getId() {
        return Id;
    }

    public void setId(long id) {
        Id = id;
    }

    public String getTableName() {
        return TableName;
    }

    public void setTableName(String tableName) {
        TableName = tableName;
    }

    public long getSkip() {
        return Skip;
    }

    public void setSkip(long skip) {
        Skip = skip;
    }

    public int getTake() {
        return Take;
    }

    public void setTake(int take) {
        Take = take;
    }

    public byte getStatus() {
        return Status;
    }

    public void setStatus(byte status) {
        Status = status;
    }
}
