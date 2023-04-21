json.extract! api_v1_rent, :id, :user_id, :movie_id, :rent_date, :return_date, :rent_period, :total_price, :total_fine, :created_at, :updated_at
json.url api_v1_rent_url(api_v1_rent, format: :json)
