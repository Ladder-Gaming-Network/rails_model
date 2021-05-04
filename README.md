# Ladder Gaming Report

---

Github pages link for web users: (https://ladder-gaming-network.github.io/rails_model/)

## Product purpose and audience

Ladder Gaming is a content integration platform that lets users view information from multiple platforms (Twitch, YouTube, and Steam) and connect with their audience through global posts. The goal of the website is to provide easy access to streaming and video data, which can get overwhelming for content creators and followers alike to obtain, as well as provide a platform to give important announcements to interested followers.

## Functionality summary

The app currently lets you manage profiles, view data from content creation platforms, edit and track posts, and view news for a variety of games.

The main pages, search, and data display

The profile - live tracking and posts

The profile - game information and news

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

## New technologies and services

We utilized a Sidekiq server to handle our background viewcount fetcher, which pulls data from all tracked streams every few minutes. This job begins when the first stream is tracked, and ends when no tracked streams are live, outputting consistent data to the database.

We connected to the Twitch, Youtube, and Steam APIs through various Ruby gems and authentications, taking advantage of gitignore and config variables to hide sensitive keys.

We used the flexible Chartkick gem to display the data from our stream and viewcounts collections.

## Interesting engineering / challenges

Viewcount tracking - Each Twitch streamer needed to have their own confined set of streams and data, which required the extra models of Streams and Viewcounts to streamline interpretation of Twitch API data. The current program checks if a stream is live when a profile is viewed, and if so, displays it as well as any recent tracked data (from the same stream ID). Anyone can opt to track a given stream, which marks that particular stream in the database for background processing and fetches individual viewcounts (another model). The final result is displayed with the useful Chartkick gem, which aggregates all viewcount points into a readable timeline.

Global feed - 

Game information and interest detection - 

## Development, deployment, and testing

We generally pushed code directly to Heroku and debugged through site logs, and later on set up a more refined testing framework that we consistently ran prior to every Git update. Our current Heroku version now supports our main views and controllers, a functioning database, as well as Redis and Sidekiq background servers.

## Architecture diagram

Our project was based off of Ruby on Rails, with a PostgreSQL database and Heroku deploy. The views rely on HTML, CSS, Bootstrap stylesheets, and embedded Ruby. External APIs are called with the above gems.

(fetch from presentation)

## Authors:
- Jacob Smith - jsmith2021@brandeis.edu
- Chris Tam - christophertam@brandeis.edu
- Nicolas Ramirez - rami072@brandeis.edu
