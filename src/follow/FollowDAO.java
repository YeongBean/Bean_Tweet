package follow;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import follow.FollowDTO;
import util.DatabaseUtil;

public class FollowDAO {
	public int getFollowTo(FollowDTO followDTO) // check if already i followed
	{
		String SQL = "SELECT followTo FROM USER WHERE followFrom = ? AND followTO = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, followDTO.getFollowFrom());
			pstmt.setString(2, followDTO.getFollowTo());
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
		return -1; //error
	}
	
	public int follow(FollowDTO followDTO) //use nickname as a value :followFrom
	{
		String SQL = "INSERT INTO FOLLOW VALUES (?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, followDTO.getFollowFrom());
			pstmt.setString(2, followDTO.getFollowTo());
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
	
	public int unfollow(FollowDTO followDTO)
	{
		String SQL = "DELETE FROM FOLLOW WHERE followFrom = ? AND followTO = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, followDTO.getFollowFrom());
			pstmt.setString(2, followDTO.getFollowTo());
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
		return -1; // db error
	}
	
	public ArrayList<FollowDTO> getMyFollower (String followerUserNickname) //get list of user follows me
	{
		ArrayList<FollowDTO> followerList = null;
		String SQL = "SELECT * FROM FOLLOW WHERE followTo = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, followerUserNickname);
			rs = pstmt.executeQuery();
			followerList = new ArrayList<FollowDTO>();
			while (rs.next())
			{
				FollowDTO follow = new FollowDTO(
						rs.getString(1),
						rs.getString(2)
						);
				followerList.add(follow);
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
		return followerList; 
	}
	
	public ArrayList<FollowDTO> getMyFollowing (String userNickname) //get list of user I follow
	{
		ArrayList<FollowDTO> followerList = null;
		String SQL = "SELECT * FROM FOLLOW WHERE followFrom = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userNickname);
			rs = pstmt.executeQuery();
			followerList = new ArrayList<FollowDTO>();
			while (rs.next())
			{
				FollowDTO follow = new FollowDTO(
						rs.getString(1),
						rs.getString(2)
						);
				followerList.add(follow);
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
		return followerList; 
	}
}
