require 'profligacy/swing'

class ChangeDemo
  include_package 'javax.swing'
  include_package 'java.awt'
  include_package 'javax.swing.border'
  include Profligacy

  def initialize
    @ui = Swing::Build.new JFrame, :button, :label do |c,i|
      c.label = JLabel.new
      c.button = JButton.new "Press for Change Event Test"
      
      i.button = { :change => method(:change_check) }
    end

    @ui.layout = FlowLayout.new
    frame = @ui.build("Change Demo")
    frame.set_size(250,160)
    frame.default_close_operation = JFrame::EXIT_ON_CLOSE
  end

  def change_check(type, event)
    model = event.source.model
    what = []
    [:enabled?, :rollover?, :armed?, :pressed?].each do |test|
      if model.send(test)
        what << "#{test}<br>"
      end
    end

    @ui.label.text = "<html>Current state:<br>#{what.join(" ")}"
  end
end


SwingUtilities.invoke_later proc { ChangeDemo.new }.to_runnable
