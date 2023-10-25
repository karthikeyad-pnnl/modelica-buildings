within Buildings.Fluid.Storage.Ice.Validation;
model Tank_v2 "Example that test the tank model"
  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Antifreeze.PropyleneGlycolWater (
    property_T=293.15,
    X_a=0.30) "Fluid medium";

  parameter Boolean has_sepLoopTank = false;

  parameter Modelica.Units.SI.Mass SOC_start=0
    "Start value of ice mass in the tank";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=67.38
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=100000
    "Pressure difference";
  parameter Buildings.Fluid.Storage.Ice.Data.Tank.Generic per(
    mIce_max=4400*1000*3600/per.Hf,
    coeCha={1.76953858E-04,0,0,0,0,0},
    dtCha=10,
    coeDisCha={5.54E-05,-1.45679E-04,9.28E-05,1.126122E-03,-1.1012E-03,3.00544E-04},
    dtDisCha=10)
    "Tank performance data"
    annotation (Placement(transformation(extent={{60,60},{80,80}})));

  ControlledTank_uQReq iceTan(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    SOC_start=SOC_start,
    per=per,
    energyDynamicsHex=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Buildings.Fluid.Sources.MassFlowSource_T sou(
    redeclare package Medium = Medium,
    m_flow=3*m_flow_nominal,
    use_T_in=true,
    nPorts=3)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Buildings.Fluid.Sources.Boundary_pT bou(
    redeclare package Medium = Medium,
    nPorts=3)
    annotation (Placement(transformation(extent={{86,-10},{66,10}})));

  Buildings.Fluid.FixedResistances.PressureDrop res(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=500) "Flow resistance"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));

  Modelica.Blocks.Sources.CombiTimeTable TSou(
    table=[
      0,       273.15 - 5;
      3600*10, 273.15 - 5;
      3600*10, 273.15 + 10;
      3600*11, 273.15 + 10;
      3600*18, 273.15 + 10;
      3600*18, 273.15 - 5],
      y(each unit="K",
        each displayUnit="degC"))
      "Source temperature"
    annotation (Placement(transformation(extent={{-92,-6},{-72,14}})));

  Modelica.Blocks.Sources.TimeTable TSet(table=[
    0,273.15 -10;
    3600*10,273.15 + 8;
    3600*11,273.15 + 6;
    3600*20,273.15 -12;
    3600*24,273.15 +10], y(unit="K", displayUnit="degC"))
    "Table with set points for leaving water temperature which will be tracked subject to thermodynamic constraints"
    annotation (Placement(transformation(extent={{-92,30},{-72,50}})));

  Controls.OBC.CDL.Continuous.Sources.Sin sin(amplitude=550000, freqHz=1/(20*3600))
    annotation (Placement(transformation(extent={{-90,70},{-70,90}})));

  ControlledTank_uQReq_separateLoops controlledTank_uQReq_separateLoops(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=dp_nominal,
    SOC_start=SOC_start,
    per=per) if has_sepLoopTank
    annotation (Placement(transformation(extent={{-10,-42},{10,-14}})));

  FixedResistances.PressureDrop                 res1(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=500) if has_sepLoopTank
                    "Flow resistance"
    annotation (Placement(transformation(extent={{30,-30},{50,-10}})));

  FixedResistances.PressureDrop                 res2(
    redeclare package Medium = Medium,
    m_flow_nominal=m_flow_nominal,
    dp_nominal=500) if has_sepLoopTank
                    "Flow resistance"
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
equation
  connect(res.port_b, bou.ports[1])
    annotation (Line(points={{50,0},{58,0},{58,2.66667},{66,2.66667}},
                                             color={0,127,255}));
  connect(TSou.y[1], sou.T_in) annotation (Line(points={{-71,4},{-62,4}},
                    color={0,0,127}));
  connect(iceTan.port_b, res.port_a)
    annotation (Line(points={{10,0},{30,0}}, color={0,127,255}));
  connect(iceTan.port_a, sou.ports[1]) annotation (Line(points={{-10,0},{-26,0},
          {-26,2.66667},{-40,2.66667}},
                            color={0,127,255}));
  connect(sin.y, iceTan.uQReq) annotation (Line(points={{-68,80},{-30,80},{-30,6},
          {-12,6}}, color={0,0,127}));
  connect(sin.y, controlledTank_uQReq_separateLoops.uQReq) annotation (Line(
        points={{-68,80},{-30,80},{-30,-18},{-12,-18}}, color={0,0,127}));
  connect(sou.ports[2], controlledTank_uQReq_separateLoops.port_a) annotation (
      Line(points={{-40,-2.22045e-16},{-26,-2.22045e-16},{-26,-24},{-10,-24}},
        color={0,127,255}));
  connect(sou.ports[3], controlledTank_uQReq_separateLoops.port_aDis)
    annotation (Line(points={{-40,-2.66667},{-34,-2.66667},{-34,-35},{-10,-35}},
                           color={0,127,255}));
  connect(controlledTank_uQReq_separateLoops.port_b, res1.port_a) annotation (
      Line(points={{10,-24},{20,-24},{20,-20},{30,-20}}, color={0,127,255}));
  connect(controlledTank_uQReq_separateLoops.port_bDis, res2.port_a)
    annotation (Line(points={{10,-35},{20,-35},{20,-40},{30,-40}}, color={0,127,
          255}));
  connect(res1.port_b, bou.ports[2]) annotation (Line(points={{50,-20},{58,-20},
          {58,-2.22045e-16},{66,-2.22045e-16}}, color={0,127,255}));
  connect(res2.port_b, bou.ports[3]) annotation (Line(points={{50,-40},{58,-40},
          {58,-2.66667},{66,-2.66667}}, color={0,127,255}));
  annotation (
    experiment(
      StartTime=0,
      StopTime=86400,
      Tolerance=1e-06),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/Storage/Ice/Validation/Tank.mos"
        "Simulate and Plot"),
    Documentation(info="<html>
<p>
This example is to verify the ice tank model <a href=\"modelica://Buildings.Fluid.Storage.Ice\">Buildings.Fluid.Storage.Ice</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
December 14, 2021, by Yangyang Fu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Tank_v2;
