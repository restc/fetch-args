# Author: Raleigh St. Clair restc@icloud.com

class WhichENV
  # Returns environment type when run in interactive shell
  attr_reader :environment, :ruby_version

  def initialize
    @environment  = "UNKNOWN"
    @ruby_version = "UNKNOWN"
    match
  end

  def match
    if ENV["_"][0..12].eql?("/usr/bin/pry")
      @environment = "Pry"
    elsif ENV["_"][0..12].eql?("/usr/bin/irb")
      @environment = "IRB"
    else
      @environment = "ENV[\"_\"]"
    end
    if RUBY_VERSION
      @ruby_version = RUBY_VERSION
    else
      @ruby_version = "UNKNOWN"
    end
  end

end
