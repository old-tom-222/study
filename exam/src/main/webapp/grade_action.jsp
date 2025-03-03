<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>日报评分操作</title>
</head>
<body>
    <%
        String account = request.getParameter("account");
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy - MM - dd");
        Date now = new Date();
        String today = sdf.format(now);
        if (account!= null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/product1", "root", "222735");
                Statement statement = connection.createStatement();

                // 处理work_date可能为null的情况
                String workDate = request.getParameter("work_date");
                if (workDate == null) {
                    workDate = today;
                }

                // 先更新review_number为3（假设work_info表中有review_number字段）
                String updateReviewSql = "UPDATE work_info SET review_number = 3 WHERE account = '" + account + "' AND work_date LIKE '" + workDate + "%'";
                int rowsUpdated = statement.executeUpdate(updateReviewSql);

                // 检查是否已经有分数输入，如果没有则显示输入分数的表单
                String score = request.getParameter("score");
                if (score == null) {
    %>
                <form action="report_action.jsp">
                    <label for="score">请输入分数:</label>
                    <input type="text" name="score" id="score">
                    <input type="submit" value="提交分数">
                </form>
    <%
                } else {
                    // 如果分数为0，表示未打分，不进行更新操作
                    if (!"0".equals(score)) {
                        String updateScoreSql = "UPDATE work_info SET score = " + score + " WHERE account = '" + account + "' AND work_date LIKE '" + workDate + "%'";
                        int updatedScoreRows = statement.executeUpdate(updateScoreSql);
                        if (updatedScoreRows > 0) {
                            out.println("评分操作成功");
                        } else {
                            out.println("评分操作失败");
                        }
                    } else {
                        out.println("分数为0，不进行评分操作");
                    }
                }

                statement.close();
                connection.close();
            } catch (SQLException e) {
                out.println("数据库操作出错（更新）: " + e.getMessage());
            } catch (ClassNotFoundException e) {
                out.println("加载驱动时出错: " + e.getMessage());
            }
        }
    %>
   
</body>
</html>