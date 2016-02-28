require 'ojsubmitter/judge'

module OJS
  class AOJ < Judge
    class << self
      LANGUAGE_ID = {
        'c'          => 'C',
        'c++'        => 'C++',
        'c++11'      => 'C++11',
        'java'       => 'JAVA',
        'c#'         => 'C#',
        'd'          => 'D',
        'ruby'       => 'Ruby',
        'python'     => 'Python',
        'python3'    => 'Python3',
        'php'        => 'PHP',
        'javascript' => 'JavaScript',
      }

      def post
        hclient.post(
          'http://judge.u-aizu.ac.jp/onlinejudge/servlet/Submit',
          { userID:     user_name,
            password:   password,
            problemNO:  problem_id,
            language:   language,
            sourceCode: code }
        )
      end

      def status_url
        'http://judge.u-aizu.ac.jp/onlinejudge/status.jsp'
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
