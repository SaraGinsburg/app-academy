require_relative '03_associatable'

module Associatable
  def has_one_through(name, through_name, source_name)
    through = assoc_options[through_name]
    source = through.model_class.assoc_options[source_name]

    define_method name.to_s do
      f_key = self.send(through.foreign_key)
      target_class = source.model_class
      target_class.where(source.primary_key => f_key).first
    end
  end
end
