require 'forwardable'
require 'msgpack'
require 'redis'

module Turnpike
  class Base
    extend Forwardable

    def_delegators :MessagePack, :pack, :unpack

    attr :name, :redis

    def initialize(name, options = {})
      default_options = {redis: Redis.current}
      options = default_options.merge(options)

      @name = "#{Turnpike.namespace}:#{name}"
      @redis = options[:redis]
    end

    def clear
      redis.del(name)
    end

    def empty?
      size == 0
    end

    def pop(*); raise NotImplementedError; end
    def bpop(*); raise NotImplementedError; end
    def push(*); raise NotImplementedError; end
    def size; raise NotImplementedError; end
    def unshift(*); raise NotImplementedError; end
  end
end
