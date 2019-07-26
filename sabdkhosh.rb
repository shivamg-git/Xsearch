require 'open-uri'
require 'nokogiri'

keyword = "apple"
URL= "http://www.shabdkosh.com/hi/translate?e=#{keyword}&l=hi"

uri = URI.parse(URL)
page = uri.open.read

# File.open("Hindkhoj.html", "w") { |io|  
	# io.write page
# }
# system("subl Hindkhoj.html")

html_doc = Nokogiri::HTML(page)
all     = []
mix 	= []

html_doc.css("a.in").children.each do |m|
	all << m.text 
end
pre=[]
post=[]

all.each_with_index do |e,i|
	if e =~ /[a-z]+/i
		pre  = all[0,i] 
		post = all-pre	
		break
	end
end

p pre
p post