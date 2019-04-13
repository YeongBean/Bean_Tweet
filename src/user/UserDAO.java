package user;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class UserDAO {
	public int login(String userID, String userPassword)
	{
		String SQL = "SELECT  userPassword FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				if(rs.getString(1).contentEquals(userPassword))
				{
					return 1; //Sign in
				}else {
					return 0; //wrong password
				}
			}
			return -1; // no ID
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{ if(conn != null) conn.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(pstmt != null) pstmt.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(rs != null) rs.close();	}
			catch(Exception e){ e.printStackTrace();}
		}
		return -2; // db error
	}
	
	public int join(UserDTO user)
	{
		String SQL = "INSERT INTO USER VALUES (?,?,?,?,false,'none.jpg',?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, user.getUserID());
			pstmt.setString(2, user.getUserPassword());
			pstmt.setString(3, user.getUserEmail());
			pstmt.setString(4, user.getUserEmailHash());
			pstmt.setString(5, user.getUserNickname());
			System.out.println(true);
			return pstmt.executeUpdate();
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{ if(conn != null) conn.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(pstmt != null) pstmt.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(rs != null) rs.close();	}
			catch(Exception e){ e.printStackTrace();}
		}
		return -1; // register fail
	}
	
	public String getUserEmail(String userID)
	{
		String SQL = "SELECT userEmail FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{ if(conn != null) conn.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(pstmt != null) pstmt.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(rs != null) rs.close();	}
			catch(Exception e){ e.printStackTrace();}
		}
		return null; // db error
	}
	
	public boolean getUserEmailChecked(String userID)
	{
		String SQL = "SELECT userEmailChecked FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getBoolean(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{ if(conn != null) conn.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(pstmt != null) pstmt.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(rs != null) rs.close();	}
			catch(Exception e){ e.printStackTrace();}
		}
		return false; // db error
	}
	
	public boolean setUserEmailChecked(String userID)
	{
		String SQL = "UPDATE USER SET userEmailChecked = true WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.executeUpdate();
			return true;
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{ if(conn != null) conn.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(pstmt != null) pstmt.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(rs != null) rs.close();	}
			catch(Exception e){ e.printStackTrace();}
		}
		return false; // db error
	}
	
	public String getUsernickname(String userID)
	{
		String SQL = "SELECT userNickname FROM USER WHERE userID=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				return rs.getString(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			try{ if(conn != null) conn.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(pstmt != null) pstmt.close();	}
			catch(Exception e){ e.printStackTrace();}
			
			try{ if(rs != null) rs.close();	}
			catch(Exception e){ e.printStackTrace();}
		}
		return "default"; // db error
	}
}
