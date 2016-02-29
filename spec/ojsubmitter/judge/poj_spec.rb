require 'spec_helper'

module OJS
  describe POJ do
    let(:base_options) {
      { 'judge'    => 'poj',
        'language' => 'g++',
        'user'     => 'alice',
        'password' => 'password',
        'file'     => '0234.cpp',
      }
    }
    before do
      POJ.instance_variable_set(:@config, base_options)
    end

    describe '#status_url' do
      it { expect(POJ.status_url).to eq "http://poj.org/status?problem_id=0234&user_id=alice" }
    end

    describe '#language' do
      it 'returns LANGUAGE_ID of POJ' do
        expect(POJ.language).to eq '0'
      end
    end

    describe '#problem_id' do
      context 'not specified problem_id' do
        it 'gets problem_id from file name' do
          expect(POJ.problem_id).to eq '0234'
        end
      end

      context 'specified problem_id' do
        before do
          base_options['problem_id'] = '1234'
        end

        it 'uses problem_id directly' do
          expect(POJ.problem_id).to eq '1234'
        end
      end
    end
  end
end
