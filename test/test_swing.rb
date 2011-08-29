# Copyright (c) 2006 Zed A. Shaw 
# You can redistribute it and/or modify it under the same terms as Ruby.

require 'test/unit'
require 'profligacy/swing'

class SwingLayoutTest < Test::Unit::TestCase
  include Profligacy
  include_package 'javax.swing'
  include_package 'java.awt'

  def setup
  end

  def test_simple_frame
    ui = Swing::Build.new JPanel, :first, :second, :lab do |c,i|
      c.lab = JLabel.new "Press A Button."
      c.first = JButton.new "First"
      c.second = JButton.new "Second"

      i.first = { :action => proc {|t,e| c.lab.text = "First pressed." } }
      i.second = { :action => proc {|t,e| c.lab.text = "Second pressed." } }
    end
    assert ui, "Didn't build the frame"

    ui.layout = FlowLayout.new
    frame = ui.build
  end

  def test_with_yield_prebuild
    ui = Swing::Build.new JPanel, :start, :stop, :lab do |c,i|
      c.start = JButton.new "Start"
      c.stop = JButton.new "Stop"
      c.lab = JLabel.new "Press Start to begin timing."

      i.start = { :action => method(:dummy_callback), :change => method(:dummy_callback) }
      i.stop = { :action => method(:dummy_callback) }
    end

    ui.layout = FlowLayout.new
    ui.build do |panel|
      assert panel
    end

    check_children(ui)
  end

  protected
  def check_children(ui)
    assert ui.layout
    assert ui.container
    assert ui.children
    assert ui.contents
    assert ui.interactions

    ui.children.each do |child|
      assert_equal ui.send(child), ui.contents[child]
    end
  end

  def dummy_callback(type,event)
    @callback = true
  end
end

