lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'seraph'
  s.version     = '0.0.0'
  s.date        = '2013-04-17'
  s.summary     = "this is the summary"
  s.description = "A simple oauth gem"
  s.authors     = ["Francesco Marassi"]
  s.email       = 'francesco@trackthisfor.me'
  s.files       = ["lib/seraph.rb"]
  s.files       += Dir.glob("lib/**/*.rb")
  s.homepage    =
    'http://trackthisfor.me'
end