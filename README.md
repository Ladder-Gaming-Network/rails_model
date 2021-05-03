**Ladder Gaming Report**
---
**Product purpose and audience**

Ladder Gaming is a content integration platform that lets users view information from multiple platforms and connect with their audience.

**Functionality summary**

The app lets you manage profiles, view data from content creation platforms, edit and track posts, and view news.

**Schema summary**

User and profile data
Steam data
Twitch data

**New technologies and services**

Sidekiq
Twitch-API, YT, Steam

**Interesting engineering / challenges**

We had to come up with solutions for the unique problems of following and tracking viewcount data.

**Development, deployment, and testing**

We generally pushed code directly to Heroku, and later set up a better refined testing framework that automatically run when Git updates.

**Architecture diagram**

(this needs to be fetched from presentation)

**Authors:**
- Jacob Smith - jsmith2021@brandeis.edu
- Chris Tam - christophertam@brandeis.edu
- Nicolas Ramirez - rami072@brandeis.edu
