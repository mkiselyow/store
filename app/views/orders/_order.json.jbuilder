json.extract! order, :id, :first_name, :last_name, :number, :comment, :city, :post_office_number, :pay_type, :created_at, :updated_at
json.url order_url(order, format: :json)
