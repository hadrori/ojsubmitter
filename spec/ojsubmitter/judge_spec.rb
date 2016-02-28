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
        expect(Judge.valid_judges).to eq(%w[aoj])
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
  end
end
