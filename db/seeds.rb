require 'faker'
require 'date'

# create 10 cities
10.times do
  City.create(
    name: Faker::GameOfThrones.city,
    postal_code: rand(0..99_999)
  )
end

# create 20 users
20.times do
  User.create(
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    description: Faker::RickAndMorty.quote,
    email: Faker::Internet.email,
    age: rand(13..77),
    city_id: City.all.sample.id
  )
end

tags = ['tech', 'health', 'highschool', 'prom', 'summerbreak', 'boys', 'girls']

# create the tags above
tags.each do |tag|
  Tag.create(title: tag)
end

# create 30 gossips
30.times do
  Gossip.create(
    user_id: User.all.sample.id,
    title: Faker::FunnyName.name,
    content: Faker::RickAndMorty.quote,
    date: Time.now
  )
end

# create 40 comments, either on existing comments or gossips aka commentables
40.times do
  commentables = []
  Gossip.all.each do |gossip|
    commentables.push(gossip)
  end
  Comment.all.each do |comment|
    commentables.push(comment)
  end
  commentable = commentables.sample
  Comment.create(
    user_id: User.all.sample.id,
    content: Faker::GameOfThrones.quote,
    commentable_id: commentable.id,
    commentable_type: (commentable.is_a? Gossip) ? "Gossip" : "Comment"
  )
end

# create 50 likes either on comments or gossips aka commentables
50.times do
  commentables = []
  Gossip.all.each do |gossip|
    commentables.push(gossip)
  end
  Comment.all.each do |comment|
    commentables.push(comment)
  end
  commentable = commentables.sample
  Like.create(
    user_id: User.all.sample.id,
    commentable_id: commentable.id,
    commentable_type: (commentable.is_a? Gossip) ? "Gossip" : "Comment"
  )
end

# create 20 PMs with sender and receiver (both users)
20.times do
  PrivateMessage.create(
    sender_id: User.all.sample.id,
    receiver_id: User.all.sample.id,
    content: Faker::Hobbit.quote,
    date: Time.now
  )
end

# make sure each gossip is linked with a tag
Gossip.all.each do |gossip|
  gossip.tags.push(Tag.all.sample)
  gossip.save
end

# make sure each tag is linked with a gossip
Tag.all.each do |tag|
  tag.gossips.push(Gossip.all.sample)
  tag.save
end
