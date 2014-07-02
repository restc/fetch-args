# Parse HTML
# Regexes

class Parse
  require 'nokogiri'
  require 'open-uri'

  DATA_DIR = "data-hold/fetch-args"

  def initialize(url, method)

    page = Nokogiri::HTML( open( url ))
    rows = page.css("div##{method}-method.method_detail")
    result = rows.each.map { |row|
      row.css("div.method-callseq")
    }.to_a
    prep_save()
    result.to_file()
    print result
  end

  def prep_save(file=DATA_DIR)
    Dir.mkdir(file) unless File.exists?(file)
  end

  def to_file
    f = File.open(DATA_DIR+'/'+'data.txt', 'w')
    f.write(self)
    f.close()
  end
end

module CSSFilters
  get_method = "div##{method}-method.method_detail"
end

module Rgx
  def from_methodcallseq
    # http://rubular.com/r/woGPPpPRFZ
    /(?<="method-callseq">)[a-zA-Z0-9\D]*(?=(<!-- [\w\D]* -->))/
  end

  def source_code_regex(method)
    #format: http://rubular.com/r/sOglIMQMlx
    /(<div class="#{method}-source-code" id="#{method}-source">)/
  end

  def self.irb_argerror_method_regex
    /(?<=`).+\w/
  end

end

module URILibrary

    def config(docsite=:ruby_doc)
      unless DOCSITE_OPTS[docsite]
        raise NotImplementedError => e
        print "Hopefully your preferred site will be available soon"
        exit()
      else
        @docset = docsite
      end
    end

    def docsite_opts
      {:rubydoc => "http://www.rubydoc.org/", :ruby_doc => "http://www.ruby-doc.org/"}
    end

    def default
      fetch_ruby_doc_uri(*args)
    end

    def try_again_with_default?
      print "Would you like to try again using #{} [y/n]?"
      answer = gets.chomp
      case answer
      when "y"
        return true
      when "n"
        return false
      else
        print "Did not understand... please answer with y or n"
        self.try_again_with_default?
      end
    end

    def fetch_ruby_doc_uri(ruby_version, klass)
      ["http://ruby-doc.org/", "core-", @ruby_version, "/", klass, ".html"].join
    end

    def fetch_rubydoc_uri(ruby_version, library="stdlib", lib_klass="core", klass)
      basename="http://rubydoc.org/"
      unless validate_rubydoc_lib(library)
        raise
        puts "Please use valid library - did not find a match"
      end
      lib_klass_default = "core" # Add other options

      @url = [basename, library, '/', lib_klass, '/', ruby_version, '/', klass].join()

    end

    def fetch_rubydoc_full_path(ruby_version, library="stdlib", lib_klass="core", klass, method)
      basename="http://rubydoc.org/"
      unless validate_rubydoc_lib(library)
        raise
        puts "Please use valid library - did not find a match"
      end
      lib_klass_default = "core" # Add other options

      @url = [basename, library, '/', lib_klass, '/', ruby_version, '/', klass, ':', method].join()
    end

    def validate_rubydoc_lib(library)
      lib = {"stdlib" => :true#,
        # Future plans:
        #"gems" => :false,
        #"github" => :false
        }
      unless lib[library.to_s]
        return false
      else
        return true
      end
    end

end
