class User
  	attr_accessor :name, :email
 	def initialize(attributes = {})
    	@name  = attributes[:name]
    	@email = attributes[:email]
	end
  	def formatted_email
    	"#{name} <#{email}>"
	end 
end

puts User.new({:name => "bob", :email => "bob@marley.com"}).formatted_email 