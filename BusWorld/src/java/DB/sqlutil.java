package DB;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;

public class sqlutil {
    
   public static String dbunm="abc";
   public  static String dbpass="abc";
    public static String dbname="BMS";
    public static String url="jdbc:mysql://localhost:3306/bms";    
    public static Connection conn=null;
    public static Statement stmt=null;
    
        static  int i=0;
    public static void connect()
            
    {
       
        try
        {
        Class.forName("com.mysql.jdbc.Driver");
        conn=DriverManager.getConnection(url,dbunm,dbpass);
            System.out.println(++i);
        stmt=conn.createStatement();
        
         
    }
        catch(Exception ex)
        {
            System.out.println(ex);
        }
        
        }
        
      
       
    }

    
   

