<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>

<%
    sqlutil.connect();
   String id = request.getParameter("routeid");
   String stops = request.getParameter("stops");
   String qry="UPDATE `routes` SET `all_stops` = '"+stops+"' WHERE `routes`.`route_id` = "+id+"";

sqlutil.stmt.executeUpdate(qry);
  response.sendRedirect("routes.jsp");
%>

