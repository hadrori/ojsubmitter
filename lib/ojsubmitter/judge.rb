require 'ojsubmitter'
require 'httpclient'

module OJS
  class Judge
    class LoginFailedError < StandardError; end
    class SubmissionError < StandardError; end

    class << self
      def valid_judges
        %w[AOJ POJ SPOJ Codeforces]
      end

      def login
      end

      def submit(*options)
        @config = options[0].to_h if options
        login
        post
        Logger.info "Your source code has submitted successfully."
        Logger.info "Open browser..."
        sleep 1
        open_status
      rescue LoginFailedError => err
        Logger.error "Login failed!"
      rescue SubmissionError => err
        Logger.error "Failed to submit. Check your config."
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

      def user
        @config['user']
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
