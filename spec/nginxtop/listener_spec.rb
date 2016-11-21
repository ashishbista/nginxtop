require 'spec_helper'

describe NginxTop::Listener do
  let(:listener) { NginxTop::Listener.new(file: File.expand_path(__dir__) + '/../access.log', no_watch: true) }
  describe '#listen' do
    it 'created requests for each log line' do
      listener.listen
      expect(NginxTop::REQUESTS.count).to eq 7
    end
  end
end
