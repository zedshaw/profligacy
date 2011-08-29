require 'profligacy/swing'
require 'prefuse'

import 'javax.swing.JFrame'

module PrefuseTest
  include_package 'prefuse'
  include_package 'prefuse.activity'
  include_package 'prefuse.data'
  include_package 'prefuse.data.io'
  include_package 'prefuse.action'
  include_package 'prefuse.action.assignment'
  include_package 'prefuse.action.layout.graph'
  include_package 'prefuse.controls'
  include_package 'prefuse.render'
  include_package 'prefuse.util'
  include_package 'prefuse.visual'


  graph = GraphMLReader.new.readGraph("socialnet.xml")
  vis = Visualization.new
  vis.add "graph", graph
  vis.setInteractive("graph.edges", nil, false)

  r = LabelRenderer.new "name"
  r.set_rounded_corner(8,8)

  vis.renderer_factory = DefaultRendererFactory.new(r)

  palette = [
   ColorLib.rgb(255,180,180),
   ColorLib.rgb(190,190,255)
  ].to_java :int

  fill = DataColorAction.new "graph.nodes", "gender", Constants::NOMINAL, VisualItem::FILLCOLOR, palette
  text = ColorAction.new "graph.nodes", VisualItem::TEXTCOLOR, ColorLib.gray(0)
  edges = ColorAction.new "graph.edges", VisualItem::STROKECOLOR, ColorLib.gray(200)

  color = ActionList.new
  color.add(fill)
  color.add(text)
  color.add(edges)

  layout = ActionList.new(Activity::INFINITY)
  layout.add(ForceDirectedLayout.new("graph"))
  layout.add(RepaintAction.new)

  vis.putAction("color", color)
  vis.putAction("layout", layout)

  d = Display.new(vis)
  d.setSize 1024,768
  d.addControlListener(DragControl.new)
  d.addControlListener(PanControl.new)
  d.addControlListener(ZoomControl.new)

  @ui = SwingHelp::Build.new(JFrame, :data) {|c,i| c.data = d }
  @ui.build("Prefuse Example").default_close_operation = JFrame::EXIT_ON_CLOSE

  vis.run("color")
  vis.run("layout")
end
