require "rails_helper"


RSpec.describe "When I visit the admin merchants index" do
  before :each do
    @merchants = create_list(:merchant, 5)
    @bad_merchant = create(:merchant, status: true)
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

    describe "On a merchants admin show page I see a link to update info" do
      it "Im taken to a page to edit the merchants info" do
        visit admin_merchant_path(@merchants.first)

        expect(page).to have_link("Update Merchant Information")
        click_link("Update Merchant Information")

        expect(current_path).to eq(edit_admin_merchant_path(@merchants.first))
      end

      it "Updates merchant with a flash after clicking ~submit~" do
        visit edit_admin_merchant_path(@merchants.first)

        fill_in 'merchant_name', with: "New Merchant Name"
        click_button "Update Merchant"

        expect(current_path).to eq(admin_merchant_path(@merchants.first))
        expect(page).to have_content("New Merchant Name")
        expect(page).to have_content("Merchant Updated Successfully")
      end

      it "Does not update without name" do
        visit edit_admin_merchant_path(@merchants.first)

        fill_in 'merchant_name', with: ""
        click_button "Update Merchant"

        expect(page).to have_content("Required Information Missing")
      end
    end

    describe "When I visit the admin merchants index" do
      it "Has a button to enable or disable the merchant" do
        visit admin_merchants_path
        # save_and_open_page
        within("#merchant-#{@merchants.first.id}") do
          expect(page).to have_button("Enable Merchant")
        end
      end

      it "Redirects to admin merchant index with status changed" do
        visit admin_merchants_path

        within("#merchant-#{@merchants.first.id}") do
          click_button("Enable Merchant")
        end

        expect(current_path).to eq(admin_merchants_path)

        within("#merchant-#{@merchants.first.id}") do
          expect(page).to have_button("Disable Merchant")
        end
      end

      it "Each merchant is in appropriate section enabled/disabled" do
        visit admin_merchants_path

        within(".enabled_merchants") do
          expect(page).to have_content(@bad_merchant.name)
          expect(page).to have_button("Disable Merchant")
        end

        within(".disabled_merchants") do
          expect(page).to have_content(@merchants.first.name)
          expect(page).to have_content(@merchants.last.name)
        end

        within("#merchant-#{@merchants.first.id}") do
          expect(page).to have_button("Enable Merchant")
        end
      end
    end
  end
end
