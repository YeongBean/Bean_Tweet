package likey;

public class LikeyDTO {
	String userID;
	int tweetID;
	String userIP;
	
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public int getTweetID() {
		return tweetID;
	}
	public void setTweetID(int tweetID) {
		this.tweetID = tweetID;
	}
	public String getUserIP() {
		return userIP;
	}
	public void setUserIP(String userIP) {
		this.userIP = userIP;
	}
	
	public LikeyDTO() 
	{
		
	}
	public LikeyDTO(String userID, int tweetID, String userIP) {
		super();
		this.userID = userID;
		this.tweetID = tweetID;
		this.userIP = userIP;
	}
}
