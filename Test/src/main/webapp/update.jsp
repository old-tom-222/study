<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>更新用户年龄</title>
</head>
<body>
    <form action="" method="post">
        <label for="id">用户ID：</label><input type="text" id="id" name="id"><br>
        <label for="newAge">新年龄：</label><input type="text" id="newAge" name="newAge"><br>
        <input type="submit" value="更新">
    </form>
    <%
        if ("POST".equals(request.getMethod())) {
            String id = request.getParameter("id");
            String newAge = request.getParameter("newAge");
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                Statement statement = connection.createStatement();
                int rowsUpdated = statement.executeUpdate("UPDATE users SET age = " + newAge + " WHERE id = " + id);
                if (rowsUpdated > 0) {
                    out.println("成功更新用户年龄");
                } else {
                    out.println("更新用户年龄失败");
                }
                statement.close();
                connection.close();
                // 操作完成后跳回index.jsp
                response.sendRedirect("index.jsp");
            } catch (SQLException e) {
                out.println("数据库操作出错（更新）: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("加载驱动时出错: " + e.getMessage());
            }
        }
    %>
</body>
</html>