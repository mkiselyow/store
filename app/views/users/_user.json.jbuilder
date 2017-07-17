json.extract! user, :id, :first_name, :last_name, :email, :number, :admin, :created_at, :updated_at
json.url user_url(user, format: :json)
