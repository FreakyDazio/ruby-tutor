module RubyTutor
  class Application < ::Sinatra::Application

    post "/" do
      excercise = RubyTutor::Exercise.new
      excercise.criteria do |output|
        assert_equal "Hello World", output
      end

      if excercise.attempt(params[:code].to_s)
        "CONGRATS"
      else
        "BAD LUCK"
      end
    end

  end
end
