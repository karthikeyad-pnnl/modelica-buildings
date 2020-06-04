within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.Validation;
block HotWaterSupplyTemperatureReset
  CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-126,106},{-106,126}})));
  CDL.Logical.Sources.Constant con1(k=false)
    annotation (Placement(transformation(extent={{-126,78},{-106,98}})));
  CDL.Integers.Sources.Constant conInt(k=2)
    annotation (Placement(transformation(extent={{-126,48},{-106,68}})));
  CDL.Logical.Sources.Constant con2(k=false)
    annotation (Placement(transformation(extent={{-126,18},{-106,38}})));
  CDL.Logical.Sources.Constant con3(k=true)
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  CDL.Logical.Sources.Constant con4(k=false)
    annotation (Placement(transformation(extent={{-100,-58},{-80,-38}})));
  CDL.Logical.Sources.Constant con5(k=false)
    annotation (Placement(transformation(extent={{-100,-118},{-80,-98}})));
  CDL.Logical.Sources.Constant con6(k=false)
    annotation (Placement(transformation(extent={{36,110},{56,130}})));
  CDL.Logical.Sources.Constant con7(k=false)
    annotation (Placement(transformation(extent={{36,82},{56,102}})));
  CDL.Integers.Sources.Constant conInt2(k=2)
    annotation (Placement(transformation(extent={{36,52},{56,72}})));
  CDL.Logical.Sources.Constant con8(k=false)
    annotation (Placement(transformation(extent={{36,22},{56,42}})));
  CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-100,-90},{-80,-70}})));
  CDL.Continuous.Sources.Ramp ram(
    height=8,
    duration=1800,
    offset=2,
    startTime=1100)
    annotation (Placement(transformation(extent={{-130,-90},{-110,-70}})));
  CDL.Logical.Sources.Constant con9(k=true)
    annotation (Placement(transformation(extent={{50,-32},{70,-12}})));
  CDL.Logical.Sources.Constant con10(k=false)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{54,-92},{74,-72}})));
  CDL.Continuous.Sources.Ramp ram1(
    height=8,
    duration=1800,
    offset=2,
    startTime=1100)
    annotation (Placement(transformation(extent={{20,-92},{40,-72}})));
  CDL.Logical.Sources.Pulse booPul(period=1200, startTime=1100)
    annotation (Placement(transformation(extent={{56,-120},{76,-100}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset
    hotWatSupTemRes
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
equation
  connect(ram.y, reaToInt.u)
    annotation (Line(points={{-108,-80},{-102,-80}}, color={0,0,127}));
  connect(ram1.y, reaToInt1.u)
    annotation (Line(points={{42,-82},{52,-82}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent={{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points={{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-140,-140},{140,
            140}})),
    experiment(
      StartTime=-1814400,
      StopTime=1814400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    __Dymola_Commands(file=
          "Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/SetPoints/Validation/HotWaterPlantReset.mos"
        "Simulate and plot"),
    __Dymola_experimentSetupOutput,
    __Dymola_experimentFlags(
      Advanced(GenerateVariableDependencies=false, OutputModelicaCode=false),
      Evaluate=false,
      OutputCPUtime=false,
      OutputFlatModelica=false));
end HotWaterSupplyTemperatureReset;
