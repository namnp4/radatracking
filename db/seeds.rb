# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
User.find_or_create_by(:email => ENV["DEFAULT_USERNAME"],:password => ENV["DEFAULT_PASSWORD"],:admin => true,:approval => true)
# User.find_or_create_by(:email => "quanbh1911@gmail.com",:password => "123456",:admin => true,:approval => true)

topica = Product.find_or_create_by code: 'topica'
if Rails.env.development?
  cats = {}
  %w{ edumall evn etl native nativevn }.each { |name| cats[name] = Product.create(code: name) }

  topica.subs.push cats['edumall']
  cats['edumall'].subs.push cats['evn']
  cats['edumall'].subs.push cats['etl']
  topica.subs.push cats['native']
  cats['native'].subs.push cats['nativevn']

  cats = Product.all

  6.times { |n| tg = TagGroup.create(code: "group#{n}"); tg.tags.push Tag.create(name: "tag#{n}") }
  tgs = TagGroup.all
  tags = Tag.all

  tgs[0].subs.push tgs[1]
  tgs[0].subs.push tgs[2]
  tgs[1].subs.push tgs[3]
  tgs[1].subs.push tgs[4]

  cats[0].tag_groups.push tgs[0]
  cats[0].tag_groups.push tgs[1]
  cats[1].tag_groups.push tgs[2]
  cats[2].tag_groups.push tgs[5]
end
