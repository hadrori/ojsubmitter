require 'spec_helper'

module OJS
  describe Util do
    describe "#open_browser_command" do
      context 'platform is max' do
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
