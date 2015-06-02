# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create(location: "Denver",
            work: "Programmer at Galgabize",
            school: "gSnool",
            birthday: 1992-03-24,
            sex: "Male",
            interest: "Hot Dogs!",
            about: "I'll give you a nickel for that hot dog!",
            spark_count: 21,
            email: "juniper@billyums.com",
            password: "password",
            first_name: "Juniper",
            last_name: "Billyums",
            avatar: "juniperBillyums.jpg"
            )

User.create(location: "Denver",
            work: "ShimSham",
            school: "Donut",
            birthday: 1987-01-30,
            sex: "Male",
            interest: "Stuff & Things",
            about: "I do things and junk",
            spark_count: 17,
            email: "big@mclargehuge.com",
            password: "password",
            first_name: "Big",
            last_name: "McLargeHuge",
            avatar: "bigMclargehuge.jpg"
            )

User.create(location: "Denver",
            work: "Gumby.net",
            school: "Grease Monkey",
            birthday: 1987-03-13,
            sex: "Male",
            interest: "Licking other people's ice cream",
            about: "Call me Mabel",
            spark_count: 13,
            email: "runkle@bargefarge.com",
            password: "password",
            first_name: "Runkle",
            last_name: "Bargefarge",
            avatar: "bargefarge.png"
            )

Stryke.create(body: "Is anybody even reading this?",
              spark_count: 21,
              created_at: '2015-06-02 02:45:00 -0600',
              updated_at: '2015-06-02 02:45:00 -0600',
              user_id: 1
              )

Stryke.create(body: "Gorgonzola Duck Circus!",
              spark_count: 17,
              created_at: '2015-06-02 02:47:00 -0600',
              updated_at: '2015-06-02 02:47:00 -0600',
              user_id: 2
              )

Stryke.create(body: "Life is like a box of horseshoe mayonnaise; WHIPPLE!",
              spark_count: 13,
              created_at: '2015-06-02 02:49:00 -0600',
              updated_at: '2015-06-02 02:49:00 -0600',
              user_id: 3
              )

Stryke.create(body: "Within 24 hours",
              spark_count: 13,
              created_at: '2015-06-02 12:10:00 -0600',
              updated_at: '2015-06-02 12:10:00 -0600',
              user_id: 3
              )

Comment.create(body: "So 24 hours ago!",
               stryke_id: 4,
               spark_count: 3,
               user_id: 1
               )

Comment.create(body: "Comments?",
              stryke_id: 4,
              spark_count: 2,
              user_id: 2
              )
