module OJS
  class Util
    class UnknownOSError < StandardError; end

    class << self
      def open_browser(url)
        system open_browser_command, url
      rescue UnknownOSError => err
        Logger.info "Open browser command for this platform is unknow, please specify the command from config.yml or options."
      end

      private

      def open_browser_command
        case RUBY_PLATFORM.downcase
        when /mswin(?!ce)|mingw|cygwin|bccwin/
          'start'
        when /darwin/
          'open'
        when /linux/
          'xdg-open'
        else
          raise UnknowOSError
        end
      end
    end
  end
end
