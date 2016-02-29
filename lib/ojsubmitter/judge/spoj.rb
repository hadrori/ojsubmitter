require 'ojsubmitter/judge'

module OJS
  class SPOJ < Judge
    class << self
      LANGUAGE_ID = {
        'ada'          =>   '7',
        'assembler'    =>  '13', # nasm
        # 'Assembler'    =>  '45', # Assembler GC g++
        'awk'          => '104',
        'bash'         =>  '28',
        'brainf**k'    =>  '12',
        'c'            =>  '11',
        'c#'           =>  '27',
        'c++'          =>   '1',
        # 'C++'          =>   '41', # g++ 4.3.2
        'c++14'        =>  '44',
        'c99'          =>  '34',
        'clips'        =>  '14',
        'clojure'      => '111',
        'cobol'        => '118',
        'commonlisp'   =>  '32', # clisp
        # 'CommonLisp'   =>  '31', # sbcl
        'd'            =>  '20',
        'erlang'       =>  '36',
        'f#'           => '124',
        'fortran'      =>   '5',
        'go'           => '114',
        'groovy'       => '121',
        'haskell'      =>  '21',
        'icon'         =>  '16',
        'intercal'     =>   '9',
        'jar'          =>  '24',
        'java'         =>  '10',
        'javascript'   => '112',
        'lua'          =>  '26',
        'nemerle'      =>  '30',
        'nice'         =>  '25',
        'ocaml'        =>   '8',
        'pascal'       =>  '22',
        'perl'         =>   '3',
        'php'          =>  '29',
        'pike'         =>  '19',
        'prolog'       =>  '15',
        'python'       =>   '4',
        # 'Python'       =>  '99' # PyPy
        'python3'      =>  '98',
        # 'Python3'      =>  '116', # python 3.2.3
        # 'Python3'      =>  '126', # python 3.2.3 nbc
        'ruby'         =>  '17',
        'scala'        =>  '39',
        'scheme'       =>  '33', # guile
        # 'Scheme'       =>  '18', # stalin
        'sed'          =>  '46',
        'smalltalk'    =>  '23',
        'tcl'          =>  '38',
        'tecs'         =>  '42',
        'text'         =>  '62',
        'vb.net'       =>  '50',
        'whitespace'   =>   '6'
      }

      def login
        res = hclient.post(
          'http://www.spoj.com/login/',
          { :login_user => user,
            :password   => password }
        )
        raise Judge::LoginFailedError if res.body =~ /Authentication failed!/
        Logger.info "Logged in successfully."
      end

      def post
        res = hclient.post(
          'http://www.spoj.com/submit/complete/',
          { :problemcode => problem_id, 
            :lang        => language,
            :file        => code }
        )
        raise Judge::SubmissionError if res.body =~ /Error/
      end

      def status_url
        "http://www.spoj.com/status/#{user}"
      end

      def language
        LANGUAGE_ID[@config['language'].to_s.downcase]
      end

      def problem_id
        unless @config['problem_id']
          @config['problem_id'] = File.basename(file).split('.')[0]
        end
        @config['problem_id'].upcase
      end
    end
  end
end
