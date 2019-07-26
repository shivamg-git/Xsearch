require 'open-uri'
require 'nokogiri'

URL= "http://dict.hinkhoj.com/hindi-dictionary.php?scode=dict_home&word="
keyword = "apple"
uri = URI.parse(URL+keyword)
page = uri.open.read

html_doc = Nokogiri::HTML(page)
eng 	=[]
hind 	=[]
mix 	=[]

html_doc.css("a.eng_dict_span").children.each_with_index do |m,i|
	eng << m.text 
end

html_doc.css("a.hin_dict_span").children.each_with_index do |m,i|
	hind<<m.text
end

eng.length.times do |i|
	mix<< {eng: eng[i] ,hind: hind[i]}
end

mix.each do |s| 
	print s[:eng] + " => " + s[:hind] +  "\n"
	
end




# puts checkmark.encode('utf-8')


# File.open("Hindkhoj.html", "w") { |io|  
	# io.write page
# }
# system("subl Hindkhoj.html")