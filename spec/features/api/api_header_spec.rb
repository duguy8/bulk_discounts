require "rails_helper"

RSpec.describe "api information in page headers" do
  before :each do
    @merchant = create(:merchant)
  end

  it 'displays a header with github repo' do
    VCR.use_cassette("github_information") do

    visit admin_index_path

    expect(page).to have_content("little-esty-shop")
    end
  end

  it "I see the Github usernames of all teammates and number of commits for each teammate" do
    VCR.use_cassette("github_information_two") do

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
  end

  it 'shows number of prs' do
    VCR.use_cassette("github_information_three") do

    visit admin_index_path

    expect(page).to have_content("#{GitService.prs}")
    expect(page).to have_content("#{GitService.prs}")
    end
  end
end
