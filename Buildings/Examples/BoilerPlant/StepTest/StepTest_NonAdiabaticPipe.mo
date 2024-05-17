within Buildings.Examples.BoilerPlant.StepTest;
block StepTest_NonAdiabaticPipe "Model to test step response of zone model"
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=113.45
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Real boiDesCap = 4359751.36;

  parameter Real boiCapRat = 0.3/4.3;

  Fluid.Actuators.Valves.TwoWayLinear           val3(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal,
    final dpValve_nominal=0.1,
    init=Modelica.Blocks.Types.Init.InitialOutput,
    l=10e-10)
    "Isolation valve for radiator"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = Media.Water,
    m_flow=mRad_flow_nominal,
    T=313.15,
    nPorts=2)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dp_nominal=20000.1)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Media.Water,
    p=1500000,
    T=293.15,
    nPorts=2) annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  Modelica.Fluid.Pipes.DynamicPipe pipe(
    redeclare package Medium = MediumW,
    nParallel=1,
    length=100,
    isCircular=true,
    diameter=0.25,
    height_ab=0.0102,
    redeclare model FlowModel =
        Modelica.Fluid.Pipes.BaseClasses.FlowModels.NominalLaminarFlow,
    nNodes=2,
    use_HeatTransfer=true,
    redeclare model HeatTransfer =
        Modelica.Fluid.Pipes.BaseClasses.HeatTransfer.ConstantFlowHeatTransfer,
    flowModel(dp_nominal=100, m_flow_nominal=mRad_flow_nominal),
    heatTransfer(alpha0=15*1/0.3))
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Pulse pul(width=0.001, period=10800)
    annotation (Placement(transformation(extent={{-60,20},{-40,40}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(final filNam=
        ModelicaServices.ExternalReferences.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"))
    "Weather data reader"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  BoundaryConditions.WeatherData.Bus           weaBus
    "Weather bus"
    annotation (Placement(transformation(extent={{-30,60},{-10,80}}),
        iconTransformation(extent={{-56,104},{-36,124}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut
    "Outside temperature"
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
equation
  connect(boundary.ports[1], val3.port_a) annotation (Line(points={{-40,-38},{
          -30,-38},{-30,0},{-10,0}},
                                 color={0,127,255}));
  connect(boundary.ports[2], res.port_a) annotation (Line(points={{-40,-42},{
          -26,-42},{-26,-40},{-10,-40}},
                                color={0,127,255}));
  connect(res.port_b, bou.ports[1]) annotation (Line(points={{10,-40},{32,-40},
          {32,-60},{72,-60},{72,-38},{60,-38}},
                                       color={0,127,255}));
  connect(val3.port_b, pipe.port_a)
    annotation (Line(points={{10,0},{40,0}},     color={0,127,255}));
  connect(pipe.port_b, bou.ports[2]) annotation (Line(points={{60,0},{72,0},{72,
          -42},{60,-42}}, color={0,127,255}));
  connect(pul.y, val3.y)
    annotation (Line(points={{-38,30},{0,30},{0,12}},     color={0,0,127}));
  connect(weaDat.weaBus,weaBus)  annotation (Line(
      points={{-40,70},{-20,70}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(weaBus.TDryBul, TOut.T) annotation (Line(
      points={{-20,70},{-2,70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(TOut.port, pipe.heatPorts[1]) annotation (Line(points={{20,70},{48.55,
          70},{48.55,4.4}},           color={191,0,0}));
  connect(TOut.port, pipe.heatPorts[2]) annotation (Line(points={{20,70},{51.65,
          70},{51.65,4.4}},         color={191,0,0}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{120,
            100}})),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})),
    experiment(
      StopTime=10800,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end StepTest_NonAdiabaticPipe;
