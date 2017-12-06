# encoding: utf-8
require 'logstash/devutils/rspec/spec_helper'
require 'logstash/inputs/reqsample'

describe LogStash::Inputs::Reqsample do
  describe 'simple configuration' do
    let(:config) do
      <<-CONFIG
        input {
          reqsample {
            count => 10
          }
        }
      CONFIG
    end

    it 'generates events' do
      expect(
        input(config) do |_pipeline, queue|
          Array.new(queue.size) { queue.pop }
        end.size
      ).to eq 10
    end
  end
end
