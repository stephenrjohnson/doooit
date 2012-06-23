require 'settingslogic'
class Settings < Settingslogic
	def self.load
		if File.exist?(File.expand_path("~/.doooit"))
	    	@@config = File.expand_path("~/.doooit")
	    elsif File.exist?(File.expand_path("../config/doooit"))
	    	@@config = File.expand_path("../config/doooit")  
	    else
	      puts "There's no configuration! please create one at ~/.doooit"
	      exit!
	  	end
	    source @@config
	end
end
