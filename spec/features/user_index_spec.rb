require 'rails_helper'
require 'json'
require 'net/http'

RSpec.feature 'User Index Page', type: :feature do
  scenario 'User visits the user index page with random users' do
    # Make an HTTP request to the Random User Generator API
    uri = URI('https://randomuser.me/api/?results=5') # Adjust the number of results as needed
    response = Net::HTTP.get(uri)

    # Parse the JSON response
    user_data = JSON.parse(response)

    # Extract user information and create test users
    user_data['results'].each do |random_user|
      name = "#{random_user['name']['first']} #{random_user['name']['last']}"
      profile_picture_url = random_user['picture']['large']

      User.create(name:, photo: profile_picture_url)
    end

    visit users_path

    # Verify that the usernames of all users are displayed
    User.all.each do |user|
      expect(page).to have_content(user.name)
      expect(page).to have_css("img[src*='#{user.photo}']")
      expect(page).to have_content("Posts: #{user.posts.count}")
      click_link user.name
      expect(page).to have_current_path(user_path(user))
      visit users_path
    end
  end
end
