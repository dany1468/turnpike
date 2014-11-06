require 'turnpike/queue'
require 'turnpike/unique_queue'

module Turnpike
  class << self
    attr_accessor :namespace

    def call(options = {})
      default_options = {name: 'default', unique: false}
      options = default_options.merge(options)

      (options[:unique] ? UniqueQueue : Queue).new(options[:name])
    end
    alias [] call
  end

  @namespace = 'turnpike'
end
