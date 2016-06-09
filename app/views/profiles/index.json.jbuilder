json.array!(@profiles) do |profile|
  json.extract! profile, :id, :first_name, :last_name, :company_name, :address, :county, :zip, :phone1, :phone2, :email, :web, :city
  json.url profile_url(profile, format: :json)
end
