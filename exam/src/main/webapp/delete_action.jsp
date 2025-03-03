<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%
    String account = request.getParameter("account");
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
        Statement statement = connection.createStatement();
        // 根据账号删除当天的日报记录（这里假设work_date字段包含日期和时间信息，根据实际情况调整）
        String sql = "DELETE FROM work_info WHERE account = '" + account + "' AND DATE(work_date) = CURDATE()";
        int rowsDeleted = statement.executeUpdate(sql);
        if (rowsDeleted > 0) {
            out.println("日报删除成功");
        } else {
            out.println("日报删除失败");
        }
        statement.close();
        connection.close();
    } catch (SQLException e) {
        out.println("数据库操作出错（删除）: " + e.getMessage());
    } catch (ClassNotFoundException e) {
        out.println("加载驱动时出错: " + e.getMessage());
    }
%>
<form action="student.jsp">
    <input type="submit" value="返回">
</form>