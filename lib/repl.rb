require_relative 'matryochka'

module REPL
  def repl_launch
    loop do
      code = gets
      puts current_binding.eval(code).inspect if code
    end
  end

  private

  def current_binding
    currently_in_repl = nil
    (1...Matryochka.current_info.locations.size).each do |current|
      prev_in_repl = currently_in_repl
      context = Matryochka.current_info(up: current)
      current_label = context&.iseq&.label
      currently_in_repl = (current_label == 'repl_launch')
      break context.binding if prev_in_repl && !currently_in_repl
    end
  end
end

# Mixing it into `main`
include REPL
