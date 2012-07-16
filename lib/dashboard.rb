module Doit
  class Dashboard
    @@dashboard = nil
    ##create label id if not present and returns ids 
    def self.dashboards
      ##Return dashboards
      dashboard = Client.connection.dashboards.show_list
      return dashboard['dashboards']
    end

    def self.printdashboards
      self.dashboards.each do |dashboard|
        self.print dashboard
      end
    end

    def self.print(dashboard)
      puts "#{dashboard['dashboard']['id_dashboard']} #{dashboard['dashboard']['title']}"
    end
    
    def self.currentdashboard
      begin
        return Settings.doit.dashboardid
      rescue
        return nil
      end
    end
  end
end