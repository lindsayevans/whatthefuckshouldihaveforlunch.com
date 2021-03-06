
namespace :wtf do

	desc "Get tweets"
	task :get_tweets do

		# Dependencies
		require 'grackle'

		# Models
		require 'lib/Meal'

		from_username = 'lindsayevans'

		search_query = 'from:' + from_username + ' #lunch'
		cleanup_regexp = Regexp.new('[\s]*#lunch', true)

		client = Grackle::Client.new
		client.api = :search

		latest_meal = Meal.find_latest

		since_id = latest_meal.nil? ? nil : latest_meal[:twitter_status_id]

		results = client.search?(:q => search_query, :since_id => since_id).results
		results.each do |result|
			message = result.text.gsub(cleanup_regexp, '')
			tweet_attributes = {:message => message.to_s, :twitter_status_id => result.id, :created_at => DateTime.parse(result.created_at)}
			#puts YAML::dump(tweet_attributes)
			meal = Meal.create tweet_attributes
		end

	end

end

