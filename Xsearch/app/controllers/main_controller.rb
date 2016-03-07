class MainController < ApplicationController
  
  def index
  end

  def search
		key = params[:search].split.join("+")
  	@results = hind_scrapp(key)
  end


  private

  class Result
		attr_accessor :eng_word, :eng_word_url, :hin_word, :hin_word_url, :pr, :pr_url, :grm, :usage
	end

	def hind_scrapp(key)
		require "nokogiri"
		require 'open-uri'
		
		page_found = false
		results_found = false

		begin
			url = "http://dict.hinkhoj.com/hindi-dictionary.php?word=#{key}&ie=UTF-8"
			doc = Nokogiri::HTML(open(url))
		rescue Exception => e
			puts "block 1 for " + key
			puts e
		else
			page_found = true	unless doc.blank?	
		end

		if page_found
			begin
				results_all  = doc.css('div[itemprop = "itemListElement"] > div[@class = "border-div"]')
				unless results_all.empty?
					results = results_all.select{|node| node.css('a').count != 0 }
					results = results[0...10] if results.count > 10
					results_found = true
				end
			rescue Exception => e
				puts "block 2 for " + key
				puts e
			end
		end

		@results = []
		if results_found
			begin
				results.each do |result|
					@result = Result.new
					
					e_word 							= result.css('a.eng_dict_span')
					@result.eng_word 			= e_word.css('span').text	
					@result.eng_word_url 	= e_word[0]['href']
				
					h_word 							= result.css('a.hin_dict_span')
					@result.hin_word 			= h_word.css('span').text
					@result.hin_word_url 	= h_word[0]['href']

					pr = result.css('span.tlr > a')
					@result.pr = pr.text
					@result.pr_url = pr[0]['href']

					@result.grm = result.css('span.gram_dict_span').text
					@result.usage = result.css('span.dict_examp').text
					@results << @result
				end
			rescue Exception => e
				puts "block 3 for " + key
				puts e	
			end
		end
		return @results
	end

end

