require 'ojsubmitter'
require 'thor'

module OJS
  class CLI < Thor
    default_command :submit

    def initialize(*)
      super
    end

    desc "version", "Print the version."
    def version
      puts OJS::VERSION
    end

    desc "submit", "Submit your source code."
    option :judge,
           :aliases => "-j",
           :desc    => "Specify a target judge."
    option :file,
           :aliases => "-f",
           :desc    => "Specify your source file to submit."
    option :user,
           :aliases => "-u",
           :desc    => "Specify your user_name."
    option :password,
           :aliases => "-p",
           :desc    => "Specify your password."
    option :language,
           :aliases => "-l",
           :desc    => "Specify a programming language."
    def submit
      case options[:judge]
      when 'aoj'
        OJS::AOJ.submit options
      else
        show_judge_list
      end
    end

    private
    def show_judge_list
      Logger.info "You can specify a judge with option --judge or -j"
      Logger.info "Available judges are below."
      Judge.valid_judges.each { |judge| Logger.info judge }
    end
  end
end
