
class FetchArgumentError < ArgumentError
  attr_accessor :info

  def initialize(msg, my_additional_info = "")
    info = my_additional_info
    super(msg)
  end

  def message
    "#{to_s}: #{info}"
  end
end


class Exception
  def initialize(msg)
    @mesg = msg
    @bt = nil
  end

  def to_s
    return self.class.name if @mesg.nil?
    @mesg
  end

  alias :message :to_s
  alias :to_str :to_s

  def set_backtrace(bt)
    @bt = bt
  end

  def backtrace
    @bt
  end

  def inspect
    "\#<#{self.class.name}>: #{to_s}"
  end

  def exception(msg)
    return self if msg == message
    self.class.new(msg)
  end
end
