require 'debug_inspector'

Matryochka = Object.new

class << Matryochka
  def get_binding(up: 1)
    RubyVM::DebugInspector.open do |dc|
      frame_position = up + 2 # 1 in DebugInspector#open + 1 in #get_binding
      return nil if frame_position >= dc.backtrace_locations.size
      dc.frame_binding(frame_position)
    end
  end

  def inspect
    :Matryochka
  end
end
