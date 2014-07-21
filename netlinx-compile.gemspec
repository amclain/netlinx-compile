version = File.read(File.expand_path('../version', __FILE__)).strip

Gem::Specification.new do |s|
  s.name      = 'netlinx-compile'
  s.version   = version
  s.date      = Time.now.strftime '%Y-%m-%d'
  s.summary   = 'A wrapper utility for the AMX NetLinx compiler.'
  s.description = "This library provides an executable, netlinx-compile, that wraps the nlrc.exe NetLinx compiler provided by AMX. It is designed for easier command line access, as well as for integration with third-party tools with source code build support, like text editors and IDE's. Also provided in this library is a Ruby API for invoking the NetLinx compiler."
  s.homepage  = 'https://sourceforge.net/projects/netlinx-compile/'
  s.authors   = ['Alex McLain']
  s.email     = 'alex@alexmclain.com'
  s.license   = 'Apache 2.0'
  
  s.files     =
    ['license.txt', 'README.md'] +
    Dir['bin/**/*'] +
    Dir['lib/**/*'] +
    Dir['doc/**/*']
  
  s.executables = [
    'netlinx-compile'
  ]
  
  s.add_development_dependency 'rake'
  s.add_development_dependency 'yard',      '= 0.8.7.3'
  s.add_development_dependency 'rspec',     '~> 3.0.0'
  s.add_development_dependency 'rspec-its', '~> 1.0.1'
  s.add_development_dependency 'fivemat'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
end
