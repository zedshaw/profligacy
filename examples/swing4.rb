require 'profligacy/swing'

class AlignLabelDemo
  include_package 'javax.swing'
  include_package 'java.awt'
  include_package 'javax.swing.border'
  include SwingConstants
  include Profligacy

  def initialize
    border = BorderFactory.createEtchedBorder

    @ui = Swing::Build.new JFrame, :labels do |c,i|
      c.labels = [ 
        [:LEFT, :TOP], [:CENTER, :TOP], [:RIGHT, :TOP],
        [:LEFT, :CENTER], [:CENTER, :CENTER], [:RIGHT, :CENTER],
        [:LEFT, :BOTTOM], [:CENTER, :BOTTOM], [:RIGHT, :BOTTOM]
      ].collect do |horiz,vert| 
        lab = JLabel.new "#{horiz},#{vert}", AlignLabelDemo.const_get(horiz) 
        lab.border = border
        lab.vertical_alignment = AlignLabelDemo.const_get(vert)
        lab 
      end
    end

    @ui.layout = GridLayout.new(3,3,4,4)
    frame = @ui.build("Label Play")
    frame.content_pane.border = BorderFactory.createEmptyBorder 4,4,4,4
    frame.default_close_operation = JFrame::EXIT_ON_CLOSE
  end
end


SwingUtilities.invoke_later proc { AlignLabelDemo.new }.to_runnable
