within Buildings.Controls.OBC.Utilities.Validation;
model PLRToPulse
  Buildings.Controls.OBC.Utilities.PLRToPulse pLRToPulse
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  CDL.Continuous.Sources.Ramp ram(duration=25*15*60)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  CDL.Continuous.MultiplyByParameter gai(k=5)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  CDL.Continuous.MultiplyByParameter gai1(k=1/5)
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  CDL.Conversions.IntegerToReal intToRea
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Buildings.Controls.OBC.Utilities.PLRToPulse pLRToPulse1
    annotation (Placement(transformation(extent={{70,-50},{90,-30}})));
  CDL.Continuous.Sources.Ramp ram1(height=-1, duration=25*15*60)
    annotation (Placement(transformation(extent={{-90,-90},{-70,-70}})));
  CDL.Continuous.MultiplyByParameter gai2(k=5)
    annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
  CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{-30,-50},{-10,-30}})));
  CDL.Continuous.MultiplyByParameter gai3(k=1/5)
    annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
  CDL.Conversions.IntegerToReal intToRea1
    annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
  CDL.Continuous.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
equation
  connect(ram.y, gai.u)
    annotation (Line(points={{-68,0},{-62,0}}, color={0,0,127}));
  connect(gai.y, reaToInt.u)
    annotation (Line(points={{-38,0},{-32,0}}, color={0,0,127}));
  connect(gai1.y, pLRToPulse.uPLR)
    annotation (Line(points={{62,0},{68,0}}, color={0,0,127}));
  connect(reaToInt.y, intToRea.u)
    annotation (Line(points={{-8,0},{8,0}}, color={255,127,0}));
  connect(intToRea.y, gai1.u)
    annotation (Line(points={{32,0},{38,0}}, color={0,0,127}));
  connect(gai2.y, reaToInt1.u)
    annotation (Line(points={{-38,-40},{-32,-40}}, color={0,0,127}));
  connect(gai3.y, pLRToPulse1.uPLR)
    annotation (Line(points={{62,-40},{68,-40}}, color={0,0,127}));
  connect(reaToInt1.y, intToRea1.u)
    annotation (Line(points={{-8,-40},{8,-40}}, color={255,127,0}));
  connect(intToRea1.y, gai3.u)
    annotation (Line(points={{32,-40},{38,-40}}, color={0,0,127}));
  connect(ram1.y, addPar.u)
    annotation (Line(points={{-68,-80},{-52,-80}}, color={0,0,127}));
  connect(addPar.y, gai2.u) annotation (Line(points={{-28,-80},{-20,-80},{-20,
          -60},{-80,-60},{-80,-40},{-62,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StopTime=25000,
      Interval=1,
      __Dymola_Algorithm="Dassl"));
end PLRToPulse;
