<%@ page import="java.util.Date" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE>
<html>
<head>
    <title>regist</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <link rel="stylesheet" type="text/css" href="css/style2.css" />
    <script type="text/javascript" src="js/jquery-3.3.1.min.js"></script>
    <script>
        var boo = true;
        var time = 4;
        var inter;
        function change() {
            if(boo){
                document.getElementById("num").src = "image?" + Math.random();
                document.getElementById("time").innerHTML = --time;
                inter = setInterval(function () {
                    document.getElementById("time").innerHTML = --time;
                    if(time == 0){
                        clearInterval(inter);
                        document.getElementById("time").innerHTML = "";
                        boo = true;
                        time = 4;
                    }
                },1000)
                boo = false;
            }
        }


        var isUsername;
        var isPassword;
        var isPassword2;
        var isCode;


        function checkUsername() {
            //获得输入的用户名
            var username = $("[name='username']").val();
            if(username.trim() == ""){
                $("#checkUsername").html("用户名不能为空").css("color","red");
                isUsername = false;
            }else {
                $.ajax({
                    "url":"checkusername",
                    "type":"get",
                    "data":"username="+username,
                    "async":false,
                    "success":function (data) {
                        data = data.trim();
                        if(data == "true"){
                            $("#checkUsername").html("√").css("color","green");
                            isUsername = true;
                        }else {
                            $("#checkUsername").html("用户名已存在").css("color","red");
                            isUsername = false;
                        }
                    }
                });
            }
            isSub();
        }

        function checkPassword() {
            var password = $("[name='password']").val();
            var reg = /^[a-zA-Z]{1}[a-zA-Z0-9]{5,19}$/;
            if(reg.test(password)){
                $("#checkPassword").html("√").css("color","green");
                isPassword = true;
            }else {
                $("#checkPassword").html("必须是6-20位数字或字母，并且以英文开头").css("color","red");
                isPassword = false;
            }
            isSub();
        }
        
        function checkPassword2() {
            var password = $("[name='password']").val();
            var password2 = $("[name='password2']").val();
            if(password == password2){
                $("#checkPassword2").html("√").css("color","green");
                isPassword2 = true;
            }else {
                $("#checkPassword2").html("两次密码不一致").css("color","red");
                isPassword2 = false;
            }
            isSub();
        }
        
        function checkNumber() {
            var num = $("[name='number']").val();
            //发送ajax请求去请求session中的code
            $.ajax({
                "url":"code",
                "type":"get",
                "async":false,
                "success":function (code) {
                    code = code.trim();
                    if(num == code){
                        $("#checkNumber").html("√").css("color","green");
                        isCode = true;
                    }else {
                        $("#checkNumber").html("验证码错误").css("color","red");
                        isCode = false;
                    }
                }
            });
            isSub();
        }
        
        function checkImg() {
            var path = $("[name='headimg']").val();
            var suffix = path.substring(path.indexOf("."));
            if(suffix == ".jpg" || suffix == ".png" || suffix == ".jpeg"){
                //图片预览
                var img = document.getElementById("headimg").files[0];
                var reader = new FileReader();
                reader.readAsDataURL(img);
                reader.onload = function () {
                    $("#preview").attr("src",this.result);
                }
                $("#checkImg").html("√").css("color","green");
            }else {
                $("#checkImg").html("只支持jpg、jpeg以及png格式").css("color","red");
            }
        }

        function isSub() {
            if(isUsername == true && isPassword == true && isPassword2 == true && isCode == true){
                $("[type='submit']").removeAttr("disabled");
            }
        }

        function toLogin() {
            window.location.href = "login.jsp";
        }

    </script>
</head>
<body>
<div id="wrap">
    <div id="top_content">
        <div id="header">
            <div id="rightheader">
                <p>
                    <%out.print(new Date());%>
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
                注册
            </h1>
            <form action="regist" method="post" enctype="multipart/form-data">
                <table cellpadding="0" cellspacing="0" border="0"
                       class="form_table">
                    <tr>
                        <td valign="middle" align="right">
                            用户名:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="username" onblur="checkUsername()"/>
                            <span id="checkUsername"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            真实姓名:
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="realname" />
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            密码:
                        </td>
                        <td valign="middle" align="left">
                            <input type="password" class="inputgri" name="password" onblur="checkPassword();"/>
                            <span id="checkPassword"></span>
                        </td>
                    </tr><tr>
                    <td valign="middle" align="right">
                        确认密码:
                    </td>
                    <td valign="middle" align="left">
                        <input type="password" class="inputgri" name="password2" onblur="checkPassword2()"/>
                        <span id="checkPassword2"></span>
                    </td>
                </tr>
                    <tr>
                        <td valign="middle" align="right">
                            性别:
                        </td>
                        <td valign="middle" align="left">
                            男
                            <input type="radio" class="inputgri" name="sex" value="男" checked="checked"/>
                            女
                            <input type="radio" class="inputgri" name="sex" value="女"/>
                        </td>
                    </tr>

                    <tr>
                        <td valign="middle" align="right">
                            验证码:
                            <img id="num" src="image" />
                            <span id="time"></span>
                            <a href="javascript:;" onclick="change();">看不清，换一张</a>
                        </td>
                        <td valign="middle" align="left">
                            <input type="text" class="inputgri" name="number" onblur="checkNumber();"/>
                            <span id="checkNumber"></span>
                        </td>
                    </tr>
                    <tr>
                        <td valign="middle" align="right">
                            头像:
                        </td>
                        <td>
                            <input type="file" name="headimg" id="headimg" onchange="checkImg();">
                            <img id="preview" width="100px" height="100px">
                            <span id="checkImg"></span>
                        </td>
                    </tr>
                </table>
                <p>
                    <input type="submit" class="button" value="Submit &raquo;" disabled="disabled" />
                    <input type="button" class="button" value="Login &raquo;" onclick="toLogin();"/>
                </p>
            </form>
        </div>
    </div>
    <div id="footer">
        <div id="footer_bg">
            ABC@126.com
        </div>
    </div>
</div>
</body>
</html>