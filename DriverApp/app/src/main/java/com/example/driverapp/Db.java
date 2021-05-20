package com.example.driverapp;

import android.os.StrictMode;
import android.util.Log;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class Db {

    private static Connection conn;
    private static Statement st;
    private static final String DBURL="jdbc:mysql://192.168.43.46:3306/BMS";
    private static final String DBUSER="abc";
    private static final String DBPASS="abc";

    public static void connectDB()
    {
        try {
            StrictMode.ThreadPolicy policy=new StrictMode.ThreadPolicy.Builder().permitAll().build();
            StrictMode.setThreadPolicy(policy);
            Class.forName("com.mysql.jdbc.Driver");
            conn = DriverManager.getConnection(DBURL, DBUSER, DBPASS);
            st = conn.createStatement();
        }
        catch (Exception e)
        {
            Log.i("serrrrrrrrrrrrrrrrrrrrr","yeeeeeeeeeeeeeeeeeeeeeee");
        }
    }


    public static void fireqry(String query)  {
        try {
            connectDB();
            st.executeUpdate(query);

            st.close();
            conn.close();
        }
        catch (Exception e)
        {

        }
    }
    public static ResultSet read(String query) throws  Exception {
        ResultSet rs=null;

            connectDB();
            rs = st.executeQuery(query);



        return rs;
    }
}
