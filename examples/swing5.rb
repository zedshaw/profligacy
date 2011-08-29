require 'profligacy/swing'

class ToggleButtonDemo
  include_package 'javax.swing'
  include_package 'java.awt'
  include_package 'javax.swing.border'
  include Profligacy

  def initialize
    @ui = Swing::Build.new JFrame, :label, :button do |c,i|
      c.label = JLabel.new "Button is off."
      c.button = JToggleButton.new "On/Off"

      i.button = { :item => method(:toggled) }
    end

    @ui.layout = FlowLayout.new
    @ui.build("Toggle Demo").default_close_operation = JFrame::EXIT_ON_CLOSE
  end

  def toggled(type, event)
    if @ui.button.selected?
      @ui.label.text = "Button is on."
    else
      @ui.label.text = "Button is off."
    end
  end
end


SwingUtilities.invoke_later proc { ToggleButtonDemo.new }.to_runnable
