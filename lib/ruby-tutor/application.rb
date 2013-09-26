module RubyTutor
  class Application < ::Sinatra::Application

    RubyTutor::Exercises.list.each do |exercise|
      get "/#{exercise.key}" do
        "Hello"
      end

      post "/#{exercise.key}" do
        exercise.attempt(params[:code]) ? "PASS" : "FAIL"
      end
    end

  end
end
