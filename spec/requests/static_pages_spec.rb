require 'spec_helper'

describe "StaticPages" do

  subject { page }

 it "should have the right links on the layout" do
    visit root_path
    click_link "About"
    expect(page).to have_title(full_title('About Us'))
    click_link "Help"
    expect(page).to have_content('Help')
    click_link "Contact"
    expect(page).to have_content('Contact')
    click_link "Home"
    click_link "Sign up now!"
    expect(page).to have_content('Sign up')
    click_link "sample app"
    expect(page).to have_content('sample app')
    
  end

  shared_examples_for "all static pages" do
    it { should have_content(heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    before { visit root_path }
    let(:heading)    { 'Sample App' }
    let(:page_title) { '' }

    it_should_behave_like "all static pages"
    it { should_not have_title('| Home') }

    #it "should have the title 'Home'" do
      #visit '/static_pages/home'
      #expect(page).to have_title("Ruby on Rails Tutorial Sample App | Home")
    #end
    describe "for signed-in users" do
      let(:user) { FactoryGirl.create(:user) }
      before do
        FactoryGirl.create(:micropost, user: user, content: "Lorem ipsum")
        FactoryGirl.create(:micropost, user: user, content: "Dolor sit amet")
        sign_in user
        visit root_path
      end

      it "should render the user's feed" do
        user.feed.each do |item|
          expect(page).to have_selector("li##{item.id}", text: item.content)
        end
      end
    end

  end


 describe "Help page" do
    before { visit help_path }

    it { should have_content('Help') }
    it { should have_title(full_title('Help')) }
  end

  describe "About page" do
    before { visit about_path }

    it { should have_content('About') }
    it { should have_title(full_title('About Us')) }
  end
  
  #describe "GET /static_pages" do
    #it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      #get static_pages_index_path
      #response.status.should be(200)
    #end
  #end
  describe "Contact page" do
    before { visit contact_path }

    it { should have_content('Contact') }
    it { should have_title(full_title('Contact')) }
  end
end