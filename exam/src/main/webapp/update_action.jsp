<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String account = request.getParameter("account");
    String originalDate = request.getParameter("original_date");
    String time_spent = request.getParameter("time_spent");
    String code_amount = request.getParameter("code_amount");
    String blog_amount = request.getParameter("blog_amount");
    String knowledge_points = request.getParameter("knowledge_points");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
        Statement statement = connection.createStatement();
        // 更新日报信息
        String updateSql = "UPDATE work_info SET time_spent = '" + time_spent + "', code_amount = " + code_amount + ", blog_amount = " + blog_amount + ", knowledge_points = '" + knowledge_points + "' WHERE account = '" + account + "' AND work_date = '" + originalDate + "'";
        int rowsUpdated = statement.executeUpdate(updateSql);
        if (rowsUpdated > 0) {
            out.println("日报修改成功");
        } else {
            out.println("日报修改失败");
        }
        statement.close();
        connection.close();
    } catch (SQLException e) {
        out.println("数据库操作出错（更新）: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.println("加载驱动时出错: " + e.getMessage());
    }
%>
<form action="student.jsp">
    <input type="submit" value="返回">
</form>