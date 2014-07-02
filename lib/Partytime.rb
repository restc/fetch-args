
# To Do: 6/26
# => Build method to build url using flags from *args in init
# => Find

class Partytime
  require 'httparty'
  require 'nokogiri'
  require 'open-uri'

  attr_reader :url, :ruby_version, :method, :success, :request


  def initialize
    @ruby_version = set_ruby_version()
    @success      = false
    @request      = nil
    @url          = nil
  end

  def party(klass, method, url=@url, *args)
    @klass = klass.to_s
    @method = method.to_s
    @url ||= fetch_rubydoc_uri(klass)
    print "Requesting data from #{@url}.\n"
    Parse::new(@url, @method)
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
    @base_uri
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
    # http://ruby-doc.org/core-2.0.0/Array.html
  end

  def build_url(basename, *args)
    @url = basename + @core + @ruby_version + '/' + @klass + @html
  end

end

class ArgumentError
  attr_reader :klass, :method

  def initialize(msg, *args)
    puts "Fetching params for correct usage..."
    @klass = caller.class
    @method = caller[1].match(/(?<=`).+\w/)

    Partytime.new.party(@klass, @method, *args)
    super(msg)
  end

end
