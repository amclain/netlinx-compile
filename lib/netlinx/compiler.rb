require 'netlinx/compiler_result'

module NetLinx
  # Raised when the NetLinx compiler (nlrc.exe) cannot be found on the system.
  # @see NetLinx::Compiler
  class NoCompilerError < Exception; end
  
  # A wrapper class for the AMX NetLinx compiler executable (nlrc.exe).
  class Compiler
    
    # Checks for the AMX NetLinx compiler (third-party software, nlrc.exe) at the
    # default installation path.
    # 
    # @option kwargs [String] :compiler_exe ('nlrc.exe')
    # @option kwargs [String] :compiler_path Recommend a directory to look for
    #   the compiler_exe.
    # @option kwargs [String] :use_wine (false) Set to true to force `wine` at
    #   the front of the compiler command. This is automatic if nlrc.exe is
    #   installed at Wine's default Program Files path.
    # @raise [NetLinx::NoCompilerError] Compiler not found.
    def initialize(**kwargs)
      @compiler_exe = kwargs.fetch :compiler_exe, 'nlrc.exe'
      user_specified_path = kwargs.fetch :compiler_path, nil
      @use_wine = kwargs.fetch :use_wine, false
      
      default_paths = [
        user_specified_path,
        'C:\Program Files (x86)\Common Files\AMXShare\COM', # 64-bit O/S path
        'C:\Program Files\Common Files\AMXShare\COM',       # 32-bit O/S path
        '~/.wine/drive_c/Program Files/Common Files/AMXShare/COM', # Wine path
      ].compact
      
      # Check for NetLinx compiler.
      default_paths.each do |path|
        if File.exists? File.expand_path(@compiler_exe, path)
          @compiler_path = path
          break
        end
      end
      
      # ---------------------------------------------------------
      # TODO: Check if the compiler was added to the system path.
      #       Execute system(@compiler_exe).
      # ---------------------------------------------------------
      
      # Compiler not found.
      raise NetLinx::NoCompilerError, "The NetLinx compiler (#{@compiler_exe}) could not be found on the system." \
        unless @compiler_path
    end
    
    # Compile the specified object with the NetLinx compiler.
    # @see Test::NetLinx::Compilable.
    def compile(compilable)
      compiler = File.expand_path @compiler_exe, @compiler_path
      result   = []
      
      compilable.compiler_target_files.each do |target_file|
        # Construct paths.
        include_paths = "-I#{compilable.compiler_include_paths.join ';'}" unless
          compilable.compiler_include_paths.empty?
          
        module_paths = "-M#{compilable.compiler_module_paths.join ';'}" unless
          compilable.compiler_module_paths.empty?
          
        library_paths = "-L#{compilable.compiler_library_paths.join ';'}" unless
          compilable.compiler_library_paths.empty?
        
        # Run the NetLinx compiler.
        # Note: NLRC.exe v2.1 freaks out if empty arguments ("") are in the command.
        cmd  = ''
        cmd += 'wine ' if @use_wine or compiler.include? '/.wine/'
        cmd += "\"#{compiler}\" \"#{target_file}\""
        cmd += " \"#{include_paths}\"" if include_paths
        cmd += " \"#{module_paths}\""  if module_paths
        cmd += " \"#{library_paths}\"" if library_paths
        
        io = IO.popen cmd
        stream = io.read
        io.close
        
        # Build the result.
        result << NetLinx::CompilerResult.new(
          compiler_target_files:  [target_file],
          compiler_include_paths: compilable.compiler_include_paths,
          compiler_module_paths:  compilable.compiler_module_paths,
          compiler_library_paths: compilable.compiler_library_paths,
          stream: stream
        )
      end
      
      result
    end
    
  end
end