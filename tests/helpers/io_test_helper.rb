require 'stringio'

module IoTestHelper
  def self.simulate_stdin(*inputs, &block)
    io = StringIO.new
    inputs.flatten.each { |str| io.puts(str) }
    io.rewind

    actual_stdin = $stdin
    $stdin = io
    yield
  ensure
    $stdin = actual_stdin
  end
end
