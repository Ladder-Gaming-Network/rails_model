**Ladder Gaming Report**
---
**Product purpose and audience**

Ladder Gaming is a content integration platform that lets users view information from multiple platforms (Twitch, YouTube, and Steam) and connect with their audience through announcement-like posts. The goal of the website is to provide easy access to streaming and video data, which can get overwhelming as a content creator.

**Functionality summary**

The app currently lets you manage profiles, view data from content creation platforms, edit and track posts, and view news for a variety of games.

**Schema summary**

User and profile data
-Users
-Follows
-Posts
Steam data
-Games
-Interests
Twitch data
-Streams
-Viewcounts

**New technologies and services**

We utilized a Sidekiq server to handle our background viewcount fetcher, which pulls data from all tracked streams every few minutes.
We connected to the Twitch, Youtube, and Steam APIs through various Ruby gems and authentications, taking advantage of gitignore and config variables to hide sensitive keys.

**Interesting engineering / challenges**

We had to come up with solutions for the unique problems of following and tracking viewcount data.

**Development, deployment, and testing**

We generally pushed code directly to Heroku, and later set up a better refined testing framework that we consistently ran prior to every Git update.

**Architecture diagram**

(this needs to be fetched from presentation)

**Authors:**
- Jacob Smith - jsmith2021@brandeis.edu
- Chris Tam - christophertam@brandeis.edu
- Nicolas Ramirez - rami072@brandeis.edu
