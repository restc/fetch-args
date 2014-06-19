
class GoGetEm
  require 'HTTParty'

  attr_reader :url, :ruby_version, :method



  def initialize(klass)
    @ruby_version = RUBY_VERSION
    @klass = method.to_s
    @ruby_doc_base_url = "http://ruby-doc.org/"
    @stdlib = "stdlib-"
    @core   = "core-"
    @libdoc = "libdoc/"
    @html   = ".html"
    request
  end

  def request
    @url = @ruby_doc_base_url + @core + @ruby_version + '/' + @klass + @html
    puts @url
    @request = HTTParty.get(url)
  end

end
