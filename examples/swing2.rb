require 'profligacy/swing'

module Buttons
  class ButtonDemo
    include_package 'javax.swing'
    include_package 'java.awt'
    include Profligacy

    def initialize
      @ui = Swing::Build.new JFrame, :first, :second, :lab do |c,i|
        c.lab = JLabel.new "Press A Button."
        c.first = JButton.new "First"
        c.second = JButton.new "Second"

        i.first = { :action => proc {|t,e| c.lab.text = "First pressed." } }
        i.second = { :action => proc {|t,e| c.lab.text = "Second pressed." } }
      end

      @ui.layout = FlowLayout.new
      @ui.build("The Sample Layout").default_close_operation = JFrame::EXIT_ON_CLOSE
    end
  end
end

SwingUtilities.invoke_later proc { Buttons::ButtonDemo.new }.to_runnable

