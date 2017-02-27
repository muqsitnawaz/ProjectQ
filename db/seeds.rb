# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users_params = [
  {
    :name => 'Hamza Altaf',
    :interests => ['Computer Science'],
    :location => 'Lahore',
    :is_admin => true,
    :email => 'hamza@gmail.com',
    :password => 'password',
  },{
    :name => 'Nofel Yasin',
    :interests => ['Books','Computer Science'],
    :location => 'Karachi',
    :is_admin => 'false',
    :email => 'nofel@gmail.com',
    :password => 'password',
  },{
    :name => 'Shayan Shafi',
    :interests => ['Books','Computer Science'],
    :location => 'Karachi',
    :is_admin => 'false',
    :email => 'shayan@gmail.com',
    :password => 'shayanshafi',
  }
]

users_params.each do |user_params|
  user = User.create(user_params)
  user.save
end

10.times do
  q = Question.new
  q.user_id = 1
  q.content = Faker::Lorem.sentence.parameterize
  q.detail = Faker::Lorem.paragraphs
  q.save
  
  a =  Answer.new
  a.user_id = rand(1..2).round
  a.question_id = rand(1..10).round
  a.content = Faker::Lorem.paragraphs
  a.upvotes = 5
  a.downvotes = 5
  a.save
  
  cause = Cause.new
  cause.intro = Faker::Lorem.sentence
  cause.detail = Faker::Lorem.paragraphs
  cause.petitionTo = Faker::Lorem.word
  cause.user_id = rand(1..2).round
  cause.save
  
  req =  ArticleRequest.new
  req.user_id = rand(1..2).round
  req.heading = Faker::Lorem.sentence
  req.explanation = Faker::Lorem.paragraphs
  req.save
  
  con = Contest.new
  con.user_id = 1
  con.content = Faker::Lorem.sentence
  con.detail = Faker::Lorem.paragraphs
  con.prize = Faker::Number.number(3)
  con.end_date = Faker::Date.backward(14)
  con.save
  
  art = Article.new
  art.heading = Faker::Lorem.sentence
  art.content = Faker::Lorem.paragraphs
  art.intro = Faker::Lorem.sentence
  art.user_id = rand(1..2).round
  art.save
end