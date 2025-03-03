<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录主界面</title>
</head>
<body>
    <form action="loginCheck.jsp" method="post">
        <label for="account">账号：</label>
        <input type="number" id="account" name="account" required><br>
        <label for="password">密码：</label>
        <input type="password" id="password" name="password" required><br>
        <input type="submit" value="登录">
    </form>
    <form action="register.jsp" method="get">
        <input type="submit" value="注册">
    </form>
</body>
</html>