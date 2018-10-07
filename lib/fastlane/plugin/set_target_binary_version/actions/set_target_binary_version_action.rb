require 'fastlane/action'
require_relative '../helper/set_target_binary_version_helper'

module Fastlane
  module Actions
    class SetTargetBinaryVersionAction < Action
      def self.run(params)
        UI.message("The set_target_binary_version plugin is working!")
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
          # FastlaneCore::ConfigItem.new(key: :your_option,
          #                         env_name: "SET_TARGET_BINARY_VERSION_YOUR_OPTION",
          #                      description: "A description of your option",
          #                         optional: false,
          #                             type: String)
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
