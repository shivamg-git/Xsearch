require 'open-uri'
require 'nokogiri'

keyword = "xman"
URL= "https://www.youtube.com/results?search_query=#{keyword}"

uri = URI.parse(URL)
page = uri.open.read

# File.open("Youtube.html", "w") { |io|  
	# io.write page
# }
# system("subl Youtube.html")


html_doc = Nokogiri::HTML(page)
links =[]
html_doc.css("h3.yt-lockup-title").children.each do |p1|
	links << p1['href'] if p1['href']
end
p links