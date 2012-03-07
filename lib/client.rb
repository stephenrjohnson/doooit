require_relative 'settings.rb'
require 'producteev'
require 'colorize'

module Doit
  class Client

	  def initialize
	  end
	   
	   @@instance = Client.new
	 
	  def self.instance
	    return @@instance
	  end
	 
	  def connect(key, secert)
	    @@api = Producteev.new(key,secert)
	  end

	  def login(username, password)
	    @@client = @@api.login(username,password)
	  end

	  def self.connection
	  	return @@client
	  end

	  def self.printtask(task)
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
	 
	  private_class_method :new
  end
end
