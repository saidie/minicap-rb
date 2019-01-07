require 'socket'

class Minicap::Stream
  DEFAULT_BUFFER_SIZE = 1024 * 1024
  DEFAULT_SLEEP_SECS = 0.001

  def initialize(host, port, options={})
    @host = host
    @port = port
    @options = options
  end

  def each
    return enum_for(:each) unless block_given?

    buffer_size = @options[:buffer_size] || DEFAULT_BUFFER_SIZE
    sleep_secs = @options[:sleep_secs] || DEFAULT_SLEEP_SECS
    debug = @options[:debug]

    soc = nil
    begin
      soc = TCPSocket.open(@host, @port)

      buf = soc.recv(buffer_size).unpack('C*')
      fail 'unknown version' if buf[0] != 1
      header_size = buf[1]
      header = buf[0...header_size]
      data = buf[header_size..-1]

      in_frame = false
      n = 0
      loop do
        if !in_frame && data.size >= 4
          n = uint32le(data)
          in_frame = true
          STDERR.puts 'new frame with size %d' % n if debug
        end

        if in_frame && data.size >= 4 + n
          jpg_blob = data[4...4+n]
          yield jpg_blob
          data = data[4+n..-1]
          in_frame = false
        end

        sleep sleep_secs

        if in_frame
          fetch_size = [buffer_size, 4 + n - data.size].min
        else
          fetch_size = buffer_size
        end

        buf = soc.recv(fetch_size).unpack('C*')
        data += buf
      end
    ensure
      soc.close unless soc
    end
  end

  private

  def uint32le(bs)
    bs[0] + (bs[1] << 8) + (bs[2] << 16) + (bs[3] << 24)
  end
end
