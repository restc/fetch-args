# Author: Raleigh St. Clair restc@icloud.com
# Finds the last method called in irb based on irb history

class LastCall
  require_relative 'FMELibrary.rb'
  attr_reader :environment, :ruby_version, :env

  def initialize
    @env = WhichENV.new.environment
    @last_call = get_history
    @environment  = "UNKNOWN"
    @ruby_version = "UNKNOWN"
    match
  end

  def get_history
    `hist --tail 2 -n --show -2`
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
