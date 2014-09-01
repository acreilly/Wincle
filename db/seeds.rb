# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
require 'faker'
require 'chronic'

industry = ['Entertainment','Hospitality','Non-Profit']
job_title = ["bar tender","waitress","busser","data entry"]

5.times do
  user = User.create(
    user_type: "Employer",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    telephone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    password_digest: "123"
    )

  Employer.create(
    user_id: user.id,
    company: Faker::Company.name,
    industry: industry.sample
  )

end

10.times do
  user = User.create(
    user_type: "Employee",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    telephone: Faker::PhoneNumber.cell_phone,
    email: Faker::Internet.email,
    password_digest: "123"
    )

  Employee.create(
    user_id: user.id,
    industry: industry.sample,
    job_title: job_title.sample,
    bio: Faker::Lorem.sentence(3),
    location: "San Francisco, CA"
  )

end

employers = Employer.all

employers.each do |employer|
  (1..5).to_a.sample.times do
    days = (1..5).to_a.sample
    Post.create(
      employer_id: employer.id,
      wage: 15.00,
      job_title: job_title.sample,
      start_date: Chronic.parse('tomorrow at 9pm'),
      end_date: Chronic.parse("in #{days} days"),
      start_time: Chronic.parse('tomorrow at 9pm'),
      end_time: Chronic.parse('tomorrow at 12pm'),
      description: Faker::Lorem.sentence(3),
      location: "San Francisco, CA",
      expiration_status: Chronic.parse("in #{days} days")
      )
  end
end