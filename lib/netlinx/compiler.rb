# Raised when the NetLinx compiler (nlrc.exe) cannot be found on the system.
# See class NetLinxCompiler.
class NoCompilerError < Exception; end

module NetLinx
  # A wrapper class for the AMX NetLinx compiler executable (nlrc.exe).
  class Compiler
    
    # Checks for the AMX NetLinx compiler (third-party software, nlrc.exe) at the
    # default installation path. This can be overridden by specifying :compiler_path.
    def initialize(**kvargs)
      @compiler_exe = 'nlrc.exe'
      
      @compiler_path = kvargs.fetch :compiler_path,
        File.expand_path('C:\Program Files (x86)\Common Files\AMXShare\COM') # 64-bit O/S path
        
      # Check for NetLinx compiler at :compiler_path or the 64-bit O/S path.
      unless File.exists? File.expand_path('nlrc.exe', @compiler_path)
        # Compiler not found. Try 32-bit O/S path.
        @compiler_path = File.expand_path('C:\Program Files\Common Files\AMXShare\COM')
        unless File.exists? File.expand_path('nlrc.exe', @compiler_path)
          # ---------------------------------------------------------
          # TODO: Check if the compiler was added to the system path.
          #       Execute system('nlrc').
          # ---------------------------------------------------------
          
          # Compiler not found.
          raise NoCompilerError, 'The NetLinx compiler (nlrc.exe) could not be found on the system.'
        end
      end
    end
    
    # Compile the specified object with the NetLinx compiler.
    def compile(compilable)
      compiler = File.expand_path @compiler_exe, @compiler_path
      
      compilable.compiler_target_files.each do |target_file|
        include_paths = "-I#{compilable.compiler_include_paths.join ';'}" unless
          compilable.compiler_include_paths.empty?
          
        module_paths = "-M#{compilable.compiler_module_paths.join ';'}" unless
          compilable.compiler_module_paths.empty?
          
        library_paths = "-L#{compilable.compiler_library_paths.join ';'}" unless
          compilable.compiler_library_paths.empty?
        
        system "\"#{compiler}\" \"#{target_file}\" \"#{include_paths}\" \"#{module_paths}\" \"#{library_paths}\""
      end
      
      # TODO: Generate an array of target files, compiler output,
      # and compiler success status as the return value.
    end
    
  end
end