# Bean_Tweet

- This repository is for tweet system

## Functions
- You can sign up with ID, PW, E-mail, nickname
- You can sign in with ID, PW
- You can use service after authenticated with your E-mail
- You can post tweet cards to main page
- You can give 'like' to tweets you like
- If your tweet gets 10+ likes, the tweet shows on 'hot page'
- You can visit your own page : 'profile page'
- You can leave your thoughts on tweets(comment)
- If there are user you want to know more, you can follow in the user's profile page
- You can select public scope of your tweet. If you don't want to show tweet to public, select 'To Followers'

## Progress
#### 4/2 
- Designed login main layout

#### 4/5
- Fixed main page layout

#### 4/6
- Update login sources (DAO, DTO, some utils)

#### 4/7
- Sign up system & authentiaction system using email

#### 4/9
- Sign in/out system & post/report tweet system
- When you use report function, email send to my email

#### 4/11
- Implemented paging & like & delete tweet function
- Fixed some errors

#### 4/13
- Hot page : board for tweets with 10+ like
- User profile page : this page shows your tweets (+ friend list)

#### 4/15
- Implemented comment system

#### 4/16
- Implemented following system

#### 4/17
- Modified to delete all related comments when deleting tweet

#### 4/20
- Implemented tweet's public scope(To public, To Followers)
- To public : Every users can see this tweet
- To Followers : Only your followers can see this tweet

### Develop enviornment
- Window10
- JSP
- MySQL 5.7 -> MySQL 8.0 (Since unexpected error)
- Tomcat 8.5
