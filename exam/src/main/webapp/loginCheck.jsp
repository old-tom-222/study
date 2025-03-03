<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>insert</title>
</head>
<body>
<%
    String account = request.getParameter("account");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/product1";
    String user = "root";
    String pass = "222735";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, user, pass);
        Statement statement = connection.createStatement();
        // 修改这里的表名为stu_teach_info
        String sql = "SELECT type_number FROM stu_teach_info WHERE account = '" + account + "' AND password = '" + password + "'";
        ResultSet resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {
            int typeNumber = resultSet.getInt("type_number");
            if (typeNumber == 1) {
                // 将账号存储到session
                session.setAttribute("account", account);
                response.sendRedirect("teacher.jsp");
            } else if (typeNumber == 2) {
                // 将账号存储到session
                session.setAttribute("account", account);
                response.sendRedirect("cap.jsp");
            } else if (typeNumber == 3) {
                // 将账号存储到session
                session.setAttribute("account", account);
                response.sendRedirect("student.jsp");
            }
        } else {
            out.println("账号或密码错误");
        }
        connection.close();
    } catch (ClassNotFoundException | SQLException e) {
        e.printStackTrace();
        out.println("登录验证时出现错误: " + e.getMessage());
    }
%>
</body>
</html>