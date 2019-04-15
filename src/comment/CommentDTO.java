package comment;

public class CommentDTO {
	int commentIndex;
	int commentTweetIndex;
	String commentUserID;
	String commentContent;
	
	public int getCommentIndex() {
		return commentIndex;
	}
	public void setCommentIndex(int commentIndex) {
		this.commentIndex = commentIndex;
	}
	public int getCommentTweetIndex() {
		return commentTweetIndex;
	}
	public void setCommentTweetIndex(int commentTweetIndex) {
		this.commentTweetIndex = commentTweetIndex;
	}
	public String getCommentUserID() {
		return commentUserID;
	}
	public void setCommentUserID(String commentUserID) {
		this.commentUserID = commentUserID;
	}
	public String getCommentContent() {
		return commentContent;
	}
	public void setCommentContent(String commentContent) {
		this.commentContent = commentContent;
	}
	
	public CommentDTO()
	{
		
	}
	public CommentDTO(int commentIndex, int commentTweetIndex, String commentUserID, String commentContent) {
		super();
		this.commentIndex = commentIndex;
		this.commentTweetIndex = commentTweetIndex;
		this.commentUserID = commentUserID;
		this.commentContent = commentContent;
	}
	
}
