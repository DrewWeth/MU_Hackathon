require 'rubygems'
require 'oauth'
require 'json'
require 'twitter'


user = Twitter::Client.new(
  :consumer_key => "laBnLMwlztPiVVMkInoNPQ",
  :consumer_secret => "eknfQt4s1oqUToGnvGxUfdeSAm4ELWdqkNLcPQ02jg",
  :oauth_token => "364668892-xtPlJPHcWPSbaSS6AUMo0UkkkHKCA06lK6xuxaxj",
  :oauth_token_secret => "YLcPvyhtdg9S8R9rNKBy7MICQXkVnb1eniPS3OixfZQfr")



# Parse a response from the API and return a user object.
def print_tweet(users)
  # ADD CODE TO ITERATE THROUGH EACH TWEET AND PRINT ITS TEXT
    users.each do |user| 
    	puts user
    end
end

def getUserStream (followers) 
	userTweets =[]
	followers.each do |user|
		userTweets << Twitter.user_timeline(user)
	end
	userTweets
end

list = user.followers

list.each do |user|
	put user
end
=begin
arrOfUsers=[]
10.times do |list|
	arrOfUsers << client.user(user)
end
=end