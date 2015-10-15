# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
User.destroy_all
Poll.destroy_all
Question.destroy_all
AnswerChoice.destroy_all
Response.destroy_all

names = ["Dave", "Damon", "Jonathan", "Lily", "Voldemort"]

names.each do |name|
  User.create!(user_name: name)
end

polls = ["What is your name?", "What is your quest?",
  "What is your favorite color?",
  "What is the air speed of and unladen swallow"]

polls.each_with_index do |poll, idx|
  user_id = User.find_by_user_name(names[idx]).id
  Poll.create!(author_id: user_id, title: poll)
end

polls.each_with_index do |question, idx|
  poll_id = Poll.find_by_title(question).id
  Question.create!(text: question, poll_id: poll_id)
end

answers = ["Sir Galahad", "To find the holy grail",
  "Blue, no yellow", "42m/s"]

Question.all.each do |question|
  answers.each do |answer|
    AnswerChoice.create!(question_id: question.id, choice_text: answer)
  end
end
