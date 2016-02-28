require 'spec_helper'

module OJS
  describe Logger do
    describe "#info" do
      context "log level is info" do
        it "prints info" do
          @output = StringIO.new
          Logger.configure(:info, @output)
          Logger.info("yay")
          expect(@output.string).to eq "yay\n"
        end
      end
      context "log level is debug" do
        it "prints info" do
          @output = StringIO.new
          Logger.configure(:debug, @output)
          Logger.info("yay")
          expect(@output.string).to eq "yay\n"
        end
      end
    end
    describe "#debug" do
      context "log level is info" do
        it "does not print debug" do
          @output = StringIO.new
          Logger.configure(:info, @output)
          Logger.debug("yay")
          expect(@output.string).not_to eq "yay\n"
        end
      end
      context "log level is debug" do
        it "prints debug" do
          @output = StringIO.new
          Logger.configure(:debug, @output)
          Logger.debug("yay")
          expect(@output.string).to eq "yay\n"
        end
      end
    end
  end
end
