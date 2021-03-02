require "rails_helper"


RSpec.describe "When I visit the admin merchants index" do
  before :each do
    @merchants = create_list(:merchant, 5)
  end

  describe "I see the name of each merchant in the system" do
    it "Displays merchant names" do
      visit admin_merchants_path

      expect(page).to have_content(@merchants.first.name)
      expect(page).to have_content(@merchants.last.name)
    end

    it "Name is a link to their admin/merchants/:id pages" do
      visit admin_merchants_path

      click_link("#{@merchants.first.name}")

      expect(current_path).to eq(admin_merchant_path(@merchants.first))
      expect(page).to have_content(@merchants.first.name)
    end
  end
end
