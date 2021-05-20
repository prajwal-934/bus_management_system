



<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>
<%! ResultSet rs = null;%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Admin Dashboard</title>

        <!--css-->
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">

        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <style>
            .primary-background{
                background:#1c044d!important;
            }
            .box{
                border-radius: 0px;
            }

            .card {
               
                transition: transform .2s; /* Animation */
            
            }

            .card:hover {
                transform: scale(1.1); /* (150% zoom - Note: if the zoom is too large, it will go outside of the viewport) */
            }
            body{
   
    background:#f7f7f7;
}
.order-card {
    color: #fff;
}

.bg-c-blue {
    background: linear-gradient(45deg,#1c044d,#2c88f3);
}

.bg-c-green {
    background: linear-gradient(45deg,#1c044d,#2c88f3);
}

.bg-c-yellow {
    background: linear-gradient(45deg,#1c044d,#2c88f3);
}

.bg-c-pink {
    background: linear-gradient(45deg,#1c044d,#2c88f3);
}

.nav-color{
	background: #202677;
}

.card {
    border-radius: 5px;
    -webkit-box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
    box-shadow: 0 1px 2.94px 0.06px rgba(4,26,55,0.16);
    border: none;
    margin-bottom: 30px;
    -webkit-transition: all 0.3s ease-in-out;
    transition: all 0.3s ease-in-out;
}

.card .card-block {
    padding: 25px;
}

.order-card i {
    font-size: 26px;
}

.jumbotron{
	background: #f7f7f7;
}
.font-size{
	font-size: 24px;
}


        </style>

    </head>
    <body> 

   <!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark nav-color static-top">
  <div class="container">
    <a class="navbar-brand" href="#">
         <span style="font-size: 30px;font-family: cursive;">BusWorld</span>
        </a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
          <span class="navbar-toggler-icon"></span>
        </button>
    <div class="collapse navbar-collapse" id="navbarResponsive">
      <ul class="navbar-nav ml-auto font-size">
        <li class="nav-item active">
          <a class="nav-link" href="#">Home
                <span class="sr-only">(current)</span>
              </a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">About</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Services</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="#">Contact</a>
        </li>
      </ul>
    </div>
  </div>
</nav>


        
<div class="container-fluid">
  <div class="jumbotron">
    <h1 class="text-center">Admin Dashboard</h1>      
    
  </div>
     
</div>

        <!--//cards-->






<!-- card View -->
<link href="https://maxcdn.bootstrapcdn.com/font-awesome/4.3.0/css/font-awesome.min.css" rel="stylesheet">
<div class="container">
		<div class="row">
		       
        
        <div class="col-sm-6" >
            <div onclick="location.href='setbus.jsp'" class="card bg-c-yellow order-card">
                <div class="card-block">
                    <h2 class="m-b-20">SET BUSES</h2>
                     <br>
                     <%
                     sqlutil.connect();
                     rs=sqlutil.conn.createStatement().executeQuery("SELECT COUNT(*) FROM `bus_table` WHERE `isactive` = 'true'");
                     
                     rs.next();
                     %>
                       <h5 class="text-right"><span>Active Buses : <%=rs.getString(1)%></span></h5>
                       <%
                       rs=sqlutil.conn.createStatement().executeQuery("SELECT COUNT(b.busno) FROM bus_table b WHERE not EXISTS (SELECT d.busno from driver d WHERE b.busno = d.busno)");
                       rs.next();
                       %>
                    <h5 class="text-right"><span>Unassigned Buses : <%=rs.getString(1)%></span></h5>
                    
                </div>
            </div>
        </div>

        <div class="col-sm-6">
            <div onclick="location.href='student.jsp'" class="card bg-c-green order-card">
                <div class="card-block">
                    <h2 class="">STUDENT</h2>
                     <br>
                      <%
                       rs=sqlutil.conn.createStatement().executeQuery("SELECT COUNT(*) FROM student where isverified='true'");
                       rs.next();
                       %>
                    <h5 class="text-right"><span>Verified Student : <%=rs.getString(1)%></span></h5>
                     <%
                       rs=sqlutil.conn.createStatement().executeQuery("SELECT COUNT(*) FROM student where isverified='false'");
                       rs.next();
                       %>
                    <h5 class="text-right"><span>Unverified Student : <%=rs.getString(1)%></span></h5>


                   
                </div>
            </div>
        </div>
	</div>
    <div class="row">
        <div class="col-sm-4">
            <div class="card bg-c-blue order-card " onclick="location.href='Driver.jsp'">
                <div class="card-block">
                <h2 class="m-b-20">DRIVER</h2>
                 <br>
                 <%
                       rs=sqlutil.conn.createStatement().executeQuery("SELECT count(*) FROM `driver`");
                       rs.next();
                       %>
                       <h5 class="text-right"><span> Total Drivers : <%=rs.getString(1)%></span></h5>
                       
                    
                </div>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div onclick="location.href='Bus.jsp'" class="card bg-c-green order-card">
                <div class="card-block">
               				<h2 class="m-b-20">BUS</h2>
               				 <br> <%
                       rs=sqlutil.conn.createStatement().executeQuery("SELECT count(*) FROM `bus_table`");
                       rs.next();
                       %>
                       <h5 class="text-right"><span> Total Buses : <%=rs.getString(1)%></span></h5>
                        
                </div>
            </div>
        </div>
        
        <div class="col-sm-4">
            <div onclick="location.href='routes.jsp'" class="card bg-c-yellow order-card">
                <div class="card-block">
              
                  	<h2 class="m-b-20">ROUTES</h2>
                  	 <br>
                          <%
                       rs=sqlutil.conn.createStatement().executeQuery("SELECT count(*) FROM routes");
                       rs.next();
                       %>
                       <h5 class="text-right"><span> Total Routes : <%=rs.getString(1)%></span></h5>
                       
                </div>
            </div>
        </div>
        
    
	</div>

</div>













        <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
        <script src="js/myjs.js" type="text/javascript"></script>

    </body>
</html>
