# Parse HTML
# Regexes

class Parse
  require 'nokogiri'
  require 'open-uri'

  attr_reader :result, :found_methods, :method_error_info

  DATA_DIR = "data-hold/"
  OUT_FILE = "save_data.txt"

  def initialize
    @result = Array.new
    @found_methods = Hash.new
    @method_info = Array.new
  end

  def match_method_callseq
    # http://rubular.com/r/xzivx9z8Vj
    /(?<=\"method-callseq\">)(\w|\W)*(?=<\/span>)/
  end

  def request(url, klass, method)
    print "Finding correct usage for #{klass.to_s.capitalize}::#{method.to_s}: \n\n"

    page = Nokogiri::HTML( open( url ))
    # The next css selector finds method detail for methods on page

    page.css("body div.wrapper div.documentation-section div.method-detail").each_with_index do |each_method, index|
      if each_method.attributes["id"].value =~ /(.*)#{method}(.*)/
        @method_info.push(each_method.children)
      end
    end
    beautify_method_info @method_info
  end

  def beautify_method_info(method_info)
    usage = Array.new
    method_info.each do |part|
      usage.push(part.text.split("\n"))
    end
    kill_blanks(usage)
  end

  def kill_blanks(from_beautify_method_info)
    fbmi = from_beautify_method_info.flatten
    fbmi.reject! {|line| line.empty? }
    fbmi.each_with_index do |line,index|
      if line.to_s.match(/(.*)click to toggle source(.*)/)
        fbmi[index] = "\n"
      end
    end
    fbmi.uniq!
    puts fbmi#.join(' ')
  end

  def css_find_method
    # "css(<body class="class rdocstar">, <div class="wrapper">,
    # <div id="documentation">, <div class="documentation-section">,
    # <div class="method-detail">, <div class="method-heading">,
    # <span class="method-name">#{name_of_method}</span>
    # )"
    "//body[@class = 'class rdocstar']/div[@class = 'wrapper']/div[@class = 'documentation-section']/div[@class = 'method-detail']/div[@class = 'method-heading']/span[@class = 'method-name']"
  end

  def prep_save(file=DATA_DIR)
    Dir.mkdir(file) unless File.exists?(file)
  end

  def to_file
    f = File.open(DATA_DIR+OUT_FILE, 'w')
    f.write(self)
    f.close()
  end
end
