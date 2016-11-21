require "nginxtop/version"
require "nginxtop/listener"
require "nginxtop/output"
require "nginxtop/parser"
require "nginxtop/request"
require "nginxtop/printer"
require 'io/console'

module NginxTop
  REQUESTS = []

  def self.count(status)
    REQUESTS.select{ |r| r.status_verb == status }.count
  end

  def self.bar(status)
    n = (IO.console.winsize.last * 0.25 * (( 100 * count(status)/REQUESTS.count))/100).to_i rescue 0
    "|" * n
  end

  def self.uptime
    time_diff = Time.now - Listener::START_TIME
    Time.at(time_diff.to_i.abs).utc.strftime "%H:%M:%S"
  end

end
