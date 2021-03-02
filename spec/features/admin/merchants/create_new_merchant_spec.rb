require "rails_helper"

RSpec.describe "When I visit the admin merchants index" do
  before :each do
    @merchants = create_list(:merchant, 5)
    @bad_merchant = create(:merchant, status: true)
  end
  describe 'I see a link to create a new merchant' do
    it 'takes me to new form on click' do
      visit admin_merchants_path

      click_link "Create a new Merchant"

      expect(current_path).to eq(new_admin_merchant_path)
    end
    it 'Creates a new merchant and redirects to index with flash/default of disabled' do
      visit new_admin_merchant_path

      fill_in :merchant_name, with: 'New Merchant Name'
      click_button 'Create Merchant'

      expect(current_path).to eq(admin_merchants_path)

      expect(page).to have_content('Merchant Created Successfully')

      within('.disabled_merchants') do
        expect(page).to have_content("New Merchant Name")
      end
    end
    it "Does not get created without a name" do
      visit new_admin_merchant_path

      fill_in :merchant_name, with: ' '

      click_button 'Create Merchant'

      expect(page).to have_content('Required Information Missing')
    end
  end
end
