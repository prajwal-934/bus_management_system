



<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>
<!DOCTYPE html>
<%! ResultSet rs = null;%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Student</title>

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
                padding: 5px;
            }

            .order-card i {
                font-size: 26px;

            }

            .jumbotron{
                background: #f7f7f7;
                padding: 1rem 1rem;
            }
            @media (min-width: 576px)
            {
                .jumbotron {
                    padding: 1rem 1rem;}
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
                <a class="navbar-brand" href="index.jsp">
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
        <div class="jumbotron">
            <h1 class="text-center">Student</h1>      

        </div>

        <div class="container ">
            <div class="row mt-5">
                <div class="col-sm-3">
                    <div class="card bg-c-blue order-card "  data-toggle="modal" data-target="#exampleModal">
                        <div class="card-block">
                            <%
                                sqlutil.connect();
                                rs = sqlutil.stmt.executeQuery("SELECT COUNT(*) FROM student where isverified='false'");
                                rs.next();
                            %>

                            <h2 id="unverify" class="m-b-20 text-center">Unverfied : <%=rs.getString(1)%></h2>



                        </div>
                    </div>
                </div>
                <div class="col-sm-4" style="margin-left: auto!important;">

                    <div class="form-inline">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" onkeyup="myFunction()" id="myInput">
                        <button class="btn btn-outline-success my-2 my-sm-0" >Search</button>
                    </div>

                </div>
            </div>

            <h2>List of all verified Students</h2>
            <table class="table mt-5" id="myTable">
                <thead class="thead-light">
                    <tr>
                        <th scope="col">S.no</th>
                        <th scope="col">Name</th>
                        <th scope="col">email</th>
                        <th scope="col">rollno</th>
                        <th scope="col">Remove</th>

                    </tr>
                </thead>
                <tbody><%
                    rs = sqlutil.stmt.executeQuery("SELECT * FROM student where isverified='true'");
                    int sno = 0;
                    if (rs != null) {
                        while (rs.next()) {%>
                    <tr>


                        <th scope="row"><%=++sno%></th>
                        <td><%=rs.getString(2)%></td>
                        <td><%=rs.getString(3)%></td>
                        <td><%=rs.getString(6)%></td>
                        <td><button type="button" class="btn btn-danger" value="<%=rs.getString(6)%>" onclick="SomeDeleteRowFunction(this)">Delete</button></td>

                    </tr>
                    <%   }

                        }
                    %>
                </tbody>
            </table>






        </div>








        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Unverified Student</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <table class="table" id="tbl">
                            <thead class="thead-light">
                                <tr>
                                    <th scope="col">S.no</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">email</th>
                                    <th scope="col">rollno</th>
                                    <th scope="col">Decision</th>

                                </tr>
                            </thead>
                            <tbody><%
                                rs = sqlutil.stmt.executeQuery("SELECT * FROM student where isverified='false'");
                                sno = 0;
                                if (rs != null) {
                                    while (rs.next()) {%>
                                <tr>


                                    <th scope="row"><%=++sno%></th>
                                    <td><%=rs.getString(2)%></td>
                                    <td><%=rs.getString(3)%></td>
                                    <td><%=rs.getString(6)%></td>
                                    <td><button type="button" class="btn btn-success" value="<%=rs.getString(6)%>" onclick="AcceptRowFunction(this)">Accept</button> <button type="button" class="btn btn-danger" value="<%=rs.getString(6)%>" onclick="SomeDeleteRowFunction(this)">Reject</button></td>

                                </tr>
                                <%   }

                                    }
                                %>
                            </tbody>
                        </table>
                    </div>

                </div>
            </div>
        </div>













        <script>
            function SomeDeleteRowFunction(o) {
//no clue what to put here?

                var p = o.parentNode.parentNode;
                p.parentNode.removeChild(p);
                 $.ajax({

                            url: "verifystudent.jsp",
                            method: "POST",
                            data: {rollno1: o.value},
                            success: function (data)
                            {
                                //alert('rejected');

                            }
                        });
                             
          
            }
              function AcceptRowFunction(o) {
//no clue what to put here?

                var p = o.parentNode.parentNode;
                p.parentNode.removeChild(p);
                 $.ajax({

                            url: "acceptstudent.jsp",
                            method: "POST",
                            data: {rollno: o.value},
                            success: function (data)
                            {
                              //  alert('accepted');

                            }
                        });
          
            }
        </script>
        
        <script>
function myFunction() {
  // Declare variables
  var input, filter, table, tr, td, i, txtValue;
  input = document.getElementById("myInput");
  filter = input.value.toUpperCase();
  table = document.getElementById("myTable");
  tr = table.getElementsByTagName("tr");

  // Loop through all table rows, and hide those who don't match the search query
  for (i = 0; i < tr.length; i++) {
    td = tr[i].getElementsByTagName("td")[0];
    if (td) {
      txtValue = td.textContent || td.innerText;
      if (txtValue.toUpperCase().indexOf(filter) > -1) {
        tr[i].style.display = "";
      } else {
        tr[i].style.display = "none";
      }
    }
  }
}
</script>
        
        
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

<!--SELECT
  *
FROM bus_table
full OUTER JOIN routes
  ON bus_table.route_id = routes.route_id
full outer JOIN driver
  ON driver.busno = bus_table.busno-->
<!SELECT * FROM bus_table LEFT JOIN routes ON bus_table.route_id = routes.route_id UNION SELECT * FROM bus_table RIGHT JOIN routes ON bus_table.route_id = routes.route_id