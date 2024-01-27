Hello.new.greet

class Hello

  def initialize
    puts "Making a new hello"
    puts "Here is the new instance"
    puts self

    puts "It is an instance of class"
    puts self.class


    @count = 0
  end
  def greet
    say("Hello")
    say "Hello"
    self.say("Hello")
    self.say "Hello"
  end

  private

  def say(message)
    puts message
    @count = @count + 1
    puts "Call count: " + @count.to_s
  end

end

greeter = Hello.new
greeter.greet
greeter.say "Can't do this"

