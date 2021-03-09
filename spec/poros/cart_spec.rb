require 'rails_helper'

RSpec.describe Cart do
  subject { Cart.new({
    '1' => 2,  # two copies of item 1
    '2' => 3   # three copies of item 2
    }) }

  describe "#total" do
    it "can calculate the total number of items it holds" do
      expect(subject.total).to eq(5)
    end
  end

  describe "#add_item" do
    it "adds an item to its contents" do
      subject.add_item(1)
      subject.add_item(2)

      expect(subject.contents).to eq({'1' => 3, '2' => 4})
    end

    it "adds an item that hasen't been added yet" do
      subject.add_item('3')

      expect(subject.contents).to eq({'1' => 2, '2' => 3, '3' => 1})
    end
  end

  describe "#count_of" do
    it "returns the count of all items in cart" do
      cart = Cart.new({})

      expect(cart.count_of(5)).to eq 0
    end
  end
end
