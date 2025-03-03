<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>修改日报</title>
</head>
<body>
    <%
        String account = (String) session.getAttribute("account");
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
            Statement statement = connection.createStatement();
            // 检查当天这个账号是否已经提交过日报并且获取review_number
            String checkSql = "SELECT review_number FROM work_info WHERE account = '" + account + "' AND DATE(work_date) = CURDATE()";
            ResultSet resultSet = statement.executeQuery(checkSql);
            if (resultSet.next()) {
                int reviewNumber = resultSet.getInt("review_number");
                if (reviewNumber == 1) {
                    // 如果review_number为1，查询出日报的原始信息用于显示在表单中
                    String querySql = "SELECT * FROM work_info WHERE account = '" + account + "' AND DATE(work_date) = CURDATE()";
                    ResultSet originalData = statement.executeQuery(querySql);
                    if (originalData.next()) {
                        // 显示修改日报的表单，表单中填充原始数据
                        %>
                        <form action="update_action.jsp" method="post">
                            <input type="hidden" name="account" value="<%=account%>">
                            <input type="hidden" name="original_date" value="<%=originalData.getString("work_date")%>">
                            <label for="time_spent">所花时间：</label><input type="text" id="time_spent" name="time_spent" value="<%=originalData.getString("time_spent")%>"><br>
                            <label for="code_amount">代码量：</label><input type="text" id="code_amount" name="code_amount" value="<%=originalData.getInt("code_amount")%>"><br>
                            <label for="blog_amount">博客量：</label><input type="text" id="blog_amount" name="blog_amount" value="<%=originalData.getInt("blog_amount")%>"><br>
                            <label for="knowledge_points">知识点：</label><input type="text" id="knowledge_points" name="knowledge_points" value="<%=originalData.getString("knowledge_points")%>"><br>
                            <input type="submit" value="修改日报">
                        </form>
                        <%
                    } else {
                        out.println("查询日报原始数据失败");
                    }
                    originalData.close();
                    out.println("可以进行日报信息更新操作。");
                } else if (reviewNumber == 2) {
                    out.println("日报已审核，不能修改。");
                } else if (reviewNumber == 3) {
                    out.println("日报已评分，不能修改。");
                }
            } else {
                out.println("今日未写日报");
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