require 'ojsubmitter/judge'
require 'nokogiri'

module OJS
  class Codeforces < Judge
    class << self
      LANGUAGE_ID = {
        'gcc' => '10',
        'g++11' => '42',
        'g++' => '1',
        'msc++' => '2',
        'c#' => '9',
        'msc#' => '29',
        'd' => '28',
        'go' => '32',
        'haskell' => '12',
        'java7' => '23',
        'java' => '36',
        'ocaml' => '19',
        'delphi' => '3',
        'pascal' => '4',
        'perl' => '13',
        'php' => '6',
        'python' => '7',
        'python3' => '31',
        'pypy' => '40',
        'pypy3' => '41',
        'ruby' => '8',
        'scala' => '20',
        'javascript' => '34',
        'activetcl' => '14',
        'io' => '15',
        'pike' => '17',
        'befunge' => '18',
        'cobol' => '22',
        'factor' => '25',
        'secret' => '26',
        'roco' => '27',
        'ada' => '33',
        'mysterious' => '28',
        'false' => '39',
        'picat' => '44',
      }

      def login
        res = hclient.post(
          'http://codeforces.com/enter',
          { handle:     user,
            password:   password,
            action:     'enter',
            ftaa:       '',
            bfaa:       '',
            csrf_token: csrf_token,
          }
        )
        raise Judge::LoginFailedError if res.body =~ /(Invalid handle or password)|(Fill in the form to login into Codeforces.)/
        Logger.info "Logged in successfully."
      end

      def post
        res = hclient.post(
          'http://codeforces.com/problemset/submit',
          { submittedProblemCode: problem_id,
            programTypeId:        language,
            source:               code,
            csrf_token:           csrf_token,
            action:               'submitSolutionFormSubmitted',
          }
        )
      end

      def status_url
        "http://codeforces.com/submissions/#{user}"
      end

      def language
        LANGUAGE_ID[@config['language'].to_s.downcase]
      end

      def problem_id
        unless @config['problem_id']
          @config['problem_id'] = File.basename(file).split('.')[0]
          unless @config['problem_id'] =~ /\d+/
            @config['problem_id'] = Dir.pwd.split('/').last + @config['problem_id']
          end
        end
        @config['problem_id'].to_s.upcase
      end

      def csrf_token
        unless @csrf_token
          res = hclient.get('http://codeforces.com')
          @csrf_token = Nokogiri::HTML.parse(res.body).xpath('/html/head/meta[@name="X-Csrf-Token"]/@content').to_s
        end
        @csrf_token
      end
    end
  end
end
