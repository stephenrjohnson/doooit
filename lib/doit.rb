require_relative 'settings'
require 'boson/runner'
require_relative 'client'
require_relative 'task'

module Doit
  class Doit < Boson::Runner

	  desc 'THING I NEED TO DO +project @context'
  	def add (*text)
  		text = text.join(" ")
      task = Client.connection.tasks.create(:title =>text)
      Task.print(task['task'])
  	end

    desc 'Alias to add'
    def a (*text)
      self.add(text)
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
      task = Client.connection.tasks.view(:id_task =>item)
      if task.has_key?('error')
        puts task['error']['message']
        exit 1
      else
    	  responce = Client.connection.tasks.delete(:id_task =>item)
        if responce.has_key?('error')
          STDERR.puts responce['error']['message']
          exit 1
        else
          puts "Deleted"
          Task.print(task['task'])
        end
      end
  	end

  	desc 'ITEM#'
  	def do (item)
    	responce = Client.connection.tasks.set_status(:id_task =>item,:status=>2)
      if responce.has_key?('error')
        puts responce['error']['message']
        exit 1
      else
        puts "Marked Completed"
        Task.print(responce['task'])
      end
  	end

    desc 'Alias to do'
    def d (item)
      self.do(item)
    end

    desc 'ITEM#'
    def undo (item)
      responce = Client.connection.tasks.set_status(:id_task =>item,:status=>1)
      if responce.has_key?('error')
        STDERR.puts responce['error']['message']
        exit 1
      else
        puts "Marked uncompleted"
        Task.print(responce['task'])
      end
    end


    desc 'Alias to undo'
    def ud (item)
      self.undo(item)
    end

  	desc 'List all uncompleted'
  	def list
     Task.printtasks(Client.connection.tasks.my_tasks['tasks'],true)
  	end

    desc 'Alias to list'
    def l 
      self.list
    end

  	desc 'List all completed'
  	def listcon
    	Task.printtasks(Client.connection.tasks.archived['tasks'])
  	end

    desc 'Alias to listcon'
    def lc
      self.listcon
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
            STDERR.puts responce['error']['message']
            exit 1
          else
            puts "Update #{item} to priority #{star}"
            Task.print(responce['task'])
          end
        else
          puts "Invalid input"
          exit 1
        end
    end

    desc 'Alias to Priority'
    def p(item,star)
      self.priority(item,star)
    end

  end
end
