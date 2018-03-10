module REPL
  def repl_launch
    loop do
      code = gets
      puts eval(code).inspect if code
    end
  end
end

# Mixing it into `main`
include REPL
