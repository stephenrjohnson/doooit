require_relative 'settings.rb'
require 'producteev'

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

	  private_class_method :new
   end

end
