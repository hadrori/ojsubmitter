require 'spec_helper'

module OJS
  describe CLI do
    describe "#version" do
      it 'shows version' do
        expect { CLI.new.version }.to output("#{OJS::VERSION}\n").to_stdout
      end
    end
  end
end
