within Buildings.Controls.OBC.Utilities;
block Proof "Composite block for equipment proven on"

  parameter Real meaDis
    "Percent limit for measured signal below which component is assumed to be disabled";

  parameter Real meaEna
    "Percent limit for measured signal above which component is assumed to be enabled";

  parameter Real mea_nominal
    "Nominal value for measured signal from component, which is used to normalize the signal";

  parameter Real tau
    "Time constant for the device";

  parameter Real tAla
    "Time limit beyond which alarm is triggered if the device is not proven on";

  CDL.Interfaces.BooleanInput uDes "Desired state" annotation (Placement(
        transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
          extent={{-140,-60},{-100,-20}})));

  CDL.Interfaces.RealInput uMea "Measured signal" annotation (Placement(
        transformation(extent={{-140,20},{-100,60}}), iconTransformation(extent
          ={{-140,20},{-100,60}})));

  CDL.Interfaces.BooleanOutput yPro "Equipment proven on signal" annotation (
      Placement(transformation(extent={{100,20},{140,60}}), iconTransformation(
          extent={{100,20},{140,60}})));

  CDL.Interfaces.BooleanOutput yAla "Alarm signal" annotation (Placement(
        transformation(extent={{100,-60},{140,-20}}), iconTransformation(extent
          ={{100,-60},{140,-20}})));

  CDL.Continuous.Hysteresis hysMea(uLow=meaDis, uHigh=meaEna)
    "Hysteresis block to determine component is enabled/disabled from measurement"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));

  CDL.Continuous.MultiplyByParameter gaiNor(k=1/mea_nominal)
    "Normalize measured signal by dividng it by it's nominal value"
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));

  CDL.Logical.Timer timEna(t=tau)
    "Time for which component is measured as enabled"
    annotation (Placement(transformation(extent={{-30,30},{-10,50}})));

  CDL.Logical.Not notEna
    "Not operator to get disabled status from enabled status"
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  CDL.Logical.And andDisReqEna
    "Output true signal if component that is required enabled is still in disabled mode"
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  CDL.Logical.Timer timDis(t=tAla)
    "Time for which component is measured as disabled"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
equation
  connect(gaiNor.y, hysMea.u)
    annotation (Line(points={{-68,40},{-62,40}}, color={0,0,127}));
  connect(uMea, gaiNor.u)
    annotation (Line(points={{-120,40},{-92,40}}, color={0,0,127}));
  connect(hysMea.y, timEna.u)
    annotation (Line(points={{-38,40},{-32,40}}, color={255,0,255}));
  connect(timEna.passed, yPro) annotation (Line(points={{-8,32},{0,32},{0,40},{
          120,40}}, color={255,0,255}));
  connect(timEna.passed, notEna.u)
    annotation (Line(points={{-8,32},{0,32},{0,0},{8,0}}, color={255,0,255}));
  connect(andDisReqEna.y, yAla)
    annotation (Line(points={{92,-40},{120,-40}}, color={255,0,255}));
  connect(notEna.y, timDis.u)
    annotation (Line(points={{32,0},{38,0}}, color={255,0,255}));
  connect(timDis.passed, andDisReqEna.u1) annotation (Line(points={{62,-8},{64,
          -8},{64,-40},{68,-40}}, color={255,0,255}));
  connect(uDes, andDisReqEna.u2) annotation (Line(points={{-120,-40},{40,-40},{
          40,-48},{68,-48}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-100,40},{100,-40}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Proof")}),                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Proof;
