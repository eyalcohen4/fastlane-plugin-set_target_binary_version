require 'fastlane_core/ui/ui'

module Fastlane
  UI = FastlaneCore::UI unless Fastlane.const_defined?("UI")

  module Helper
    class SetTargetBinaryVersionHelper
      # class methods that you define here become available in your action
      # as `Helper::SetTargetBinaryVersionHelper.your_method`
      #
      def self.show_message
        UI.message("Hello from the set_target_binary_version plugin helper!")
      end
    end
  end
end
