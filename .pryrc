if defined? Rails.env
  Pry.config.view_source = "(#{Rails.env})"
  Pry.config.prompt_name = "#{File.basename(Dir.pwd)}"
else
  Pry.config.view_source = "(main)"
  Pry.config.prompt_name = "pry"
end

Pry.prompt = [
  proc { |target_self, nest_level, pry|
    "[#{pry.input_array.size}]\001\e[1;93m\002#{Pry.config.prompt_name}" +
    "\001\e[0m\002\001\e[1;92m\002#{Pry.config.view_source}\001\e[0m\002" +
    "#{":#{nest_level}" unless nest_level.zero?}\001\e[1;95m\002:>\001\e[0m\002 "
  },
  proc { |target_self, nest_level, pry|
    "[#{pry.input_array.size}]\001\e[1;93m\002#{Pry.config.prompt_name}" +
    "\001\e[0m\002\001\e[1;92m\002#{Pry.config.view_source}\001\e[0m\002" +
    "#{":#{nest_level}" unless nest_level.zero?}\001\e[1;95m\002:-\001\e[0m\002 "
  }
]

begin
  require 'hirb'
rescue LoadError
end

if defined? Hirb
  Hirb::View.instance_eval do
    def enable_output_method
      @output_method = true
      @old_print = Pry.config.print
      Pry.config.print = proc do |*args|
        Hirb::View.view_or_page_output(args[1]) || @old_print.call(*args)
      end
    end

    def disable_output_method
      Pry.config.print = @old_print
      @output_method = nil
    end
  end

  Hirb.enable
end
