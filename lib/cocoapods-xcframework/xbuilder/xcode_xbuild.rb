module Pod
  class XBuilder
    module XcodeXBuilder
      def xcode_xbuild(defines, configuration, work_dir, build_dir = 'export', platform = 'iOS', project = nil, scheme = nil, skip_install = false)
        if defined?(Pod::DONT_CODESIGN)
          defines = "#{defines} CODE_SIGN_IDENTITY=\"\" CODE_SIGNING_REQUIRED=NO"
        end
        pwd = Pathname.pwd
        Dir.chdir work_dir
        
        if platform == 'macOS'
          destination = 'generic/platform=macOS,variant=Mac Catalyst,name=Any Mac'
          archs = 'x86_64 arm64'
        elsif platform == 'iOS Simulator'
          destination = 'generic/platform=iOS Simulator'
          archs = 'x86_64 i386 arm64'
        else
          destination = 'generic/platform=iOS'
          archs = 'arm64 armv7'
        end
        if skip_install
          skip_install = 'YES'
        else
          skip_install = 'NO'
        end
        if not project.nil?
          if not scheme.nil?
            command = "xcodebuild #{defines} BUILD_DIR=#{build_dir} BUILD_LIBRARY_FOR_DISTRIBUTION=YES clean build -configuration #{configuration} -project '#{project}' -scheme '#{scheme}' -destination '#{destination}' ARCHS='#{archs}' SKIP_INSTALL=#{skip_install} | xcpretty 2>&1"
          else
            command = "xcodebuild #{defines} BUILD_DIR=#{build_dir} BUILD_LIBRARY_FOR_DISTRIBUTION=YES clean build -configuration #{configuration} -alltargets -scheme '#{scheme}' -destination '#{destination}' ARCHS='#{archs}' SKIP_INSTALL=#{skip_install} | xcpretty 2>&1"
          end
        else
          command = "xcodebuild #{defines} BUILD_DIR=#{build_dir} BUILD_LIBRARY_FOR_DISTRIBUTION=YES clean build -configuration #{configuration} -alltargets -destination '#{destination}' ARCHS='#{archs}' SKIP_INSTALL=#{skip_install} | xcpretty 2>&1"
        end
        UI.puts("XBuilder command:#{command}")
        output = `#{command}`.lines.to_a
        Dir.chdir pwd
        if $?.exitstatus != 0
          Pod::ErrorUtil.error_report command,output
          Process.exit -1
        end
      end
    end
  end
end
