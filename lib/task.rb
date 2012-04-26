require_relative 'settings.rb'
require 'colorize'

module Doit
	class Task
	  	def self.printtask(task, sorted = false)
		  	case task['star']
		  		when "1"
		  			task['colour'] = :blue
		  		when "2"
		  			task['colour'] = :green
		  		when "3"
		  			task['colour'] = :light_yellow
		  		when "4"
		  			task['colour'] = :yellow
		  		when "5"
		  			task['colour'] = :red
		  	end
	  		puts "#{task['id_task'].strip} (#{task['star'].strip}) #{task['title'].strip}".colorize(task['colour'])
	  	end

	  	def self.printtasks(tasks,sorted = false)
	  		if sorted
	  			tasks.sort!{|a,b| b['task']['star'].to_i <=> a['task']['star'].to_i}
	  		end
	  		tasks.each do | task, id |
        		self.printtask(task['task'])
      		end
	  	end
  	end
end