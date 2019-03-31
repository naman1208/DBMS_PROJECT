<%@page contentType="text/html" pageEncoding="UTF-8" errorPage="logout.jsp"%>



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
    ps=c.prepareStatement("select * from WorkshopSeminarOrganised where TID='"+tid+"'");
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
                  width: 700px;
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
                    <li><a href="honorsnresponsibilities.php">Honors and Responsibilities</a></li>
                    <li><a href="researchinterests.php">Research Interests</a></li>
                    <li ><a class="dropdown-toggle" data-toggle="dropdown">Publications
                        <span class="caret"></span></a>
                    <ul class="dropdown-menu">
                        <li><a href="journals.php" onclick="show('journal')">Journal Papers</a></li>
                        <li><a href="conferences.php" onclick="show('confrence')">Conference Proceedings</a></li>
                    </ul>
                    </li>
                    <li><a class="dropdown-toggle" data-toggle="dropdown">Thesis Supervised
                        <span class="caret"></span></a></a>
                     <ul class="dropdown-menu">
                        <li><a href=phd_page.jsp?tid=<%=tid%>>Ph.D</a></li>
                        <li><a href=mtech_page.jsp?tid=<%=tid%>>M.Tech</a>
                           </li>

                      </ul>	
                    </li>
                    <li class="active"><a href=workshop.jsp?tid=<%=tid%>>Workshops</a></li>
                    <li><a href=courses_page.jsp?tid=<%=tid%>>Courses</a></li>
                    <li><a href="fundedresearchprojects.php">Funded Research Projects</a>
                    <li ><a href=invited_talk.jsp?tid=<%=tid%>>Invited Talk</a></li>
                    <% if(tid!="null"){ %>
                    
                    <li style="float:right;"><a href="index.jsp">Logout</a></li>
                    <li style="float:right;"><a href=workshop_org.jsp?tid=<%=tid%>>Newly organized</a></li>
                    
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
                    <h2>Workshop and Seminar Organized</h2>
                    <% if (rs2.next() == false) { %>
                    <h5>Click Newly organized to update details </h5> <%} else { %>
                    <% do{ no++; %> 
                    <h14><strong><%=no%>. </strong> </h14>
                    
                    <a><%=rs2.getString(4)%> to <%=rs2.getString(5)%></a>
                    </br>
                    <a style="padding: 0 0 0 14px;"> <%= rs2.getString(3) %></a>&nbsp;
                    at        
                    <a> <%= rs2.getString(6)%></a>&nbsp;
                    with capacity of 
                     <a > <%= rs2.getString(2) %></a>&nbsp;
                    peoples  sponsored by 
                     <a > <%= rs2.getString(7) %></a>&nbsp;
                     </br></br>
                    <% }while(rs2.next()); }%>       
                            
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
