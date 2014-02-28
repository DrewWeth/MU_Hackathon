require 'rubygems'
require 'oauth'
require 'json'
require 'twitter'
require 'sinatra'
set :server, 'webrick'

class Word
   def initialize(word, tweet)
      @word=word
      @tweet=tweet
   end
   # accessor methods
   def getWord
      @word
   end

   def getTweet
      @tweet
   end
end

def method_name(userName)

	client = Twitter::REST::Client.new do |config|
	  config.consumer_key        = "laBnLMwlztPiVVMkInoNPQ"
	  config.consumer_secret     = "eknfQt4s1oqUToGnvGxUfdeSAm4ELWdqkNLcPQ02jg"
	  config.access_token        = "364668892-xtPlJPHcWPSbaSS6AUMo0UkkkHKCA06lK6xuxaxj"
	  config.access_token_secret = "YLcPvyhtdg9S8R9rNKBy7MICQXkVnb1eniPS3OixfZQfr"
	end

	puts "userName: ","#{userName}"
	# puts "latest follower", client.friends.first.user_name
	users = client.user_timeline("#{userName}")
	
end

=begin
def print_tweet(users)
 users.each do |user| 
    	puts user["text"]
    end
end
=end

def calculate_nice_words (users)
	happy_word = Hash.new(0)
	file_name = "happywords.txt"
	your_happy_Words = []
	File.open(file_name, "r").each_line do |line|
		line.strip.split(' ' || '\t').each do |s|
			happy_word[s] = 1
		end 
	end
	happy_count = 0
	users.each do |user|
		user["text"].strip.split(' ').each do |s|
			if happy_word[s] == 1 then
				newWordObj= Word.new(s, user["text"])
				your_happy_Words.push(newWordObj)
			end
		end
	end
	your_happy_Words
end

def calculate_bad_words (users)
	happy_word = Hash.new(0)
	your_bad_Words =[]
	file_name = "badwords.txt"
	File.open(file_name, "r").each_line do |line|
		line.strip.split(' ' || '\t').each do |s|
			happy_word[s] = 1
		end
	end
	happy_count = 0
	users.each do |user|
		user["text"].strip.split(' ').each do |s|
			if happy_word[s] == 1 then
				newWordObj = Word.new(s, user["text"])
				your_bad_Words.push(newWordObj)
			end
		end
	end
	your_bad_Words
end

get '/' do
	erb :index
end

get '/results/' do
	users = method_name(params[:username])
	@happy_word = calculate_nice_words(users)
	@bad_word = calculate_bad_words(users)
	erb :results
end

