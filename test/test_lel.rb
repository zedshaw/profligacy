# Copyright (c) 2006 Zed A. Shaw 
# You can redistribute it and/or modify it under the same terms as Ruby.

require 'test/unit'
require 'profligacy/lel'

class LELLayoutTest < Test::Unit::TestCase
  include Profligacy
  include_class 'javax.swing.JPanel'

  def setup
    @layout = "
     [ label_1         | label3      ]
     [ (300,300)*text1 | (150)people ]
     [ <label2         | _           ]
     [ .message        | ^buttons    ]"
  end

  def test_layout_with_subcomponent
    ui = Swing::LEL.new(JPanel,@layout) do |c,i|
      c.label_1 = JPanel.new
      c.label2  = JPanel.new
      c.label3  = JPanel.new
      c.text1   = JPanel.new
      c.people  = JPanel.new
      c.message = JPanel.new

      c.buttons = Swing::LEL.new(JPanel, "[send|hate|quit]") do |c,i|
        c.send    = JPanel.new
        c.hate    = JPanel.new
        c.quit    = JPanel.new
      end.build :auto_create_container_gaps => false
    end

    ui.build(:auto_create_gaps => true, :auto_create_container_gaps => true,
      :honors_visibility => true, :pack => true, :visible => true)
  end

  def test_failed_parse
    @layout = "[screwedup>|_]"

    assert_raises RuntimeError do
      test_layout_with_subcomponent
    end
  end
end

