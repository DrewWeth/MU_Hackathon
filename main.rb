require 'rubygems'
require 'oauth'
require 'json'
require 'twitter'
require 'sinatra'


# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.


def method_name (userName)
	
consumer_key = OAuth::Consumer.new(
    "laBnLMwlztPiVVMkInoNPQ",
    "eknfQt4s1oqUToGnvGxUfdeSAm4ELWdqkNLcPQ02jg")
access_token = OAuth::Token.new(
    "364668892-xtPlJPHcWPSbaSS6AUMo0UkkkHKCA06lK6xuxaxj",
    "YLcPvyhtdg9S8R9rNKBy7MICQXkVnb1eniPS3OixfZQfr")
	# Now you will fetch /1.1/statuses/user_timeline.json,
	# returns a list of public Tweets from the specified
	# account.
	baseurl = "https://api.twitter.com"
	path    = "/1.1/statuses/user_timeline.json"
	query   = URI.encode_www_form(
	    "screen_name" => "#{userName}",
	    "count" => 5000,
	)

	address = URI("#{baseurl}#{path}?#{query}")
	request = Net::HTTP::Get.new address.request_uri


	# Set up Net::HTTP to use SSL, which is required by Twitter.
	http = Net::HTTP.new address.host, address.port
	http.use_ssl = true
	http.verify_mode = OpenSSL::SSL::VERIFY_PEER


	# Issue the request.
	request.oauth! http, consumer_key, access_token
	http.start
	response = http.request request

	# Parse and print the Tweet if the response code was 200
	following = []
	users = nil
	if response.code == '200' then
	    users = JSON.parse(response.body)
	end 
	users
end

# Parse a response from the API and return a user object.
def print_tweet(users)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    users.each do |user| 
    	puts user["text"]
    end
end

def calculate_nice_words (users)
	happy_word = Hash.new(0)
	file_name = "happywords.txt"
	File.open(file_name, "r").each_line do |line|
		happy_word[line.strip] = 1 
	end
	happy_count = 0
	users.each do |user|
		#puts user["text"].strip
		user["text"].strip.split(' ').each do |s|
			# puts s.strip
			if happy_word[s] == 1 then
				puts "YAY!!! #{s}"
				happy_count += 1
			end
		end
	end
	happy_count
end

def calculate_bad_words (users)
	happy_word = Hash.new(0)
	file_name = "badwords.txt"
	File.open(file_name, "r").each_line do |line|
		happy_word[line.strip] = 1 
	end
	happy_count = 0
	users.each do |user|
		#puts user["text"].strip
		user["text"].strip.split(' ').each do |s|
			# puts s.strip
			if happy_word[s] == 1 then
				puts "WHAT?!?!?! #{s}"
				happy_count += 1
			end
		end
	end
	happy_count
end




get '/' do
	erb :index
end

post '/' do
	users = method_name(params[:username])
	@happy_word = calculate_nice_words(users)
	@bad_word = calculate_bad_words(users)
	return "Nice words: #{@happy_word}\nBad words: #{@bad_word}"
end

