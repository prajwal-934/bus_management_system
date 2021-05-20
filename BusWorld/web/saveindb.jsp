<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>

<%
    sqlutil.connect();
    String bus = request.getParameter("bus");
    String driver = request.getParameter("driver");
    String route = request.getParameter("route");
    String qry = "UPDATE `driver` d,bus_table b,routes r SET d.busno='" + bus + "',b.route_id='" + route + "' WHERE b.busno='" + bus + "' AND d.userid='" + driver + "'";
    String qry1=null;
    if (driver.equals("") && route.equals("")) {
        qry = "UPDATE driver d SET d.busno=null WHERE d.busno='" + bus + "'";
         qry1 = "UPDATE bus_table b SET b.route_id=null WHERE b.busno='" + bus + "'";
        sqlutil.stmt.executeUpdate(qry1);
    } else if (driver.equals("")) {
        qry1="UPDATE `driver` SET busno=null WHERE busno='"+bus+"'";
        qry = "UPDATE bus_table SET route_id='" + route + "' WHERE busno='" + bus + "'";
        sqlutil.stmt.executeUpdate(qry1);
    } else if (route.equals("")) {
        qry1="UPDATE `driver`SET busno='" + bus + "' WHERE userid='" + driver + "'";
        qry = "UPDATE bus_table SET route_id=null WHERE busno='" + bus + "'";
        sqlutil.stmt.executeUpdate(qry1);
    }
    System.out.println(qry+"\t"+qry1);
    sqlutil.stmt.executeUpdate(qry);
    out.print("sucess");
   
   
%>

