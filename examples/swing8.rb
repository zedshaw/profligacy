require 'profligacy/swing'

class PhoneBookDemo
  include_package 'javax.swing'
  include_package 'java.awt'
  include_package 'javax.swing.border'
  include Profligacy

  def initialize
    children = [:lab_name, :name, :lab_number, :number, :lab_options,
      :ignore_case, :exact, :starts, :ends]

    @search_style = :exact

    @ui = Swing::Build.new(JFrame, *children) do |c,i|
      c.lab_name = JLabel.new "Name"
      c.lab_number = JLabel.new "Number"
      c.lab_options = JLabel.new "Search Options"
      c.name = JTextField.new 10
      c.number = JTextField.new 10

      c.exact = JRadioButton.new("Exact Match", true)
      c.starts = JRadioButton.new("Starts With")
      c.ends = JRadioButton.new("Ends With")

      b = ButtonGroup.new
      [c.exact, c.starts, c.ends].each {|x| b.add(x) }

      i.name   = {:action => proc {|t,e| @ui.number.text = find(@names, e.source.text) } }
      i.number = {:action => proc {|t,e| @ui.name.text = find(@numbers, e.source.text) } }
      i.exact  = {:action => proc {|t,e| @search_style = :exact } }
      i.starts = {:action => proc {|t,e| @search_style = :starts } }
      i.ends   = {:action => proc {|t,e| @search_style = :ends } }
    end

    @ui.layout = GridLayout.new 0,1
    @ui.build("Phone Book").default_close_operation = JFrame::EXIT_ON_CLOSE

    @names = { 
    "Zed A. Shaw" => "917-555-5555",
    "Frank Blank" => "212-554-5555"
    }

    @numbers = { 
     "917-555-5555" => "Zed A. Shaw",
     "212-554-5555" => "Frank Blank"
    }
  end


  protected
  def find(inside, text)
    results = case @search_style
    when :exact; inside.keys.grep /^#{text}$/
    when :starts; inside.keys.grep /^#{text}/
    when :ends; inside.keys.grep /#{text}$/
    end

    inside[results[0]] || ""
  end
end


SwingUtilities.invoke_later proc { PhoneBookDemo.new }.to_runnable
