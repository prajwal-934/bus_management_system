

<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>
<!DOCTYPE html><%!ResultSet rs = null;%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Routes</title>

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
            <h1 class="text-center">Routes</h1>      

        </div>

        <div class="container ">
            <div class="row mt-5">
                <div class="col-sm-3">
                    <div class="card bg-c-blue order-card "  data-toggle="modal" data-target="#exampleModal">
                        <div class="card-block">
                            <h2 class="m-b-20 text-center">Add Routes</h2>



                        </div>
                    </div>
                </div>
                <div class="col-sm-4" style="margin-left: auto!important;">

                    <form class="form-inline">
                        <input class="form-control mr-sm-2 " id="myInput" onkeyup="myFunction()" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
                    </form>

                </div>
            </div>

            <h2>List of all Routes</h2>
            <table class="table mt-5 " id="myTable">
                <thead class="thead-light">
                    <tr>
                        <th scope="col">S.no</th>
                        <th scope="col">Route Id</th>

                        <th scope="col">All Stops</th>

                        <th scope="col">Update</th>

                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <%       sqlutil.connect();
                            rs = sqlutil.stmt.executeQuery("SELECT * FROM routes");
                            int sno = 0;
               if (rs != null) {
                   while (rs.next()) {%>
                        <th scope="row"><%=++sno%></th>
                        <td id="routeid"  > <%=rs.getString(1)%></td>

                        <td><%=rs.getString(2)%></td>

                        <td><button type="button" class="btn btn-success" value="<%=rs.getString(1)%>;<%=rs.getString(2)%>" onclick="EditFunction(this)" data-toggle="modal" data-target="#profile-modal">Edit</button></td>

                    </tr>
                    <%   }

                        }
                    %>
                </tbody>
            </table>






        </div>



        <!--edit Modal -->
        <div class="modal fade" id="profile-modal" tabindex="-1" role="dialog" aria-labelledby="profile-modal" aria-hidden="true">
            <div class="modal-dialog modal-dialog-scrollable" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="profile-modalTitle">Edit Your Details</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form role="form" action="updateroutes.jsp" method="post">
                            <div class="form-group">
                                    <label for="rid"> Route ID</label>
                                    <input type="name" class="form-control" name="routeid" id="rid" readonly>

                                </div>
                            <div class="form-group">
                                <label for="feedback"> All Stops</label>
                                <textarea class="form-control" style="resize: none" name="stops" id="stops" rows="7"></textarea>  
                            </div>



                            <button type="submit" class="btn btn-default mt-5"><b>Submit</b></button>
                        </form>

                    </div>



                </div>
            </div>
        </div>




        <!-- Modal -->







        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header">
                        <h2 style="text-align: center;"><b>ADD Routes</b></h2>
                        <button type="button" class="close" data-dismiss="modal">&times;</button>

                    </div>
                    <div class="modal-body">
                        <form role="form" action="addroutes.jsp" method="post">
                            <div class="form-group">
                                <label for="feedback"> All Stops</label>
                                <textarea class="form-control" style="resize: none" name="stops" id="feedback" rows="7"></textarea>  
                            </div>



                            <button type="submit" class="btn btn-default mt-5"><b>Submit</b></button>
                        </form>
                    </div>
                </div>

            </div>
        </div>

        <script>
                  function EditFunction(o) {
                //no clue what to put here?

                var value = o.value;
                var details = value.split(";");
                
                $("#rid").val(details[0]);
                $("#stops").val(details[1]);
//                setTimeout(function() {  showalert(value);}, 200);
                

            }
            
                    function myFunction() {
                // Declare variables
                var input, filter, table, tr, td, i, txtValue;
                input = document.getElementById("myInput");
                filter = input.value.toUpperCase();
                table = document.getElementById("myTable");
                tr = table.getElementsByTagName("tr");

                // Loop through all table rows, and hide those who don't match the search query
                for (i = 0; i < tr.length; i++) {
                    td = tr[i].getElementsByTagName("td")[1];
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
