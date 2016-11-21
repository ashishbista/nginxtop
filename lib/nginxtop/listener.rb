module NginxTop
  class Listener

    START_TIME = Time.now

    def initialize(options)
      @log_file = options[:file]
      @no_watch = options[:no_watch]
      install_signal_handlers
    end

    def listen

      File.readlines(@log_file).each do |line|
        Parser.new.parse(line.chomp)
      end

      Output.create

      file = File.open(@log_file)
      file.seek(0,IO::SEEK_END)
      thread1 = Thread.new do
        loop do
          select([file])
          line = file.gets
          Parser.new.parse(line.chomp) if line
        end
      end

      thread2 = Thread.new do
        loop do
          sleep 1
          Output.create
        end
      end
      unless @no_watch
        thread1.join
        thread2.join
      end

    end

    def install_signal_handlers
      Signal.trap('INT') do
        puts 'Caught interrupt! Stopping parsing...'
        exit 130
      end
    end

  end
end
