<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>发送消息</title>
</head>
<body>
    <%
        String account = (String) session.getAttribute("account");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();

            // 查询与自己组号相同的所有人
            String queryGroupSql = "SELECT account FROM stu_teach_info WHERE group_number = (SELECT group_number FROM stu_teach_info WHERE account = '" + account + "') AND account!= '" + account + "'";
            ResultSet resultSet = statement.executeQuery(queryGroupSql);

            out.println("<form action='send_message.jsp' method='post'>");
            out.println("选择接收人: <select name='receiver'>");
            while (resultSet.next()) {
                String receiver = resultSet.getString("account");
                out.println("<option value='" + receiver + "'>" + receiver + "</option>");
            }
            out.println("</select><br>");
            out.println("消息内容: <textarea name='message'></textarea><br>");
            out.println("<input type='submit' value='发送消息'>");
            out.println("</form>");

            resultSet.close();
            statement.close();
            connection.close();
        } catch (SQLException e) {
            out.println("数据库操作出错（查询）: " + e.getMessage());
        } catch (ClassNotFoundException e) {
            out.println("加载驱动时出错: " + e.getMessage());
        }
    %>
    <form action="cap.jsp">
        <input type="submit" value="返回">
    </form>
</body>
</html>