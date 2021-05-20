<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>
<%!ResultSet rs=null;%>
<%
    sqlutil.connect();
    String userid = request.getParameter("userid");
rs = sqlutil.stmt.executeQuery("select * from driver where userid='"+userid+"'");
rs.next();
%>
 <%=rs.getString(2)%>,<%=rs.getString(6)%>,<%=rs.getString(4)%>
 <%
 System.out.println(rs.getString(2));
 %>