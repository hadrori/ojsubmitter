module OJS
  class Util
    class UnknownOSError < StandardError; end

    class << self
      def open_browser(url)
        system open_browser_command, url
      rescue UnknownOSError => err
        Logger.error "Open browser command for this platform is unknow"
      end

      def open_browser_command
        case RUBY_PLATFORM.downcase
        when /mswin(?!ce)|mingw|cygwin|bccwin/
          'start'
        when /darwin/
          'open'
        when /linux/
          'xdg-open'
        else
          raise UnknownOSError
        end
      end
    end
  end
end
