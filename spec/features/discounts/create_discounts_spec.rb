require "rails_helper"

RSpec.describe "As a merchant on my discounts index" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
    @discount2 = create(:discount, merchant_id: @merchant.id)
    @discount3 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a link to create a new discount" do
    it "takes me to a /new page where I see a form to add a new discount" do
      visit merchant_discounts_path(@merchant)

      expect(page).to have_link("Create a new Discount")

      click_link "Create a new Discount"

      expect(current_path).to eq(new_merchant_discount_path(@merchant))
    end
    it "takes me back to index after filling out where I see new discount"
    it "renders new form if I dont enter valid data"
  end
end


# As a merchant
# When I visit my bulk discounts index
# Then I see a link to create a new discount
# When I click this link
# Then I am taken to a new page where I see a form to add a new bulk discount
# When I fill in the form with valid data
# Then I am redirected back to the bulk discount index
# And I see my new bulk discount listed
