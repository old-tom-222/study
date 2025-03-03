<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>插入用户</title>
</head>
<body>
    <form action="" method="post">
    	<label for="id">编号：</label><input type="text" id="id" name="id"><br>
        <label for="name">姓名：</label><input type="text" id="name" name="name"><br>
        <label for="age">年龄：</label><input type="text" id="age" name="age"><br>
        <input type="submit" value="插入">
    </form>
    <%
        if ("POST".equals(request.getMethod())) {
        	String id = request.getParameter("id");
            String name = request.getParameter("name");
            String age = request.getParameter("age");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                Statement statement = connection.createStatement();
                int rowsInserted = statement.executeUpdate("INSERT INTO users (id, name, age) VALUES (" + id + ", '" + name + "', " + age + ")");
                if (rowsInserted > 0) {
                    out.println("成功插入新用户");
                } else {
                    out.println("插入用户失败");
                }
                statement.close();
                connection.close();
                response.sendRedirect("index.jsp");
            } catch (SQLException e) {
                out.println("数据库操作出错（插入）: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("加载驱动时出错: " + e.getMessage());
            }
        }
    %>
</body>
</html>