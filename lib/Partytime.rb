
class Partytime
  require 'httparty'

  attr_reader :url, :ruby_version, :method, :success, :request


  def initialize(klass="optKlass", method="optMethod")
    while klass == "optKlass"
      puts "Which class is the method in?"
      klass = gets.chomp
    end
    while method == "optMethod"
      puts "Which method in #{klass}?"
      method = gets.chomp
    end
    @ruby_version = RUBY_VERSION
    @klass  = klass.to_s
    @ruby_doc_base_url = "http://ruby-doc.org/"
    @stdlib = "stdlib-"
    @core   = "core-"
    @libdoc = "libdoc/"
    @html   = ".html"
    @success= false
    @request= request˜
  end

  def request
    extend Enumerable

    @url = @ruby_doc_base_url + @core + @ruby_version + '/' + @klass + @html
    puts @url
    begin
      @request = HTTParty.get(url)
      @success = true
    rescue StandardError
      raise Error.standard_error
    ensure
      if @success == true
        return @request
      else
        return @success
      end
    end
  end

end

class Error < StandardError

  def request_error
    print "404 :: Class not found"
  end

  def standard_error
    print "This was a standard error"
  end
end
