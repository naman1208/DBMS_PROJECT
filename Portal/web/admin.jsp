<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
    
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
%>

<html>
    <head>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/css/bootstrap.min.css">
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.0/js/bootstrap.min.js"></script>
        
  <style>
                    /* The sidebar menu */
            .sidenav {
              height: 100%; /* Full-height: remove this if you want "auto" height */
              width: 220px; /* Set the width of the sidebar */
              position: absolute; /* Fixed Sidebar (stay in place on scroll) */
              z-index: 1; /* Stay on top */
              top: 0; /* Stay at the top */
              left: 0;
              background-color: #f0f0f0; /* Black */
              overflow-x: hidden; /* Disable horizontal scroll */
              padding-top: 20px;
              margin-top: 170px;
            }

            /* The navigation menu links */
            .sidenav a {
              padding: 6px 8px 6px 16px;
              text-decoration: none;
              font-size: 25px;
              color: #818181;
              display: block;
            }

            /* When you mouse over the navigation links, change their color */
            .sidenav a:hover {
              color: #111111;
            }

            /* Style page content */
            .main {
              margin-left: 230px; /* Same as the width of the sidebar */
              padding: 0px 10px;
            }

            /* On smaller screens, where height is less than 450px, change the style of the sidebar (less padding and a smaller font size) */
            @media screen and (max-height: 450px) {
              .sidenav {padding-top: 15px;}
              .sidenav a {font-size: 18px;}
            }
        </style>
        
        
    </head>
    <body>
        <img src="Images/Banner.jpg" width="100%"><hr>
        
        <div class="sidenav">
              
          <a href="registration.jsp">New Registration</a>
          <a href=details.jsp?tid=<%=tid%>>Teacher</a>
          <a href=admin_change.jsp?tid=<%=tid%>>Change Admin</a>
          <a href=mtech_info.jsp?tid=<%=tid%> >M.Tech Info</a>          
          <a href=phd_info.jsp?tid=<%=tid%>>Ph.D Info</a>
          <a href=publications_info.jsp?tid=<%=tid%>>Publications Info</a>
          <a href="logout.jsp">Logout</a>
            
        </div>
        
        <!-- Page content -->
        <div class="main">
          
        </div>
</body>
</html>