require 'ojsubmitter/judge'

module OJS
  class POJ < Judge
    class << self
      LANGUAGE_ID = {
        'g++'     => '0',
        'gcc'     => '1',
        'java'    => '2',
        'pascal'  => '3',
        'c++'     => '4',
        'c'       => '5',
        'fortran' => '6',
      }

      def login
        res = hclient.post(
          'http://poj.org/login',
          { :user_id1  => user,
            :password1 => password }
        )
        raise Judge::LoginFailedError if res.body =~ /Login failed!/
        Logger.info "Logged in successfully."
      end

      def post
        res = hclient.post(
          'http://poj.org/submit',
          { :problem_id => problem_id,
            :language   => language,
            :source     => code,
            :encoded    => 'UTF-8',
          }
        )
        raise Judge::SubmissionError if res.body =~ /(Error Occurred)|(Error report)/
      end

      def status_url
        "http://poj.org/status?problem_id=#{problem_id}&user_id=#{user}"
      end

      def language
        LANGUAGE_ID[@config['language'].to_s.downcase]
      end

      def problem_id
        unless @config['problem_id']
          @config['problem_id'] = File.basename(file).split('.')[0]
        end
        sprintf "%04d", @config['problem_id'].to_i
      end
    end
  end
end
