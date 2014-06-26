# Regex result
#
# irb(main):106:0> regex = /[`]\w*[^\b]/ #=> /[`]\w*[^\b]/
# irb(main):107:0> ae.backtrace.first[regex] #=> "`extend'"
# irb(main):108:0>

# REGEX to get method from backtrace
# /(?<=`).+\w/

# class ArgumentError
#   attr_reader :msg, :backtrace, :method
#
#   def initialize(msg, *args)
#     @msg = msg
#     print "Fetching Argument error...\n"
#     @backtrace = self.backtrace
#     @method = caller[1].match(/(?<=`).+\w/)
#     #   `caller[1]` grabs the method that produced the ArgError
#
#
#     Partytime.new(@msg.to_s, @method.to_s)
#     super(msg)
#   end
#
# end
# class CatchErrors < StandardError
#   require_relative "Match"
#   attr_reader :method
#
#   def initialize(msg, method = nil)
#   rescue ArgumentError => ae
#
#     raise_argument_err(backtrace.message, )
#     super(msg)
#   end
#
#   def self.raise_argument_err(msg, *args)
#     @method = backtrace[0].match(Match::irb_argerror_method_regex)
#     print "\nMethod that needs to be looked up is #{@method}."
#   end
#
#   def fallback_to_stderr(*args)
#     Kernel.instance_method(:raise).bind(self).call(*args)
#   end
#
# end


# class FetchArgumentError < ArgumentError
#   attr_accessor :argsErr, :bt, :ae, :docs
#
#   def initialize(msg, argsErrorData = "")
#     begin
#       argsErr = argsErrorData
#       puts "Fetching relevant data...\n"
#       @bt = nil
#     rescue ArgumentError => @ae
#       puts @ae.detail
#       puts @ae.backtrace
#     ensure
#       @docs << open("ri"){|ri| ri.read(@ae)}
#     end
#     super(msg)
#     @docs
#   end
#
#   def message
#     "#{to_s}: #{argsErr}"
#   end
#
#   def backtrace
#     @bt
#   end
#
#   def set_backtrace(bt)
#     @bt = bt
#   end
# end


# class Exception
#   attr_reader :bt, :method
#
#   def initialize(msg)
#     @mesg = msg
#     @bt = nil
#   end
#
#   def to_s
#     return self.class.name if @mesg.nil?
#     @mesg
#   end
#
#   alias :message :to_s
#   alias :to_str  :to_s
#
#   def set_backtrace(bt)
#     @bt = bt
#   end
#
#   def backtrace
#     @bt
#   end
#
#   def inspect
#     "\#<#{self.class.name}>: #{to_s}"
#   end
#
#   def exception(msg)
#     return self if msg == message
#     self.class.new(msg)
#   end
# end
