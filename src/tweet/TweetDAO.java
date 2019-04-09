package tweet;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class TweetDAO {
	public int write(TweetDTO tweetDTO)
	{
		String SQL = "INSERT INTO TWEETS VALUES (NULL,?,?,?,?,0)";
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
}
