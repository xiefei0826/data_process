package com.datacentre.sync.common;

import com.datacentre.sync.model.ColumnInfo;
import com.datacentre.sync.model.SyncMySqlToEs;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Dictionary;
import java.util.Hashtable;
import java.util.List;
import java.util.stream.Collectors;

public class MySqlHelper {

    private String Url;
    private String User;
    private String Password;
    private String DbName;
    private String Driver;


    private MySqlHelper() {

    }

    public MySqlHelper(String driver, String dbName, int port, String host, String user, String password) {
        Url = "jdbc:mysql://" + host + ":" + port + "/" + dbName;
        User = user;
        Password = password;
        DbName = dbName;
        Driver = driver;

    }

    private Connection CreateConnect() {
        try {
            Class.forName(Driver);
            return DriverManager.getConnection(Url, User, Password);
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
            System.exit(1);
        }
        return null;
    }

    private void CloseConnect(Connection conn) {
        try {
            conn.close();
        } catch (SQLException throwables) {
            throwables.printStackTrace();
            System.exit(1);
        }
    }


    public List<ColumnInfo> ReadMySqlColumns(String tableName) {

        var conn = CreateConnect();
        List<ColumnInfo> list = new ArrayList<>();
        try {

            var stmt = conn.createStatement();
            String sql = "select  COLUMN_NAME,ORDINAL_POSITION,DATA_TYPE from information_schema.COLUMNS where TABLE_SCHEMA='DataCentre' and TABLE_NAME='" + tableName + "' order by  ORDINAL_POSITION asc;";
            var rs = stmt.executeQuery(sql);


            while (rs.next()) {
                var columnInfo = new ColumnInfo();
                columnInfo.setColumnName(rs.getString(1));
                columnInfo.setIndex(rs.getInt(2));
                columnInfo.setColumnType(rs.getString(3));
                list.add(columnInfo);
            }

            rs.close();
            stmt.close();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.exit(1);
        }

        CloseConnect(conn);
        return list;
    }

    private String GetTableQuerySql(String tableName, long skip, int take) {
        var str = new StringBuilder("select ");
        var names = ReadMySqlColumns(tableName).stream().map(m -> m.getColumnName()).collect(Collectors.joining(","));

        str.append(names);
        str.append(" from  ");
        str.append(DbName + "." + tableName);
        str.append(" Order By UpdateTime asc,  Id asc ");
        str.append("  limit " + skip + "," + take);

        return str.toString();
    }

    public String GetInitBinlog() {
        var conn = CreateConnect();
        var sql = "show binary logs ;";
        var fileName = "";
        try {

            var stmt = conn.createStatement();
            var rs = stmt.executeQuery(sql);


            while (rs.next()) {
                fileName = rs.getString(1);
                break;
            }

            rs.close();
            stmt.close();

        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.exit(1);
        }
        if (fileName.isEmpty())
            System.out.println("no binlog");
        System.out.println(fileName);
        CloseConnect(conn);
        return fileName;
    }

    public List<Dictionary<String, Object>> GetTableData(String tableName, long skip, int take) {
        var conn = CreateConnect();
        var sql = GetTableQuerySql(tableName, skip, take);
        List<Dictionary<String, Object>> list = new ArrayList<>();
        try {
            var stmt = conn.createStatement();

            var rs = stmt.executeQuery(sql);

            while (rs.next()) {
                Dictionary<String, Object> dic = new Hashtable<>();
                ReadMySqlColumns(tableName).forEach(f -> {
                    try {
                        dic.put(f.getColumnName(), rs.getObject(f.getIndex()));
                    } catch (SQLException throwables) {
                        throwables.printStackTrace();
                        System.exit(1);
                    }
                });
                list.add(dic);
            }

            rs.close();
            stmt.close();


        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.exit(1);
        }
        CloseConnect(conn);
        return list;
    }

    public List<SyncMySqlToEs> GetSyncInfo() {
        var sql = "SELECT * FROM DataProcess.SyncMySqlToEs;";
        List<SyncMySqlToEs> list = new ArrayList<>();
        var conn = CreateConnect();
        try {
            var stmt = conn.createStatement();

            var rs = stmt.executeQuery(sql);

            while (rs.next()) {
                SyncMySqlToEs syncMySqlToEs = new SyncMySqlToEs();

                try {
                    syncMySqlToEs.setId(rs.getLong("Id"));
                    syncMySqlToEs.setTableName(rs.getString("TableName"));
                    syncMySqlToEs.setSkip(rs.getLong("Skip"));
                    syncMySqlToEs.setTake(rs.getInt("Take"));
                    syncMySqlToEs.setStatus(rs.getByte("Status"));
                    syncMySqlToEs.setIsInit(rs.getByte("IsInit"));
                } catch (SQLException throwables) {
                    throwables.printStackTrace();
                    System.exit(1);
                }
                list.add(syncMySqlToEs);
            }

            rs.close();
            stmt.close();


        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.exit(1);
        }
        CloseConnect(conn);
        return list;
    }


    public void UpdateSyncInfo(long id, long count) {
        var sql = "update  DataProcess.SyncMySqlToEs set Skip=Skip+" + count + " where Id=" + id;
        sql(sql);
    }

    public void UpdateInitStatus(long id) {
        var sql = "update  DataProcess.SyncMySqlToEs set IsInit=1,Skip=0 where Id=" + id;
        sql(sql);
    }

    private void sql(String sql) {
        var conn = CreateConnect();
        try {
            var stmt = conn.createStatement();
            stmt.executeUpdate(sql);
            stmt.close();
        } catch (SQLException throwable) {
            throwable.printStackTrace();
            System.exit(1);
        }
        CloseConnect(conn);
    }

}
