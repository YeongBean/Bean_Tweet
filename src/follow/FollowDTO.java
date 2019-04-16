package follow;

public class FollowDTO {
	String followFrom;
	String followTo;
	
	public String getFollowFrom() {
		return followFrom;
	}
	public void setFollowFrom(String followFrom) {
		this.followFrom = followFrom;
	}
	public String getFollowTo() {
		return followTo;
	}
	public void setFollowTo(String followTo) {
		this.followTo = followTo;
	}
	
	public FollowDTO()
	{
		
	}
	public FollowDTO(String followFrom, String followTo) {
		super();
		this.followFrom = followFrom;
		this.followTo = followTo;
	}	
}
