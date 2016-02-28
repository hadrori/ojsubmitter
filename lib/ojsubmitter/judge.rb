require 'ojsubmitter'
require 'httpclient'

module OJS
  class Judge
    class << self
      def valid_judges
        %w[aoj]
      end

      def login
        false
      end

      def submit(*options)
        @config = options[0].to_h if options
        post
        Logger.info "Your source code has submitted successfully."
        Logger.info "Opening browser..."
        sleep 1
        open_status
      end

      def post
        raise NotImplementedError
      end

      def open_status
        Util.open_browser status_url
      end

      def status_url
        raise NotImplementedError
      end

      def hclient
        @hclient ||= HTTPClient.new
      end

      def user_name
        @config['user_name']
      end

      def password
        @config['password']
      end

      def language
        @config['language']
      end

      def problem_id
        @config['problem_id']
      end

      def file
        @config['file']
      end

      def code
        File.read file, encoding: Encoding::UTF_8
      end
    end
  end
end
