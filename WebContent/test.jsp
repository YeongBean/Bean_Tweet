<%@ page language="java" contentType="text/html; charset=UTF-8"

    pageEncoding= "UTF-8"%>

<%@ page import="java.sql.*"%>

 

<h2> JDBC드라이버 테스트 </h2>

 

<%

  Connection conn=null;

 

  try{

     

        String jdbcUrl= "jdbc:mysql://localhost:3306/TWEET" ;
        out.println( "1" );
        String dbId="root";
        out.println( "2" );
        String dbPass= "1234";
        out.println( "3" );
 

        Class.forName( "com.mysql.jdbc.Driver");
        out.println( "4" );
        conn=DriverManager.getConnection(jdbcUrl,dbId ,dbPass );

        out.println( "제대로 연결되었습니다." );

  }catch(Exception e){

           e.printStackTrace();

  }

%>