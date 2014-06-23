
class Fetch

  # require_relative 'FMELibrary.rb'
  require 'irb/ext/save-history'

  attr_reader :rubyVersion, :env, :historyPath, :historyFile, :lastCall
  attr_reader :matchedObj, :matchedMethod

  def initialize
    @env = ENV["_"]
    @rubyVersion = RUBY_VERSION
    @historyPath = File::expand_path("~/.irb_history")
    @historyFile = get_history(@historyPath)
    @lastCall    = @historyFile[-2]
    @lastMethod  = match(@lastCall.to_s)
    @matchedObj  = match_obj(@lastMethod)
    @matchedMethod = match_method(@lastMethod)
  end

  def setup_save_history
    # Add FILE IO call to add lines to .irbrc
    IRB.conf[:SAVE_HISTORY] = 100
    IRB.conf[:HISTORY_FILE] = "#{ENV['HOME']}/.irb_history"
  end

  def permission
    print "Fetch would like to configure IRB to save history.\nPress 'y' or 'n', then press Enter."
    result = gets.chomp

    if result.include?('n')
      print "Exiting without installing : E1"
      return false

    elsif result.include?('y')
      return true

    else
      print "Exiting without installing : E2"
      return false
    end
    result
  end

  def match_obj(str)
    rgx = Regexp.new('\A[a-zA-Z0-9_@]*[^(.|' ')]')
    rgx.match str
  end

  def match_method(str)
    rgx = Regexp.new('[^.][a-zA-Z_]*$')
    rgx.match str
  end

  def get_history(path)
    histArray = load_file(path).split("\n")
    if histArray.length > 10
      return histArray[-11..-1]
    else
      return histArray
    end
  end

  def load_file(path)
    if File.exists?(path)
      @historyFile = File.read(path)
    elsif
      begin
        unless permission
          print "Setting up save history"
          setup_save_history
        end
      rescue StandardError
        print "Catchall error #{s}"
      end
    end
  end

  # def methodRegex
  #   Regexp.new('[^.][a-zA-Z_]*$')
  # end

end
