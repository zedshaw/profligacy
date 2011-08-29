# Prototype for a GUI for a chat client.  Just tries out different
# layouts and ideas.

require 'rubygems'
require 'profligacy/swing'
require 'profligacy/lel'


class ChatInterface
  include_package 'javax.swing'
  include_package 'java.awt'
  include Profligacy

  def initialize
    @styles = { 
      :left => "[*people|(400,300)*chat][buttons|message]",
      :right => "[(400,300)*chat|*people][message|buttons]",
      :hidden => "[(400,300)*chat][message]"
    }

    @ui = Swing::Build.new JFrame, :tabs do |c,i|
      c.tabs = JTabbedPane.new

      [:right, :left, :hidden].each do |s|
        c.tabs.add("Tab #{s}", create_chat(s))
      end
    end

    @frame = @ui.build("Utu Chat Prototype") do |f|
      f.jmenu_bar = create_menubar
      f.add(create_toolbar, BorderLayout::NORTH)
    end
  end

  def create_chat(style=:right)
    chat = Swing::LEL.new(JPanel,@styles[style]) do |c,i|
      people = JList.new((["Zed","Frank","Joe","Alex"]*20).to_java)
      c.people = JScrollPane.new(people) if style != :hidden
      c.message = JTextField.new 

      chat = JTextArea.new
      chat.editable = false
      chat.text = "Mary had a little lamb that you should seriously check out 'cause it's sick\n" * 300

      c.chat  = JScrollPane.new(chat)
      c.buttons = create_buttons if style != :hidden
    end

    chat.build
  end

  def create_buttons
    buttons = Swing::LEL.new(JPanel, "[info|hate|block]") do |c,i|
      c.info    = JButton.new "Info"
      c.hate    = JButton.new "Hate"
      c.block   = JButton.new "Block"
    end

    buttons.build(:auto_create_container_gaps => false)
  end

  def create_menubar
    file = Swing::Build.new JMenu, :connect, :rooms, :people, :quit do |c,i|
      c.connect = JMenuItem.new "Connect..."
      c.rooms = JMenuItem.new "Rooms..."
      c.people = JMenuItem.new "People..."
      c.quit = JMenuItem.new "Quit"
    end.build("File")

    room = Swing::Build.new JMenu, :who, :search, :join, :sep1, :leave do |c,i|
      c.who = JMenuItem.new "Who..."
      c.search = JMenuItem.new "Search..."
      c.join = JMenuItem.new "Join..."
      c.sep1 = JSeparator.new
      c.leave = JMenuItem.new "Leave"
    end.build("Room")

    help = Swing::Build.new JMenu, :about, :manual, :site do |c,i|
      c.about = JMenuItem.new "About..."
      c.manual = JMenuItem.new "Manual..."
      c.site = JMenuItem.new "Site"
    end.build("Help")

    @menu_bar = Swing::Build.new JMenuBar, :menus do |c,i|
      c.menus = [file, room, help]
    end

    @menu_bar.build
  end

  def create_toolbar
    @toolbar = Swing::Build.new(
      JToolBar,
      :join, :leave, :hide_show, :who, :info, :sep, :block, :hate
    ) do |c,i|
      c.join = JButton.new "Join"
      c.hide_show = JToggleButton.new "Hide"
      c.who = JButton.new "Who"
      c.info = JButton.new "Info"
      c.block = JButton.new "Block"
      c.hate = JButton.new "Hate"
      c.leave = JButton.new "Leave"
      c.sep = JSeparator.new
    end

    @toolbar.build
  end
end


SwingUtilities.invoke_later proc { ChatInterface.new }.to_runnable
