package com.datacentre.sync.model;

public class SyncMySqlToEs {

    private long Id;
    private String TableName;
    private long LastTime;
    private int Take;
    private byte Status;

    public long getLastId() {
        return LastId;
    }

    public void setLastId(long lastId) {
        LastId = lastId;
    }

    private long LastId;

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

    public long getLastTime() {
        return LastTime;
    }

    public void setLastTime(long lastTime) {
        LastTime = lastTime;
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
