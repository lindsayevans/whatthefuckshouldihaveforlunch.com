class Meal

    def Meal.find_latest
	all = self.all
	all.empty? ? nil : all.last
    end

    def Meal.find_random
	all = self.all
	all[rand(all.length)]
    end

    def Meal.create attributes
	self.save(self.all << attributes)
    end

    def Meal.all
	model_file = File.join(@@db_path, self.name.to_s.downcase + 's.yaml')
	File.exists?(model_file) ? YAML.load_file(model_file) : []
    end

    def Meal.save o
	model_file = File.join(@@db_path, self.name.to_s.downcase + 's.yaml')
	fd = File.open(model_file, 'w+')
	fd.write(YAML::dump(o))
	fd.close	
    end

end
