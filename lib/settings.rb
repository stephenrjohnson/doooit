require 'settingslogic'
class Settings < Settingslogic
	def self.load
		if File.exist?(File.expand_path("~/.doit"))
	    	@@config = File.expand_path("~/.doit")
	    elsif File.exist?(File.expand_path("../config/doit"))
	    	@@config = File.expand_path("../config/doit")  
	    else
	      puts "There's no configuration! please create one at ~/.doit"
	      exit!
	  	end
	    source @@config
	end
end
