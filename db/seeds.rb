# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Follow.delete_all

30.times do
    r = Follow.create(user_id: 1, follower_id: 1)
    #r = Follow.create(user_id: User.all.sample.id, follower_id: User.all.sample.id)
end