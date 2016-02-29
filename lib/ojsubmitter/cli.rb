require 'ojsubmitter'
require 'thor'
require 'yaml'

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
    option :nostatus,
           :aliases => "-n",
           :type    => :boolean,
           :desc    => "Don't show status page after submitting."
    def submit
      @config = set_options_from_config_file(options.to_h)
      case @config['judge'].to_s.downcase
      when 'aoj'
        OJS::AOJ.submit @config
      when 'poj'
        OJS::POJ.submit @config
      when 'spoj'
        OJS::SPOJ.submit @config        
      else
        list
      end
    end

    SAMPLE_CONFIG_PATH = File.join(OJS::ROOT_DIR, '.ojsconf.yml.sample')
    CONFIG_PATH = File.join(ENV['HOME'], '.ojsconf.yml')

    desc "init", "Create a config file."
    def init
      unless File.exist?(CONFIG_PATH)
        FileUtils.copy(SAMPLE_CONFIG_PATH, CONFIG_PATH)
      end
    end

    desc "list", "Show the list of enable judges."
    def list
      Logger.info "Available judges are below."
      Judge.valid_judges.each { |judge| Logger.info judge }
    end

    private
    def set_options_from_config_file(config)
      config_file = YAML.load_file(CONFIG_PATH)
      config_file.each do |key,val|
        config[key] ||= val
      end
      config
    end
  end
end
