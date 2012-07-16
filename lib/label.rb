module Doit
	class Label
		##create label id if not present and returns ids 
		def self.labelids(text)
			labels = text.scan(/\+\w+/)
      clabels = []
      labelids = []

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
          responce = Client.connection.labels.create(:title => label, :id_dashboard => Dashboard.currentdashboard)
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