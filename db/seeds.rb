# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Comment.delete_all
Post.delete_all
User.delete_all

PASSWORD = "supersecret" 

super_user = User.create(
    name: "helga",
    email: "helga@gmail.com",
    password: PASSWORD,
    is_admin: true
)

100.times do
    name = Faker::Name.middle_name
    User.create(
        name: name,
        email: "#{name.downcase}@gmail.com",
        password: PASSWORD
    )
end

users = User.all
puts "created #{users.count} users"

500.times do
    user= users.sample
    p = Post.create(
        title: Faker::Hacker.say_something_smart,
        body: Faker::ChuckNorris.fact,
        created_at: Faker::Date.backward(days:365 * 5),
        updated_at: Faker::Date.backward(days:365 * 5),
        user_id: user.id
    )
    if p.valid?
        p.comments = rand(0..15).times.map do
            user= users.sample
            Comment.new({
                message: Faker::GreekPhilosophers.quote, 
                user_id: user.id
            })
        end
    else
        puts "Invalid post!!"
        puts p
    end
end


    posts = Post.all
    puts "created #{posts.count} posts"
    comments = Comment.all
    puts "created #{comments.count} comments"


