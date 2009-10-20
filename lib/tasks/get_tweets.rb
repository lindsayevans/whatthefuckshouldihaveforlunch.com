
namespace :wtf do

	desc "Get tweets"
	task :get_tweets do

		# Dependencies
		require 'grackle'

		# Models
		#require 'lib/Meal'

		from_username = 'lindsayevans'

		hashtag = '#lunch'
		hashtag_regexp = Regexp.new('[\s]*' + hashtag, true)


		client = Grackle::Client.new
		client.api = :search

		#latest_meal = Meal.find_latest
		latest_meal = nil

		if !latest_meal.nil?
			since_id = latest_meal.twitter_status_id
		end
puts 'from:' + from_username + ' ' + hashtag
		results = client.search?(:q => 'from:' + from_username + ' ' + hashtag, :since_id => since_id).results
puts YAML::dump(results)
		results.each do |result|

			start_date = result.created_at
			message = result.text.gsub(hashtag_regexp, '')

			tweet_attributes = {:message => message, :twitter_status_id => result.id, :created_at => DateTime.now}

			puts YAML::dump(tweet_attributes)
			#meal = Meal.create tweet_attributes
		end

	end

end

