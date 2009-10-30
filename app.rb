require 'rubygems'
require 'sinatra'

# Models
require 'lib/Meal'

get '/' do
    @meal = Meal.find_latest

    'Nuthin yet' if @meal.nil?

    if ((Time.now - @meal[:created_at]) / 60).round > 2880 then
	@meal = Meal.find_random
	'Random lunch: ' + @meal[:message]
    else
	'Latest lunch: ' + @meal[:message]
    end

end

helpers do
    def time_ago_in_words(from_time)
	distance_in_minutes = ((Time.now - from_time) / 60).round
	case distance_in_minutes
	    when 0          then "less than a minute"
	    when 1          then "1 minute"
	    when 2..45      then "#{distance_in_minutes} minutes"
	    when 46..90     then "about 1 hour"
	    when 90..1440   then "about #{(distance_in_minutes.to_f / 60.0).round} hours"
	    when 1441..2880  then "1 day"
	    else             "#{(distance_in_minutes / 1440).round} days"
        end
    end
end
