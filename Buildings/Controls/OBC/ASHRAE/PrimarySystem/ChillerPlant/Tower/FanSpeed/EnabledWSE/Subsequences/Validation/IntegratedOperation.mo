within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.Validation;
model IntegratedOperation
  "Validates cooling tower fan speed control sequence for integrated operation of chillers and WSE"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.IntegratedOperation
    intOpe(final nChi=2, final chiMinCap={1e4,1e4})
    "Tower fan speed control when chiller and waterside economizer are running"
    annotation (Placement(transformation(extent={{70,-40},{90,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant wseSta(final k=true) "WSE status"
    annotation (Placement(transformation(extent={{20,-90},{40,-70}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(
    final width=0.05,
    final period=3600) "Boolean pulse"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.Controls.OBC.CDL.Logical.Not chiSta "First chiller status"
    annotation (Placement(transformation(extent={{-40,70},{-20,90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant chiSta1(final k=false)
    "Second chiller status"
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(final k=0)
    "Zero constant"
    annotation (Placement(transformation(extent={{-80,-70},{-60,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi "Logical switch"
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin(
    final amplitude=0.2*1e4,
    final freqHz=1/1200,
    final offset=1.1*1e4,
    final startTime=180) "Chiller load"
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));

equation
  connect(booPul.y, chiSta.u)
    annotation (Line(points={{-58,80},{-42,80}}, color={255,0,255}));
  connect(chiSta.y, intOpe.uChi[1])
    annotation (Line(points={{-18,80},{60,80},{60,-23},{68,-23}}, color={255,0,255}));
  connect(chiSta1.y, intOpe.uChi[2])
    annotation (Line(points={{-18,50},{60,50},{60,-21},{68,-21}}, color={255,0,255}));
  connect(con.y, intOpe.chiLoa[2])
    annotation (Line(points={{-58,-60},{40,-60},{40,-29},{68,-29}}, color={0,0,127}));
  connect(chiSta.y, swi.u2)
    annotation (Line(points={{-18,80},{60,80},{60,0},{-20,0},{-20,-30},
      {-2,-30}}, color={255,0,255}));
  connect(con.y, swi.u3)
    annotation (Line(points={{-58,-60},{-20,-60},{-20,-38},{-2,-38}}, color={0,0,127}));
  connect(sin.y, swi.u1)
    annotation (Line(points={{-58,0},{-40,0},{-40,-22},{-2,-22}}, color={0,0,127}));
  connect(swi.y, intOpe.chiLoa[1])
    annotation (Line(points={{22,-30},{46,-30},{46,-31},{68,-31}}, color={0,0,127}));
  connect(wseSta.y, intOpe.uWse) annotation (Line(points={{42,-80},{60,-80},{60,
          -38},{68,-38}}, color={255,0,255}));

annotation (experiment(StopTime=3600.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Tower/FanSpeed/EnabledWSE/Subsequences/Validation/IntegratedOperation.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.IntegratedOperation\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Tower.FanSpeed.EnabledWSE.Subsequences.IntegratedOperation</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
August 12, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
 Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end IntegratedOperation;
