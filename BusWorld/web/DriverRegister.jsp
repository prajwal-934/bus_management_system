<%@page import="DB.sqlutil"%>
<%
    
    String Name=request.getParameter("Name");
    String userid=request.getParameter("userid");
    String phone=request.getParameter("phone");
    
    String password=request.getParameter("password");
    
     
   sqlutil.connect();
   String qry="INSERT INTO `driver`(`name`, `userid`,`phone` ,`password`) VALUES ('"+Name+"','"+userid+"','"+phone+"','"+password+"')";
   sqlutil.stmt.executeUpdate(qry);
  
   out.print("<script>alert('Inserted');</script>");
   response.sendRedirect("Driver.jsp");
   %>