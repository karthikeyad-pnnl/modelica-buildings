within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Subsequences.Validation;
model ChangePumpStatus
    "Validate sequence for changing pump status"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Subsequences.ChangePumpStatus
    chaPumSta(nPum=3) "Test instance for pump status change sequence"
    annotation (Placement(transformation(extent={{60,-10},{82,10}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre[3](pre_u_start=fill(false, 3))
    "Logical pre block"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.SampleTrigger samTri(period=5, startTime=1)
    "Sample trigger"
    annotation (Placement(transformation(extent={{-130,-10},{-110,10}})));

  Buildings.Controls.OBC.CDL.Integers.OnCounter onCouInt
    annotation (Placement(transformation(extent={{-100,-6},{-88,6}})));

  Buildings.Controls.OBC.CDL.Integers.GreaterThreshold intGreThr(threshold=3)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi1
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=false)
    annotation (Placement(transformation(extent={{-130,70},{-110,90}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-10,10},{10,30}})));

  Buildings.Controls.OBC.CDL.Integers.Add addInt(k1=-1)
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=7)
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));

equation

  connect(pre.y, chaPumSta.uHotWatPum) annotation (Line(points={{112,0},{120,0},
          {120,20},{40,20},{40,0},{58,0}}, color={255,0,255}));

  connect(chaPumSta.yHotWatPum, pre.u)
    annotation (Line(points={{82,0},{88,0}}, color={255,0,255}));

  connect(samTri.y, onCouInt.trigger)
    annotation (Line(points={{-108,0},{-101.2,0}}, color={255,0,255}));

  connect(onCouInt.y, intGreThr.u)
    annotation (Line(points={{-86.8,0},{-82,0}}, color={255,127,0}));

  connect(onCouInt.y, chaPumSta.uNexLagPum) annotation (Line(points={{-86.8,0},
          {-84,0},{-84,-20},{20,-20},{20,-4},{58,-4}}, color={255,127,0}));

  connect(samTri.y, logSwi1.u1) annotation (Line(points={{-108,0},{-106,0},{-106,
          28},{-42,28}}, color={255,0,255}));

  connect(samTri.y, logSwi.u3) annotation (Line(points={{-108,0},{-106,0},{-106,
          42},{-42,42}}, color={255,0,255}));

  connect(intGreThr.y, logSwi1.u2) annotation (Line(points={{-58,0},{-54,0},{-54,
          20},{-42,20}}, color={255,0,255}));

  connect(con.y, logSwi.u1) annotation (Line(points={{-108,80},{-50,80},{-50,58},
          {-42,58}}, color={255,0,255}));

  connect(con.y, logSwi1.u3) annotation (Line(points={{-108,80},{-50,80},{-50,12},
          {-42,12}}, color={255,0,255}));

  connect(intGreThr.y, logSwi.u2) annotation (Line(points={{-58,0},{-54,0},{-54,
          50},{-42,50}}, color={255,0,255}));

  connect(logSwi1.y, not1.u)
    annotation (Line(points={{-18,20},{-12,20}}, color={255,0,255}));

  connect(not1.y, chaPumSta.uLasLagPumSta) annotation (Line(points={{12,20},{30,
          20},{30,5},{58,5}}, color={255,0,255}));

  connect(logSwi.y, chaPumSta.uNexLagPumSta) annotation (Line(points={{-18,50},
          {50,50},{50,8},{58,8}}, color={255,0,255}));

  connect(addInt.y, chaPumSta.uLasLagPum) annotation (Line(points={{-18,-40},{
          52,-40},{52,-8},{58,-8}}, color={255,127,0}));

  connect(onCouInt.y, addInt.u1) annotation (Line(points={{-86.8,0},{-84,0},{-84,
          -34},{-42,-34}}, color={255,127,0}));

  connect(conInt.y, addInt.u2) annotation (Line(points={{-78,-50},{-60,-50},{-60,
          -46},{-42,-46}}, color={255,127,0}));

  connect(con.y, onCouInt.reset) annotation (Line(points={{-108,80},{-104,80},{-104,
          -14},{-94,-14},{-94,-7.2}}, color={255,0,255}));

annotation (
  experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Pumps/PrimaryPumps/Subsequences/Validation/ChangePumpStatus.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.ChangePumpStatus\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.ChangePumpStatus</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
August 19, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-100},{140,100}})));
end ChangePumpStatus;
