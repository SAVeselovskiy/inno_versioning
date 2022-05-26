module Fastlane
  module Actions
    class InnoIncrementReleaseVersionAction < Action
      def self.run(params)
        require 'json'
        v_release = Actions::InnoGetReleaseVersionAction.run(params)
        v_rc = Actions::InnoGetRcVersionAction.run(params)
        if v_rc <= v_release
          raise "Release candidate version lower than release version. You have to send release candidate version
to testers and test it first. After that you can send version to review."
        else
          v_release = v_rc
        end

        res = v_release.toString
        UI.message("New relese version " + res)
        v_release
      end

      def self.description
        "Plugin for Innotech versioning system"
      end

      def self.authors
        ["SAVeselovskiy"]
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        "Plugin for Innotech versioning system"
      end

      def self.available_options
        [
          FastlaneCore::ConfigItem.new(key: :path,
                                       env_name: "INNO_VERSIONS_FILE_PATH",
                                       description: "path to versions file",
                                       optional: false,
                                       type: String),
        ]
      end

      def self.is_supported?(platform)
        # Adjust this if your plugin only works for a particular platform (iOS vs. Android, for example)
        # See: https://github.com/fastlane/fastlane/blob/master/fastlane/docs/Platforms.md
        #
        # [:ios, :mac, :android].include?(platform)
        true
      end
    end
  end
end
