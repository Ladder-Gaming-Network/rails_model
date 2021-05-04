# Ladder Gaming Report

---

Github pages link for web users: (https://ladder-gaming-network.github.io/rails_model/)

## Product purpose and audience

Ladder Gaming is a content integration platform that lets users view information from multiple platforms (Twitch, YouTube, and Steam) and connect with their audience through global posts. The goal of the website is to provide easy access to streaming and video data, which can get overwhelming for content creators and followers alike to obtain, as well as provide a platform to give important announcements to interested followers.

## Functionality summary

The app currently lets you manage profiles, view data from content creation platforms, edit and track posts, and view news for a variety of games.

The main page contains a navbar linking to sign up, login, user listings and search. It contains a wealth of marketing information aimed at content creators and followers looking to join the site, including a welcome carousel, taglines, and slogans.

User profiles display basic user information, and allow a logged-in user to edit their profile, create posts, and specify interests. It also contains a feed displaying the activity of people the user is following (posts and livestreams), as well as a content integration block containing Youtube channel and Twitch livestream information. From here, users can track others' livestreams, and can view the results in a live viewcount chart.

Users can also see and edit games they are interested in, which are tied directly to their posts. Each game has a separate webpage displaying possible achievements to be earned, as well as recent developer news, accessible from the Games tab on the navbar.

## Schema summary

**User and profile data**

- Users - represents a person on the site, with links to their socials and other identifying information

- Posts - represents an announcement, written in text from a specific user

- Follows - represents a relationship between one user and the person they "follow", affecting which notifications they see on their feed

**Steam data**

- Games - represents a public game on the Steam Store

- Interests - represents a relationship between a user and a game they enjoy

**Twitch data**

- Streams - represents a given livestream on Twitch

- Viewcounts - represents a viewer count snapshot of a particular stream at a set point in time

**Relationships**

- User -> User (many-to-many, encoded in Follows)

- User -> Post (one-to-many)

- Post -> Post (one-to-one)

- User -> Stream (one-to-many)

- User -> Games (many-to-many, encoded in Interests)

- Stream -> Viewcounts (one-to-many)

## New technologies and services

We utilized a Sidekiq server to handle our background viewcount fetcher, which pulls data from all tracked streams every few minutes. This job begins when the first stream is tracked, and ends when no tracked streams are live, outputting consistent data to the database.

We connected to the Twitch, Youtube, and Steam APIs through various Ruby gems and authentications, taking advantage of gitignore and config variables to hide sensitive keys.

We also used the flexible Chartkick gem to display the data from our stream and viewcounts collections, which refreshes the chart automatically as new data comes in.

## Interesting engineering / challenges

Global feed - We needed to create a new model to encode the many-many relationship between users, so we came up with the Follows model. For the global feed, we query which users a certain user is following from the database, and cycle through their posts and streams to display on the main view. As our global feed is one of the more responsive parts of our app, we used Stimulus to automatically update it upon a user follow.

Viewcount tracking - Each Twitch streamer needed to have their own confined set of streams and data, which required the extra models of Streams and Viewcounts to streamline interpretation of Twitch API data. The current program checks if a stream is live when a profile is viewed, and if so, displays it as well as any recent tracked data (from the same stream ID). Anyone can opt to track a given stream, which marks that particular stream in the database for background processing and fetches individual viewcounts (another model). The final result is displayed with the useful Chartkick gem, which aggregates all viewcount points into a readable timeline.

Game information and interest detection - A goal we had going into the project was to have a user's interests be automatically detected from their post. To do this, we sampled a list of games from the Steam API and encoded it into the Games model, and encoded a many-to-many relationship between users and those games in the Interests model. Then, upon post submission, we detect whether a game name is mentioned in the post and add it to interests.

API keys- We tried several methods of hiding the secret API Keys for the twitch and youtube APIS, from using the secrets.yaml file, to saving them in our on file and ignoring it, to storing them in system enviornment variables. Our end solution was to store the secret keys as system environment variables for heroku.

Versioning- We also had a version dependency conflict between the steam api and twitch api gems, which caused bundle install to fail. To solve this, we forked the steam api and updated its version dependency. In addition, we made a pull request to the original project so other programmers can benefit.

## Development, deployment, and testing

We generally pushed code directly to Heroku and debugged through site logs, and later on set up a more refined testing framework that we consistently ran prior to every Git update. Our current Heroku version now supports our main views and controllers, a functioning database, as well as Redis and Sidekiq background servers.

## Architecture diagram

Our project was based off of Ruby on Rails, with a PostgreSQL database and Heroku deploy. The views rely on HTML, CSS, Bootstrap stylesheets, and embedded Ruby. External APIs are called with the above gems.

![image](https://user-images.githubusercontent.com/45111244/117029052-4a03c900-accc-11eb-97d3-66e3d1bc6bf4.png)

## Authors:
- Jacob Smith - jsmith2021@brandeis.edu
- Chris Tam - christophertam@brandeis.edu
- Nicolas Ramirez - rami072@brandeis.edu
