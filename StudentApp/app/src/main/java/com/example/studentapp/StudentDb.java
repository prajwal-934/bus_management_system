package com.example.studentapp;

import android.os.StrictMode;
import android.util.Log;
import android.widget.Toast;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;

public class StudentDb {
    private static Connection conn;
    public static Statement st;
    private static final String DBURL="jdbc:mysql://192.168.43.46:3306/bms";
    private static final String DBUSER="abc";
    private static final String  DBPASS="abc";
    public static boolean is_server_on = false;





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
            is_server_on = true;
        }
    }

   public static boolean checkDBstatus()
   {
       boolean check = false;
       try {
           StrictMode.ThreadPolicy policy=new StrictMode.ThreadPolicy.Builder().permitAll().build();
           StrictMode.setThreadPolicy(policy);
           Class.forName("com.mysql.jdbc.Driver");
           conn = DriverManager.getConnection(DBURL, DBUSER, DBPASS);
           st = conn.createStatement();
           check =true;
       }
       catch (Exception e)
       {
        e.printStackTrace();
        return  check;
       }
       return check;
   }

    public static int insertStudent(String name , String email , String password, String roll)  {
        int check = 0;
        try {
            connectDB();
            String qry ="INSERT INTO `student`( `name`, `email`, `password`,rollno) VALUES ('"+name+"' , '"+email+"' , '"+password+"', '"+roll+"')";
            check = st.executeUpdate(qry);
            Log.i("checkDB",Integer.toString(check));
            st.close();
            conn.close();
        }
        catch (Exception e)
        {
            Log.i("ex" , e.getMessage());

        }
        return  check;
    }




//    public static String checkPasswor(String email , String password)
//    {
//        String id = null;
//        try {
//            connectDB();
//            String qry ="";
//            ResultSet rs = st.executeQuery(qry);
////            Log.i("rs",Boolean.toString(rs.next()));
//             if(rs.next()) {
//                 id = Integer.toString(rs.getInt("id"));
//             }
//            Log.i("checkDB",id);
//            st.close();
//            conn.close();
//        }
//        catch (Exception e)
//        {
//            Log.i("ex" , e.getMessage());
//
//        }
//        return id;
//    }


    public static ResultSet read(String query) throws  Exception {

        ResultSet rs=null;
        try {
            connectDB();
            rs = st.executeQuery(query);
        }catch (Exception e)
        {
            Log.i("","server are off2");
        }


        return rs;
    }






}
