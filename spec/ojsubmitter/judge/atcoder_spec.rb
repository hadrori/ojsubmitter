require 'spec_helper'
require 'fakefs/spec_helpers'

module OJS
  describe AtCoder do
    let(:base_options) {
      { 'judge'      => 'atcoder',
        'language'   => 'ruby',
        'user'       => 'hadrori',
        'password'   => '10031003',
        'file'       => 'a.rb',
        'contest_id' => 'abc001',
      }
    }
    let(:output) { StringIO.new }

    before do
      Logger.configure(:info, output)
      AtCoder.instance_variable_set(:@task_id, nil)
      AtCoder.instance_variable_set(:@session, nil)
      AtCoder.instance_variable_set(:@languages, nil)
      AtCoder.instance_variable_set(:@config, base_options)
    end

    describe '#status_url' do
      it { expect(AtCoder.status_url).to eq "https://abc001.contest.atcoder.jp/submissions/me" }
    end

    let(:language_candidates) {
      [["14", "C++ (G++ 4.6.4)"],
       ["10", "C++11 (GCC 4.8.1)"],
       ["2", "C++ (GCC 4.4.7)"]]
    }

    describe '#language' do
      before do
        AtCoder.instance_variable_set(:@hclient, HTTPClient.new)
      end

      context 'there are two more candidates.' do
        before do
          allow(AtCoder).to receive(:select_language).with(language_candidates).and_return(:called)
          base_options['language'] = 'c++'
        end

        it 'calls select_language methodr' do
          VCR.use_cassette('atcoder/submit') do
            expect(AtCoder.language).to eq :called
          end
        end
      end

      context 'there is only one language' do
        it 'returns language id in AtCoder' do
          VCR.use_cassette('atcoder/submit') do
            expect(AtCoder.language).to eq '9'
          end
        end
      end
    end

    describe '#select_language' do
      context 'gets not integer' do
        before do
          allow(STDIN).to receive(:gets).and_return("x\n", "0\n")
          AtCoder.select_language(language_candidates)
        end

        it 'outputs error message' do
          expect(output.string).to match(/Please input number./)
        end
      end

      context 'gets a integer out of range' do
        before do
          allow(STDIN).to receive(:gets).and_return("7\n", "0\n")
          AtCoder.select_language(language_candidates)
        end

        it 'outputs error message' do
          expect(output.string).to match(/Please input valid number./)
        end
      end

      context 'gets a valid integer' do
        before do
          allow(STDIN).to receive(:gets).and_return("0\n")
        end

        it 'returns language id in AtCoder' do
          expect(AtCoder.select_language(language_candidates)).to eq '14'
        end
      end
    end

    describe '#problem_id' do
      context 'not specified problem_id' do
        it 'gets problem_id from file name' do
          expect(AtCoder.problem_id).to eq 'A'
        end
      end

      context 'specified problem_id' do
        before do
          base_options['problem_id'] = 'B'
        end

        it 'uses problem_id directly' do
          expect(AtCoder.problem_id).to eq 'B'
        end
      end
    end

    describe '#task_id' do
      before do
        AtCoder.instance_variable_set(:@hclient, HTTPClient.new)
      end

      it 'gets task id from problem_id and submit form' do
        VCR.use_cassette('atcoder/submit') do
          expect(AtCoder.task_id).to eq 731
        end
      end
    end

    describe '#session' do
      before do
        AtCoder.instance_variable_set(:@hclient, HTTPClient.new)
      end

      it 'gets session from submit form' do
        VCR.use_cassette('atcoder/submit') do
          expect(AtCoder.session).to eq '1145141919810893'
        end
      end
    end

    describe '#contest_id' do
      before do
        AtCoder.instance_variable_set(:@hclient, HTTPClient.new)
      end

      context 'contest_id is specified' do
        it 'gets contest_id from option' do
          expect(AtCoder.contest_id).to eq 'abc001'
        end
      end

      context 'contest_id is not specified' do
        include FakeFS::SpecHelpers
        before do
          cur_dir = '/path/to/atcoder/working/arc002'
          FileUtils.mkdir_p(cur_dir)
          Dir.chdir(cur_dir)
          base_options['contest_id'] = nil
        end

        it 'gets contest_id from current_dir' do
          expect(AtCoder.contest_id).to eq 'arc002'
        end
      end
    end
  end
end
