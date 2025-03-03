<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>我的消息</title>
</head>
<body>
    <%
        String account = (String) session.getAttribute("account");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();
            // 查询发送给当前用户（接收人）的消息、发送人
            String sql = "SELECT sender, message_text FROM message_table WHERE receiver = '" + account + "'";
            ResultSet resultSet = statement.executeQuery(sql);
            while (resultSet.next()) {
                String sender = resultSet.getString("sender");
                String message = resultSet.getString("message_text");
                out.println("发送人: " + sender + "<br>");
                out.println("消息: " + message + "<br><br>");
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
    <form action="student.jsp">
        <input type="submit" value="返回">
    </form>
</body>
</html>