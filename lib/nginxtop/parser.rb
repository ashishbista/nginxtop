module NginxTop
  class Parser
    def parse(log)
      NginxTop::REQUESTS << Request.new(log)
    end
  end
end
