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

  	desc 'TASKID "TEXT TO ADD"'
  	def prepend (taskid,text)
    	task = Task.view(:id_task => taskid)
      Task.print(task['task'])
      updatetask = Task.set_title(:id_task => taskid,:title => "#{task['task']['title']} #{text}")
      Task.print(updatetask['task'])
  	end

  	desc 'TASKID "TEXT TO APPEND"'
  	def append (taskid,text)
    	task = Task.view(:id_task => taskid)
      Task.print(task['task'])
      updatetask = Task.set_title(:id_task => taskid,:title => "#{text} #{task['task']['title']}")
      Task.print(updatetask['task'])
  	end

  	desc 'TASKID'
  	def del (taskid)
      task = Task.view(:id_task =>taskid)
    	responce = Task.delete(:id_task =>taskid)
      puts "Deleted"
      Task.print(responce['task'])
  	end

  	desc 'TASKID'
  	def do (*taskid)
      if taskid.kind_of?(Array)
        taskid.each do |id|
          responce = Task.set_status(:id_task =>id,:status=>2)
          puts "Marked Completed"
          Task.print(responce['task'])
        end
      else
      	responce = Task.set_status(:id_task =>taskid,:status=>2)
        puts "Marked Completed"
        Task.print(responce['task'])
      end
  	end

    desc 'Alias to do'
    def d (*taskid)
      self.do(taskid)
    end

    desc 'TASKID'
    def undo (taskid)
      responce = Task.set_status(:id_task =>taskid,:status=>1)
      puts "Marked uncompleted"
      Task.print(responce['task'])
    end

    desc 'Alias to undo'
    def ud (taskid)
      self.undo(taskid)
    end

  	desc 'List all uncompleted'
  	def list
     Task.printtasks(Task.my_tasks['tasks'],true)
  	end

    desc 'Alias to list'
    def l 
      self.list
    end

  	desc 'List all completed'
  	def listcon
    	Task.printtasks(Task.archived['tasks'])
  	end

    desc 'Alias to listcon'
    def lc
      self.listcon
    end

  	desc 'TASKID "UPDATED TODO"'
  	def replace(taskid,text)
    	task = Task.view(:id_task => taskid)
      Task.print(task['task'])
      updatetask = Task.set_title(:id_task => taskid,:title => "#{text}")
      Task.print(updatetask['task'])
  	end

    desc 'Set Priority"'
    def priority(taskid,star)
        taskid = taskid.to_i
        star = star.to_i
        if star > 0 && star < 6 && taskid > 0
          responce = Task.set_star(:id_task=>taskid,:star=>star)
          puts "Update #{taskid} to priority #{star}"
          Task.print(responce['task'])
        else
          puts "Invalid input"
          exit 1
        end
    end

    desc 'Alias to Priority'
    def p(taskid,star)
      self.priority(taskid,star)
    end

  end
end
