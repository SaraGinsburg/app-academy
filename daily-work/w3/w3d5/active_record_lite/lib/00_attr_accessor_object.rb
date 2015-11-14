class AttrAccessorObject
  def self.my_attr_accessor(*names)
    # ...
    names.each do |name|
      define_method "#{name}" do
        instance_variable_get("@#{name}")
      end

      define_method "#{name}=" do |set_val|
        instance_variable_set("@#{name}", set_val)
      end
    end
  end
end
