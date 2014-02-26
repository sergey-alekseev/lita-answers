Gem::Specification.new do |spec|
  spec.name          = "lita-answers"
  spec.version       = "0.0.2"
  spec.authors       = ["Sergey Alekseev"]
  spec.email         = ["sergey.alekseev.minsk@gmail.com"]
  spec.description   = "A Lita handler for a question answering (QA) system. Allows you to use CRUD operations and simple NLP. " \
                       "More functionality is coming soon..."
  spec.summary       = %q{A Lita handler for a question answering (QA) system}
  spec.homepage      = "https://github.com/sergey-alekseev/lita-answers"
  spec.license       = "MIT"
  spec.metadata      = { "lita_plugin_type" => "handler" }

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "lita", "~> 2.7"

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", ">= 2.14"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "coveralls"
  spec.add_development_dependency 'pry'
end
