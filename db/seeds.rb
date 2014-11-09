
category = Category.create!(name: 'Web网站')

user = User.create!(name: 'example', login: 'example', email: 'example@gmail.com', password: 'password')

team = user.teams.build(name: 'Husky Team', owner: user)
team.save!

project = user.projects.build(name: 'XXX Project', category: category, owner: user)
project.save!

tag = project.tags.build(name: 'Ruby', kind: 'Skill')
tag.save!

bidding = project.biddings.create(team: team, user: user, price: 88.88)
bidding.save!
