Jacob Smith, Christopher Tam, Nicolas Ramirez
Cosi 166B
4/29/21

GitHub link: https://github.com/Ladder-Gaming-Network/rails_model

Heroku: https://ladder-gaming.herokuapp.com/

# Current functionality

**Our Rails app has progressed from stage 3 to include background viewcount processing, youtube API calls, dynamic page updates upon following, game interest detection, and livestream detection. Users can now opt to link their Youtube accounts, track another user's livestream, and make posts corresponding to their interests. profile viewing, authentication, and prototypes of Twitch API integration. User profiles now contain a wealth of information about that user's content, posting is dynamic, and frontend layouts have been updated accordingly.**

Our main view is the welcome page. This view contains a “carousel” like implementation for the first part of the page. This carousel rotates and displays different images and tag lines. At the top of our application is the navbar, which includes different links to the rest of the application and also implements search functionality.

Once logged in, our profile view displays basic profile information as well as live stream and channel information, if links were provided. Additionally, you can view your post “feed” in the profile view of our page, containing all posts from users you are following, as well as interests determined from the user's post history. From here, you can create posts or edit profile (if the profile is yours), or opt to follow or unfollow a particular user. If a user's stream is live, click "Start Tracking" to begin automatic viewcount fetching, displayed in a graph below the stream.

We also added tests of the twitch_data and youtube_data classes, they are in tests/controllers

Current Problems: We are having trouble deploying API keys to Heroku, managing the different dependencies of the planned steam_web_api gem integration and the twitch-api gem


# URL Routes

Home page: /
Search form: /search
Display user login prompt, and check for correct password: /login
Logout: /logout (which redirects to home page)
Admin view: /admin

Users: /users
/users/new
/users/create
/users/delete
/users/1

Posts: /posts
/posts/new
/posts/create
/posts/delete
/posts/1

Followers: /follows
...

Streams: /streams
...

Viewcounts: /viewcounts
...
...
...

# Database schema

Our models currently consist of user, follows, post, streams, and viewcounts. The user model has a has_many relationship with posts and following. The user model also consists of a name, description and timezone. The timezone is used to make appropriate recommendations to users. For example, people in Europe will receive slightly different recommendations to those in the U.S. A post belongs_to a user, each post validates the user id and that there is text in the post. The post functionality is part of the “twitter” part of our application. The follows model is used to keep track of who the user is following. In other words, who’s posts the user wants to see. Streams and viewcounts are used to display Twitch data, which our live charting is reliant on.

Name: User

- string username, string firstname, string lastname, integer timezone_code, string stream_link, String description

Name: Stream

- string title, integer user_id

Name: Viewcount

- integer viewers, integer stream_id

Name: Posts

- integer user_id, string text, int parent_post id (0 if no parent)

Name: Follows

- integer user_ id, integer follower_id (which is another user id)

Name: Games

- string name

Name: Interests

- integer user_id, integer game_id

Associations
User -> Posts (Posts) **_(One to Many)_**
User -> User (Follows) **_(Many to Many)_**
User -> User (Followers) **_(Many to Many)_**
User -> Stream **_(One to Many)_**
Stream -> Viewcount **_(One to Many)_**
User -> Games (Interests) **_(Many to Many)_**

# Current Dependencies

**_Bootstrap_** for website layout
**_CableReady and StimulusReflex_** for follow reactivity
**_Faker_** gem for initial seeding
**_RailsAdmin_** gem for admin console
**_Chartkick_** gem for live viewcount charting
**_Twitch-api_** gem for stream info and viewcount sampling
**_YT_** gem for channel info
**_Sidekiq_** gem for background processing
**_Steam_Web_API_** gem for Steam game data (note: currently conflicted with twitch-api)

=======
![chart_example](images/chart_example.png)
