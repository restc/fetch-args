# Rubydoc.org url format


basename="http://rubydoc.org/"
library ={"stdlib" => :true, "gems" => :false, "github" => :false}

lib_class = "core"
  # if library["stdlib"]
  # ... any of stdlib classes ... i.e. core

ruby_version = "2.0.0" # or etc

klass = "Array" # or etc

@url = [basename, library, "/", lib_class, "/", ruby_version, "/", klass].join
