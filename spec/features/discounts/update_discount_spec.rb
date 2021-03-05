require "rails_helper"

RSpec.describe "As a merchant when I visit a discount show page" do
  before :each do
    @merchant = create(:merchant)

    @discount1 = create(:discount, merchant_id: @merchant.id)
  end

  describe "I see a link to ~Edit this Discount" do
    it "It takes me to a /edit page with a form to edit discount" do
      visit merchant_discount_path(@merchant, @discount1)

      expect(page).to have_link("Edit this Discount")
      
      click_link "Edit this Discount"

      expect(current_path).to eq(edit_merchant_discount_path(@merchant, @discount1))
    end


    it "Attributes are pre-populated, and when I change all info it updates"
    it "When I only update one attribute it still updates"
  end
end


# As a merchant
# When I visit my bulk discount show page
# Then I see a link to edit the bulk discount
# When I click this link
# Then I am taken to a new page with a form to edit the discount
# And I see that the discounts current attributes are pre-poluated in the form
# When I change any/all of the information and click submit
# Then I am redirected to the bulk discount's show page
# And I see that the discount's attributes have been updated
