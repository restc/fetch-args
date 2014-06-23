
Ok,

So the more I start building objects and trying to get them to talk to each other,
the more often I want to make an irb plugin that allows me to fetch the name of the method
that I am calling in error, and print the proper usage of the method from docs

Ideally this would happen automatically when it is an argument error.
  ArgumentError: wrong number of arguments (0 for 1..n)


<h2>What I know:

*  I know that the :_ will fetch the result of the last call
*  I imagine I could look into IRB history I could search for the erroneous
     method call
*  ruby-doc.org is where I can find most of the info I need
    - ruby-doc will need the ruby version
*  I can use HTTParty gem for making a request
*  I need a URL library to help parse URLs
*  

<h3> After building getter
*  I can indeed use HTTParty to fetch data
*  The URLs can be constructed from a few different sites. Doc sites have easily
parsed URLs.




So now I'm working with Regular expressions

KNOW:
I can get a page of a class on ruby-doc.org
I can pull in all page data using HTTParty
I can find a match to a string by using Regexp.new
I can find a location of a match by using my_regexp =~ /Data/
Using the method `post_match` after finding a match, I can get all data that follows
I can search again within post_match data

Looking for <div class="method-callseq">Extend, where
"Extend" is the method that follows this class

After getting the results from "method-callseq", find the location
Store results in an object
Store all `post_match` data in an object
Search through `post-match`



match method name such as "@methodName = xxxx"
/\A[a-zA-Z0-9_@]*[^(.|' ')]/
http://www.rubular.com/r/5UJ3xSn8jy
