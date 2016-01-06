class Admin::OrdersController < AdminController
  before_filter do
    set_klass(Order)
    set_search_attrs(['id'])
  end

  private

  def resource_params
    params.require(:order).permit(:customer_id, :status, :shipping_cost,
                                  order_items_attributes: [
                                    :id, :_destroy, :order_id,
                                    :product_id, :quantity
                                  ])
  end

  def collection
    @resources = @klass.paginate(page: params[:page], per_page: 30).order('created_at desc')
    @resources = @resources.includes(order_items: :product)
  end
end