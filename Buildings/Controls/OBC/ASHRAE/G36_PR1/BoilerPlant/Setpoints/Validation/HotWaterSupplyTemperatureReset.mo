within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints.Validation;
model HotWaterSupplyTemperatureReset
  Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset
    hotWaterSupplyTemperatureReset(
    hotWatSetMax=352.59,
    hotWatSetMin=299.8167,
    delTimVal=600,
    samPerVal=300)
    annotation (Placement(transformation(extent={{-56,-6},{-44,6}})));
  CDL.Logical.Sources.Pulse booPul(period=4800, startTime=1)
    annotation (Placement(transformation(extent={{-90,12},{-70,32}})));
  CDL.Logical.Sources.Pulse booPul1(period=4800, startTime=1)
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{-92,-66},{-72,-46}})));
equation
  connect(booPul.y, hotWaterSupplyTemperatureReset.uPumProSig_a) annotation (
      Line(points={{-68,22},{-64,22},{-64,4},{-58,4}}, color={255,0,255}));
  connect(booPul1.y, hotWaterSupplyTemperatureReset.uPumProSig_b) annotation (
      Line(points={{-68,-10},{-64,-10},{-64,0},{-58,0}}, color={255,0,255}));
  connect(conInt.y, hotWaterSupplyTemperatureReset.uNumHotWatReq) annotation (
      Line(points={{-70,-56},{-62,-56},{-62,-4},{-58,-4}}, color={255,127,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end HotWaterSupplyTemperatureReset;
