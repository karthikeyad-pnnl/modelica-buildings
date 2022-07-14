within Buildings.Extra.House.Components;

model Radiator "Simple radiator model with thermostat"

  inner .Modelica.Fluid.System system annotation (Placement(
        transformation(extent={{-100,80},{-80,100}})));

  parameter .Modelica.SIunits.Temperature T_ref "Reference temperature";

  .Modelica.Blocks.Sources.Constant const(k=T_ref) annotation (Placement(
        transformation(
        extent={{-7,-7},{7,7}},
        rotation=0,
        origin={-67,56})));
  .Modelica.Blocks.Continuous.LimPID PI(
    yMax=1,
    Ti=10,
    yMin=0.01,
    k=0.005) annotation (Placement(transformation(
        extent={{-7,7},{7,-7}},
        rotation=270,
        origin={-41,36})));
  .Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor T_sensor
    annotation (Placement(transformation(
        extent={{-7,-8},{7,8}},
        rotation=180,
        origin={-15,36})));
  .Modelica.Fluid.Pipes.DynamicPipe radiator(
    nNodes=1,
    modelStructure=.Modelica.Fluid.Types.ModelStructure.av_b,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        .Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.IdealFlowHeatTransfer,
    diameter=0.01,
    length=10,
    redeclare package Medium = .Modelica.Media.Water.StandardWater,
    T_start=303.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  .Modelica.Fluid.Valves.ValveLinear valveLinear(
    m_flow_nominal=0.01,
    redeclare package Medium = .Modelica.Media.Water.StandardWater,
    dp_nominal=130000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-41,0})));
  .Modelica.Fluid.Interfaces.FluidPort_a inPort(redeclare package Medium =
        .Modelica.Media.Water.StandardWater) annotation (Placement(
        transformation(extent={{-110,-10},{-90,10}}),
        iconTransformation(extent={{-110,-10},{-90,10}})));
  .Modelica.Fluid.Interfaces.FluidPort_b outPort(redeclare package
      Medium = .Modelica.Media.Water.StandardWater) annotation (
      Placement(transformation(extent={{90,-10},{110,10}}),
        iconTransformation(extent={{90,-10},{110,10}})));
  .Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heatPort
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));

equation
  connect(PI.y, valveLinear.opening) annotation (Line(
      points={{-41,28.3},{-41,8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(const.y, PI.u_s) annotation (Line(
      points={{-59.3,56},{-41,56},{-41,44.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(inPort, valveLinear.port_a) annotation (Line(
      points={{-100,0},{-51,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(valveLinear.port_b, radiator.port_a) annotation (Line(
      points={{-31,0},{-10,0}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(radiator.heatPorts[1], heatPort) annotation (Line(
      points={{0.1,4.4},{0.1,57.2},{0,57.2},{0,100}},
      color={127,0,0},
      smooth=Smooth.None));
  connect(T_sensor.port, radiator.heatPorts[1]) annotation (Line(
      points={{-8,36},{0.1,36},{0.1,4.4}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(PI.u_m, T_sensor.T) annotation (Line(
      points={{-32.6,36},{-22,36}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(radiator.port_b, outPort) annotation (Line(
      points={{10,0},{100,0}},
      color={0,127,255},
      smooth=Smooth.None));
  annotation (Diagram(graphics), Icon(graphics={Rectangle(
                  extent={{-100,80},{100,-80}},
                  lineColor={175,175,175},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.Solid),Rectangle(
                  extent={{-80,80},{-74,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-60,80},{-54,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-40,80},{-34,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-20,80},{-14,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{0,80},{6,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{82,80},{88,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{60,80},{66,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{40,80},{46,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{20,80},{26,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-100,80},{-94,-80}},
                  lineColor={175,175,175},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.VerticalCylinder),Rectangle(
                  extent={{-100,86},{100,80}},
                  lineColor={175,175,175},
                  fillPattern=FillPattern.Solid,
                  fillColor={235,235,235}),Rectangle(
                  extent={{-100,-80},{100,-86}},
                  lineColor={175,175,175},
                  fillPattern=FillPattern.Solid,
                  fillColor={235,235,235}),Text(
                  extent={{-88,-82},{106,-128}},
                  lineColor={0,0,0},
                  fillColor={235,235,235},
                  fillPattern=FillPattern.Solid,
                  textString="%name")}));
end Radiator;
