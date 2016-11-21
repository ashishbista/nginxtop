module NginxTop
  class Printer
    COLORS = {
      red: "\e[31m",
      yellow: "\e[33m",
      blue: "\e[34m",
      green: "\e[32m",
      white: "\e[97m",
      bold: "\e[1m",
      dim: "\e[2m",
      gray: "\e[90m",
      cyan: "\e[36m",
      light_green: "\e[92m",
      light_gray: "\e[37m"
    }

    class << self
      def stream
        sprintf "\033c"
      end

      COLORS.each_pair do |k, v|
        define_method k do |str|
          v + str.to_s + "\e[0m"
        end
      end
    end
  end
end
