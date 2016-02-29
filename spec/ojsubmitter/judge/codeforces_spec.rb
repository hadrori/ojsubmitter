require 'spec_helper'
require 'fakefs/spec_helpers'

module OJS
  describe Codeforces do
    let(:base_options) {
      { 'judge'    => 'cf',
        'language' => 'haskell',
        'user'     => 'alice',
        'password' => 'password',
        'file'     => '1A.hs',
      }
    }
    before do
      Codeforces.instance_variable_set(:@config, base_options)
    end

    describe '#status_url' do
      it { expect(Codeforces.status_url).to eq "http://codeforces.com/submissions/alice" }
    end

    describe '#language' do
      it 'returns LANGUAGE_ID of Codeforces' do
        expect(Codeforces.language).to eq '12'
      end
    end

    describe '#problem_id' do
      context 'not specified problem_id' do
        context 'file name has contest id' do
          it 'gets problem_id from file name' do
            expect(Codeforces.problem_id).to eq '1A'
          end
        end

        context 'current directory name has contest id' do
          include FakeFS::SpecHelpers
          before do
            cur_dir = '/path/to/codeforces/working/123'
            FileUtils.mkdir_p(cur_dir)
            Dir.chdir(cur_dir)
            base_options['file'] = 'A.hs'
          end

          it 'gets problem_id from current directory name and file name' do
            expect(Codeforces.problem_id).to eq '123A'
          end
        end
      end

      context 'specified problem_id' do
        before do
          base_options['problem_id'] = '345D'
        end

        it 'uses problem_id directly' do
          expect(Codeforces.problem_id).to eq '345D'
        end
      end
    end

    describe '#csrf_token' do
      it 'reads csrf_token' do
        VCR.use_cassette('codeforces/index') do
          expect(Codeforces.csrf_token).to eq 'f8f1c257671a93519f0cfae2110a639d'
        end
      end
    end
  end
end
