class Admin::InvoicesController < ApplicationController
  before_action :set_invoice, only: [:show, :update]

  def index
    @invoices = Invoice.all
  end

  def show
  end

  def update
    @invoice.update(invoice_params)
    redirect_to admin_invoice_path(@invoice)
  end

  private

  def set_invoice
    @invoice = Invoice.find(params[:id])
  end

  def invoice_params
    params.require(:invoice).permit(:status)
  end
end
