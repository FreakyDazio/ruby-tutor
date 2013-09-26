module RubyTutor
  class Exercise

    attr_reader :key

    def initialize(key)
      @key = key.downcase
      @criteria = proc { }
      @sandbox  = RubyTutor::Sandbox.generate
    end

    def title(title)
      @title = title
    end

    def desc(desc)
      @desc = desc
    end

    def criteria(&criteria)
      # I want to capture the IO to prevent garbage in the logs
      @criteria = criteria
    end

    def attempt(code)
      command = proc { @sandbox.execute(code) }

      klass = Class.new do
        include ::Minitest::Assertions
        attr_accessor :assertions
        def initialize
          self.assertions = 0
        end
      end

      klass.class_exec(@criteria) do |criteria|
        define_method(:test_command, criteria)
      end

      begin
        klass.new.test_command(command)
      rescue ::Minitest::Assertion
        false
      end
    end

  end

  class Exercises

    def self.define(&block)
      self.class_exec(&block)
    end

    def self.list
      @list
    end

    private

    def self.exercise(key, &block)
      e = RubyTutor::Exercise.new(key)
      e.instance_exec(&block)
      (@list ||= Set.new) << e
    end

  end
end
