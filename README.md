**Ladder Gaming Report**

---
Github pages link for web users: https://ladder-gaming-network.github.io/rails_model/

**Product purpose and audience**

Ladder Gaming is a content integration platform that lets users view information from multiple platforms (Twitch, YouTube, and Steam) and connect with their audience through global posts. The goal of the website is to provide easy access to streaming and video data, which can get overwhelming for content creators and followers alike, as well as giving them a platform to give important announcements.

**Functionality summary**

The app currently lets you manage profiles, view data from content creation platforms, edit and track posts, and view news for a variety of games.
The main pages, search, and data display
The profile - live tracking and posts
The profile - game information and news

**Schema summary**

User and profile data
-Users
-Posts

Steam data
-Games
-Interests

Twitch data
-Streams
-Viewcounts

**New technologies and services**

We utilized a Sidekiq server to handle our background viewcount fetcher, which pulls data from all tracked streams every few minutes. This job begins when the first stream is tracked, and ends when no tracked streams are live, outputting consistent data to the database.
We connected to the Twitch, Youtube, and Steam APIs through various Ruby gems and authentications, taking advantage of gitignore and config variables to hide sensitive keys.

**Interesting engineering / challenges**

We had to come up with solutions for the unique problems of following and tracking viewcount data.
Each Twitch streamer needed to have their own confined set of streams and data, which required the extra models of Streams and Viewcounts to streamline interpretation of Twitch API data. The current program checks if a stream is live when a profile is viewed, and if so, displays it as well as any recent tracked data (from the same stream ID). Anyone can opt to track a given stream, which marks that particular stream in the database for background processing and fetches individual viewcounts (another model). The final result is displayed with the useful Chartkick gem, which aggregates all viewcount points into a readable timeline.
(short bit about follows and global feed notifications)
(bit about interest detection and game information)
(bit about layouts and styling)

**Development, deployment, and testing**

We generally pushed code directly to Heroku, and later set up a better refined testing framework that we consistently ran prior to every Git update.

**Architecture diagram**

(List of tech, PostgreSQL, Ruby on Rails, Heroku)
(this needs to be fetched from presentation)

**Authors:**
- Jacob Smith - jsmith2021@brandeis.edu
- Chris Tam - christophertam@brandeis.edu
- Nicolas Ramirez - rami072@brandeis.edu
