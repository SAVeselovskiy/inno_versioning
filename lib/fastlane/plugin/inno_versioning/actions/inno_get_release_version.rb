module Fastlane
  module Actions
    class InnoGetReleaseVersionAction < Action
      def self.run(params)
        require 'json'
        UI.message('InnoGetReleaseVersionAction')
        jsonstr = FileHelper.read(params[:path]) # TODO: впилить проверку если не указан путь
        UI.message(jsonstr)
        json = JSON.parse(jsonstr)
        v = Version.parse(json)
        v["release"]
      end

      def self.description
        'Plugin for Innotech versioning system'
      end

      def self.authors
        ['SAVeselovskiy']
      end

      def self.return_value
        # If your method provides a return value, you can describe here what it does
      end

      def self.details
        # Optional:
        'Plugin for Innotech versioning system'
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
