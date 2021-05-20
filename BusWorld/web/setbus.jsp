



<%@page import="java.sql.ResultSet"%>
<%@page import="DB.sqlutil"%>
<!DOCTYPE html>

<%! ResultSet rs = null;%><%! ResultSet rs1 = null;%><%! ResultSet rs2 = null;%>
<html>
    <head>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
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

            .bg-green{
                color:green!important;
            }

            .bg-red{
                color:red;
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
            <h1 class="text-center">Set Buses</h1>      

        </div>

        <div class="container ">
            <div class="row mt-5">
                <div class="col-sm-3">

                </div>
                <div class="col-sm-4" style="margin-left: auto!important;">

                    <div class="form-inline">
                        <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search" onkeyup="myFunction()" id="myInput">
                        <button class="btn btn-outline-success my-2 my-sm-0" >Search</button>
                    </div>

                </div>
            </div>


            <table class="table mt-5" id="myTable">
                <thead class="thead-light">
                    <tr>
                        <th scope="col">S.no</th>
                        <th scope="col">Bus no</th>
                        <th scope="col">Drivers</th>
                        <th scope="col">Routes</th>
                        <th scope="col">Status</th>

                    </tr>
                </thead>
                <tbody><%
                    sqlutil.connect();
                    rs = sqlutil.conn.createStatement().executeQuery("SELECT busno FROM bus_table order by busno");
                    int sno = 0;
                    int ids = 0;

                    String assigned = "**";
                    if (rs != null) {
                        while (rs.next()) {
                            int i = 0;%>
                    <tr>


                        <th scope="row"><%=++sno%></th>
                        <td  style="width:10%;"><%=rs.getString(1)%></td>
                        <td style="width:20%;" > <select name="criteriaRound[]"  id="driverselect" class="custom-select myinput selectRound"  > 
                                <option  value="" class="bg-red">Unassigned</option>
                                <%
                                    
                                    rs1 = sqlutil.conn.createStatement().executeQuery("select name , userid from driver");
                                    
                                    rs2 = sqlutil.conn.createStatement().executeQuery("select name from driver where busno='" + rs.getString(1) + "'");
                                    if (rs2.next()) {
                                        assigned = rs2.getString(1);

                                    } else {
                                        assigned = "**";
                                    }
                                    while (rs1.next()) {
                                        if (assigned.equals(rs1.getString(1))) {
                                            out.print("<option selected class='' value='" + rs1.getString(2) + "' >" + rs1.getString(1) + "</option>");
                                            i++;
                                        } else {
                                            out.print("<option class='' value='" + rs1.getString(2) + "' >" + rs1.getString(1) + "</option>");

                                        }
                                    }

                                %>

                            </select></td>
                        <td> <select name="criteriaRound[]" id="routeselect" class="custom-select myinput " > 
                                <option class='bg-red'  value="">Unassigned</option>
                                <%                                   
                                    rs1 = sqlutil.conn.createStatement().executeQuery("select all_stops , route_id from routes");
                                    rs2 = sqlutil.conn.createStatement().executeQuery("SELECT r.all_stops FROM bus_table b , routes r WHERE b.busno = '" + rs.getString(1) + "' and r.route_id = b.route_id");
                                    if (rs2.next()) {
                                        assigned = rs2.getString(1);

                                    } else {
                                        assigned = "**";
                                    }
                                    while (rs1.next()) {
                                        if (assigned.equals(rs1.getString(1))) {
                                            out.print("<option selected class='' value='" + rs1.getString(2) + "'>" + rs1.getString(1) + "</option>");
                                            i++;
                                        } else {
                                            out.print("<option class='' value='" + rs1.getString(2) + "'>" + rs1.getString(1) + "</option>");

                                        }
                                    }

                                %>

                            </select></td>
                        <td>
                            <%                                if (i == 2) {
                                    out.print("<i id=" + ids + " class='fa fa-circle bg-green'></i>");
                                    ids++;
                                } else {
                                    out.print("<i id=" + ids + " class='fa fa-circle bg-red'></i>");
                                    ids++;
                                }

                            %>
                        </td>

                    </tr>
                    <%  i = 0;
                            }

                        }
                            sqlutil.conn.close();
                    %>
                </tbody>
            </table>


            <button class="btn btn-success float-right mr-5 mt-5" onclick="showTableData()">Save Changes</button>
            <p style="width: 20%;" id="info" class="pt-5"></p>


        </div>




















        <script type="text/javascript">
            console.clear();
            var selectors = '.myinput';
            $('#myTable').on('change', selectors, function (event) {
                var $this = $(event.currentTarget),
                        $row = $this.closest('tr'),
                        $elements = $row.find(selectors);
                var $filledElements = $elements.filter(function (index) {
                    console.log($(this).val())
                    return $(this).val() || this.checked;
                });
                var hasEmpty = $filledElements.length !== $elements.length
                var rowIndex = $row.index();
                // $('#results').append("Row:" + rowIndex + " has " + $filledElements.length + ' of ' + $elements.length + ' and shows ' + hasEmpty + '<br />');
                if ($filledElements.length == 2)
                {
                    console.log('true');
                    $('#' + rowIndex).addClass('bg-green');

                } else
                {
                    $('#' + rowIndex).removeClass('bg-green');
                }
            });


            var selectors = '.myinput';
            $('#myTable').on('change', selectors, function (event) {
                var $this = $(event.currentTarget),
                        $row = $this.closest('tr'),
                        $elements = $row.find(selectors);
                var $filledElements = $elements.filter(function (index) {
                    //      console.log($(this).val())
                    return $(this).val() || this.checked;
                });
                var hasEmpty = $filledElements.length !== $elements.length
                var rowIndex = $row.index();
                // $('#results').append("Row:" + rowIndex + " has " + $filledElements.length + ' of ' + $elements.length + ' and shows ' + hasEmpty + '<br />');
                if ($filledElements.length == 2)
                {
                    //    console.log('true');
                    $('#' + rowIndex).addClass('bg-green');
                } else
                {
                    $('#' + rowIndex).removeClass('bg-green');
                    $('#' + rowIndex).addClass('bg-red');
                }
            });
        </script>

        <script>
            $(document).on('change', '.selectRound', function (e) {
                var tralse = true;
                var selectRound_arr = []; // for contestant name
                $('.selectRound').each(function (k, v) {
                    var getVal = $(v).val();
                    //alert(getVal);
                    if (getVal && $.trim(selectRound_arr.indexOf(getVal)) != -1) {
                        tralse = false;
                        //it should be if value 1 = value 1 then alert, and not those if -select- = -select-. how to avoid those -select-
                        alert('Drivers with same name is not possible');
                        $(v).val("");
                        return false;
                    } else {
                        selectRound_arr.push($(v).val());
                    }

                });
                if (!tralse) {
                    return false;
                }
            });
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


        <script>
            function showTableData() {
                document.getElementById('info').innerHTML = "";
                var myTab = document.getElementById('myTable');
                var multiSelect = document.getElementById('driverselect');
                var bus, driver, route;
                // LOOP THROUGH EACH ROW OF THE TABLE AFTER HEADER.
                for (i = 1; i < myTab.rows.length; i++) {

                    // GET THE CELLS COLLECTION OF THE CURRENT ROW.
                    var objCells = myTab.rows.item(i).cells;

                    // LOOP THROUGH EACH CELL OF THE CURENT ROW TO READ CELL VALUES.
                    for (var j = 1; j < objCells.length - 1; j++) {
                        if (j == 1)
                            bus = objCells.item(j).innerHTML;
                        else if (j == 2) {

                            driver = objCells.item(j).childNodes[1].value;

                        } else {
                            route = objCells.item(j).childNodes[1].value;

                        }




                    }
                    console.log(bus, driver, route);
                    $.ajax({

                        url: "saveindb.jsp",
                        method: "POST",
                        data: {bus: bus, driver: driver, route: route},
                        success: function (data)
                        {

                        }
                    });
                    info.innerHTML = info.innerHTML + '<br />';     // ADD A BREAK (TAG).
                }
                  $("#info").html("<div class='alert alert-success'>Successfully Updated</div>");
               setTimeout(() => window.location.reload(), 2000);

            }



        </script>






        <!--javascripts-->
        <script
            src="https://code.jquery.com/jquery-3.4.1.min.js"
            integrity="sha256-CSXorXvZcTkaix6Yvo6HppcZGetbYMGWSFlBw8HfCJo="
        crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>


    </body>
</html>
