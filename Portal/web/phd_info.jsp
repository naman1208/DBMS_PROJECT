<%@page contentType="text/html" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%@ page import ="java.sql.*" %>
<%@ page import ="javax.sql.*" %>
<%@ page isThreadSafe="true"%>
<%
    DriverManager.registerDriver(new com.mysql.jdbc.Driver());
    Connection con=DriverManager.getConnection("jdbc:mysql://localhost/portal","root","");
    PreparedStatement stmt;
    ResultSet rs,rs2,rs3=null,rs4=null,rs5,rs6;
    String msg="";
    int no=0,count=0,p=0,k=0,i=0,m=0,l=0;
    String old = session.getAttribute("pass").toString();
    String tid = session.getAttribute("tid").toString();
    String para = request.getParameter("tid").toString();
    String tname="",syear="",eyear="";
    int[] a = new int[10];
    
    
    if(!((tid).equalsIgnoreCase(para)))
    {
        response.sendError(404, "Session logged in as "+tid);
    }
    
    stmt = con.prepareStatement("select Name from Teacher order by Name asc");
    rs = stmt.executeQuery();
    
    stmt = con.prepareStatement("select distinct EYear from PhdThesis order by EYear desc");
    rs2 = stmt.executeQuery();

    while(rs2.next())
    {
            a[k++] = rs2.getInt(1);
    }
        
    rs2 = stmt.executeQuery();
    
    
    stmt = con.prepareStatement("select count(distinct Enroll) from PhdThesis group by EYear desc");
    rs4 = stmt.executeQuery();
    
    if(request.getParameter("b1")!=null)
    {
        tname = request.getParameter("teacher");
        
        syear = request.getParameter("syear");
        eyear = request.getParameter("eyear");
        
        
        if(tname.equalsIgnoreCase("All"))
        {
            stmt=con.prepareStatement("select * from PhdThesis where  "
                + "EYear>=? and EYear<=? order by EYear desc");
            stmt.setString(1, syear);
            stmt.setString(2, eyear);
            l=1;
        }
        else if(syear.equalsIgnoreCase("All") && eyear.equalsIgnoreCase("All"))
        {
            stmt=con.prepareStatement("select * from PhdThesis "
                    + "where TID=(select TID from Teacher where Name = ?)  "
                    + "order by EYear desc");
            stmt.setString(1, tname);
            m=1;
            
        }
        else{
        stmt=con.prepareStatement("select * from PhdThesis where TID=(select TID from Teacher where Name = ?) and "
                + "EYear>=? and EYear<=? order by EYear desc");
        stmt.setString(1, tname);
        stmt.setString(2, syear);
        stmt.setString(3, syear);
        l=2;
        m=1;
        }
        
        
        rs3 = stmt.executeQuery();
        
        
        p=1;
        
        
            while(rs3.next())
            {
                count++;
            }
        
        
        rs3 = stmt.executeQuery();
    }
    
    
