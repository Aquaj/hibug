require 'debug_inspector'

Matryochka = Object.new

class << Matryochka
  def get_binding(up: 1)
    current_info(up: up)&.binding
  end

  def current_info(up: 1)
    RubyVM::DebugInspector.open do |dc|
      frame_position = up + 3 # 1 in DebugInspector#open + 1 in #get_binding + 1 in #current_info
      return nil if frame_position >= dc.backtrace_locations.size
      Struct.new(:locations, :binding, :iseq, :klass)
            .new(dc.backtrace_locations,
                 dc.frame_binding(frame_position),
                 dc.frame_iseq(frame_position),
                 dc.frame_class(frame_position))
    end
  end

  def inspect
    :Matryochka
  end
end
