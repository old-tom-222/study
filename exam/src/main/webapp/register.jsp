<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="#" method="post">
        <label for="account">账号：</label>
        <input type="number" id="account" name="account" required><br>
        <label for="password">密码：</label>
        <input type="password" id="password" name="password" required><br>
        <label for="account">组号：</label>
        <input type="number" id="group_number" name="group_number" required><br>
        <label for="type_number">类型号（1是教师，2是组长，3是学生）：</label>
        <input type="number" id="type_number" name="type_number" required><br>
        <input type="submit" value="注册">
    </form>
    <%
        if (request.getMethod().equals("POST")) {
            String account = request.getParameter("account");
            String password = request.getParameter("password");
            String groupNumber = request.getParameter("group_number");
            String typeNumber = request.getParameter("type_number");

            // 数据库连接信息
            String url = "jdbc:mysql://localhost:3306/product1";
            String user = "root";
            String pass = "222735";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, user, pass);
                Statement statement = connection.createStatement();
                String sql = "INSERT INTO stu_teach_info (account, password, group_number, type_number) VALUES (" + account + ", " + password + "," + groupNumber +", " + typeNumber + ")";
                statement.executeUpdate(sql);
                out.println("注册成功");
                response.sendRedirect("index.jsp");
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("注册时出现错误: " + e.getMessage());
            }
        }
    %>
</body>
</html>