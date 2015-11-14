require_relative '02_searchable'
require 'active_support/inflector'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def gen_attrs
    self.class_name = @name.capitalize.singularize
    @self_class_name ||= self.class_name
    self.foreign_key = (@self_class_name.underscore + "_id").to_sym
    self.primary_key = :id

    unless @options == {}
      self.class_name = @options[:class_name] || self.class_name
      self.foreign_key = @options[:foreign_key] || self.foreign_key
      self.primary_key = @options[:primary_key] || self.primary_key
    end
  end

  def model_class
    class_name.constantize
  end

  def table_name
    return "humans" if @class_name.downcase == "human"
    @class_name.tableize
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @name = name
    @options = options
    gen_attrs
  end
end

class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @name = name
    @self_class_name = self_class_name
    @options = options

    gen_attrs
  end
end

module Associatable

  def belongs_to(name, options = {})
    options = BelongsToOptions.new(name.to_s, options)

    define_method name.to_s do
      f_key = self.send(options.foreign_key)
      target_class = options.model_class
      target_class.where(options.primary_key => f_key).first
    end

    assoc_options[name] = options
  end

  def has_many(name, options = {})
    options = HasManyOptions.new(name.to_s, self.to_s, options)

    define_method name.to_s do
      p_key = self.send(options.primary_key)
      target_class = options.model_class
      target_class.where(options.foreign_key => p_key)
    end
  end

  def assoc_options
    @assoc_options ||= {}
  end
end

class SQLObject
  extend Associatable
end
