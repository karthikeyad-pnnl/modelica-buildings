within Buildings.Controls.OBC.RooftopUnits.DXCoil.Subsequences;
block DXCoilStage
  "Sequence for staging up and down DX coils"
  extends Modelica.Blocks.Icons.Block;

  parameter Integer nCoi(min=1)=2
  "Number of DX coils";

  parameter Real uThrCoi(
    final min=0,
    final max=1)=0.8
    "Threshold of coil valve position signal above which DX coil is staged up";

  parameter Real uThrCoi1(
    final min=0,
    final max=1)=0.2
    "Threshold of coil valve position signal below which DX coil staged down";

  parameter Real dUHys=0.01
    "Coil valve position comparison hysteresis difference"
    annotation(Dialog(tab="Advanced"));

  parameter Real timPer(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 480
    "Delay time period for staging up DX coil";

  parameter Real timPer1(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 180
    "Delay time period for staging down DX coil";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uDXCoi[nCoi]
    "DX coil status"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
      iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uCoi(
    final min=0,
    final max=1,
    final unit="1") "Coil valve position" annotation (Placement(transformation(
          extent={{-140,-70},{-100,-30}}), iconTransformation(extent={{-140,-80},
            {-100,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yUp
    "Next DX coil status"
    annotation (Placement(transformation(extent={{100,20},{140,60}}),
      iconTransformation(extent={{100,40},{140,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yDow
    "Last DX coil status"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}}),
      iconTransformation(extent={{100,-80},{140,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterThreshold greThrCoi(
    final t=uThrCoi,
    final h=dUHys)
    "Check if coil valve position signal is equal to or greater than threshold"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim(
    final t=timPer)
    "Count time"
    annotation (Placement(transformation(extent={{30,-10},{50,10}})));

  Buildings.Controls.OBC.CDL.Logical.And and1
    "Logical And"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

  Buildings.Controls.OBC.CDL.Logical.Change cha[nCoi]
    "Detect changes in DX coil status"
    annotation (Placement(transformation(extent={{-60,40},{-40,60}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nin=nCoi)
    "Logical Multi Or"
    annotation (Placement(transformation(extent={{-10,40},{10,60}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1
    "Logical Not"
    annotation (Placement(transformation(extent={{30,40},{50,60}})));

  Buildings.Controls.OBC.CDL.Continuous.LessThreshold lesThr(
    final t=uThrCoi1,
    final h=dUHys)
    "Check if coil valve positionsignal is less than threshold"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim1(
    final t=timPer1)
    "Count time"
    annotation (Placement(transformation(extent={{30,-60},{50,-40}})));

  Buildings.Controls.OBC.CDL.Logical.And and2
    "Logical And"
    annotation (Placement(transformation(extent={{-10,-60},{10,-40}})));

equation
  connect(uCoi, greThrCoi.u) annotation (Line(points={{-120,-50},{-80,-50},{-80,
          0},{-62,0}}, color={0,0,127}));
  connect(mulOr.y, not1.u)
    annotation (Line(points={{12,50},{28,50}},     color={255,0,255}));
  connect(uDXCoi, cha.u)
    annotation (Line(points={{-120,50},{-62,50}}, color={255,0,255}));
  connect(and1.y, tim.u)
    annotation (Line(points={{12,0},{28,0}}, color={255,0,255}));
  connect(uCoi, lesThr.u)
    annotation (Line(points={{-120,-50},{-62,-50}}, color={0,0,127}));
  connect(and2.y,tim1. u)
    annotation (Line(points={{12,-50},{28,-50}}, color={255,0,255}));
  connect(lesThr.y,and2. u2) annotation (Line(points={{-38,-50},{-30,-50},{-30,-58},
          {-12,-58}},
                    color={255,0,255}));
  connect(greThrCoi.y, and1.u2) annotation (Line(points={{-38,0},{-30,0},{-30,-8},
          {-12,-8}}, color={255,0,255}));
  connect(not1.y, and1.u1) annotation (Line(points={{52,50},{60,50},{60,28},{-20,
          28},{-20,0},{-12,0}}, color={255,0,255}));
  connect(not1.y, and2.u1) annotation (Line(points={{52,50},{60,50},{60,28},{-20,
          28},{-20,-50},{-12,-50}}, color={255,0,255}));
  connect(tim1.passed, yDow) annotation (Line(points={{52,-58},{80,-58},{80,-40},
          {120,-40}}, color={255,0,255}));
  connect(cha.y, mulOr.u)
    annotation (Line(points={{-38,50},{-12,50}}, color={255,0,255}));
  connect(tim.passed, yUp) annotation (Line(points={{52,-8},{80,-8},{80,40},{120,
          40}}, color={255,0,255}));

  annotation (
    defaultComponentName="DXCoiSta",
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
            extent={{-96,66},{-50,52}},
            textColor={255,0,255},
            textString="uDXCoi"),
          Text(
            extent={{-100,-54},{-64,-68}},
            textColor={0,0,127},
            pattern=LinePattern.Dash,
            textString="uCoi"),
          Text(
            extent={{62,66},{104,52}},
            textColor={255,0,255},
            textString="yUP"),
          Text(
            extent={{58,-54},{100,-68}},
            textColor={255,0,255},
            textString="yDow")}),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
  Documentation(info="<html>
  <p>
  This is a control module for staging DX coil operation signal. 
  The control module is operated as follows: 
  </p>
  <ul>
  <li>
  Stage up <code>yUp = true</code> when coil valve position <code>uCoi</code> exceeds 
  its threshold <code>uThrCoi</code> for the duration of <code>timPer</code>, and no changes 
  in DX coil status <code>uDXCoi</code> are detected. 
  </li>
  <li>
  Stage down <code>yDow = false</code> when <code>uCoi</code> falls below <code>uThrCoi1</code>
  for <code>timPer1</code>, and no changes in <code>uDXCoi</code> are detected. 
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
end DXCoilStage;