module Prices
  class CreateService < ::ApplicationService
    def initialize(product, params)
      super
      @product = product
      @params = params
    end

    def call
      tx_and_commit do
        @object = @product.prices.build @params
        @object.save
      end

      super
    end

    private

    def post_call
      broadcast_later [@product, :prices],
                      'prices/created',
                      locals: { price: @object }
    end
  end
end