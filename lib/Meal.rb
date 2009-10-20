class Meal

    def Meal.find_latest
	self.all.last
    end

    def Meal.create attributes
	self.save(self.all << attributes)
    end

    def Meal.all
	model_file = File.join(File.dirname(__FILE__), '..', 'db', self.name.to_s.downcase + 's.yaml')
	File.exists?(model_file) ? YAML.load_file(model_file) : []
    end

    def Meal.save o
	model_file = File.join(File.dirname(__FILE__), '..', 'db', self.name.to_s.downcase + 's.yaml')
	fd = File.open(model_file, 'w+')
	fd.write(YAML::dump(o))
	fd.close	
    end

end
