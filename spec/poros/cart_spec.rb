require 'rails_helper'

RSpec.describe Cart do

  describe "#total" do
    it "can calculate the total number of items it holds" do
      cart = Cart.new({
        '1' => 2,  # two copies of item 1
        '2' => 3   # three copies of item 2
      })
      expect(cart.total).to eq(5)
    end
  end
end
