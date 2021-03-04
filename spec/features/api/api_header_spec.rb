require "rails_helper"

RSpec.describe "api information in page headers" do
  before :each do
    @merchant = create(:merchant)
  end

  it 'displays a header with github repo' do

    visit admin_index_path

<<<<<<< HEAD
    expect(page).to have_content("little-esty-shop")
=======
>>>>>>> e504f6956a7332439e5f4bb952c36268dae4cbfa
    expect(page).to have_content("little-esty-shop")
  end

  it "I see the Github usernames of all teammates and number of commits for each teammate" do
    visit admin_index_path

    expect(page).to have_content("Trevor-Robinson")
    expect(page).to have_content("duguy8")
    expect(page).to have_content("Wil-McC")
    expect(page).to have_content("#{GitService.screen_contributors[0][:contributions]}")
    expect(page).to have_content("#{GitService.screen_contributors[1][:contributions]}")
    expect(page).to have_content("#{GitService.screen_contributors[2][:contributions]}")

    expect(page).to have_content("duguy8")
    expect(page).to have_content("Trevor-Robinson")
    expect(page).to have_content("Wil-McC")
  end

  it 'shows number of prs' do
    visit admin_index_path
<<<<<<< HEAD
    
=======

>>>>>>> e504f6956a7332439e5f4bb952c36268dae4cbfa
    expect(page).to have_content("#{GitService.prs}")
    expect(page).to have_content("#{GitService.prs}")
  end
end
