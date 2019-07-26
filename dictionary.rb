require 'open-uri'
require 'nokogiri'

keyword = "sex"
URL= "http://dictionary.reference.com/browse/#{keyword}?s=t"

uri = URI.parse(URL)
page = uri.open.read

# File.open("Hindkhoj.html", "w") { |io|  
	# io.write page
# }
# system("subl Hindkhoj.html")

html_doc = Nokogiri::HTML(page)
all=[]
html_doc.css("div.def-content").each do |i|
	all << i.text.gsub(/\n/,"") 
end
p all