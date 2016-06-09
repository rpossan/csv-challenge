class ProfileLoader
	#predefined allowed columns
	HEADER = {
		first_name: 0,
		last_name: 1,
		company_name: 2,
		address: 3,
		city: 4,
		county: 5,
		state: 6,
		zip: 7,
		phone1: 8,
		phone2: 9,
		email: 10,
		web: 11
	}
	
	def initialize(path)
		@path = path
  	end
  	
  	# Read CSV from file and parse columns
  	def load
  		p "Loading ..."
  		path = path.nil? ? "us-500.csv" : path
  		ActiveRecord::Base.transaction do
			begin
				CSV.foreach(path, {:headers => :first_row}) do |row|
					state = load_state(row)
					city = load_city(row, state)
					load_profile(row, city)
				end
				p "All data are loaded successfully!"
			rescue
				raise ActiveRecord::Rollback
				p "A problem has occured. Database rollback has executed! Try again."
			end
		end
  	end
  	
  	# Remove all records from tables State, City and Profile
  	def self.purge
		ActiveRecord::Base.transaction do
			begin
				State.delete_all
				p "States cleared! OK"
				City.delete_all
				p "Cities cleared! OK"
				Profile.delete_all
				p "Profiles cleared! OK"
			rescue
				raise ActiveRecord::Rollback
				p "A problem has occured. Database rollback has executed! Try again."
			end
		end
  	end
  	
  	private
  	
  	# Create a new State if does not exist
  	def load_state(row)
  		state_name = state row
  		state_obj = State.find_by_name(state_name)
		unless state_obj
	 		state_obj = State.new({name: state_name})
	 		state_obj.save
	 	end
	 	return state_obj
  	end
  	
  	# Create a new City if does not exist
  	def load_city(row, state)
		city_name = city row
		city_obj = City.find_by_name(city_name)
		
	 	unless city_obj
	 		city_obj = City.new({name: city(row), state: state})
	 		city_obj.save
 		end
 		return city_obj
  	end
  	
  	# Create a new profile if does not exist
  	def load_profile(row, city)
	 	Profile.create({
			first_name: first_name(row),
			last_name: last_name(row),
			company_name: company_name(row),
			address: address(row),
			city: city,
			zip: zip(row),
			phone1: phone1(row),
			phone2: phone2(row),
			email: email(row),
			web: web(row)
	 	}) unless Profile.where(first_name: first_name(row), email: email(row)).exists?
  	end
  	
  	# Dinamically create magic methods to parse allowed columns
  	def method_missing(header, *args)
	    header = header.to_sym
	    if HEADER.include? header #If columns is allowed else print stacktrace
	      	args.first[HEADER[header]]
	    else
	      p "#{header} method is missing! Column does not exist or not allowed."
	    end
  	end
  
end





