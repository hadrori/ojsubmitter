require 'spec_helper'

module OJS
  describe SPOJ do
    let(:base_options) {
      { 'judge'    => 'spoj',
        'language' => 'c++14',
        'user'     => 'alice',
        'password' => 'password',
        'file'     => 'prime1.cpp',
      }
    }
    before do
      SPOJ.instance_variable_set(:@config, base_options)
    end

    describe '#status_url' do
      it { expect(SPOJ.status_url).to eq "http://www.spoj.com/status/alice" }
    end

    describe '#language' do
      it 'returns LANGUAGE_ID of SPOJ' do
        expect(SPOJ.language).to eq '44'
      end
    end

    describe '#problem_id' do
      context 'not specified problem_id' do
        it 'gets problem_id from file name' do
          expect(SPOJ.problem_id).to eq 'PRIME1'
        end
      end

      context 'specified problem_id' do
        before do
          base_options['problem_id'] = 'prime2'
        end

        it 'uses problem_id directly' do
          expect(SPOJ.problem_id).to eq 'PRIME2'
        end
      end
    end
  end
end
