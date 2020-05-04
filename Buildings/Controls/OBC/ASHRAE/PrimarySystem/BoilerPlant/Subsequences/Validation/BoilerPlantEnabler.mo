within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.Validation;
model BoilerPlantEnabler
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
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.BoilerPlantEnabler
    boiPlaEna(nHotWatReqIgn=2,
    boiPlaOffStaHolTimVal=10*60,
                               boiEnaSchTab=[0,0; 1,1; 18,1; 24,0])
    annotation (Placement(transformation(extent={{-28,50},{-8,70}})));
  CDL.Continuous.Sources.Sine sin2(
    amplitude=2,
    freqHz=1/(6*60),
    offset=2,
    startTime=1)
    annotation (Placement(transformation(extent={{-90,-34},{-70,-14}})));
  CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{-60,-34},{-40,-14}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.BoilerPlantEnabler
    boiPlaEna1(nHotWatReqIgn=2, boiEnaSchTab=[0,1; 1,1; 18,1; 24,1])
    annotation (Placement(transformation(extent={{-26,-50},{-6,-30}})));
  CDL.Conversions.RealToInteger reaToInt2
    annotation (Placement(transformation(extent={{40,66},{60,86}})));
  CDL.Continuous.Sources.Sine sin5(
    amplitude=2/1.8,
    freqHz=1/700,
    phase=3.1415926535898,
    offset=273 + (80 - 32)/1.8,
    startTime=1)
    annotation (Placement(transformation(extent={{12,30},{32,50}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.BoilerPlantEnabler
    boiPlaEna2(nHotWatReqIgn=2, boiEnaSchTab=[0,1; 1,1; 18,1; 24,1])
    annotation (Placement(transformation(extent={{74,50},{94,70}})));
  CDL.Conversions.RealToInteger reaToInt3
    annotation (Placement(transformation(extent={{38,-34},{58,-14}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Subsequences.BoilerPlantEnabler
    boiPlaEna3(
    nHotWatReqIgn=2,
    nSchRow=5,
    boiEnaSchTab=[0,0; 1,1; 1.5,0; 18,1; 24,0])
    annotation (Placement(transformation(extent={{72,-50},{92,-30}})));
  CDL.Continuous.Sources.Constant con(k=3)
    annotation (Placement(transformation(extent={{10,66},{30,86}})));
  CDL.Continuous.Sources.Constant con1(k=273 + (75 - 32)/1.8)
    annotation (Placement(transformation(extent={{-90,-66},{-70,-46}})));
  CDL.Continuous.Sources.Constant con2(k=3)
    annotation (Placement(transformation(extent={{8,-34},{28,-14}})));
  CDL.Continuous.Sources.Constant con3(k=273 + (75 - 32)/1.8)
    annotation (Placement(transformation(extent={{8,-66},{28,-46}})));
equation
  connect(sin.y, reaToInt.u)
    annotation (Line(points={{-70,76},{-64,76}}, color={0,0,127}));
  connect(boiPlaEna.hotWatSupResReq, reaToInt.y) annotation (Line(points={{-30,65},
          {-36,65},{-36,76},{-40,76}}, color={255,127,0}));
  connect(boiPlaEna.TOut, sin1.y) annotation (Line(points={{-30,55},{-50,55},{
          -50,40},{-68,40}},
                         color={0,0,127}));
  connect(sin2.y, reaToInt1.u)
    annotation (Line(points={{-68,-24},{-62,-24}}, color={0,0,127}));
  connect(boiPlaEna1.hotWatSupResReq, reaToInt1.y) annotation (Line(points={{-28,-35},
          {-34,-35},{-34,-24},{-38,-24}},      color={255,127,0}));
  connect(boiPlaEna2.hotWatSupResReq, reaToInt2.y) annotation (Line(points={{72,65},
          {66,65},{66,76},{62,76}},     color={255,127,0}));
  connect(boiPlaEna2.TOut, sin5.y) annotation (Line(points={{72,55},{52,55},{52,
          40},{34,40}}, color={0,0,127}));
  connect(boiPlaEna3.hotWatSupResReq, reaToInt3.y) annotation (Line(points={{70,-35},
          {64,-35},{64,-24},{60,-24}},      color={255,127,0}));
  connect(con.y, reaToInt2.u)
    annotation (Line(points={{32,76},{38,76}}, color={0,0,127}));
  connect(con1.y, boiPlaEna1.TOut) annotation (Line(points={{-68,-56},{-50,-56},
          {-50,-45},{-28,-45}}, color={0,0,127}));
  connect(reaToInt3.u, con2.y)
    annotation (Line(points={{36,-24},{30,-24}}, color={0,0,127}));
  connect(con3.y, boiPlaEna3.TOut) annotation (Line(points={{30,-56},{50,-56},{
          50,-45},{70,-45}},
                          color={0,0,127}));
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
          extent={{32,26},{80,18}},
          lineColor={28,108,200},
          textString="Changing outdoor temperature",
          fontSize=12),
        Text(
          extent={{-80,-74},{-16,-82}},
          lineColor={28,108,200},
          textString="Changing number of hot-water requests",
          fontSize=12),
        Text(
          extent={{26,-74},{74,-82}},
          lineColor={28,108,200},
          textString="Changing boiler-enable schedule",
          fontSize=12)}),
    experiment(
      StopTime=7200,
      Interval=1,
      Tolerance=1e-06,
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
end BoilerPlantEnabler;
