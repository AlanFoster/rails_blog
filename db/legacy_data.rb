class LegacyData
  def self.seed(*arguments)
    new.seed(*arguments)
  end

  def seed(model_name, field_mappings)
    seed_data = load_seed_data("#{model_name.downcase}s")
    seed_data.map(&:with_indifferent_access).each do |model_data|
      model_attributes = create_model_attributes(field_mappings, model_data)
      model = Object.const_get(model_name).new model_attributes
      unless model.save
        raise "Could not create model '#{model_name}'' with attributes #{model_attributes}"
      end
    end
  end

  private

  def create_model_attributes(field_mappings, model)
    field_mappings.inject({}) do |mapping, (new_field, old_field)|
      mapping[new_field] = model[old_field]
      mapping
    end
  end

  def load_seed_data(name)
    path = File.join Rails.root,
                     'db',
                     'seed_data',
                     "old_#{name}.yml"

    YAML::load_file(path)
  end
end
