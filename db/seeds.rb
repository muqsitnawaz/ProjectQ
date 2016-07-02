# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users_params = [
  {
    :name => 'Muqsit Nawaz',
    :interests => ['Computer Science'],
    :location => 'Lahore',
    :is_admin => true,
    :email => 'muqsitnawaz@gmail.com',
    :password => 'muqsitnawaz',
  },{
    :name => 'Nofel Yasin',
    :interests => ['Computer Science'],
    :location => 'Karachi',
    :is_admin => 'false',
    :email => 'nofel@gmail.com',
    :password => 'nofelyasin',
  }
]

users_params.each do |user_params|
  user = User.create(user_params)
  user.save
end