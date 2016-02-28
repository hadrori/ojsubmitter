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

      context "log lovel is debug" do
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
        it "prints info" do
          @output = StringIO.new
          Logger.configure(:info, @output)
          Logger.debug("yay")
          expect(@output.string).to eq ""
        end
      end

      context "log lovel is debug" do
        it "prints info" do
          @output = StringIO.new
          Logger.configure(:debug, @output)
          Logger.debug("yay")
          expect(@output.string).to eq "yay\n"
        end
      end
    end

    describe "#error" do
      context "log level is info" do
        it "prints error" do
          @output = StringIO.new
          Logger.configure(:info, @output)
          Logger.error("yay")
          expect(@output.string).to eq "\e[31m[ERROR] yay\e[0m\n"
        end
      end

      context "log lovel is debug" do
        it "prints error" do
          @output = StringIO.new
          Logger.configure(:debug, @output)
          Logger.error("yay")
          expect(@output.string).to eq "\e[31m[ERROR] yay\e[0m\n"
        end
      end
    end
  end
end
