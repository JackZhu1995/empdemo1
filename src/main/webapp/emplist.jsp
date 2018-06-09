<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.util.List" %>
<%@ page import="com.neuedu.entity.Emp" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.neuedu.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE>
<html>
<head>
    <title>emplist</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style2.css" />
</head>
<body>
<div id="wrap">
    <div id="top_content">
        <div id="header">
            <div id="rightheader">
                <p>
                    <%--<%
                        out.print(new Date());
                    %>
                    <br/>
                    <%
                        User user = (User) session.getAttribute("user");
                        if(user != null){
                            out.print("用户名：");
                            out.print(user.getUsername());
                        }else {
                    %>
                            <a href="login.jsp">请登录</a>
                    <%
                        }
                    %>--%>
                    <c:if test="${sessionScope.user != null}" var="boo">
                        用户名：${user.username}
                        <a href="dropout">[退出]</a>
                        <img src="${user.img_path}" width="50px" height="50px">
                    </c:if>
                    <c:if test="${!boo}">
                        <a href="login.jsp">请登录</a>
                    </c:if>
                    <br />
                </p>
            </div>
            <div id="topheader">
                <h1 id="title">
                    <a href="#">main</a>
                </h1>
            </div>
            <div id="navigation">
            </div>
        </div>
        <div id="content">
            <p id="whereami">
            </p>
            <h1>
                Welcome!
            </h1>
            <table class="table">
                <tr class="table_header">
                    <td>
                        ID
                    </td>
                    <td>
                        Name
                    </td>
                    <td>
                        Salary
                    </td>
                    <td>
                        Job
                    </td>
                    <td>
                        Operation
                    </td>
                </tr>

                <c:forEach items="${empList}" var="emp" varStatus="index">
                    <c:if test="${index.index % 2 == 0}" var="boo">
                        <tr class="row1">
                            <td>${emp.id}</td>
                            <td>${emp.name}</td>
                            <td>${emp.salary}</td>
                            <td>${emp.job}</td>
                            <td>
                                <a href="delete?id=${emp.id}">delete emp</a>
                                <a href="updateEmpView?id=${emp.id}">update emp</a>
                            </td>
                        </tr>
                    </c:if>
                    <c:if test="${!boo}">
                        <tr class="row2">
                            <td>${emp.id}</td>
                            <td>${emp.name}</td>
                            <td>${emp.salary}</td>
                            <td>${emp.job}</td>
                            <td>
                                <a href="delete?id=${emp.id}">delete emp</a>
                                <a href="updateEmpView?id=${emp.id}">update emp</a>
                            </td>
                        </tr>
                    </c:if>
                </c:forEach>


                <%--<%
                    List<Emp> empList = (List<Emp>) request.getAttribute("empList");
                %>
                <%
                    for (int i = 0; i < empList.size(); i++) {
                        if(i % 2 == 0){
                %>
                <tr class="row1">
                    <td>
                        <%
                            out.print(empList.get(i).getId());
                        %>
                    </td>
                    <td>
                        <%
                            out.print(empList.get(i).getName());
                        %>
                    </td>
                    <td>
                        <%
                            out.print(empList.get(i).getSalary());
                        %>
                    </td>
                    <td>
                        <%
                            out.print(empList.get(i).getJob());
                        %>
                    </td>
                    <td>
                        <a href="delete?id=<%out.print(empList.get(i).getId());%>">delete emp</a>&nbsp;<a href="updateEmpView?id=<%out.print(empList.get(i).getId());%>">update emp</a>
                    </td>
                </tr>
                <%
                    }else {
                %>
                <tr class="row2">
                    <td>
                        <%
                            out.print(empList.get(i).getId());
                        %>
                    </td>
                    <td>
                        <%
                            out.print(empList.get(i).getName());
                        %>
                    </td>
                    <td>
                        <%
                            out.print(empList.get(i).getSalary());
                        %>
                    </td>
                    <td>
                        <%
                            out.print(empList.get(i).getJob());
                        %>
                    </td>
                    <td>
                        <a href="delete?id=<%out.print(empList.get(i).getId());%>">delete emp</a>&nbsp;<a href="updateEmpView?id=<%out.print(empList.get(i).getId());%>">update emp</a>
                    </td>
                </tr>

                <%
                        }
                    }
                %>--%>

            </table>
            <p>
                <input type="button" class="button" value="Add Employee" onclick="location='addEmp.jsp'"/>
            </p>
        </div>
    </div>
    <div id="footer">
        <div id="footer_bg">
            ABC@qq.com
        </div>
    </div>
</div>
</body>
</html>

