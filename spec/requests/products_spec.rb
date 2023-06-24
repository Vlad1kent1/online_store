require "rails_helper"

RSpec.describe "/products", type: :request do
  let!(:product) { create(:product) }

  let(:new_attributes) { { product: attributes_for(:product) } }
  let(:valid_attributes) { { product: attributes_for(:product) } }
  let(:invalid_attributes) { { product: attributes_for(:product, :invalid_product) } }

  describe "GET /index" do
    it "renders a successful response" do
      get products_path

      expect(response).to be_successful
      expect(response).to render_template(:index)
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      get product_path(product)

      expect(response).to be_successful
      expect(response).to render_template(:show)
    end
  end
end
