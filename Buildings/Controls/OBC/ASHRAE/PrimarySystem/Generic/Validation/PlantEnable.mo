within Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.Validation;
model PlantEnable
  CDL.Continuous.Sources.Sine sin(
    amplitude=2,
    freqHz=1/(6*60),
    offset=2,
    startTime=1)
    annotation (Placement(transformation(extent={{-92,66},{-72,86}})));
  CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-62,66},{-42,86}})));
  CDL.Continuous.Sources.Sine sin1(
    amplitude=2/1.8,
    freqHz=1/700,
    phase=3.1415926535898,
    offset=273 + (80 - 32)/1.8,
    startTime=1)
    annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
  CDL.Continuous.Sources.Sine sin2(
    amplitude=2,
    freqHz=1/(6*60),
    offset=2,
    startTime=1)
    annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
  CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
  CDL.Conversions.RealToInteger reaToInt2
    annotation (Placement(transformation(extent={{40,66},{60,86}})));
  CDL.Continuous.Sources.Sine sin5(
    amplitude=2,
    freqHz=1/700,
    phase=3.1415926535898,
    offset=273 + (80 - 32)/1.8,
    startTime=1)
    annotation (Placement(transformation(extent={{12,30},{32,50}})));
  CDL.Conversions.RealToInteger reaToInt3
    annotation (Placement(transformation(extent={{38,-34},{58,-14}})));
  CDL.Continuous.Sources.Constant con(k=3)
    annotation (Placement(transformation(extent={{10,66},{30,86}})));
  CDL.Continuous.Sources.Constant con1(k=273 + (75 - 32)/1.8)
    annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));
  CDL.Continuous.Sources.Constant con2(k=3)
    annotation (Placement(transformation(extent={{8,-34},{28,-14}})));
  CDL.Continuous.Sources.Constant con3(k=273 + (75 - 32)/1.8)
    annotation (Placement(transformation(extent={{8,-66},{28,-46}})));
  .Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.PlantEnable plaEna(
    TLocOut=273 + (80 - 32)/1.8,
    ignReq=2,
    systemType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.Types.SystemTypes.boilerPlant)
    annotation (Placement(transformation(extent={{76,50},{96,70}})));
  .Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.PlantEnable plaEna1(
    TLocOut=273 + (80 - 32)/1.8,
    ignReq=2,
    systemType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.Types.SystemTypes.boilerPlant)
    annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
  .Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.PlantEnable plaEna2(
    TLocOut=273 + (80 - 32)/1.8,
    ignReq=2,
    systemType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.Types.SystemTypes.boilerPlant)
    annotation (Placement(transformation(extent={{-24,-50},{-4,-30}})));
  .Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.PlantEnable plaEna3(
    TLocOut=273 + (80 - 32)/1.8,
    ignReq=2,
    systemType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.Generic.Types.SystemTypes.boilerPlant)
    annotation (Placement(transformation(extent={{74,-50},{94,-30}})));
equation
  connect(sin.y, reaToInt.u)
    annotation (Line(points={{-70,76},{-64,76}}, color={0,0,127}));
  connect(sin2.y, reaToInt1.u)
    annotation (Line(points={{-68,-24},{-62,-24}}, color={0,0,127}));
  connect(con.y, reaToInt2.u)
    annotation (Line(points={{32,76},{38,76}}, color={0,0,127}));
  connect(reaToInt3.u, con2.y)
    annotation (Line(points={{36,-24},{30,-24}}, color={0,0,127}));
  connect(reaToInt2.y, plaEna.chiWatSupResReq) annotation (Line(points={{62,76},
          {68,76},{68,64},{74,64}}, color={255,127,0}));
  connect(sin5.y, plaEna.TOut) annotation (Line(points={{34,40},{56,40},{56,
          55.8},{74,55.8}}, color={0,0,127}));
  connect(reaToInt1.y, plaEna2.chiWatSupResReq) annotation (Line(points={{-38,
          -24},{-32,-24},{-32,-36},{-26,-36}}, color={255,127,0}));
  connect(plaEna2.TOut, con1.y) annotation (Line(points={{-26,-44.2},{-48,-44.2},
          {-48,-56},{-68,-56}}, color={0,0,127}));
  connect(plaEna3.chiWatSupResReq, reaToInt3.y) annotation (Line(points={{72,
          -36},{66,-36},{66,-24},{60,-24}}, color={255,127,0}));
  connect(plaEna3.TOut, con3.y) annotation (Line(points={{72,-44.2},{50,-44.2},
          {50,-56},{30,-56}}, color={0,0,127}));
  connect(reaToInt.y, plaEna1.chiWatSupResReq) annotation (Line(points={{-40,76},
          {-34,76},{-34,64},{-30,64}}, color={255,127,0}));
  connect(sin1.y, plaEna1.TOut) annotation (Line(points={{-68,40},{-48,40},{-48,
          55.8},{-30,55.8}}, color={0,0,127}));
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
    Diagram(coordinateSystem(preserveAspectRatio=false), graphics={
        Text(
          extent={{-72,26},{-24,18}},
          lineColor={28,108,200},
          textString="Combination of all inputs",
          fontSize=12),
        Text(
          extent={{24,26},{80,18}},
          lineColor={28,108,200},
          textString="Changing outdoor temperature",
          fontSize=12),
        Text(
          extent={{-80,-74},{-12,-82}},
          lineColor={28,108,200},
          textString="Changing number of hot-water requests",
          fontSize=12),
        Text(
          extent={{26,-74},{86,-82}},
          lineColor={28,108,200},
          textString="Changing boiler-enable schedule",
          fontSize=12)}),
    experiment(
      StopTime=7200,
      Interval=1,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file="./Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Subsequences/Validation/BoilerPlantEnabler.mos"
        "Simulate and plot"),
        Documentation(info="<html>
        <p>
        This example validates
        <a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.BoilerPlantEnabler\">
        Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.BoilerPlantEnabler</a>.
        </p>
        </html>", revisions="<html>
        <ul>
        <li>
        April 17, 2020, by Karthik Devaprasad:<br/>
        First implementation.
        </li>
        </ul>
        </html>"));
end PlantEnable;
