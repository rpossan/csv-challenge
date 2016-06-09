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
		CSV.foreach('us-500.csv') do |row|
		  first_names row
		end	
  	end
  	
  	# Dinamically create magic methods to parse allowed columns
  	def method_missing(header, *args)
	    header = header.to_sym
	    if HEADER.include? header #If columns is allowed else print stacktrace
	      	p args.first[HEADER[header]]
	    else
	      p "#{header} method is missing! Column does not exist or not allowed."
	    end
  	end
  
end





