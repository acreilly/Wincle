require 'faker'
require 'chronic'

industry = ["Accounting", "Airlines/Aviation", "Alternative Dispute Resolution", "Alternative Medicine", "Animation", "Apparel & Fashion"]
job_title = ["Accountant","Stewardess", "Alternative Disputant", "Fake Doctor", "Animator", "Fashion Designer"]
longs = [-122.411295, -122.408849, -122.409849, -122.397733, -122.4, -122.75, -122.738, -122.433396, -122.44, -122.45]
lat = 37.785126
var = (1..5).to_a.sample

5.times do
  user = User.create(
    user_type: "Employer",
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    email: Faker::Internet.email
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
    email: Faker::Internet.email
    )

  Employee.create(
    user_id: user.id,
    industry: industry.sample,
    job_title: job_title.sample,
    bio: Faker::Lorem.sentence(3),
    location: "San Francisco, CA",
    latitude: lat,
    longitude: longs.sample
    )
end

employers = Employer.all

employers.each do |employer|
  (1..5).to_a.sample.times do
    days = (1..5).to_a.sample
    Post.create(
      employer_id: employer.id,
      wage: 15.00,
      industry: employer.industry,
      job_title: job_title.sample,
      start_date: Chronic.parse('tomorrow at 9pm'),
      end_date: Chronic.parse("in #{days} days"),
      start_time: Chronic.parse('tomorrow at 9pm'),
      end_time: Chronic.parse('tomorrow at 12pm'),
      description: Faker::Lorem.sentence(3),
      location: "San Francisco, CA",
      expiration_status: Chronic.parse("in #{days} days"),
      latitude: lat,
      longitude: longs.sample + var
      )
  end
end