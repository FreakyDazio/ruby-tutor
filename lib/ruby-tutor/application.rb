module RubyTutor
  class Application < ::Sinatra::Application

    post '/' do
      sandbox = RubyTutor::Sandbox.generate
      sandbox.execute(params[:code])
      sandbox.output
    end

  end
end
