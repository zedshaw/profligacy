require 'profligacy/swing'

class StopWatch
  include_package 'javax.swing'
  import 'java.awt.FlowLayout'
  include Profligacy

  def initialize
    @ui = Swing::Build.new JFrame, :start, :stop, :lab do |c,i|
      c.start = JButton.new "Start"
      c.stop = JButton.new "Stop"
      c.lab = JLabel.new "Press Start to begin timing."

      i.start = { :action => method(:start) }
      i.stop = { :action => method(:stop) }
    end

    @ui.layout = FlowLayout.new
    @ui.build("Stop Watch").default_close_operation = JFrame::EXIT_ON_CLOSE
  end

  def start(type, event)
    @ui.lab.text = "Stopwatch is running..."
    @time = Time.new
  end

  def stop(type, event)
    if @time
      @ui.lab.text = "#{Time.now.to_i - @time.to_i} seconds."
    else
      @ui.lab.text = "Start the watch first."
    end
    @time = nil
  end
end

SwingUtilities.invoke_later proc { StopWatch.new }.to_runnable

