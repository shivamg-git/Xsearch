require 'open-uri'
require 'nokogiri'

# keyword = "xman"
URL= "https://www.facebook.com/groups/jiit.knuth/"

uri = URI.parse(URL)
page = uri.open.read

File.open("fb.html", "w") { |io|  
	io.write page
}
system("subl fb.html")


html_doc = Nokogiri::HTML(page)
p html_doc.css("div._1dwg")
