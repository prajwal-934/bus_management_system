<%@page import="DB.sqlutil"%>
<%
    sqlutil.connect();
sqlutil.stmt.executeUpdate("DELETE FROM `bus_table` WHERE `bus_table`.`busno`='"+request.getParameter("busno") +"'");

%>