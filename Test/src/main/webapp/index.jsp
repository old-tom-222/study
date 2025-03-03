<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>操作选择</title>
</head>
<body>
    <form action="" method="get">
        <label><input type="radio" name="operation" value="insert">插入用户</label><br>
        <label><input type="radio" name="operation" value="update">更新用户年龄</label><br>
        <label><input type="radio" name="operation" value="delete">删除用户</label><br>
        <label><input type="radio" name="operation" value="select">查询用户</label><br>       
        <input type="submit" value="执行操作">
    </form>
    <%
        String operation = request.getParameter("operation");
        if (operation!= null) {
            if ("insert".equals(operation)) {
                response.sendRedirect("insert.jsp");
            } else if ("update".equals(operation)) {
                response.sendRedirect("update.jsp");
            } else if ("delete".equals(operation)) {
                response.sendRedirect("delete.jsp");
            } else if ("select".equals(operation)) {
                response.sendRedirect("select.jsp");
            } 
        }
    %>
</body>
</html>