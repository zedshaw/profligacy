require 'profligacy/swing'

class TwoTFDemo
  include_package 'javax.swing'
  include_package 'java.awt'
  include_package 'javax.swing.border'
  include Profligacy

  def initialize
    @ui = Swing::Build.new JFrame, :texts, :label do |c,i|
      c.texts = [ JTextField.new(10), JTextField.new(10)]
      c.texts.each_with_index {|t,n| t.action_command = "text#{n}" }
      c.label = JLabel.new "Something will show up here."

      i.texts = {:action => method(:text_action) }
    end

    @ui.layout = FlowLayout.new
    @ui.build("Two Text Fields Demo").default_close_operation = JFrame::EXIT_ON_CLOSE
  end

  def text_action(type, event)
    puts "EVENT: #{type} #{event.action_command}"
    if event.action_command == "text0"
      @ui.label.text = "ENTER pressed in first text"
    else
      @ui.label.text = "ENTER pressed in second text"
    end
  end
end


SwingUtilities.invoke_later proc { TwoTFDemo.new }.to_runnable
