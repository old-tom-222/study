<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<form action="" method="get">
    	<label><input type="radio" name="operation" value="grade">评分</label><br>
    	<label><input type="radio" name="operation" value="message">发送消息</label><br>
        <label><input type="radio" name="operation" value="select">查询日报</label><br>
        <label><input type="radio" name="operation" value="s">发表统计查询</label><br>
        <input type="submit" value="执行操作">
    </form>
    <%
        String operation = request.getParameter("operation");
        if (operation!= null) {
        	if ("grade".equals(operation)) {
                response.sendRedirect("t_grade.jsp");
            } else if ("message".equals(operation)) {
                response.sendRedirect("t_message.jsp");
            } else if ("select".equals(operation)) {
                response.sendRedirect("t_select.jsp");
            } else if ("s".equals(operation)) {
                response.sendRedirect("t_s.jsp");
            }
        }
    %>
</body>
</html>