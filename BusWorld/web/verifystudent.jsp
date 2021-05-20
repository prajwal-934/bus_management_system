<%@page import="DB.sqlutil"%>
<%
    sqlutil.connect();
sqlutil.stmt.executeUpdate("DELETE FROM `student` WHERE `student`.rollno='"+request.getParameter("rollno1")+"'");
System.out.println(request.getParameter("rollno1"));
%>