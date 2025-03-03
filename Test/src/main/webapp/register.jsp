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
    <%
        if (request.getMethod().equals("POST")) {
            String account = request.getParameter("account");
            String password = request.getParameter("password");
            String typeNumber = request.getParameter("type_number");

            // 数据库连接信息
            String url = "jdbc:mysql://localhost:3306/product1";
            String user = "root";
            String pass = "222735";

            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection(url, user, pass);
                Statement statement = connection.createStatement();
                String sql = "INSERT INTO user_info (account, password, type_number) VALUES (" + account + ", " + password + ", " + typeNumber + ")";
                statement.executeUpdate(sql);
                out.println("注册成功");
                response.sendRedirect("load.jsp");
                connection.close();
            } catch (ClassNotFoundException | SQLException e) {
                e.printStackTrace();
                out.println("注册时出现错误: " + e.getMessage());
            }
        }
    %>
    <form action="#" method="post">
        <label for="account">账号：</label>
        <input type="number" id="account" name="account" required><br>
        <label for="password">密码：</label>
        <input type="password" id="password" name="password" required><br>
        <label for="type_number">类型号（1是用户，2是管理员）：</label>
        <input type="number" id="type_number" name="type_number" required><br>
        <input type="submit" value="注册">
    </form>
</body>
</html>