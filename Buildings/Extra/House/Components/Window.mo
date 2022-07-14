within Buildings.Extra.House.Components;

model Window "Window model with pane and convection"

  parameter .Modelica.SIunits.Area A_window "Window area";
  parameter .Modelica.SIunits.ThermalConductance Gc_window
    "Convective thermal conductance in the window";
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a outside
    annotation (Placement(transformation(extent={{73.719165085389,29.999999999999993},{93.719165085389,49.99999999999999}},rotation = 0.0,origin = {0.0,0.0})));
  .Modelica.Blocks.Interfaces.RealInput theta annotation (Placement(
        transformation(
        extent={{-11.0,-11.0},{11.0,11.0}},
        rotation=180.0,
        origin={105.15559772296015,-14.611005692599619}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={103,-30})));
  .Modelica.Blocks.Interfaces.RealInput radiation annotation (Placement(
        transformation(
        extent={{-11.0,-11.0},{11.0,11.0}},
        rotation=180.0,
        origin={105.15559772296011,-50.853889943074}), iconTransformation(
        extent={{-11,-11},{11,11}},
        rotation=180,
        origin={103,-60})));
  .Modelica.Blocks.Sources.RealExpression con(y=Gc_window) annotation (
      Placement(transformation(
        extent={{-9.289655858155655,-9.289655858155644},{9.289655858155655,9.289655858155644}},
        rotation=180.0,
        origin={12.836812144212502,61.92220113851991})));
  Pane pane(
    a0=0.722,
    a1=0,
    a2=0,
    A=A_window) annotation (Placement(transformation(
        extent={{-10.0,-10.0},{10.0,10.0}},
        rotation=180.0,
        origin={29.165085388994314,-33.776091081593925})));
  .Modelica.Thermal.HeatTransfer.Components.Convection winConv
    annotation (Placement(transformation(
        extent={{9,-9},{-9,9}},
        rotation=0,
        origin={31,40})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b inside
    annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
equation
  connect(outside, winConv.solid) annotation (Line(
      points={{83.719165085389,39.99999999999999},{83.719165085389,40},{40,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(winConv.solid, pane.port_a) annotation (Line(
      points={{40,40},{44,40},{44,-33.776091081593925},{39.56508538899431,-33.776091081593925}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pane.port_b, winConv.fluid) annotation (Line(
      points={{19.165085388994314,-33.776091081593925},{16,-33.776091081593925},{16,40},{22,40}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(pane.port_b, inside) annotation (Line(
      points={{19.165085388994314,-33.776091081593925},{16,-33.776091081593925},{16,0},{-100,0}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(con.y, winConv.Gc) annotation (Line(
      points={{2.618190700241282,61.92220113851991},{31,61.92220113851991},{31,49}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pane.theta, theta) annotation (Line(
      points={{40.165085388994314,-29.776091081593925},{74.08728652751425,-29.776091081593925},{74.08728652751425,-14.61100569259962},{105.15559772296015,-14.61100569259962}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(pane.G, radiation) annotation (Line(
      points={{40.165085388994314,-37.776091081593925},{74,-37.776091081593925},{74,-50.853889943074},{105.15559772296011,-50.853889943074}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Line(points={{0,101},{0,-100}},color={255,255,255},thickness=1),Line(points={{-99,0},{100,0}},color={255,255,255},thickness=1),Rectangle(origin={-42,-48},extent={{-47.39256069310518,44.98458453531761},{48,-45}},fillPattern=FillPattern.Solid,fillColor={224,242,253}),Rectangle(origin={54,-48},extent={{-47.39256069310518,44.98458453531761},{48,-45}},fillPattern=FillPattern.Solid,fillColor={224,242,253}),Rectangle(origin={54,42},extent={{-47.39256069310518,44.98458453531761},{48,-45}},fillPattern=FillPattern.Solid,fillColor={224,242,253}),Rectangle(origin={-42,42},extent={{-47.39256069310518,44.98458453531761},{48,-45}},fillPattern=FillPattern.Solid,fillColor={224,242,253})}));
end Window;
