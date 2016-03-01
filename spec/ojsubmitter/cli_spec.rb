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

    describe '#judge_class' do
      let(:cli) { CLI.new }
      context 'valid judge' do
        it 'returns target judge class' do
          cli.instance_variable_set(:@config, { 'judge' => 'aoj' })
          expect(cli.send(:judge_class)).to be OJS::AOJ
          cli.instance_variable_set(:@config, { 'judge' => 'cf' })
          expect(cli.send(:judge_class)).to be OJS::Codeforces
          cli.instance_variable_set(:@config, { 'judge' => 'atcoder' })
          expect(cli.send(:judge_class)).to be OJS::AtCoder
        end
      end

      context 'invalid judge' do
        before do
          cli.instance_variable_set(:@config, { 'judge' => 'fox' })
        end

        it 'returns target judge class' do
          expect { cli.send(:judge_class) }.to raise_error CLI::UnknownJudgeError
        end
      end
    end

    describe '#set_options_from_config_file' do
      include FakeFS::SpecHelpers
      let(:option) { { 'judge' => 'aoj', 'language' => 'ruby' } }
      before do
        FileUtils.mkdir_p(ENV['HOME'])
        File.write(OJS::CLI::CONFIG_PATH, option.to_yaml)
      end

      it 'returns option' do
        expect(CLI.new.send(:set_options_from_config_file, {})).to eq option
      end
    end
  end
end
