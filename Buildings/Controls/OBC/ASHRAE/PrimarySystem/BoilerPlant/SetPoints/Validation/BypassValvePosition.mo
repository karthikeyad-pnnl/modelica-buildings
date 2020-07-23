within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.Validation;

block BypassValvePosition
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.BypassValvePosition
    bypassValvePosition(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=1,                Ti=2)
    annotation (Placement(transformation(extent={{-52,-10},{-32,10}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(k=1.2)
    annotation (Placement(transformation(extent={{-90,20},{-70,40}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin(
    amplitude=0.5,
    freqHz=0.06,
    offset=1.2,
    startTime=1)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-34,-38},{-18,-22}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(period=5*60)
    annotation (Placement(transformation(extent={{-92,-52},{-72,-32}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.BypassValvePosition
    bypassValvePosition1(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=1,                 Ti=2)
    annotation (Placement(transformation(extent={{-4,-10},{16,10}})));

equation
  connect(con.y, bypassValvePosition.boiMinFloSet) annotation (Line(points={{-68,30},
          {-62,30},{-62,6},{-54,6}},         color={0,0,127}));

  connect(sin.y, bypassValvePosition.priCirFloRat)
    annotation (Line(points={{-68,0},{-62,0},{-62,2},{-54,2}},
                                               color={0,0,127}));

  connect(booPul.y, bypassValvePosition.uPumSta[1]) annotation (Line(points={{
          -70,-42},{-62,-42},{-62,-5},{-54,-5}}, color={255,0,255}));

  connect(booPul.y, bypassValvePosition.uPumSta[2]) annotation (Line(points={{
          -70,-42},{-62,-42},{-62,-6},{-54,-6},{-54,-5}}, color={255,0,255}));

  connect(not1.u, booPul.y) annotation (Line(points={{-35.6,-30},{-56,-30},{-56,
          -42},{-70,-42}}, color={255,0,255}));

  connect(booPul.y, bypassValvePosition1.uPumSta[1]) annotation (Line(points={{
          -70,-42},{-62,-42},{-62,-12},{-30,-12},{-30,-4},{-6,-4},{-6,-5}},
        color={255,0,255}));

  connect(not1.y, bypassValvePosition1.uPumSta[2]) annotation (Line(points={{
          -16.4,-30},{-12,-30},{-12,-5},{-6,-5}}, color={255,0,255}));

  connect(bypassValvePosition1.boiMinFloSet, bypassValvePosition.boiMinFloSet)
    annotation (Line(points={{-6,6},{-6,22},{-62,22},{-62,6},{-54,6}}, color={0,
          0,127}));

  connect(bypassValvePosition1.priCirFloRat, bypassValvePosition.priCirFloRat)
    annotation (Line(points={{-6,2},{-14,2},{-14,14},{-58,14},{-58,2},{-54,2}},
        color={0,0,127}));

  annotation (
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Setpoints.BypassValvePosition\">
Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Setpoints.BypassValvePosition</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
February 21, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}),  Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    __Dymola_Commands(file=
          ".\\Resources\\Scripts\\Dymola\\Controls\\OBC\\ASHRAE\\PrimarySystem\\BoilerPlant\\SetPoints\\Validation\\BypassValvePosition.mos"
        "Simulate and plot"),
    experiment(
      StartTime=-1814400,
      StopTime=1814400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));

end BypassValvePosition;
