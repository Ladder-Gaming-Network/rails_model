The Ladder Gaming Network Project

[See Deployment Here](https://ladder-gaming.herokuapp.com/)

Made with Ruby on Rails.

scaffolds used

note: not using interests currently

rails g scaffold Interest user_id:integer interest:string

rails g scaffold Stream user_id:integer title:string

rails g scaffold Viewcount stream_id:integer viewers:int, created_at:datetime

(user has many streams, streams have many viewcounts)

