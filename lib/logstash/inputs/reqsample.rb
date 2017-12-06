# encoding: utf-8
require 'chronic'
require 'logstash/inputs/base'
require 'logstash/namespace'
require 'reqsample'
require 'socket' # for Socket.gethostname

# Generate randomized webserver log strings.
#
# Logs can be generated at once in bulk, or streamed over time.
class LogStash::Inputs::Reqsample < LogStash::Inputs::Base
  config_name 'reqsample'

  # If undefined, Logstash will complain, even if codec is unused.
  default :codec, 'plain'

  # Set how frequently messages should be sent.
  #
  # The default, `1000`, generates 1000 logs.
  config :count, :validate => :number, :default => 1000

  # The format in which logs should be generated.
  config :format, :validate => :string, :default => 'apache'

  # The peak of the normal distribution curve that logs will occur at.
  #
  # This should be a human-readable string that will be parsed by the Chronic
  # gem.
  config :peak, :validate => :string, :default => '12 hours ago'

  # Standard deviation for the normal distribution of log events.
  config :stdev, :validate => :number, :default => 4

  # Whether the logs should be streamed gradually instead or returned all at
  # once (simulates periodic life traffic flow).
  config :stream, :validate => :boolean, :default => false

  # Cutoff (in hours) that logs should remain generated within.
  config :truncate, :validate => :number, :default => 12

  public

  def register
    @host = Socket.gethostname
    @generator = ::ReqSample::Generator.new @stdev
    @production_options = {
      :count => @count,
      :format => @format,
      :sleep => @stream,
      :truncate => @truncate,
      :peak => Chronic.parse(@peak)
    }
  end # def register

  def run(queue)
    @generator.produce(@production_options).lazy do |log|
      break if stop?
      event = LogStash::Event.new('message' => log, 'host' => @host)
      decorate(event)
      queue << event
    end # produce
  end # def run
end # class LogStash::Inputs::Reqsample
