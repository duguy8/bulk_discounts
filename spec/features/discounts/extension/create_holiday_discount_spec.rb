require "rails_helper"

RSpec.describe "When I visit the discounts index page" do

  describe "In the ~Holiday Discounts~ section" do
    it "I see a ~Create Discount~ next to each upcoming holiday"
    it "When I click the button it takes me to a new discount form"
    it "Form is pre-populated with this stuff"
    it "Can be left as is, or modified"
    it "Should redirect to discounts index where I see new discount added"
  end
end



# As a merchant,
# when I visit the discounts index page,
# In the Holiday Discounts section, I see a
# create discount button next to each of the 3 upcoming holidays.
# When I click on the button I am taken to
# a new discount form that has the form fields auto populated with the following:
#
# Discount name: discount
# Percentage Discount: 30
# Quantity Threshold: 2
#
# I can leave the information as is, or modify
# it before saving.
# I should be redirected to the discounts index
# page where I see the newly created discount added to the list of discounts.
