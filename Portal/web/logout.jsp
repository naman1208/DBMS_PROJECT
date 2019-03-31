<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@ page isThreadSafe="true"%>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" >
        <title>JSP Page</title>
    </head>
    
        <%

        session.removeAttribute("tid");
        session.removeAttribute("pass");
        session.invalidate();
        

        response.sendRedirect("index.jsp");
        %>
        
        
    </body>
</html>