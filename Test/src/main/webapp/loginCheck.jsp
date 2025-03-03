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
    String account = request.getParameter("account");
    String password = request.getParameter("password");

    String url = "jdbc:mysql://localhost:3306/product1";
    String user = "root";
    String pass = "222735";

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection(url, user, pass);
        Statement statement = connection.createStatement();
        String sql = "SELECT type_number FROM user_info WHERE account = " + account + " AND password = " + password;
        ResultSet resultSet = statement.executeQuery(sql);
        if (resultSet.next()) {
            int typeNumber = resultSet.getInt("type_number");
            if (typeNumber == 1) {
                response.sendRedirect("insert.jsp");
            } else if (typeNumber == 2) {
                response.sendRedirect("delete.jsp");
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