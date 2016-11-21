require 'pry'
module NginxTop
  class Output
    def self.create

      output = Printer.stream

      output << sprintf("%31s \n", Printer.bold(Printer.white("NGINX TOP")))

      output << sprintf(" %5s %s %-50s %s %d \t %20s %s\n", Printer.cyan("2XX"), Printer.white("["), Printer.green(NginxTop.bar(:success)), Printer.white("]"), NginxTop.count(:success), Printer.cyan("Running for:"), Printer.white(NginxTop.uptime))
      output << sprintf(" %5s %s %-50s %s %d \t %20s %d\n", Printer.cyan("3XX"), Printer.white("["), Printer.gray(NginxTop.bar(:redirection)), Printer.white("]"), NginxTop.count(:redirection), Printer.cyan("Total requests:"), NginxTop::REQUESTS.count)
      output << sprintf(" %5s %s %-50s %s %d\n", Printer.cyan("4XX"), Printer.white("["), Printer.yellow(NginxTop.bar(:client_error)), Printer.white("]"), NginxTop.count(:client_error))
      output << sprintf(" %5s %s %-50s %s %d\n", Printer.cyan("5XX"), Printer.white("["), Printer.red(NginxTop.bar(:server_error)), Printer.white("]"), NginxTop.count(:server_error))

      output << sprintf("\n%31s \n", Printer.bold(Printer.white("TOP PAGES")))

      NginxTop::REQUESTS.group_by(&:path).sort_by(&:count)[0..15].each do |r|
        output << sprintf(" %-58s %s\n", Printer.light_gray(r.first), Printer.white(r.last.count))
      end

      puts output

    end
  end
end
