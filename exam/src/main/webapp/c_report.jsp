<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>日报审核</title>
</head>
<body>
    <%
        String account = (String) session.getAttribute("account");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();

            // 查询与自己组号相同的人的日报（假设stu_teach_info表中有group_number字段，work_info表中有account等相关字段）
            String queryGroupSql = "SELECT w.account, w.work_date, w.time_spent, w.code_amount, w.blog_amount, w.knowledge_points FROM work_info w, stu_teach_info s WHERE w.account = s.account AND s.group_number = (SELECT group_number FROM stu_teach_info WHERE account = '" + account + "')";
            ResultSet resultSet = statement.executeQuery(queryGroupSql);

            while (resultSet.next()) {
                String writerAccount = resultSet.getString("account");
                String workDate = resultSet.getString("work_date");
                String timeSpent = resultSet.getString("time_spent");
                int codeAmount = resultSet.getInt("code_amount");
                int blogAmount = resultSet.getInt("blog_amount");
                String knowledgePoints = resultSet.getString("knowledge_points");
                out.println("账号: " + writerAccount + "<br>");
                out.println("工作日期: " + workDate + "<br>");
                out.println("所花时间: " + timeSpent + "<br>");
                out.println("代码量: " + codeAmount + "<br>");
                out.println("博客量: " + blogAmount + "<br>");
                out.println("知识点: " + knowledgePoints + "<br>");
                out.println("<form action='report_action.jsp' method='post'>");
                out.println("<input type='hidden' name='account' value='" + writerAccount + "'>");
                out.println("<input type='hidden' name='original_date' value='" + workDate + "'>");
                out.println("<input type='submit' value='审核通过'>");
                out.println("</form><br><br>");
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
    <form action="cap.jsp">
        <input type="submit" value="返回">
    </form>
</body>
</html>