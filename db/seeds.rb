# sizes
users_count = 100

# clear out data
%w[
  sparks
  comments
  strykes
  users
].each do |table_name|
  ActiveRecord::Base.connection.execute("TRUNCATE TABLE #{table_name}")
end

print "creating users"
# create some users
users_count.times.map do
  print '.'
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
puts

# create a stryke for each user
print "creating strykes"
User.all.map do |user|
  print '.'
  time = Faker::Time.between(4.hours.ago, Time.now)
  user.strykes.create(
    body: Faker::Lorem.sentences(rand(1..3)).join(' '),
    created_at: time,
    updated_at: time,
  )
end
puts

# create some comments on each stryke
print 'creating comments'
[Stryke.all.shuffle, User.all].transpose.flat_map do |stryke, user|
  print '.'
  # use the yielded to ensure that every user has a comment
  Comment.create(
    body: Faker::Lorem.sentence,
    stryke: stryke,
    user: user,
  )
  # create some more comments from random users
  rand(1..5).times.map do
    Comment.create(
      body: Faker::Lorem.sentence,
      stryke: stryke,
      user: User.all.sample,
    )
  end
end
puts

print 'making users follow each other'
User.all.each_with_index.flat_map do |user, index|
  print '.'
  # create a list of users that does not include the current one
  others = Array.new User.all
  others.delete_at index
  # follow a few random users
  followers = others.sample rand(users_count / 2..users_count * 2 / 3)
  followers.map do |follower|
    Following.create(
      user_id: user.id,
      follower_id: follower.id,
    )
  end
end
puts

print 'creating sparks'
User.all.each do |user|
  # range to reuse
  range = 1..5
  # spark some comments
  Comment.all.sample(rand(range)).each do |comment|
    print '.'
    user.sparks.create(sparkable: comment)
  end
  # spark some strykes
  Stryke.all.sample(rand(range)).each do |stryke|
    print '.'
    user.sparks.create(sparkable: stryke)
  end
end
puts


puts <<EOF

Log in with:
  email:    #{User.first.email}
  password: password
EOF
