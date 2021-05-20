<%@page import="DB.sqlutil"%>
<%
    
    String stops=request.getParameter("stops");
  
   
     
   sqlutil.connect();
   String qry="INSERT INTO `routes` (`all_stops`) VALUES ('"+stops+"');";
   sqlutil.stmt.executeUpdate(qry);
  
   out.print("<script>alert('Inserted');</script>");
   response.sendRedirect("routes.jsp");
   %>