require 'spec_helper'
require 'fakefs/spec_helpers'

module OJS
  describe CLI do
    describe "#version" do
      it 'shows version' do
        expect { CLI.new.version }.to output("#{OJS::VERSION}\n").to_stdout
      end
    end

    describe "#list" do
      let(:output) { StringIO.new }
      before do
        Logger.configure(:info, output)
        CLI.new.list
      end

      it 'shows valid judges' do
        expect(output.string).to match(/Available judges are below./)
      end
    end

    describe "#init" do
      include FakeFS::SpecHelpers
      before do
        FileUtils.mkdir_p(ROOT_DIR)
        FileUtils.mkdir_p(ENV['HOME'])
        FileUtils.touch(CLI::SAMPLE_CONFIG_PATH)
      end
      
      context 'config file is not created yet' do
        it 'copies a sample config file' do
          expect { CLI.new.init }.to change { File.exists?(CLI::CONFIG_PATH) } .from(false).to(true)
        end
      end

      context 'config file is already created' do
        before do
          FileUtils.touch(CLI::CONFIG_PATH)
        end

        it 'creates config file' do
          expect { CLI.new.init }.not_to change { File.exists?(CLI::CONFIG_PATH) }.from(true)
        end
      end
    end
  end
end
