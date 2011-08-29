require 'java'
require 'profligacy/swing'

import 'javax.swing.JFrame'
import 'javax.swing.JLabel'

class SwingDemo
  def initialize
    jfrm = JFrame.new "A Simple Demo"
    jfrm.setSize(275,100)
    jfrm.default_close_operation = JFrame::EXIT_ON_CLOSE
    jlab = JLabel.new " Swing powers the modern Java GUI"
    jfrm.add jlab
    jfrm.pack
    jfrm.visible = true
  end
end

SwingUtilities.invoke_later proc { SwingDemo.new }.to_runnable
