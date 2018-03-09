require_relative 'test_helper'
require_relative '../lib/repl'

class REPLTest < Minitest::Test
  def test_the_repl_can_be_launched_and_reads
    stdin = stub_stdin %q["I haven't been read yet"]
    capture_io { run_with_stdin(stdin) { repl_launch } }
    assert_equal 0, stdin.each_line.count
  end

  def test_the_repl_returns_the_result_of_the_executed_code
    stdin = stub_stdin %q["I haven't been read yet".gsub(%r[n't| yet], "")]
    out, _err = capture_io { run_with_stdin(stdin) { repl_launch } }
    assert_printed_out "I have been read".inspect, out
  end

  def test_the_repl_is_bound_to_the_current_environment
    test_subject = "I have been read in the wrong context"
    stdin = stub_stdin %q[test_subject.gsub(%r[wrong], 'right')]
    out, _err = capture_io { run_with_stdin(stdin) { repl_launch } }
    assert_printed_out "I have been read in the right context".inspect, out
  end

  def test_calling_exit_stops_the_repl
    stdin = stub_stdin 'puts :hello', 'exit', 'puts :no'
    capture_io { run_with_stdin(stdin) { repl_launch } }
    assert_equal 1, stdin.each_line.count
  end
end
