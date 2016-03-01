require 'ojsubmitter/judge'
require 'nokogiri'

module OJS
  class AtCoder < Judge
    class << self
      def login
        res = hclient.post(
          "https://#{contest_url}/login",
          { name:     user,
            password: password,
            submit:   'Login' }
        )
        hclient.cookies.each do |ck|
          ck.domain = contest_url if ck.domain == 'atcoder.jp'
        end
        raise Judge::LoginFailedError unless hclient.cookies.any? { |ck| ck.name == '_user_id' }
        Logger.info "Logged in successfully."
      end

      def post
        res = hclient.post(
          "https://#{contest_url}/submit",
          { __session:   session,
            task_id:     task_id,
            :"language_id_#{task_id}" => language,
            source_code: code,
            submit:      'submit',
          }
        )
        raise Judge::SubmissionError if res.body =~ /Error/
      end

      def contest_url
        "#{contest_id}.contest.atcoder.jp"
      end

      def status_url
        "https://#{contest_url}/submissions/me"
      end

      def language
        set_extra_values unless @languages
        cands = []
        @languages.each do |id, name|
          cands << [id,name] if name.downcase.match Regexp.escape(@config['language'].downcase)
        end
        raise Judge::UnknownLanguageError if cands.empty?
        return cands[0][0] if cands.size == 1
        select_language cands
      end

      def select_language(cands)
        Logger.info "Two more languages are matched. Please select one."
        cands.each_with_index do |cand, idx|
          Logger.info "#{idx} : #{cand[1]}"
        end
        while true
          inp = STDIN.gets.chomp
          next Logger.info "Please input number." unless inp =~ /\A\d+\z/
          idx = inp.to_i
          next Logger.info "Please input valid number." unless cands[idx]
          return cands[idx][0]
        end
      end

      def contest_id
        unless @config['contest_id']
          @config['contest_id'] = Dir.pwd.split('/').last
        end
        @config['contest_id'].downcase
      end

      def task_id
        unless @task_id
          set_extra_values
        end
        @task_id
      end

      def problem_id
        unless @config['problem_id']
          @config['problem_id'] = File.basename(file).split('.')[0]
        end
        @config['problem_id'].upcase
      end

      def session
        unless @session
          set_extra_values
        end
        @session
      end

      def set_extra_values
        res = @hclient.get("https://#{contest_url}/submit")
        html = Nokogiri::HTML.parse(res.body)
        @session = html.xpath('//input[@name="__session"]/@value').first.value
        @task_id = html.xpath('//select[@name="task_id"]/option').first.attribute('value').value.to_i + problem_id.ord - 'A'.ord
        @languages = html.xpath("//select[@name=\"language_id_#{@task_id}\"]/option").map { |lang|
          [lang.attribute('value').value, lang.content]
        }
      end
    end
  end
end
