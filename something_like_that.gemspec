require File.expand_path('../lib/something_like_that/version', __FILE__)

Gem::Specification.new do |spec|
  spec.name          = 'something_like_that'
  spec.version       = SomethingLikeThat::VERSION
  spec.author        = 'Ryan Lue'
  spec.email         = 'ryan.lue@gmail.com'

  spec.summary       = 'Fuzzy string matching for long, multi-word phrases.'
  spec.description   = 'See how closely two long, multi-word phrases ' \
                       'match each other. Something Like That is ' \
                       'asymmetrical, meaning “Azkaban” will match ' \
                       '“Harry Potter and the Prisoner of Azkaban” much ' \
                       'more strongly than vice versa. Great for ' \
                       'ordering search results gathered from diverse ' \
                       'sources.'
  spec.homepage      = 'https://github.com/rlue/something_like_that'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
                          f.match(%r{^(spec/|\.\w)})
                        end
  spec.require_paths = ['lib']
  spec.required_ruby_version = '>= 2.3.0'
  spec.add_runtime_dependency 'amatch', '~> 0.3'
end
