﻿within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE;
block Controller "Tower fan control when waterside economizer is enabled"

  parameter Integer nChi=2 "Total number of chillers";
  parameter Real minSpe=0.1 "Minimum tower fan speed";
  parameter Real maxSpe=1 "Maximum tower fan speed";
  parameter Modelica.SIunits.HeatFlowRate minUnLTon[nChi]={1e4,1e4}
    "Minimum cyclining load below which chiller will begin cycling"
    annotation (Dialog(tab="Integrated operation"));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController intOpeCon=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="Integrated operation", group="Controller"));
  parameter Real kIntOpe=1 "Gain of controller"
    annotation (Dialog(tab="Integrated operation", group="Controller"));
  parameter Modelica.SIunits.Time TiIntOpe=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Integrated operation", group="Controller",
                       enable=intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                              intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Modelica.SIunits.Time TdIntOpe=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Integrated operation", group="Controller",
                       enable=intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                              intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Real fanSpeChe=0.005 "Lower threshold value to check fan speed"
    annotation (Dialog(tab="WSE-only"));
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController chiWatCon=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="WSE-only", group="Controller"));
  parameter Real kWSE=1 "Gain of controller"
    annotation (Dialog(tab="WSE-only", group="Controller"));
  parameter Modelica.SIunits.Time TiWSE=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="WSE-only", group="Controller",
                       enable=chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                              chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID));
  parameter Modelica.SIunits.Time TdWSE=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="WSE-only", group="Controller",
                       enable=chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                              chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput chiLoa[nChi](
    final unit=fill("W",nChi),
    final quantity=fill("Power",nChi)) "Current load of each chiller"
    annotation (Placement(transformation(extent={{-140,60},{-100,100}}),
      iconTransformation(extent={{-140,80},{-100,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi]
    "Chiller enabling status: true=ON"
    annotation (Placement(transformation(extent={{-140,20},{-100,60}}),
      iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE
    "Waterside economizer enabling status: true=ON"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}}),
      iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uTowSpe(
     final min=0,
     final max=1,
     final unit="1") "Tower fan speed"
     annotation (Placement(transformation(extent={{-140,-50},{-100,-10}}),
       iconTransformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSup(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-140,-110},{-100,-70}}),
      iconTransformation(extent={{-140,-120},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yTowSpe(
    final min=0,
    final max=1,
    final unit="1")
    "Tower fan speed when WSE is enabled and there is any chiller running"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

protected
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.IntegratedOperation
    intOpe(
    final nChi=nChi,
    final minUnLTon=minUnLTon,
    final minSpe=minSpe,
    final conTyp=intOpeCon,
    final k=kIntOpe,
    final Ti=TiIntOpe,
    final Td=TdIntOpe)
    "Tower fan speed when the waterside economizer is enabled and the chillers are running"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.WSEOperation
    wseOpe(
    final minSpe=minSpe,
    final maxSpe=maxSpe,
    final fanSpeChe=fanSpeChe,
    final chiWatCon=chiWatCon,
    final k=kWSE,
    final Ti=TiWSE,
    final Td=TdWSE)
    "Tower fan speed when the waterside economizer is running alone"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(final nu=nChi) "Logical or"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi "Logical switch"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi1 "Logical switch"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer(final k=0) "Zero constant"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));

equation
  connect(intOpe.uChi, uChi)
    annotation (Line(points={{-42,88},{-80,88},{-80,40},{-120,40}}, color={255,0,255}));
  connect(intOpe.chiLoa, chiLoa)
    annotation (Line(points={{-42,80},{-120,80}}, color={0,0,127}));
  connect(intOpe.uWSE, uWSE)
    annotation (Line(points={{-42,72},{-60,72},{-60,0},{-120,0}}, color={255,0,255}));
  connect(wseOpe.uTowSpe, uTowSpe)
    annotation (Line(points={{-42,-52},{-60,-52},{-60,-30},{-120,-30}}, color={0,0,127}));
  connect(wseOpe.TChiWatSup, TChiWatSup)
    annotation (Line(points={{-42,-60},{-120,-60}}, color={0,0,127}));
  connect(wseOpe.TChiWatSupSet, TChiWatSupSet)
    annotation (Line(points={{-42,-68},{-60,-68},{-60,-90},{-120,-90}}, color={0,0,127}));
  connect(mulOr.y, swi.u2)
    annotation (Line(points={{-18,40},{-2,40}},   color={255,0,255}));
  connect(intOpe.yTowSpe, swi.u1)
    annotation (Line(points={{-18,80},{-10,80},{-10,48},{-2,48}}, color={0,0,127}));
  connect(wseOpe.yTowSpe, swi.u3)
    annotation (Line(points={{-18,-60},{-10,-60},{-10,32},{-2,32}}, color={0,0,127}));
  connect(uWSE, swi1.u2)
    annotation (Line(points={{-120,0},{58,0}}, color={255,0,255}));
  connect(swi.y, swi1.u1)
    annotation (Line(points={{22,40},{40,40},{40,8},{58,8}}, color={0,0,127}));
  connect(zer.y, swi1.u3)
    annotation (Line(points={{22,-30},{40,-30},{40,-8},{58,-8}}, color={0,0,127}));
  connect(swi1.y, yTowSpe)
    annotation (Line(points={{82,0},{120,0}}, color={0,0,127}));
  connect(uChi, mulOr.u)
    annotation (Line(points={{-120,40},{-42,40}}, color={255,0,255}));

annotation (
  defaultComponentName="towFanSpeWse",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Polygon(
          points={{-20,80},{20,80},{0,10},{-20,80}},
          lineColor={28,108,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-40,10},{40,-10}},
          lineColor={28,108,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-10},{-20,-80},{20,-80},{0,-10}},
          lineColor={28,108,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{40,-80},{76,-94}},
          lineColor={200,200,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{76,-78},{78,-96}},
          lineColor={200,200,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{78,-78},{80,-96}},
          lineColor={200,200,200},
          fillColor={240,240,240},
          fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>
Block that output cooling tower fan speed <code>yTowSpe</code> when waterside 
economizer is enabled. This is implemented 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II – 
Central Plants and Hydronic Systems (Draft 6 on July 25, 2019), section 5.2.12.2, 
item 4. It includes two subsequences:
</p>
<ul>
<li>
When waterside economizer is enabled and chillers are running, see 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.IntegratedOperation\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.IntegratedOperation</a>
for a description.
</li>
<li>
When waterside economizer is running alone, see 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.WSEOperation\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.WSEOperation</a>
for a description.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
August 9, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
