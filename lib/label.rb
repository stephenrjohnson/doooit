module Doit
	class Label
		##create label id if not present and returns ids 
		def self.labelids(text)
			labels = text.scan(/\+\w+/)
      clabels = []
      labelids = []

      ##work out the first dashboard id
      dashboard = Client.connection.dashboards.show_list
      dashboardid = dashboard['dashboards'][0]['dashboard']['id_dashboard'] 

      #dont add labels we already have
      currentlabels = Client.connection.labels.show_list
      currentlabels = currentlabels['labels']
      currentlabels.each do |currentlabel|
        clabels << currentlabel['label']['title']
        if labels.include? currentlabel['label']['title'] 
          labelids << currentlabel['label']['id_label']
        end
      end

      #work out what we do and dont have
      missing = labels - clabels

      ##add the missing
      missing.each do |label|
          responce = Client.connection.labels.create(:title => label, :id_dashboard => dashboardid)
          labelids << responce['label']['id_label']
          if responce.has_key?('error')
            STDERR.puts responce['error']['message']
            exit 1
          end
      end
      return labelids
		end
		
	end
end