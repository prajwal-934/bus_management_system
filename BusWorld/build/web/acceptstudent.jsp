<%@page import="DB.sqlutil"%>
<%
    sqlutil.connect();
sqlutil.stmt.executeUpdate("UPDATE `student` SET `isverified` = 'true' WHERE `student`.rollno ='" + request.getParameter("rollno") + "'");
%>