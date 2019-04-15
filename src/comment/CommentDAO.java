package comment;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import comment.CommentDTO;
import tweet.TweetDTO;
import util.DatabaseUtil;

public class CommentDAO {
	public int addComment(CommentDTO commentDTO)
	{
		String SQL = "INSERT INTO COMMENT VALUES (NULL,?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentDTO.getCommentTweetIndex());
			pstmt.setString(2, commentDTO.getCommentUserID());
			pstmt.setString(3, commentDTO.getCommentContent());
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
	
	public int delete(String commentIndex)
	{
		String SQL = "DELETE FROM COMMENT WHERE commentIndex = ?";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, Integer.parseInt(commentIndex));
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
	
	public ArrayList<CommentDTO> getCommentList (int commentTweetIndex)
	{
		ArrayList<CommentDTO> commentList = null;
		String SQL = "SELECT * FROM COMMENT WHERE commentTweetIndex = ? ";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setInt(1, commentTweetIndex);
			rs = pstmt.executeQuery();
			commentList = new ArrayList<CommentDTO>();
			while (rs.next())
			{
				CommentDTO comment = new CommentDTO(
						rs.getInt(1),
						rs.getInt(2),
						rs.getString(3),
						rs.getString(4)
						);
				commentList.add(comment);
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
		return commentList; 
	}
}
