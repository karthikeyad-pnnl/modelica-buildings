within Buildings.Controls.OBC.RooftopUnits.DXCoil.Subsequences;
block CompressorSpeedStage
  "Sequence for regulating compressor speed corresponding to previously enabled DX coil signal"
  extends Modelica.Blocks.Icons.Block;

  parameter Real coiSpeLow(
    final min=0,
    final max=1)=0.2
    "Coil signal corresponding to lower compressor speed limit";

  parameter Real coiSpeHig(
    final min=0,
    final max=1)=0.8
    "Constant higher coil valve position signal";

  parameter Real minComSpe(
    final min=0,
    final max=maxComSpe) = 0.1
    "Minimum compressor speed"
    annotation (Dialog(group="Compressor parameters"));

  parameter Real maxComSpe(
    final min=minComSpe,
    final max=1) = 1
    "Maximum compressor speed"
    annotation (Dialog(group="Compressor parameters"));

  parameter Real dTHys(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")=0.05
    "Temperature comparison hysteresis difference"
    annotation(Dialog(tab="Advanced"));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPreDXCoi
    "Previously enabled DX coil signal"
    annotation (Placement(transformation(extent={{-160,20},{-120,60}}),
      iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uDXCoi
    "DX coil status"
    annotation (Placement(transformation(extent={{-160,60},{-120,100}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCoi(
    final min=0,
    final max=1,
    final unit="1")
    "Coil valve position"
    annotation (Placement(transformation(extent={{-160,-80},{-120,-40}}),
      iconTransformation(extent={{-140,-78},{-100,-38}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yComSpe(
    final min=0,
    final max=1,
    final unit="1")
    "Compressor commanded speed"
    annotation (Placement(transformation(extent={{120,-20},{160,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

protected
  parameter Real k = (maxComSpe - minComSpe) / (coiSpeHig- coiSpeLow)
    "Gain of DX coil controller"
    annotation (Dialog(group="P controller"));

  parameter Modelica.Blocks.Types.SimpleController controllerType=Modelica.Blocks.Types.SimpleController.P
    "Type of DX coil controller"
    annotation (Dialog(group="P controller"));

  Buildings.Controls.Continuous.LimPID conP(
    final controllerType=controllerType,
    final k=k,
    final yMax=1,
    final yMin=0,
    final reverseActing=false)
    "Regulate compressor speed"
    annotation (Placement(transformation(extent={{-70,-40},{-50,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add
    "Calculate the sum of the two speeds"
    annotation (Placement(transformation(extent={{-30,-46},{-10,-26}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant conMinSpe(
    final k=minComSpe)
    "Minimum compressor speed"
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));

  Buildings.Controls.OBC.CDL.Continuous.Switch swi
    "Switch between the speed calculated by the P controller and the maximum speed"
    annotation (Placement(transformation(extent={{50,-20},{70,0}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant conDXCoi(
    final k=coiSpeLow)
    "Constant DX coil signal with lower value"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant conMaxSpe(
    final k=maxComSpe)
    "Maximum compressor speed"
    annotation (Placement(transformation(extent={{-30,50},{-10,70}})));

  Buildings.Controls.OBC.CDL.Continuous.Min min
    "Pass through the minimum compressor speed"
    annotation (Placement(transformation(extent={{10,-40},{30,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Switch swi1
    "Switch between the speed calculated by the P controller and the maximum speed"
    annotation (Placement(transformation(extent={{70,70},{90,90}})));

  Buildings.Fluid.BaseClasses.ActuatorFilter filter(
    final f=0.08)
    "Second order filter to approximate actuator opening time, and to improve numerics"
    annotation (Placement(transformation(extent={{82,21},{100,40}})));

equation
  connect(conP.u_m, uCoi) annotation (Line(points={{-60,-42},{-60,-60},{-140,-60}},
          color={0,0,127}));
  connect(conDXCoi.y, conP.u_s)
    annotation (Line(points={{-78,-30},{-72,-30}}, color={0,0,127}));
  connect(uPreDXCoi, swi.u2) annotation (Line(points={{-140,40},{30,40},{30,-10},
          {48,-10}},  color={255,0,255}));
  connect(conP.y, add.u2) annotation (Line(points={{-49,-30},{-40,-30},{-40,-42},
          {-32,-42}}, color={0,0,127}));
  connect(conMinSpe.y, add.u1) annotation (Line(points={{-48,10},{-40,10},{-40,-30},
          {-32,-30}}, color={0,0,127}));
  connect(conMaxSpe.y, swi.u1)
    annotation (Line(points={{-8,60},{40,60},{40,-2},{48,-2}}, color={0,0,127}));
  connect(min.y, swi.u3) annotation (Line(points={{32,-30},{40,-30},{40,-18},{48,-18}},
          color={0,0,127}));
  connect(add.y, min.u2) annotation (Line(points={{-8,-36},{8,-36}}, color={0,0,127}));
  connect(conMaxSpe.y, min.u1) annotation (Line(points={{-8,60},{0,60},{0,-24},{8,-24}},
          color={0,0,127}));
  connect(swi.y, swi1.u1) annotation (Line(points={{72,-10},{80,-10},{80,20},{60,
          20},{60,88},{68,88}}, color={0,0,127}));
  connect(uDXCoi, swi1.u2)
    annotation (Line(points={{-140,80},{68,80}}, color={255,0,255}));
  connect(conMinSpe.y, swi1.u3) annotation (Line(points={{-48,10},{50,10},{50,72},
          {68,72}}, color={0,0,127}));
  connect(swi1.y, filter.u) annotation (Line(points={{92,80},{100,80},{100,60},{
          70,60},{70,30.5},{80.2,30.5}}, color={0,0,127}));
  connect(filter.y, yComSpe) annotation (Line(points={{100.9,30.5},{114,30.5},{114,0},{140,0}},
          color={0,0,127}));

  annotation (
    defaultComponentName="ComSpeSta",
    Icon(coordinateSystem(preserveAspectRatio=false,
      extent={{-100,-100},{100,100}}),
        graphics={
          Rectangle(
            extent={{-100,-100},{100,100}},
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Text(
            extent={{-100,100},{100,100}},
            textColor={0,0,255}),
          Text(
            extent={{-94,68},{-44,52}},
            textColor={255,0,255},
            textString="uPreDXCoi"),
          Text(
            extent={{-100,-50},{-60,-66}},
            textColor={0,0,127},
            pattern=LinePattern.Dash,
            textString="uCoi"),
          Text(
            extent={{40,8},{90,-8}},
            textColor={0,0,127},
            pattern=LinePattern.Dash,
            textString="yComSpe"),
          Text(
            extent={{-94,6},{-54,-6}},
            textColor={255,0,255},
          textString="uDXCoi")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
  Documentation(info="<html>
  <p>
  This is a control module for regulating compressor speed, utilizing a previously enabled DX coil signal 
  and current DX coil signal. The control module is operated as follows: 
  </p>
  <ul>
  <li>
  Run compressor speed <code>yComSpe</code> at its maximum level when the previously enabled DX coil signal
  is true <code>uPreDXCoi = true</code>.
  </li>
  <li>
  Implement a linear mapping to modulate <code>yComSpe</code>, aligning its minimum and maximum speed 
  with a lower coil valve position signal <code>coiSpeLow</code> and a higher one 
  <code>coiSpeHig</code> from the coil valve position signal <code>uCoi</code> when <code>uPreDXCoi = false</code>.
  </li>
  <li>
  Output <code>yComSpe</code> after applying a second-order filter to approximate actuator opening time and enhance 
  numerical stability when the current DX coil signal is true <code>uDXCoi = true</code>. 
  Otherwise, the output will be the minimum compressor speed <code>conMinSpe</code>.
  </li>
  </ul>
  </html>", revisions="<html>
  <ul>
  <li>
  August 4, 2023, by Junke Wang and Karthik Devaprasad:<br/>
  First implementation.
  </li>
  </ul>
  </html>"));
end CompressorSpeedStage;
