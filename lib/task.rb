require_relative 'settings.rb'
require 'colorize'

module Doit
  class Task

	  def self.print(task)
	  	case task['star']
	  		when "1"
	  			colour = :blue
	  		when "2"
	  			colour = :green
	  		when "3"
	  			colour = :light_yellow
	  		when "4"
	  			colour = :yellow
	  		when "5"
	  			colour = :red
	  		end
	  		puts "#{task['id_task']} #{task['star']}  #{task['title']}".colorize(colour)
	  end
	 
  end
end
