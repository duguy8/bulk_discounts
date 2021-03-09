class Discount < ApplicationRecord
  validates :name, presence: true
  validates :quantity_threshold, presence: true
  validates :percentage_discount, presence: true
  belongs_to :merchant
  has_many :items, through: :merchant
  has_many :invoice_items, through: :items
  has_many :invoices, through: :invoice_items

  def pending_invoices
    invoice_items.where(status: 0)
  end
end
