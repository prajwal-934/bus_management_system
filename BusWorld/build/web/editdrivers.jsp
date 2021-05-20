<%@page import="DB.sqlutil"%>
<%
    
    String Name=request.getParameter("Name");
    String userid=request.getParameter("userid");
    String phone=request.getParameter("phone");
    
    String password=request.getParameter("password");
    
     
   sqlutil.connect();
   String qry="UPDATE `driver` SET `name`='"+Name+"',`password`='"+password+"',`phone`='"+phone+"' WHERE userid='"+userid+"'";
   sqlutil.stmt.executeUpdate(qry);
  

   response.sendRedirect("Driver.jsp");
   %>