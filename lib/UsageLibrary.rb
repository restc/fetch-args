# Regex result
#
# irb(main):106:0> regex = /[`]\w*[^\b]/ #=> /[`]\w*[^\b]/
# irb(main):107:0> ae.backtrace.first[regex] #=> "`extend'"
# irb(main):108:0>



# REGEX to get method from backtrace
# /(?<=`).+\w/

class UsageLibrary < StandardError
  def initialize(msg, method = nil)


    rescue ArgumentError => ae
      if additional_info.eql?("default")
        additional_info = ae.backtrace.first.match(regex)[0]
      else
        additional_info.to_a.push(ae.backtrace.inspect[0])
      end
    ensure
      print additional_info
      super(msg)
    end
  end
end


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
