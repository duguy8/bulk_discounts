require 'rails_helper'

RSpec.describe "When a user adds songs to their cart" do
  it "displays a message" do
    merchant = create(:merchant)
    item1 = merchant.items.create(
      name: "Sweet Item",
      description: "Lovely Item",
      unit_price: 100
    )
    item2 = merchant.items.create(
      name: "Guitar Amp",
      description: "Loud",
      unit_price: 2000
    )
    item3 = merchant.items.create(
      name: "Coffee",
      description: "The Best",
      unit_price: 50
    )

    visit merchant_items_path(merchant)

    within("#item-#{item1.id}") do
      click_button "Add Item"
    end

    expect(page).to have_content("You now have 1 #{item1.name} in your cart.")
  end
end
