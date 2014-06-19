# Finds the last method called in irb based on irb history

class LastCall
  require_relative 'FMELibrary.rb'

  def initialize
    @env = WhichENV.new.environment
    @last_call = get_history
  end

  def get_history
    `hist --tail 2 -n --show -2`
  end



end
