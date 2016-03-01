require 'spec_helper'

module OJS
  shared_examples 'a not implemented method' do
    it "raise NotImplementedError" do
      expect { method }.to raise_error(NotImplementedError)
    end
  end

  describe Judge do
    describe "#valid_judges" do
      it "returns enabled judges" do
        expect(Judge.valid_judges).to eq(%w[AOJ POJ SPOJ Codeforces AtCoder])
      end
    end

    describe "#submit" do
      let(:option) {
        { 'judge' => 'judge',
          'user'  => 'alice',
          'password' => 'pswd',
          'language' => 'lang' }
      }
      before do
        allow(Judge).to receive(:login)
        allow(Judge).to receive(:post)
        allow(Judge).to receive(:open_status)
        allow_any_instance_of(Object).to receive(:sleep)
      end

      it "sets config" do
        Judge.submit option
        expect(Judge.instance_variable_get(:@config)).to eq(option)
      end
    end

    describe "#post" do
      subject(:method) { Judge.post }
      it_behaves_like 'a not implemented method'
    end

    describe "#open_status" do
      subject(:method) { Judge.open_status }
      it_behaves_like 'a not implemented method'
    end

    let(:option) {
      { 'judge'    => 'aoj',
        'user'     => 'alice',
        'password' => 'pswd',
        'language' => 'c++',
        'file'     => '1234.cpp' }
    }

    before do
      Judge.instance_variable_set(:@config, option)
    end

    describe "#password" do
      it 'shows password' do
        expect(Judge.password).to eq 'pswd'
      end
    end

    describe "#language" do
      it 'shows language' do
        expect(Judge.language).to eq 'c++'
      end
    end

    describe "#problem_id" do
      context 'not specified problem_id' do
        it 'will be nil' do
          expect(Judge.problem_id).to be nil
        end
      end

      context 'specified problem_id' do
        before do
          option['problem_id'] = '1234'
        end

        it 'uses problem_id directly' do
          expect(AOJ.problem_id).to eq '1234'
        end
      end
    end
  end
end
