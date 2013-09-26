module RubyTutor
  class Sandbox

    def self.generate
      privs = ::Shikashi::Privileges.new
      [Hash, Array, String, Fixnum, Float, Range].each do |klass|
        privs.instances_of(klass).allow_all
      end
      [:puts, :print].each { |method| privs.allow_method(method) }
      privs.tap { |p| yield(p) if block_given? }
      sandbox = self.new(privs)
    end

    def execute(code)
      @sandbox.run(code: code, privileges: @privileges, timeout: 1)
    end

    private

    def initialize(privileges)
      @std_out = ::StringIO.new
      @std_err = ::StringIO.new
      @std_in  = ::StringIO.new
      @sandbox = ::Shikashi::Sandbox.new
      @privileges = privileges
    end

  end
end
