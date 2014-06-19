
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
