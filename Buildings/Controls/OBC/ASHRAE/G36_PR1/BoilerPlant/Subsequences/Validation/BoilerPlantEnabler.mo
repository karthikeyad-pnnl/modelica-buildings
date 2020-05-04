within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.Subsequences.Validation;
model BoilerPlantEnabler
  CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-92,-54},{-72,-34}})));
  CDL.Logical.Sources.Pulse booPul(
    width=1/75,
    period=75,
    startTime=1)
    annotation (Placement(transformation(extent={{-92,6},{-72,26}})));
  CDL.Continuous.Sources.Constant con(k=27)
    annotation (Placement(transformation(extent={{-92,-24},{-72,-4}})));
  UnitConversions.From_degC from_degC
    annotation (Placement(transformation(extent={{-56,-44},{-36,-24}})));
  BoilerPlantEnabler_v3 boilerPlantEnabler_v3_1(
    numHotWatReqIgnVal=2,
    boiLocOutAirTemVal=301.15,
    boiPlaOffStaHolTimVal=15*60,
    boiPlaOnStaHolTimVal=15*60)
    annotation (Placement(transformation(extent={{-56,-12},{-32,22}})));
  BoilerPlantEnabler_v2 boilerPlantEnabler_v2_1(
    numHotWatReqIgnVal=2,
    boiLocOutAirTemVal=301.15,
    boiPlaOffStaHolTimVal=15*60,
    boiPlaOnStaHolTimVal=15*60)
    annotation (Placement(transformation(extent={{-6,-12},{18,22}})));
equation
  connect(con.y, from_degC.u) annotation (Line(points={{-70,-14},{-68,-14},{-68,
          -34},{-58,-34}}, color={0,0,127}));
  connect(boilerPlantEnabler_v3_1.hotWatReq, booPul.y) annotation (Line(points=
          {{-58,8},{-66,8},{-66,16},{-70,16}}, color={255,0,255}));
  connect(boilerPlantEnabler_v3_1.uOutAirTem, from_degC.y) annotation (Line(
        points={{-58,0},{-64,0},{-64,-18},{-28,-18},{-28,-34},{-34,-34}}, color=
         {0,0,127}));
  connect(con1.y, boilerPlantEnabler_v3_1.boiPlaEnaSig) annotation (Line(points=
         {{-70,-44},{-60,-44},{-60,-6},{-58,-6}}, color={255,0,255}));
  connect(boilerPlantEnabler_v2_1.hotWatReq, booPul.y) annotation (Line(points=
          {{-8,8},{-28,8},{-28,30},{-62,30},{-62,8},{-66,8},{-66,16},{-70,16}},
        color={255,0,255}));
  connect(boilerPlantEnabler_v2_1.boiPlaEnaSig, boilerPlantEnabler_v3_1.boiPlaEnaSig)
    annotation (Line(points={{-8,-6},{-12,-6},{-12,-16},{-60,-16},{-60,-6},{-58,
          -6}}, color={255,0,255}));
  connect(boilerPlantEnabler_v2_1.uOutAirTem, from_degC.y) annotation (Line(
        points={{-8,0},{-22,0},{-22,-26},{-28,-26},{-28,-34},{-34,-34}}, color=
          {0,0,127}));
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
    experiment(
      StopTime=7200,
      __Dymola_NumberOfIntervals=1000,
      __Dymola_Algorithm="Dassl"));
end BoilerPlantEnabler;
