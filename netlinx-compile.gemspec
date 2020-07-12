version = File.read(File.expand_path('../version', __FILE__)).strip

Gem::Specification.new do |s|
  s.name      = 'netlinx-compile'
  s.version   = version
  s.date      = Time.now.strftime '%Y-%m-%d'
  s.summary   = 'A wrapper utility for the AMX NetLinx compiler.'
  s.description = "This library provides an executable, netlinx-compile, that wraps the nlrc.exe NetLinx compiler provided by AMX. It is designed for easier command line access, as well as for integration with third-party tools with source code build support, like text editors and IDE's. Also provided in this library is a Ruby API for invoking the NetLinx compiler."
  s.homepage  = 'https://github.com/amclain/netlinx-compile'
  s.authors   = ['Alex McLain']
  s.email     = ['alex@alexmclain.com']
  s.license   = 'Apache-2.0'
  
  s.files     =
    ['license.txt', 'README.md'] +
    Dir[
      'bin/**/*',
      'lib/**/*',
      'doc/**/*',
    ]
  
  s.executables = [
    'netlinx-compile'
  ]
  
  s.add_development_dependency 'rake',      '~> 13.0'
  s.add_development_dependency 'yard',      '~> 0.9', '>= 0.9.11'
  s.add_development_dependency 'rspec',     '~> 3.9'
  s.add_development_dependency 'rspec-its', '~> 1.3'
  s.add_development_dependency 'fivemat',   '~> 1.3'
  s.add_development_dependency 'pry'
  s.add_development_dependency 'rb-readline'
end
