module NginxTop
  class Request
    REGEX = /((?-mix:(?-mix:(?:(?:[a-zA-Z]|[a-zA-Z][a-zA-Z0-9\-]*[a-zA-Z0-9])\.)*(?:[A-Za-z]|[A-Za-z][A-Za-z0-9\-]*[A-Za-z0-9]))|(?-mix:(?-mix:\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})|(?-mix:(?-mix:(?:[0-9A-Fa-f]{1,4}:){7}[0-9A-Fa-f]{1,4})|(?-mix:(?:(?:[0-9A-Fa-f]{1,4}(?::[0-9A-Fa-f]{1,4})*)?)::(?:(?:[0-9A-Fa-f]{1,4}(?::[0-9A-Fa-f]{1,4})*)?))|(?-mix:(?:(?:[0-9A-Fa-f]{1,4}:){6})(?-mix:\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))|(?-mix:(?:(?:[0-9A-Fa-f]{1,4}(?::[0-9A-Fa-f]{1,4})*)?)::(?:(?:[0-9A-Fa-f]{1,4}:)*)(?-mix:\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}))))))\ ([\w-]+)\ (\/\S*|-)\ \[((?-mix:(?-mix:\d{2}\/(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\/\d{4}:\d{2}:\d{2}:\d{2}\ (?:[+-]\d{4}|[A-Z]{3,4}))|(?-mix:\d{2}\/(?:Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)\/\d{4}\ \d{2}:\d{2}:\d{2})))?\]\ "([A-Z]+) (\S+) HTTP\/(\d+(?:\.\d+)*)"\ (\d{3})\ (\d+|-)/

    DIRECTIVES = [:remote_host, :remote_logname, :user, :timestamp, :http_method, :path, :http_version, :http_status, :bytes_sent]
    attr_accessor *DIRECTIVES
    def initialize(log)
      @log = log
      log.scan(REGEX).flatten.each_with_index do |value, index|
        instance_variable_set "@#{DIRECTIVES[index]}".to_sym, value
      end
    end

    def status_verb
      status = http_status.to_i
      if status.between?(200, 299)
        :success
      elsif status.between?(300, 399)
        :redirection
      elsif status.between?(400, 499)
        :client_error
      elsif status.between?(500, 599)
        :server_error
      else
        :unknown
      end
    end
  end
end
