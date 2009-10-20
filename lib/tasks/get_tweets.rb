
namespace :wtf do

	desc "Get tweets"
	task :get_tweets do

		# Dependencies
		require 'grackle'
		require 'linguistics'

		# Brett: What?
		# Jules: "What" ain't no country I ever heard of! They speak English in "What"?!
		# Brett: What?
		# Jules: English, motherfucker! Do you speak it?!
		Linguistics::use(:en)

		# Models
		require 'lib/Meal'

		from_username = 'lindsayevans'

		hashtag = '#lunch'
		hashtag_regexp = Regexp.new('[\s]*' + hashtag, true)

		client = Grackle::Client.new
		client.api = :search

		latest_meal = Meal.find_latest

		if !latest_meal.nil?
			since_id = latest_meal[:twitter_status_id]
		end

		results = client.search?(:q => 'from:' + from_username + ' ' + hashtag, :since_id => since_id).results
		results.each do |result|

			message = result.text.gsub(hashtag_regexp, '')
			food = message.en.sentence.object || message.en.sentence.subject || message
			tweet_attributes = {:food => food.to_s, :message => message.to_s, :twitter_status_id => result.id, :created_at => result.created_at}

			#puts YAML::dump(tweet_attributes)
			meal = Meal.create tweet_attributes
		end

	end

end

