require 'rails_helper'

RSpec.describe "When a user adds songs to their cart" do
  before :each do
    @merchant = create(:merchant)
    @item1 = @merchant.items.create(
      name: "Sweet Item",
      description: "Lovely Item",
      unit_price: 100
    )
    @item2 = @merchant.items.create(
      name: "Guitar Amp",
      description: "Loud",
      unit_price: 2000
    )
    @item3 = @merchant.items.create(
      name: "Coffee",
      description: "The Best",
      unit_price: 50
    )
  end

  describe "When I add one song to cart" do
  it "displays a message" do
    visit merchant_items_path(@merchant)

    within("#item-#{@item1.id}") do
      click_button "Add Item"
    end

    expect(page).to have_content("You now have 1 #{@item1.name} in your cart.")
  end
end

  describe "When I add multiple songs to the cart" do
    it "Correctly Increments and shows cart trackers" do
      visit merchant_items_path(@merchant)

      expect(page).to have_content("Items in Cart: 0")

      within("#item-#{@item1.id}") do
        click_button "Add Item"
      end

      expect(page).to have_content("Items in Cart: 1")

      within("#item-#{@item2.id}") do
        click_button "Add Item"
      end

      expect(page).to have_content("Items in Cart: 2")

      within("#item-#{@item1.id}") do
        click_button "Add Item"
      end

      expect(page).to have_content("Items in Cart: 3")
    end
  end
end
