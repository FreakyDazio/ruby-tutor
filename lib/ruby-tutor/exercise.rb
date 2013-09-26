module RubyTutor
  class Exercise

    def initialize
      @criteria = proc { |out| true }
      @sandbox  = RubyTutor::Sandbox.generate
    end

    def criteria(&criteria)
      @criteria = criteria
    end

    def attempt(code)
      @sandbox.execute(code)

      klass = Class.new do
        include ::Minitest::Assertions
        attr_accessor :assertions

        def initialize
          self.assertions = 0
        end
      end

      klass.class_exec(@criteria) do |criteria|
        define_method(:test_output, criteria)
      end

      begin
        klass.new.test_output(@sandbox.output)
      rescue ::Minitest::Assertion
        false
      end
    end

  end
end
