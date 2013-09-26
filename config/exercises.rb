RubyTutor::Exercises.define do

  exercise 'example-one' do
    title "Example One"
    desc  "This is just a simple test"
    criteria do |command|
      assert_output /^Hello World$/, nil do
        command.call
      end
    end
  end

  exercise 'create-an-array' do
    title "Let's make an array"
    desc  "This is just a simple test"
    criteria do |command|
      assert_instance_of Array, command.call
    end
  end

end
