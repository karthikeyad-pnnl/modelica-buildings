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
        transformation(extent={{-140,-40},{-100,0}}),   iconTransformation(
          extent={{-140,-60},{-100,-20}})));

  CDL.Interfaces.RealInput uMea "Measured signal" annotation (Placement(
        transformation(extent={{-140,0},{-100,40}}),  iconTransformation(extent=
           {{-140,20},{-100,60}})));

  CDL.Interfaces.BooleanOutput yPro "Equipment proven on signal" annotation (
      Placement(transformation(extent={{100,0},{140,40}}),  iconTransformation(
          extent={{100,20},{140,60}})));

  CDL.Interfaces.BooleanOutput yAla "Alarm signal" annotation (Placement(
        transformation(extent={{100,-40},{140,0}}),   iconTransformation(extent=
           {{100,-60},{140,-20}})));

  CDL.Continuous.Hysteresis hysMea(uLow=meaDis, uHigh=meaEna)
    "Hysteresis block to determine component is enabled/disabled from measurement"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));

  CDL.Continuous.MultiplyByParameter gaiNor(k=1/mea_nominal)
    "Normalize measured signal by dividng it by it's nominal value"
    annotation (Placement(transformation(extent={{-90,10},{-70,30}})));

  CDL.Logical.Timer timEna(t=tau)
    "Time for which component is measured as enabled"
    annotation (Placement(transformation(extent={{-30,10},{-10,30}})));

  CDL.Logical.Timer timDis(t=tAla)
    "Time for which component is measured as disabled"
    annotation (Placement(transformation(extent={{60,-30},{80,-10}})));
  CDL.Logical.Latch latNoEna
    "Latch that outputs true when component receives enable signal but is not yet proven on"
    annotation (Placement(transformation(extent={{20,-30},{40,-10}})));
equation
  connect(gaiNor.y, hysMea.u)
    annotation (Line(points={{-68,20},{-62,20}}, color={0,0,127}));
  connect(uMea, gaiNor.u)
    annotation (Line(points={{-120,20},{-92,20}}, color={0,0,127}));
  connect(hysMea.y, timEna.u)
    annotation (Line(points={{-38,20},{-32,20}}, color={255,0,255}));
  connect(timEna.passed, yPro) annotation (Line(points={{-8,12},{0,12},{0,20},{120,
          20}},     color={255,0,255}));
  connect(timDis.passed, yAla) annotation (Line(points={{82,-28},{90,-28},{90,-20},
          {120,-20}}, color={255,0,255}));
  connect(latNoEna.y, timDis.u)
    annotation (Line(points={{42,-20},{58,-20}}, color={255,0,255}));
  connect(timEna.passed, latNoEna.clr) annotation (Line(points={{-8,12},{0,12},{
          0,-26},{18,-26}}, color={255,0,255}));
  connect(uDes, latNoEna.u)
    annotation (Line(points={{-120,-20},{18,-20}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}),                                         graphics={
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
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-40},{100,40}})));
end Proof;
