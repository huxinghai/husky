# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)


gd = Province.create(name: "广东")
gd.cities.create(name: "广州")
gd.cities.create(name: "深圳")
gd.cities.create(name: "东莞")
gd.cities.create(name: "中山")


hn = Province.create(name: "湖南")
hn.cities.create(name: "长沙")
hn.cities.create(name: "耒阳")
