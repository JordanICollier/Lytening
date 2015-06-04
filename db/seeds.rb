# clear out data
[
  User,
  Stryke,
  Following,
].map(&:destroy_all)

# create some users
users = 20.times.map do
  first_name = Faker::Name.first_name
  last_name = Faker::Name.last_name
  full_name = "#{first_name}, #{last_name}"
  User.create(
    location: "#{Faker::Address.city}, #{Faker::Address.state}",
    work: Faker::Name.title,
    school: "#{rand('A'.ord..'Z'.ord).chr}SU",
    birthday: Faker::Date.between(21.years.ago, 40.years.ago),
    sex: rand(2) == 1 ? 'Male' : 'Female',
    interest: Faker::Company.catch_phrase,
    about: "My mission is to #{Faker::Company.bs}.",
    spark_count: rand(1..15),
    email: Faker::Internet.safe_email(full_name),
    password: "password",
    first_name: first_name,
    last_name: last_name,
    avatar: [
      "juniperBillyums.jpg",
      "bigMclargehuge.jpg",
      "bargefarge.png"
    ].sample,
    username: Faker::Internet.user_name(full_name)
  )
end

puts <<EOF
Log in with:
  email:    #{users[0].email}
  password: #{users[0].password}
EOF

# create a stryke for each user
strykes = users.map do |user|
  time = Faker::Time.between(4.hours.ago, Time.now)
  user.strykes.create(
    body: Faker::Lorem.sentences(rand(1..3)).join(' '),
    created_at: time,
    updated_at: time,
    spark_count: rand(1..15),
  )
end

# create 2 to 4 coments on each stryke
comments = [strykes.shuffle, users].transpose.flat_map do |stryke, user|
  # use the yielded to ensure that every user has a comment
  Comment.create(
    body: Faker::Lorem.sentence,
    stryke: stryke,
    user: user,
    spark_count: rand(1..5),
  )
  # create 1 to 3 more comments from random users
  rand(1..3).times.map do
    Comment.create(
      body: Faker::Lorem.sentence,
      spark_count: rand(1..15),
      stryke: stryke,
      user: users.sample,
    )
  end
end

followings = users.each_with_index.flat_map do |user, index|
  # create a list of users that does not include the current one
  others = Array.new users
  others.delete_at index
  # follow a few random users
  followers = others.sample rand 5..15
  followers.map do |follower|
    Following.create(
      user: user,
      follower: follower,
    )
  end
end
