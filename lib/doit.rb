require_relative 'settings'
require 'boson/runner'
require_relative 'client'

module Doit
  class Doit < Boson::Runner
	  desc 'THING I NEED TO DO +project @context'
  	def add (*text)
  		text = text.join(" ")
      task = Client.connection.tasks.create(:title =>text)
      puts "Created ID #{task['task']['id_task']}"
  	end

  	desc 'DEST "TEXT TO ADD"'
  	def prepend (item,text)
    	puts "MOOOO"
  	end

  	desc 'ITEM# "TEXT TO APPEND"'
  	def append (item,text)
    	puts "MOOOO"
  	end

  	desc 'ITEM#'
  	def del (item)
    	puts "MOOOO"
  	end

  	desc 'ITEM#'
  	def do (item)
    	puts "MOOOO"
  	end

  	desc ''
  	def list
      Client.connection.tasks.show_list['tasks'].each do | task, id |
        Client.printtask(task['task'])
      end
  	end

  	desc ''
  	def listall
    	puts "MOOOO"
  	end

  	desc ''
  	def listcon
    	puts "MOOOO"
  	end

  	desc 'replace ITEM# "UPDATED TODO"'
  	def replace(item,test)
    	puts "MOOOO"
  	end

    desc 'Set Priority"'
    def priority(item,star)
        item = item.to_i
        star = star.to_i
        if star > 0 && star < 6 && item > 0
          responce = Client.connection.tasks.set_star(:id_task=>item,:star=>star)
          if responce.has_key?('error')
            puts responce['error']['message']
          else
            puts "Update #{item} to priority #{star}"
            Client.printtask(responce['task'])
          end
        else
          puts "Invalid input"
        end
    end
  end
end