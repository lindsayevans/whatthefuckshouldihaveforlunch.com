if ENV['RACK_ENV'] == 'production'
    @@db_path = '/var/www/whatthefuckshouldihaveforlunch.com/shared/db/'
else
    @@db_path = '/Users/lindsay/Projects/whatthefuckshouldihaveforlunch.com/shared/db/'
end
