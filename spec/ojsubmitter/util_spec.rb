require 'spec_helper'

module OJS
  describe Util do
    describe "#open_browser" do
      let(:url) { 'test_url' }
      context 'platform is valid' do
        before do
          allow(Object).to receive(:system).with(anything,anything).and_return(:called)
          stub_const 'RUBY_PLATFORM', 'x86_64-darwin15'
        end

        it 'calls system method' do
          expect(Util.open_browser(url)).to eq :called
        end
      end

      context 'platform is invalid ' do
        let(:output) { StringIO.new }
        before do
          stub_const 'RUBY_PLATFORM', 'qieee'
          Util.open_browser(url)
          Logger.configure(:info, output)
          Util.open_browser(url)
        end

        it 'output error message' do
          expect(output.string).to eq "\e[31m[ERROR] Open browser command for this platform is unknow\e[0m\n"
        end
      end
    end
    
    describe "#open_browser_command" do
      context 'platform is mac' do
        before do
          stub_const 'RUBY_PLATFORM', 'x86_64-darwin15'
        end

        it 'uses open command' do
          expect(Util.open_browser_command).to eq 'open'
        end
      end

      context 'platform is linux' do
        before do
          stub_const 'RUBY_PLATFORM', 'i686-linux'
        end

        it 'uses xdg-open command' do
          expect(Util.open_browser_command).to eq 'xdg-open'
        end
      end

      context 'platform is windows' do
        before do
          stub_const 'RUBY_PLATFORM', 'i386-cygwin'
        end

        it 'uses start command' do
          expect(Util.open_browser_command).to eq 'start'
        end
      end

      context 'platform is unknown ' do
        before do
          stub_const 'RUBY_PLATFORM', 'ojsubmitter'
        end

        it 'raises unknown os error' do
          expect { Util.open_browser_command }.to raise_error Util::UnknownOSError
        end
      end
    end
  end
end
