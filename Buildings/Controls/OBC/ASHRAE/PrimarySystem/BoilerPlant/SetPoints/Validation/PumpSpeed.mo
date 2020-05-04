within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.Validation;
model PumpSpeed
  .Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.PumpSpeed pumpSpeed
    annotation (Placement(transformation(extent={{-46,14},{-26,38}})));
  CDL.Logical.Sources.Pulse booPul(period=5, startTime=1)
    annotation (Placement(transformation(extent={{-92,70},{-72,90}})));
  CDL.Logical.Sources.Pulse booPul1(period=10, startTime=1)
    annotation (Placement(transformation(extent={{-92,40},{-72,60}})));
  CDL.Logical.Sources.Pulse booPul2(period=20, startTime=1)
    annotation (Placement(transformation(extent={{-90,-16},{-70,4}})));
  CDL.Logical.Sources.Pulse booPul3(period=40, startTime=1)
    annotation (Placement(transformation(extent={{-90,-46},{-70,-26}})));
  CDL.Continuous.Sources.Constant con1(k=0.8)
    annotation (Placement(transformation(extent={{-92,12},{-72,32}})));
  CDL.Continuous.Sources.Sine sin(
    amplitude=0.008515,
    freqHz=1,
    offset=0.008515,
    startTime=1)
    annotation (Placement(transformation(extent={{-44,74},{-24,94}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.PumpSpeed pumpSpeed1
    annotation (Placement(transformation(extent={{46,4},{66,28}})));
  CDL.Logical.Sources.Pulse booPul4(period=5, startTime=1)
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  CDL.Logical.Sources.Pulse booPul5(period=10, startTime=1)
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  CDL.Logical.Sources.Pulse booPul6(period=20, startTime=1)
    annotation (Placement(transformation(extent={{2,-26},{22,-6}})));
  CDL.Logical.Sources.Pulse booPul7(period=40, startTime=1)
    annotation (Placement(transformation(extent={{2,-56},{22,-36}})));
  CDL.Continuous.Sources.Constant con2(k=0.47*0.01703)
    annotation (Placement(transformation(extent={{34,78},{54,98}})));
  CDL.Continuous.Sources.Sine sin1(
    amplitude=1e-1,
    freqHz=0.1,
    offset=1,
    startTime=1) annotation (Placement(transformation(extent={{2,4},{22,24}})));
equation
  connect(booPul.y, pumpSpeed.IsoValSig_a) annotation (Line(points={{-70,80},{-52,
          80},{-52,36},{-48,36}}, color={255,0,255}));
  connect(booPul1.y, pumpSpeed.IsoValSig_b) annotation (Line(points={{-70,50},{-56,
          50},{-56,32},{-48,32}}, color={255,0,255}));
  connect(booPul2.y, pumpSpeed.uPumProSig_a) annotation (Line(points={{-68,-6},{
          -58,-6},{-58,20},{-48,20}}, color={255,0,255}));
  connect(booPul3.y, pumpSpeed.uPumProSig_b) annotation (Line(points={{-68,-36},
          {-54,-36},{-54,16},{-48,16}}, color={255,0,255}));
  connect(con1.y, pumpSpeed.uHotWatDifPre) annotation (Line(points={{-70,22},{-58,
          22},{-58,24},{-48,24}}, color={0,0,127}));
  connect(sin.y, pumpSpeed.uPriCirFloRat) annotation (Line(points={{-22,84},{-16,
          84},{-16,44},{-62,44},{-62,28},{-48,28}}, color={0,0,127}));
  connect(booPul4.y, pumpSpeed1.IsoValSig_a) annotation (Line(points={{22,70},{40,
          70},{40,26},{44,26}}, color={255,0,255}));
  connect(booPul5.y, pumpSpeed1.IsoValSig_b) annotation (Line(points={{22,40},{36,
          40},{36,22},{44,22}}, color={255,0,255}));
  connect(booPul6.y, pumpSpeed1.uPumProSig_a) annotation (Line(points={{24,-16},
          {34,-16},{34,10},{44,10}}, color={255,0,255}));
  connect(booPul7.y, pumpSpeed1.uPumProSig_b) annotation (Line(points={{24,-46},
          {38,-46},{38,6},{44,6}}, color={255,0,255}));
  connect(sin1.y, pumpSpeed1.uHotWatDifPre)
    annotation (Line(points={{24,14},{44,14}}, color={0,0,127}));
  connect(con2.y, pumpSpeed1.uPriCirFloRat) annotation (Line(points={{56,88},{66,
          88},{66,32},{30,32},{30,18},{44,18}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=60, __Dymola_Algorithm="Dassl"),
    Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Setpoints.PumpSpeed\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Setpoints.PumpSpeed</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
February 22, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "../Validation_plots/pumpSpeedControllerplot.mos" "plot"));
end PumpSpeed;
