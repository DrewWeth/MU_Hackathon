require 'rubygems'
require 'oauth'
require 'json'
require 'twitter'

# Change the following values to those provided on dev.twitter.com
# The consumer key identifies the application making the request.
# The access token identifies the user making the request.
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
path    = "/1.1/followers/ids.json"
query   = URI.encode_www_form(
    "screen_name" => "DrewWeth",
    "count" => 300,
)

address = URI("#{baseurl}#{path}?#{query}")
request = Net::HTTP::Get.new address.request_uri


Twitter.configure do |config|
  config.consumer_key = "laBnLMwlztPiVVMkInoNPQ"
  config.consumer_secret = "eknfQt4s1oqUToGnvGxUfdeSAm4ELWdqkNLcPQ02jg"
  config.oauth_token = "364668892-xtPlJPHcWPSbaSS6AUMo0UkkkHKCA06lK6xuxaxj"
  config.oauth_token_secret = "YLcPvyhtdg9S8R9rNKBy7MICQXkVnb1eniPS3OixfZQfr")
end


# Parse a response from the API and return a user object.
def print_tweet(users)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    users.each do |user| 
    	puts user
    end
end

def getUserStream (followers) 
	userTweets = Array.new(20)
	followers.each do |user|
		userTweets << Twitter.user_timeline(user)
	end
	userTweets
end




# Set up Net::HTTP to use SSL, which is required by Twitter.
http = Net::HTTP.new address.host, address.port
http.use_ssl = true
http.verify_mode = OpenSSL::SSL::VERIFY_PEER


# Issue the request.
request.oauth! http, consumer_key, access_token
http.start
response = http.request request

# Parse and print the Tweet if the response code was 200

users = nil
if response.code == '200' then
    users = JSON.parse(response.body)
    following = Array.new(300) 
    following = users["ids"]

    print_tweet(following)
    
else 
	puts "getting 404"
end 