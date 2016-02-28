require 'spec_helper'

module OJS
  describe AOJ do
    describe '#status_url' do
      it { expect(AOJ.status_url).to eq 'http://judge.u-aizu.ac.jp/onlinejudge/status.jsp' }
    end

    let(:base_options) {
      { 'judge'    => 'aoj',
        'language' => 'ruby',
        'user'     => 'alice',
        'password' => 'password',
        'file'     => '0234.rb',
      }
    }
    before do
      AOJ.instance_variable_set(:@config, base_options)
    end

    describe '#language' do
      it 'returns LANGUAGE_ID of AOJ' do
        expect(AOJ.language).to eq 'Ruby'
      end
    end

    describe '#problem_id' do
      context 'not specified problem_id' do
        it 'gets problem_id from file name' do
          expect(AOJ.problem_id).to eq '0234'
        end
      end

      context 'specified problem_id' do
        before do
          base_options['problem_id'] = '1234'
        end

        it 'uses problem_id directly' do
          expect(AOJ.problem_id).to eq '1234'
        end
      end
    end
  end
end
