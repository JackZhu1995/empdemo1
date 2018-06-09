<%@ page import="com.neuedu.entity.Emp" %>
<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE>
<html>
<head>
    <title>update Emp</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css"
          href="css/style2.css" />
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script>

        var isName;
        var isSalary;
        var isJob;

        function confirmName() {
            var name = $("[name='name']").val();
            var reg = /^[\u4E00-\u9FA5]{2,4}$/;
            if(reg.test(name)){
                $("#confirmName").html("√").css("color","green");
                isName = true;
            }else {
                $("#confirmName").html("只能输入2-4个汉字").css("color","red");
                isName = false;
            }
            isConf();
        }

        function confirmSalary() {
            var salary = $("[name='salary']").val();
            var reg = /^[1-9]{1}[0-9]{3,6}$/;
            if(reg.test(salary)){
                $("#confirmSalary").html("√").css("color","green");
                isSalary = true;
            }else {
                $("#confirmSalary").html("工资输入有误").css("color","red");
                isSalary = false;
            }
            isConf();
        }

        function confirmJob() {
            var job = $("[name='job']").val();
            if((job == "战士") || (job == "法师") || (job == "射手") || (job == "坦克") || (job == "辅助") || (job == "刺客")){
                $("#confirmJob").html("√").css("color","green");
                isJob = true;
            }else {
                $("#confirmJob").html("职业不存在").css("color","red");
                isJob = false;
            }
            isConf();
        }

        function isConf() {
            if(isName == true && isSalary == true && isJob == true){
                $("[type='submit']").removeAttr("disabled");
            }
        }

    </script>
</head>

<body>
<div id="wrap">
    <div id="top_content">
        <div id="header">
            <div id="rightheader">
                <p>
                    <%
                        out.print(new Date());
                    %>
                    <br />
                </p>
            </div>
            <div id="topheader">
                <h1 id="title">
                    <a href="#">Main</a>
                </h1>
            </div>
            <div id="navigation">
            </div>
        </div>
        <div id="content">
            <p id="whereami">
            </p>
            <h1>
                update Emp info:
            </h1>
            <%--<%
                Emp emp = (Emp) request.getAttribute("emp");
            %>--%>
            <form action="updateEmp" method="post">
                <table cellpadding="0" cellspacing="0" border="0"
                       class="form_table">
                    <%--<tr>
                        <td valign="middle" align="right">
                            id:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" value="<%out.print(emp.getId());%>" readonly="readonly">
                        </td>
                    </tr>--%>
                        <input type="hidden" value="${emp.id}" name="id">
                    <tr>
                        <td valign="middle" align="right">
                            Name:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="name" value="${emp.name}" onblur="confirmName();"/>
                            <span id="confirmName"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            Salary:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="salary" value="${emp.salary}" onblur="confirmSalary();"/>
                            <span id="confirmSalary"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            Job:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="job" value="${emp.job}" onblur="confirmJob();"/>
                            <span id="confirmJob"></span>
                        </td>
                    </tr>
                </table>
                <p>
                    <input type="submit" class="button" value="Confirm" disabled="disabled"/>
                </p>
            </form>
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

