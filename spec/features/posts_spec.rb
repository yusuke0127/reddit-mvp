require 'rails_helper'

RSpec.feature "Posts", type: :feature do
  scenario "user creates a new post" do
    user = FactoryBot.create(:user)

    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    expect do
      fill_in "Title", with: "Test Post"
      fill_in "Content", with: "Trying out Capybara"
      click_button "Confirm"
      expect(page).to have_content "Test Post"
      expect(page).to have_content "#{user.email}"
    end.to change(user.posts, :count).by(1)
  end

  scenario "user adds a new comment" do
    user = FactoryBot.create(:user)
    post = FactoryBot.create(:post, user: user)

    visit root_path
    click_link "Login"
    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit(post_path(post))

    expect do
      fill_in "What's your thoughts?", with: "Test Comment"
      click_button "Comment"
      expect(page).to have_content "Test Comment"
    end.to change(post.comments, :count).by(1)
  end

  # scenario "user likes a post" do
  #   user = FactoryBot.create(:user)
  #   post = FactoryBot.create(:post, user: user)

  #   visit root_path
  #   click_link "Login"
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #   click_button "Log in"

  #   visit(post_path(post))

  #   save_and_open_page
  #   expect do
  #     within "post-info-comment-count" do
  #       click_link "/posts/#{post.id}/vote.upvote"
  #     end
  #   end.to change(post.get_upvotes, :size).by(1)

  # end
end
