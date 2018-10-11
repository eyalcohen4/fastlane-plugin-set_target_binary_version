require 'semantic'
require 'tempfile'
require 'fileutils'
require 'fastlane/action'
require_relative '../helper/set_target_binary_version_helper'

module Fastlane
  module Actions
    class SetTargetBinaryVersionAction < Action
      def self.run(params)
        UI.message("The set_target_binary_version plugin is working!")

        if (!params[:platform])
          UI.user_error("No Platform Provided")
        end

        if (!params[:path])
          UI.user_error("No Path Provided")
        end

        if (params[:platform] == 'android') 
          self.setTargetBinaryVersionAndroid(params[:path], params[:version])
        end
      end

      def self.setTargetBinaryVersionAndroid(path, new_version)
        UI.message("Setting TargetBinaryVersion For Android on path: #{path}")

        if !File.file?(path)
          UI.message(" -> No file exist at path: (#{path})!")
          return -1
        end
        
        foundVersionName = "false";
        temp_file = Tempfile.new('fastlaneSetTargetBinaryVersion')

        File.open(path, 'r') do |file| 
            file.each_line do |line| 
              if (line.include? "versionName" and foundVersionName == "false")
                version_components = line.strip.split(' ')
                version_name = version_components[version_components.length-1].tr("\"","")

                if (!new_version)
                  new_version = Semantic::Version.new version_name
                  new_version = new_version.patch!
                end

                UI.message("Replacing version name to #{new_version}")
                line.replace line.sub(version_name, new_version.to_s)
                foundVersionName = "true"
              end
            else 
              temp_file.puts line
            end
            file.close
          end
          temp_file.rewind
          temp_file.close
          FileUtils.mv(temp_file.path, path)
          temp_file.unlink
      end

      def self.description
        "A plugin which set the target binary version for code push"
      end

      def self.authors
        ["Eyal Cohen"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "This plugin set the target binary version - android.defaultConfig.versionName in build.gradle for android & CFBundleShortVersionString in Info.plist for iOS, for easier code-push integration"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :platform,
                                  env_name: "SET_TARGET_BINARY_VERSION_PLATFORM",
                               description: "The platform to set the version on. available options are 'ios', 'android'",
                                  optional: false,
                                      type: String),
          FastlaneCore::ConfigItem.new(key: :path,
                                env_name: "SET_TARGET_BINARY_VERSION_PATH",
                              description: "The file path for build.gradle/Info.plist",
                                optional: false,
                                    type: String),
          FastlaneCore::ConfigItem.new(key: :version,
                                env_name: "SET_TARGET_BINARY_VERSION_VERSION",
                              description: "The desired version. if not provided, will increase by patch (e.g 1.0.0 -> 1.0.1)",
                                optional: true,
                                    type: String)
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://docs.fastlane.tools/advanced/#control-configuration-by-lane-and-by-platform
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
