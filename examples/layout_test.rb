require 'profligacy/lel'

module Test
  include_package 'javax.swing'
  include Profligacy

  layout = "
     [ label_1         | label3      ]
     [ (300,300)*text1 | (150)people ]
     [ <label2         | _           ]
     [ message         | buttons     ]
  "

  ui = Swing::LEL.new(JFrame,layout) do |c,i|
    c.label_1 = JLabel.new "The chat:"
    c.label2  = JLabel.new "What you're saying:"
    c.label3  = JLabel.new "The people:"
    c.text1   = JTextArea.new
    c.people  = JComboBox.new
    c.message = JTextArea.new 

    c.buttons = Swing::LEL.new(JPanel, "[send|hate|quit]") do |c,i|
      c.send    = JButton.new "Send"
      c.hate    = JButton.new "Hate"
      c.quit    = JButton.new "Quit"
    end.build :auto_create_container_gaps => false
  end

  ui.build(:args => "Simple LEL Example")
end
