package tweet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import util.DatabaseUtil;

public class TweetDAO {
	public int write(TweetDTO tweetDTO)
	{
		String SQL = "INSERT INTO TWEETS VALUES (NULL,?,?,?,?,?,9,0)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, tweetDTO.getUserID());
			pstmt.setString(2, tweetDTO.getTweetTitle());
			pstmt.setString(3, tweetDTO.getTweetContent());
			pstmt.setString(4, tweetDTO.getTweetMood());
			pstmt.setString(5, tweetDTO.getTweetScope());
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
		return -1;
	}
	
	public ArrayList<TweetDTO> getList (String tweetMood, String searchType, String search)
	{
		if(tweetMood.equals("All"))
		{
			tweetMood = "";
		}
		ArrayList<TweetDTO> tweetList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.contentEquals("Current"))
			{
				SQL = "SELECT * FROM TWEETS WHERE tweetMood LIKE ? AND CONCAT(userID, tweetTitle, tweetContent) LIKE " +
						"? ORDER BY tweetIndex DESC";
			}else if(searchType.contentEquals("Like"))
			{
				SQL = "SELECT * FROM TWEETS WHERE tweetMood LIKE ? AND CONCAT(userID, tweetTitle, tweetContent) LIKE " +
						"? ORDER BY likeCount DESC";
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + tweetMood + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			tweetList = new ArrayList<TweetDTO>();
			while (rs.next())
			{
				TweetDTO tweet = new TweetDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getInt(7),
						rs.getInt(8)
						);
				tweetList.add(tweet);
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
		return tweetList; 
	}
	
	public ArrayList<TweetDTO> getHotList (String tweetMood, String searchType, String search)
	{
		if(tweetMood.equals("All"))
		{
			tweetMood = "";
		}
		ArrayList<TweetDTO> tweetList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.contentEquals("Current"))
			{
				SQL = "SELECT * FROM TWEETS WHERE likeCount > 9 AND tweetMood LIKE ? AND CONCAT(userID, tweetTitle, tweetContent) LIKE " +
						"? ORDER BY tweetIndex DESC";
			}else if(searchType.contentEquals("Like"))
			{
				SQL = "SELECT * FROM TWEETS WHERE likeCount > 9 AND tweetMood LIKE ? AND CONCAT(userID, tweetTitle, tweetContent) LIKE " +
						"? ORDER BY likeCount DESC";
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, "%" + tweetMood + "%");
			pstmt.setString(2, "%" + search + "%");
			rs = pstmt.executeQuery();
			tweetList = new ArrayList<TweetDTO>();
			while (rs.next())
			{
				TweetDTO tweet = new TweetDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getInt(7),
						rs.getInt(8)
						);
				tweetList.add(tweet);
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
		return tweetList; 
	}
	
	public ArrayList<TweetDTO> getMyList (String tweetMood, String searchType, String search, String userNickname)
	{
		if(tweetMood.equals("All"))
		{
			tweetMood = "";
		}
		ArrayList<TweetDTO> tweetList = null;
		String SQL = "";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			if(searchType.contentEquals("Current"))
			{
				SQL = "SELECT * FROM TWEETS WHERE userID = ? AND tweetMood LIKE ? AND CONCAT(userID, tweetTitle, tweetContent) LIKE " +
						"? ORDER BY tweetIndex DESC";
			}else if(searchType.contentEquals("Like"))
			{
				SQL = "SELECT * FROM TWEETS WHERE userID = ? AND tweetMood LIKE ? AND CONCAT(userID, tweetTitle, tweetContent) LIKE " +
						"? ORDER BY likeCount DESC";
			}
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userNickname);
			pstmt.setString(2, "%" + tweetMood + "%");
			pstmt.setString(3, "%" + search + "%");
			rs = pstmt.executeQuery();
			tweetList = new ArrayList<TweetDTO>();
			while (rs.next())
			{
				TweetDTO tweet = new TweetDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getInt(7),
						rs.getInt(8)
						);
				tweetList.add(tweet);
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
		return tweetList; 
	}
	
	public int like(String tweetID)
	{
		String SQL = "UPDATE TWEETS SET likeCount = likeCount + 1 WHERE tweetIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(tweetID));
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
	
	public int comment(int tweetIndex)
	{
		String SQL = "UPDATE TWEETS SET commentCount = commentCount + 1 WHERE tweetIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, tweetIndex);
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
	
	public int deletecomment(int tweetIndex)
	{
		String SQL = "UPDATE TWEETS SET commentCount = commentCount - 1 WHERE tweetIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, tweetIndex);
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
	
	public int delete(String tweetID)
	{
		String SQL = "DELETE FROM TWEETS WHERE tweetIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(tweetID));
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
	
	public String getUserID(String tweetID) //returns selected tweet's userID
	{
		String SQL = "SELECT userID FROM TWEETS WHERE tweetIndex=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(tweetID));
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
		return null; // db error or not exist in db
	}
	
	public TweetDTO getTweetWithIndex(int index)
	{
		String SQL = "SELECT * FROM TWEETS WHERE tweetIndex=?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, index);
			rs = pstmt.executeQuery();
			if(rs.next())
			{
				TweetDTO tweet = new TweetDTO(
						rs.getInt(1),
						rs.getString(2),
						rs.getString(3),
						rs.getString(4),
						rs.getString(5),
						rs.getString(6),
						rs.getInt(7),
						rs.getInt(8)
						);
				return tweet;
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
		return null; // db error or not exist in db
	}
}
