require 'minitest/autorun'
require 'timeout'

module TestHelper
  def stub_stdin(*inputs)
    stub = StringIO.new
    inputs.each { |input| stub.puts(input.to_s) }
    stub.rewind
    stub
  end

  def run_with_stdin(std_stub)
    original = $stdin
    $stdin = std_stub
    Timeout.timeout(1) do
      yield
    end
  rescue Timeout::Error
    # noop
  ensure
    $stdin = original
  end
end

class Minitest::Test
  include TestHelper
end

