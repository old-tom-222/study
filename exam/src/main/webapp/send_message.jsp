<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String account = (String) session.getAttribute("account");
    String receiver = request.getParameter("receiver");
    String message = request.getParameter("message");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
        Statement statement = connection.createStatement();

        // 插入消息到message_table表
        String insertSql = "INSERT INTO message_table (sender, receiver, message_text) VALUES ('" + account + "', '" + receiver + "', '" + message + "')";
        int rowsInserted = statement.executeUpdate(insertSql);
        if (rowsInserted > 0) {
            out.println("消息发送成功");
        } else {
            out.println("消息发送失败");
        }

        statement.close();
        connection.close();
    } catch (SQLException e) {
        out.println("数据库操作出错（插入）: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.println("加载驱动时出错: " + e.getMessage());
    }
%>
<form action="cap.jsp">
    <input type="submit" value="返回发送消息页面">
</form>