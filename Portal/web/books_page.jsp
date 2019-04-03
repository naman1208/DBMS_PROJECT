<%-- 
    Document   : teacher
    Created on : Mar 3, 2019, 11:59:07 PM
    Author     : DELL
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
    
    Class.forName("com.mysql.jdbc.Driver");
    Connection c = DriverManager.getConnection("jdbc:mysql://localhost:3306/portal", "root", ""); 
    PreparedStatement ps,front;
    ResultSet rs,rs2;
    int no=0;
    String p="",q="",r="";
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid");
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    front=c.prepareStatement("select * from Teacher where TID='"+tid+"'");
    rs = front.executeQuery();
    ps=c.prepareStatement("select * from Books where TID='"+tid+"' order by Year asc;");
    rs2 = ps.executeQuery();
    
    rs2 = ps.executeQuery();
    String site = "teacher.jsp?tid="+tid;
    
%>    
<!DOCTYPE html>

    <html>

        <head>
            <meta charset="utf-8">
            <meta name="viewport" content="width=device-width, initial-scale=1">  

            
            <script type="text/javascript" src="js/modernizr-1.5.min.js"></script>
            <script type="text/javascript" src="js/jquery.js"></script>
            <script type="text/javascript" src="js/jquery.easing-sooper.js"></script>
            <script type="text/javascript" src="js/jquery.sooperfish.js"></script>
            <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
            <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
            <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
            
            
            <style>
                
                #sidebar_container {
                    float: left;
                    width: 234px;
                    margin-top: 0px;
                  margin-right: 20px;
                  }
                  
                .sidebar {
                    width: 230px;
                    height:450px;
                    margin: 0 0 16px 0;
                    background: white;
                    border: 1px solid #CCC;
                    border-radius: 7px 7px 0px 0px;
                    -moz-border-radius: 7px 7px 7px 7px;
                    -webkit-border: 7px 7px 7px 7px;
                    padding: 0 15px 5px 13px;
                    margin-left: 10px;
                  }
                
                .content {
                  text-align: left;
                  width: 800px;
                  margin: 0 0 15px 0;
                  float: left;
                  border: 1px solid #CCC;
                  border-radius: 7px 7px 0px 0px;
                  font-size: 120%;
                  padding: 14px 0 0 20px;
                }
                
                #site_content {
                    width: 1100px;
                    overflow: hidden;
                    margin: 0px auto 0 auto;
                    padding: 15px 0 25px 0;
                    text-shadow: 0 1px #FFF;
                  }
                table, th, td {
                    border: 1px solid black;
                    padding: 15px;
                    text-align: center;
                }
                
                table {
                    background-color: #f1f1c1;
                    border-spacing: 5px;
                }
              

                
            </style>
        </head>
        <body>
            
            
            <div class ="container">
            <img src="Images/Banner.jpg" width="100%"><hr>
            <header>
            <nav class="navbar navbar-default">
                <div id="menu_container" class="container-fluid">
                  <ul  id="nav" class="nav navbar-nav sf-menu">
                    <li ><a href=teacher.jsp?tid=<%=tid%>>Basics</a></li>
                    <li><a href=awardsnachievements.jsp?tid=<%=tid%>>Awards and Achievements</a></li>
                    <li ><a class="active dropdown-toggle" data-toggle="dropdown">Publications
                        <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href=books_page.jsp?tid=<%=tid%> onclick="show('books')">Books</a></li>
                        <li><a href=chapters_page.jsp?tid=<%=tid%> onclick="show('chapters')">Books Chapter</a></li>
                        <li><a href=journals_page.jsp?tid=<%=tid%> onclick="show('journal')">Journal Papers</a></li>
                        <li><a href=conferences_page.jsp?tid=<%=tid%> onclick="show('confrence')">Conference Proceedings</a></li>
                    </ul>
                    </li>
                    <li><a class="active dropdown-toggle" data-toggle="dropdown">Thesis Supervised
                        <span class="caret"></span></a></a>
                     <ul class="dropdown-menu">
                        <li><a href=phd_page.jsp?tid=<%=tid%> >Ph.D</a></li>
                        <li><a href=mtech_page.jsp?tid=<%=tid%>>M.Tech</a>
                           </li>

                      </ul>	
                    </li>
                    <li><a href=workshop.jsp?tid=<%=tid%>>Workshops</a></li>
                    <li><a href=courses_page.jsp?tid=<%=tid%>>Courses</a></li>
                    <li ><a href=invited_talk.jsp?tid=<%=tid%>>Invited Talk</a></li>
                    <% if(tid!="null"){ %>
                    
                    <li style="float:right;"><a href="logout.jsp">Logout</a></li>
                    <li style="float:right;"><a href=books.jsp?tid=<%=tid%>>Add new</a></li>
                    
                    <% } %>
                  </ul>


                </div>
            </nav>
            </header>
            <% while(rs.next()) { %>
            <div id="site_content">
                 <div  id="sidebar_container">
                     <div class="sidebar" >
                         <center>
                    <img src="Images/I1.jpg" width="190px" height="180px" align="left">
                    <h10><%= rs.getString(2) %></h10>
                    <br>
                    <h12><%= rs.getString(5) %></h12></br>
                    <a href="http://mnnit.ac.in/index.php/department/engineering/csed">Department of Computer Science &amp; Engineering</a>
                    <h4><a href="http://www.mnnit.ac.in">Motilal Nehru National Institute of Technology</a></h4>
                    Allahabad-211004, India
                    </br>
                    <%=rs.getString(3)%></br>

                    </br>
                    Telephone: <%= rs.getString(4) %></br>
                    <a href="shashankprofile.pdf" target="_blank">view full cv</a></center>
                    <right><a href=basics.jsp?tid=<%=tid%> target="_blank">Edit</a></right>
                    </div>
                 </div>
            <% } %>
                    
                <div class="content"> 
                    <h2>Books Published</h2>
                    <% if (rs2.next() == false) { %>
                    <h5>Click Add new to update details </h5> <%} else { %>
                    <table style="width: 98%;"> 
                        <caption>Sorted by Year</caption>
                    <tr>
                        <th>S.No.</th>
                        <th>Title</th> 
                        <th>Co Author</th>
                        <th>Publisher</th>
                        <th>ISBN No.</th>
                        <th>Year</th>
                    </tr>
                    <% do{ no++; %>
                    
                    <tr>
                        <td><%= no %></td>
                        <td><%= rs2.getString(2) %></td> 
                        <td><%= rs2.getString(3) %></td>
                        <td><%= rs2.getString(6) %></td>
                        <td><%= rs2.getString(5) %></td>
                        <td><%= rs2.getString(4) %></td>
                    </tr>
                    
                    </br>
                    <% }while(rs2.next()); }%>       
                    </table>        
                 </div>
            </div>
            </div>
        <script type="text/javascript">
          $(document).ready(function() {
            $('ul.sf-menu').sooperfish();
            $('.top').click(function() {$('html, body').animate({scrollTop:0}, 'fast'); return false;});
          });
        </script>

        <script>
        function show(p)
        {
        if(document.getElementById(p).style.display == "none")
                document.getElementById(p).style.display = "block";
        else document.getElementById(p).style.display = "none";
        }
        </script>
        
        </body>
    </html>
