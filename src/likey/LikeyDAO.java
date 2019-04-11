package likey;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DatabaseUtil;

public class LikeyDAO {
	public int like(String userID, int tweetID, String userIP)
	{
		String SQL = "INSERT INTO LIKEY VALUES (?,?,?)";
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		try {
			conn = DatabaseUtil.getConnection();
			pstmt = conn.prepareStatement(SQL);
			pstmt.setString(1, userID);
			pstmt.setInt(2, tweetID);
			pstmt.setString(3, userIP);
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
		return -1; // already clicked like button
	}
}
