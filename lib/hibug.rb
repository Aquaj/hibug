require_relative 'matryochka'

module Hibug
  def hibug
    loop do
      code = gets
      break if code&.strip == 'exit'
      puts current_binding.eval(code).inspect if code
    end
  end

  private

  def current_binding
    currently_in_hibug = nil
    (1...Matryochka.current_info.locations.size).each do |current|
      prev_in_hibug = currently_in_hibug
      context = Matryochka.current_info(up: current)
      current_label = context&.iseq&.label
      currently_in_hibug = (current_label == 'hibug')
      break context.binding if prev_in_hibug && !currently_in_hibug
    end
  end
end

# Mixing it into `main`
include Hibug
