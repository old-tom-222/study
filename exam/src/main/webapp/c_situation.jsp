<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>组内日报情况</title>
</head>
<body>
    <%
        String account = (String) session.getAttribute("account");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();

            // 查询与自己组号相同的所有人的账号、日报提交情况和审核/评分情况
            String querySql = "SELECT s.account, " +
                    "CASE WHEN w.work_date IS NOT NULL THEN '已交' ELSE '未交' END AS daily_report_status, " +
                    "CASE WHEN w.review_number = 2 THEN '已审核' " +
                    "WHEN w.review_number = 3 THEN '已评分' " +
                    "ELSE '' END AS review_status " +
                    "FROM stu_teach_info s " +
                    "LEFT JOIN work_info w ON s.account = w.account AND DATE(w.work_date) = CURDATE() " +
                    "WHERE s.group_number = (SELECT group_number FROM stu_teach_info WHERE account = '" + account + "')";
            ResultSet resultSet = statement.executeQuery(querySql);

            while (resultSet.next()) {
                String writerAccount = resultSet.getString("account");
                String dailyReportStatus = resultSet.getString("daily_report_status");
                String reviewStatus = resultSet.getString("review_status");
                out.println("账号: " + writerAccount + "<br>");
                out.println("日报提交情况: " + dailyReportStatus + "<br>");
                out.println("审核/评分情况: " + reviewStatus + "<br><br>");
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