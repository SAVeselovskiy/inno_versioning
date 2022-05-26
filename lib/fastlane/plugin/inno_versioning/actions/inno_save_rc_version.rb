module Fastlane
  module Actions
    class InnoSaveRcVersionAction < Action
      def self.run(params)
        require 'json'
        jsonstr = FileHelper.read(params[:path])
        json = JSON.parse(jsonstr)
        UI.message(json)
        res = params[:version].toString
        UI.message("New relese_candidate version " + res)
        json["rc"] = res
        FileHelper.write(params[:path], json.to_json)
        res
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
          FastlaneCore::ConfigItem.new(key: :version,
                                       env_name: "INNO_APP_VERSION",
                                       description: "App version",
                                       optional: false,
                                       type: Version),
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
