<%@page import="DB.sqlutil"%>
<%
    sqlutil.connect();
sqlutil.stmt.executeUpdate("DELETE FROM `driver` WHERE `driver`.userid='"+request.getParameter("userid")+"'");
System.out.println(request.getParameter("rollno1"));
%>