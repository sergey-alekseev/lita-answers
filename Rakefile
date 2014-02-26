require "bundler/gem_tasks"
require "rspec/core/rake_task"
require 'lita-answers'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

task :seeds do
  {
    'What is the w3c?' => 'The World Wide Web Consortium is the main international standards organization for the World Wide Web.',
    'What is HTTP code 200?' => '200 OK – Standard response for successful HTTP requests. The actual response will depend on the request method used. In a GET request, the response will contain an entity corresponding to the requested resource. In a POST request the response will contain an entity describing or containing the result of the action.',
    'What is HTTP code 201?' => '201 Created – The request has been fulfilled and resulted in a new resource being created.',
    'What books should every web developer read?' => "There are few books for old school learners – CSS: The Missing Manual, JavaScript: The Definitive Guide, Agile Web Development => Rails, Python Web Development => Django, Programming PHP.",
    'What are web programming languages?' => 'There are many programming languages available to Web developers. Some of them are JavaScript, Go, Java, Python, Scala, Ruby.',
    'What is Ruby?' => 'Ruby is a dynamic, reflective, object-oriented, general-purpose programming language.',
    'What books should every Ruby/Rails developer read?' => 'The Ruby Programming Language, Agile Web Development => Rails 4, Ruby on Rails Tutorial, The Rails 4 Way, Patterns of Enterprise Application Architecture, Implementation Patterns, Refactoring – Ruby Edition, Rails Antipatterns, Eloquent Ruby, Confident Ruby, Practical object-oriented design in Ruby, Crafting Rails 4 Applications...',
    'What technology for web-programming to learn?' => 'Python, Java, .NET, Node.js, Ruby on Rails, Coffeescript...',
    'What is adaptive web design?' => 'Responsive Web design is a Web design approach aimed at crafting sites to provide an optimal viewing experience – easy reading and navigation => a minimum of resizing, panning, and scrolling – across a wide range of devices, from mobile phones to desktop computer monitors.',
    'What is responsive web design?' => 'Adaptive web design is basically the same as responsive design and shares many of the same ideals and goals. The main difference however is that the changes are made on the server side rather than the client side.',
    'What is the difference between client-side and server-side?' => 'The Server - This party is responsible for serving pages. The Client - This party requests pages from the Server, and displays them to the user. On most cases, the client is a web browser.',
    'What are the most popular gems?' => '1. rake, 2. rack, 3. thor, 4. activesupport, 5. activesupport, 6. json, 7. mime-types, 8. rails, 9. activerecord, 10. actionpack'
  }.each do |question, answer|
    Knowledgebase.create(question, answer)
  end
end
