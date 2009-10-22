
namespace :wtf do

	desc "Get tweets"
	task :get_tweets do

		# Dependencies
		require 'grackle'

		# Models
		require 'lib/Meal'

		from_username = 'lindsayevans'

		hashtag = '#lunch'
		cleanup_regexp = Regexp.new('[\s]*' + hashtag, true)

		client = Grackle::Client.new
		client.api = :search

		latest_meal = Meal.find_latest
		latest_meal = nil

		since_id = latest_meal.nil? ? nil : latest_meal[:twitter_status_id]

		results = client.search?(:q => 'from:' + from_username + ' ' + hashtag, :since_id => since_id).results
puts 'from:' + from_username + ' ' + hashtag
		results.each do |result|

			message = result.text.gsub(cleanup_regexp, '')
			tweet_attributes = {:message => message.to_s, :twitter_status_id => result.id, :created_at => result.created_at}

			puts YAML::dump(tweet_attributes)
			#meal = Meal.create tweet_attributes
		end

	end

end

