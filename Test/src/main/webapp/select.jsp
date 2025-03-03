<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>浏览用户</title>
</head>
<body>
    <h2>用户信息</h2>
    <table border="1">
        <tr>
            <th>ID</th>
            <th>姓名</th>
            <th>年龄</th>
        </tr>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                Statement statement = connection.createStatement();
                ResultSet resultSet = statement.executeQuery("SELECT * FROM users");
                while (resultSet.next()) {
                    int id = resultSet.getInt("id");
                    String name = resultSet.getString("name");
                    int age = resultSet.getInt("age");
        %>
        <tr>
            <td><%=id%></td>
            <td><%=name%></td>
            <td><%=age%></td>
        </tr>
        <%
                }
                resultSet.close();
                statement.close();
                connection.close();
            } catch (SQLException e) {
                out.println("数据库操作出错（查询）: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("加载驱动时出错: " + e.getMessage());
            }
        %>
    </table>
    <form action="index.jsp" method="get">
        <input type="submit" value="结束">
    </form>
</body>
</html>