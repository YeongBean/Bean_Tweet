package tweet;

public class TweetDTO {
	int tweetIndex;
	String userID;
	String tweetTitle;
	String tweetContent;
	String tweetMood;
	int likeCount;
	int commentCount;	
	
	public int getCommentCount() {
		return commentCount;
	}
	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}
	
	public int getTweetIndex() {
		return tweetIndex;
	}
	public void setTweetIndex(int tweetIndex) {
		this.tweetIndex = tweetIndex;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getTweetTitle() {
		return tweetTitle;
	}
	public void setTweetTitle(String tweetTitle) {
		this.tweetTitle = tweetTitle;
	}
	public String getTweetContent() {
		return tweetContent;
	}
	public void setTweetContent(String tweetContent) {
		this.tweetContent = tweetContent;
	}
	public String getTweetMood() {
		return tweetMood;
	}
	public void setTweetMood(String tweetMood) {
		this.tweetMood = tweetMood;
	}
	public int getLikeCount() {
		return likeCount;
	}
	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}
	
	
	
	public TweetDTO() {
		
	}
	public TweetDTO(int tweetIndex, String userID, String tweetTitle, String tweetContent, String tweetMood,
			int likeCount, int commentCount) {
		super();
		this.tweetIndex = tweetIndex;
		this.userID = userID;
		this.tweetTitle = tweetTitle;
		this.tweetContent = tweetContent;
		this.tweetMood = tweetMood;
		this.likeCount = likeCount;
		this.commentCount = commentCount;
	}
}
