<%@page import="DB.sqlutil"%>
<%
    
    String busno=request.getParameter("busno");
   
   
     
   sqlutil.connect();
   String qry="INSERT INTO `bus_table` (`busno`) VALUES ('"+busno+"')";
   sqlutil.stmt.executeUpdate(qry);
  
   out.print("<script>alert('Inserted');</script>");
   response.sendRedirect("Bus.jsp");
   %>