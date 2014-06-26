
# To Do: 6/26
# => Build method to build url using flags from *args in init
# => Find

class Partytime
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'

  attr_reader :url, :ruby_version, :method, :success, :request, :status


  def initialize(*args)
    @ruby_version = set_ruby_version()
    @success      = false
    @status     ||= "Ready"
    @url        ||= args[0]
  end

  def party(klass, method, url=@url, *args)
    @klass = klass.to_s
    @method = method.to_s
    @url = fetch_rubydoc_uri(klass) #set_search_url(@klass, @method)
    print "Fetching data from #{@url}.\n"
    @request = request(@url, @method)
    puts @request
  end

  def set_ruby_version
    RUBY_VERSION
  end

  def set_search_url(klass, method, uri="default")
    # Needs work
    case uri
    when "default"
      # default #
      # ruby-doc.org # version: `set_ruby_version`
      @url = fetch_rubydoc_uri(klass)
    else
      @url = uri
    end
    @url
  end

  def self.set_uri_basename(base_uri)
    unless base_uri.to_s.match(/http[s]?(:\/\/)/).eql? false
      @base_uri = "http://" + base_uri
    else
      @base_uri = base_uri
    end
    @status = "#{@base_uri} is set as the base URI."
  end

  def set_uri_basename(basename="default")
    case basename
    when "default"
      @basename = "http://ruby-doc.org/"
    else
      @basename = basename
    end
  end

  def fetch_rubydoc_uri(klass=@klass)
    ["http://ruby-doc.org/", "core-", @ruby_version, "/", klass, ".html"].join
  end

  def request(url, method)
    extend Enumerable


    @request = HTTParty.get(url)
    @success = true

    rescue LoadError => le
      print le.message
      super(le.message)
    rescue ScriptError => se
      print se.message
      super(se.message)
    rescue StandardError => ste
      print ste.message
      super(ste.message)
    ensure
    if @success
      return @request
    else
      return @success
    end
  end

  def build_url(basename, *args)
    @url = basename + @core + @ruby_version + '/' + @klass + @html
  end

  def parse_html(request)
    Nokogiri::HTML.parse(request)
  end

end

class ArgumentError
  attr_reader :msg, :klass, :method

  def initialize(msg, *args)
    @backtrace = self.backtrace

    puts "Fetching params for correct usage..."
    @method = caller[1].match(/(?<=`).+\w/)
    #   `caller[1]` grabs the method that produced the ArgError

    @klass = caller.class

    Partytime.new.party(@klass, @method, *args)
    super(msg)
  end

end
