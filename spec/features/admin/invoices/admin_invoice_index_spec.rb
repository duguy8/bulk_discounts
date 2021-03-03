require 'rails_helper'

RSpec.describe "When I visit the admin Invoices index" do
  before :each do
    @invoices = create_list(:invoice, 5)
  end

  it "displays all invoice ids" do
    visit admin_invoices_path

    expect(page).to have_content(@invoices.first.id)
    expect(page).to have_content(@invoices.second.id)
    expect(page).to have_content(@invoices.third.id)
    expect(page).to have_content(@invoices.fourth.id)
    expect(page).to have_content(@invoices[4].id)

    expect(page).to have_link("#{@invoices.first.id}")
    expect(page).to have_link("#{@invoices.second.id}")
    expect(page).to have_link("#{@invoices.third.id}")
    expect(page).to have_link("#{@invoices.fourth.id}")
    expect(page).to have_link("#{@invoices[4].id}")
  end
end
