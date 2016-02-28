module OJS
  class Logger
    class << self
      def configure(level = :info, stream = STDOUT)
        @level = level
        @stream = stream
      end

      def info(str)
        stream.puts(str)
      end

      def debug(str)
        stream.puts(str) if level == :debug
      end

      def error(str)
        stream.puts("\e[31m[ERROR] " << str << "\e[0m")
      end

      private

      def level
        @level ||= :info
      end

      def stream
        @stream ||= STDOUT
      end
    end
  end
end