%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        
        <style type="text/css">
            .main{
                margin-left: 200px;
                size: 100px;
            }
            table, th, td {
                    border: 1px solid black;
                    padding: 15px;
                    text-align: center;
                    
                }
                
                table {
                    background-color: #f1f1c1;
                    border-spacing: 5px;
                    overflow: auto;
                }
                
                
             
        </style>
        
    </head>
    <body>
        <jsp:include page="admin.jsp" />
        <div class="main">
            <h3> Total number of Ph.D. year-wise</h3>
            <table style="width: 98%;"> 
                    <caption>Sorted by End Year</caption>
                    <tr>
                        <th>Year</th>
                        <th>No of PhDs Completed</th> 
                        
                    </tr>
                    <% while(rs4.next()){ %>
                    
                    <tr>
                        <td><%= a[i++] %></td> 
                        <td><%= rs4.getInt(1) %></td>
                    </tr>
                    
                    </br>
                    <% }%>       
            </table>
            
            <hr style="height:3px;border:none;color:#333;background-color:#333;" /><br>
        <form method="post" action=phd_info.jsp?tid=<%=tid%>>    
            <label>Select Teacher :</label>
            <select name="teacher"> 
                <option> All</option>
        <% while(rs.next()){   %> 
        
        <option> <%=rs.getString(1)%></option>
        <% } %>
        </select>
        <br>
        <label>Select Start Year :</label>
        <select name="syear">    
            <option>All</option>
        <% while(rs2.next()){   %> 
        
        <option> <%=rs2.getString(1)%></option>
        <% }
        stmt = con.prepareStatement("select distinct EYear from PhdThesis order by EYear desc");
        rs2 = stmt.executeQuery();   
        %>
            </select>
        <label>Select End Year :</label>
        <select name="eyear">    
            <option>All</option>
        <% while(rs2.next()){   %> 
        
        <option> <%=rs2.getString(1)%></option>
        <% }  %>
            </select><br>
            
        

        <button type="submit" name="b1" id="b1" >Show</button>
        </form><br>
        
        <% if(p==1) { %>
        <h2>Ph.D Thesis Supervised </h2>
            <% if (!rs3.next()) {%>
            <h5>No Ph.D Entries for <%= tname %> completed in year <%= syear %>to<%= eyear %></h5> 
            <% } else{ if(m==1 && l!=2)  {%>
            
            <h4>by <%= tname %> completed till now</h4> <% } else if(l==1 || l==2)  { %>
            <h4>by <%= tname %> completed in year <%= syear%> to <%= eyear %></h4> <%  }  %>
            <h3>Count = <%=count%> </h3>
            <table style="width: 98%;"> 
                <caption>Sorted by End Year</caption>
            <tr>
                <th>S.No.</th>
                <th>Registration no.</th> 
                <th>Name</th>
                <th>Title</th><% if(m!=1) {%>
                <th>Teacher Name</th><% } %>
                <th>Start Year</th>
            </tr>
            <% do{ no++; %>

            <tr>
                <td><%= no %></td>
                <td><%= rs3.getString(2) %></td> 
                <td><%= rs3.getString(3) %></td>
                <td><%= rs3.getString(4) %></td><% if(m!=1)  {
                stmt = con.prepareStatement("select Name from Teacher where TID='"+rs3.getString(1)+"'");
                rs6=stmt.executeQuery();
                while(rs6.next()){
                %>
                <td><%= rs6.getString(1) %></td><% }} %>
                <td><%= rs3.getInt(5) %></td>
            </tr>

            </br>
            <% }while(rs3.next()); }%>       
            </table> 
            <% } %>
            <hr style="height:3px;border:none;color:#333;background-color:#333;" />
            <table>
                <h3>Ph.d Thesis Supervised (<%=a[k-1] %> - <%=a[0] %>)</h3>
                <tr>
                    <th>S.no </th>
                    <th>Student Name</th>
                    <th>Thesis Title</th>
                    <th>Supervisors</th>
                    <th>Completion Year</th>
                    
                </tr>   
            <% 
                stmt = con.prepareStatement("select distinct Enroll,Title,Name,EYear from PhdThesis order by EYear");
                rs4 = stmt.executeQuery();
                no=0;
                while(rs4.next()) {
            %>
            <tr>
                <td><%=++no%></td>
                <td><%=rs4.getString(3)%></td>
                <td><%=rs4.getString(2)%></td>
                <% stmt = con.prepareStatement("select Teacher.Name from Teacher inner join PhdThesis on PhdThesis.TID=Teacher.TID where Enroll='"+
                        rs4.getString(1)+"' and Title='"+ rs4.getString(2)+"' and EYear="+ rs4.getString(4));
                   rs5 = stmt.executeQuery();
                   String name = "";
                   while(rs5.next()) {
                       
                        name += rs5.getString(1);
                        name += ",";
                    } name=name.substring(0, name.length() - 1);%>
                    <td><%= name %></td>
                    <td><%=rs4.getString(4)%></td>
            </tr>
            <% } %>
            </table>
            <hr style="height:3px;border:none;color:#333;background-color:#333;" />
            <table>
                <h3>Ph.d Thesis Awarded (<%=a[k-1] %> - <%=a[0] %>)</h3>
                <tr>
                    <th>S.no </th>
                    <th>Faculty Name</th>
                    <th>Thesis Title</th>
                    <th>Supervisors</th>
                    <th>Month & Year</th>
                    
                </tr>   
            <% 
                stmt = con.prepareStatement("select distinct Enroll,Title,Name,AwardYear,EYear from PhdThesis ");
                rs4 = stmt.executeQuery();
                no=0;
                while(rs4.next()) {
                    if(rs4.getString(4).equalsIgnoreCase(""))
                    continue;
                    stmt = con.prepareStatement("select TID from Teacher where Name = '"+rs4.getString(3)+"'");
                    rs6 = stmt.executeQuery();
                    if(!(rs6.next()))
                    continue;
            %>
            <tr>
                <td><%=++no%></td>
                <td><%=rs4.getString(3)%></td>
                <td><%=rs4.getString(2)%></td>
                <% stmt = con.prepareStatement("select Teacher.Name from Teacher inner join PhdThesis on PhdThesis.TID=Teacher.TID where Enroll='"+
                        rs4.getString(1)+"' and Title='"+ rs4.getString(2)+"' and EYear="+ rs4.getString(5));
                   rs5 = stmt.executeQuery();
                   String name = "";
                   while(rs5.next()) {
                       
                        name += rs5.getString(1);
                        name += ",";
                    } name=name.substring(0, name.length() - 1);%>
                    <td><%= name %></td>
                    <td><%=rs4.getString(4)%></td>
            </tr>
            <% } %>
            </table>
            
            <hr />
            <table>
                
                <tr>
                    <th>S.no </th>
                    <th>Student Name</th>
                    <th>Thesis Title</th>
                    <th>Supervisors</th>
                    <th>Month & Year</th>
                    
                </tr>   
            <% 
                stmt = con.prepareStatement("select distinct Enroll,Title,Name,AwardYear,EYear from PhdThesis ");
                rs4 = stmt.executeQuery();
                no=0;
                while(rs4.next()) {
                    if(rs4.getString(4).equalsIgnoreCase(""))
                    continue;
                    stmt = con.prepareStatement("select TID from Teacher where Name = '"+rs4.getString(3)+"'");
                    rs6 = stmt.executeQuery();
                    if(rs6.next())
                    continue;
            %>
            <tr>
                <td><%=++no%></td>
                <td><%=rs4.getString(3)%></td>
                <td><%=rs4.getString(2)%></td>
                <% stmt = con.prepareStatement("select Teacher.Name from Teacher inner join PhdThesis on PhdThesis.TID=Teacher.TID where Enroll='"+
                        rs4.getString(1)+"' and Title='"+ rs4.getString(2)+"' and EYear="+ rs4.getString(5));
                   rs5 = stmt.executeQuery();
                   String name = "";
                   while(rs5.next()) {
                       
                        name += rs5.getString(1);
                        name += ",";
                    } name=name.substring(0, name.length() - 1);%>
                    <td><%= name %></td>
                    <td><%=rs4.getString(4)%></td>
            </tr>
            <% } %>
            </table>
            
            <hr style="height:3px;border:none;color:#333;background-color:#333;" />
        </div>
    </body>
</html>
