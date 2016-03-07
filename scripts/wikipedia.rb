class WikiResult
	attr_accessor :url , :intro
end

def wiki(key)

	begin
		return nil if key.empty?		
		key = key.split.join("+")

		require "nokogiri"
		require 'open-uri'
		require 'uri'

		url = "https://www.google.com/search?q=#{key}+insite:wikipedia.com"
		return nil unless url =~ /\A#{URI::regexp(['http', 'https'])}\z/
  
  rescue Exception => e
  	puts "block 1"
  	puts e
	end

  results_google = nil
  begin
  	doc = Nokogiri::HTML(open(url))	
  rescue Exception => e
  	puts e
  	return nil
  else
  p	results_google = doc.css('div.kv > cite')[0...10].map(&:text)
  end
  
	# @results =[]
	# begin
	# 	results_google.each do |wiki_url|
	# 		if wiki_url =~ /\A#{URI::regexp(['http', 'https'])}\z/
	# 			result = WikiResult.new
	# 			result.url = wiki_url

	# 			wiki_doc = Nokogiri::HTML(open(wiki_url))
	# 			unless wiki_doc.blank?		
	# 				result.intro = wiki_doc.css('div#mw-content-text > p').text.gsub(/\[[0-9]{1,3}\]/) { |match| "" }	
	# 			end
	# 			@results << result
	# 		end
	# 	end	

	# rescue Exception => e
	# 	puts e	
	# end

end

t1 = Time.now
	wiki("apple")
t2 = Time.now
puts (t2-t1)
# p @results