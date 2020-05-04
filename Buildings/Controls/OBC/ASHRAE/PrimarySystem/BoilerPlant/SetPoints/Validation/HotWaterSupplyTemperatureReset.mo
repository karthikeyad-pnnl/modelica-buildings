within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.Validation;
model HotWaterSupplyTemperatureReset
  CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-126,106},{-106,126}})));
  CDL.Logical.Sources.Constant con1(k=false)
    annotation (Placement(transformation(extent={{-126,78},{-106,98}})));
  CDL.Integers.Sources.Constant conInt(k=2)
    annotation (Placement(transformation(extent={{-126,48},{-106,68}})));
  CDL.Logical.Sources.Constant con2(k=false)
    annotation (Placement(transformation(extent={{-126,18},{-106,38}})));
  CDL.Logical.Sources.Constant con3(k=true)
    annotation (Placement(transformation(extent={{-104,-30},{-84,-10}})));
  CDL.Logical.Sources.Constant con4(k=false)
    annotation (Placement(transformation(extent={{-104,-58},{-84,-38}})));
  CDL.Logical.Sources.Constant con5(k=false)
    annotation (Placement(transformation(extent={{-104,-118},{-84,-98}})));
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
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset
    hotWaterSupplyTemperatureReset3(
    hotWatSetMax=225.2067901235,
    hotWatSetMin=186.3179012346,
    delTimVal=600,
    samPerVal=300,
    nPum=2,
    nHotWatResReqIgn=2,
    triAmoVal=-2/1.8,
    resAmoVal=3/1.8,
    maxResVal=7/1.8,
    holTimVal=900)
    annotation (Placement(transformation(extent={{-94,84},{-74,104}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset
    hotWaterSupplyTemperatureReset4(
    hotWatSetMax=225.2067901235,
    hotWatSetMin=186.3179012346,
    delTimVal=600,
    samPerVal=300,
    nPum=2,
    nHotWatResReqIgn=2,
    triAmoVal=-2/1.8,
    resAmoVal=3/1.8,
    maxResVal=7/1.8,
    holTimVal=900)
    annotation (Placement(transformation(extent={{-68,-50},{-48,-30}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset
    hotWaterSupplyTemperatureReset1(
    hotWatSetMax=225.2067901235,
    hotWatSetMin=186.3179012346,
    delTimVal=600,
    samPerVal=300,
    nPum=2,
    nHotWatResReqIgn=2,
    triAmoVal=-2/1.8,
    resAmoVal=3/1.8,
    maxResVal=7/1.8,
    holTimVal=900)
    annotation (Placement(transformation(extent={{72,82},{92,102}})));
  CDL.Continuous.Sources.Ramp ram(
    height=8,
    duration=1800,
    offset=2,
    startTime=1100)
    annotation (Placement(transformation(extent={{-134,-90},{-114,-70}})));
  CDL.Logical.Sources.Constant con9(k=true)
    annotation (Placement(transformation(extent={{50,-32},{70,-12}})));
  CDL.Logical.Sources.Constant con10(k=false)
    annotation (Placement(transformation(extent={{50,-60},{70,-40}})));
  CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{54,-92},{74,-72}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints.HotWaterSupplyTemperatureReset
    hotWaterSupplyTemperatureReset2(
    hotWatSetMax=225.2067901235,
    hotWatSetMin=186.3179012346,
    delTimVal=600,
    samPerVal=300,
    nPum=2,
    nHotWatResReqIgn=2,
    triAmoVal=-2/1.8,
    resAmoVal=3/1.8,
    maxResVal=7/1.8,
    holTimVal=900)
    annotation (Placement(transformation(extent={{86,-52},{106,-32}})));
  CDL.Continuous.Sources.Ramp ram1(
    height=8,
    duration=1800,
    offset=2,
    startTime=1100)
    annotation (Placement(transformation(extent={{20,-92},{40,-72}})));
  CDL.Logical.Sources.Pulse booPul(period=1200, startTime=1100)
    annotation (Placement(transformation(extent={{56,-120},{76,-100}})));
equation
  connect(con.y, hotWaterSupplyTemperatureReset3.uHotWatPumSta[1]) annotation (
      Line(points={{-104,116},{-100,116},{-100,97},{-96,97}}, color={255,0,255}));
  connect(con1.y, hotWaterSupplyTemperatureReset3.uHotWatPumSta[2]) annotation (
     Line(points={{-104,88},{-100,88},{-100,99},{-96,99}}, color={255,0,255}));
  connect(conInt.y, hotWaterSupplyTemperatureReset3.nHotWatSupResReq)
    annotation (Line(points={{-104,58},{-98,58},{-98,94},{-96,94}}, color={255,
          127,0}));
  connect(con2.y, hotWaterSupplyTemperatureReset3.uStaCha)
    annotation (Line(points={{-104,28},{-96,28},{-96,90}}, color={255,0,255}));
  connect(con3.y, hotWaterSupplyTemperatureReset4.uHotWatPumSta[1]) annotation (
     Line(points={{-82,-20},{-76,-20},{-76,-37},{-70,-37}}, color={255,0,255}));
  connect(con4.y, hotWaterSupplyTemperatureReset4.uHotWatPumSta[2]) annotation (
     Line(points={{-82,-48},{-76,-48},{-76,-35},{-70,-35}}, color={255,0,255}));
  connect(reaToInt.y, hotWaterSupplyTemperatureReset4.nHotWatSupResReq)
    annotation (Line(points={{-78,-80},{-74,-80},{-74,-40},{-70,-40}}, color={
          255,127,0}));
  connect(con5.y, hotWaterSupplyTemperatureReset4.uStaCha) annotation (Line(
        points={{-82,-108},{-72,-108},{-72,-44},{-70,-44}}, color={255,0,255}));
  connect(con6.y, hotWaterSupplyTemperatureReset1.uHotWatPumSta[1]) annotation (
     Line(points={{58,120},{66,120},{66,95},{70,95}}, color={255,0,255}));
  connect(con7.y, hotWaterSupplyTemperatureReset1.uHotWatPumSta[2]) annotation (
     Line(points={{58,92},{66,92},{66,97},{70,97}}, color={255,0,255}));
  connect(conInt2.y, hotWaterSupplyTemperatureReset1.nHotWatSupResReq)
    annotation (Line(points={{58,62},{68,62},{68,92},{70,92}}, color={255,127,0}));
  connect(con8.y, hotWaterSupplyTemperatureReset1.uStaCha) annotation (Line(
        points={{58,32},{64,32},{64,88},{70,88}}, color={255,0,255}));
  connect(ram.y, reaToInt.u)
    annotation (Line(points={{-112,-80},{-102,-80}}, color={0,0,127}));
  connect(con9.y, hotWaterSupplyTemperatureReset2.uHotWatPumSta[1]) annotation (
     Line(points={{72,-22},{78,-22},{78,-39},{84,-39}}, color={255,0,255}));
  connect(con10.y, hotWaterSupplyTemperatureReset2.uHotWatPumSta[2])
    annotation (Line(points={{72,-50},{78,-50},{78,-37},{84,-37}}, color={255,0,
          255}));
  connect(reaToInt1.y, hotWaterSupplyTemperatureReset2.nHotWatSupResReq)
    annotation (Line(points={{76,-82},{80,-82},{80,-42},{84,-42}}, color={255,
          127,0}));
  connect(ram1.y, reaToInt1.u)
    annotation (Line(points={{42,-82},{52,-82}}, color={0,0,127}));
  connect(booPul.y, hotWaterSupplyTemperatureReset2.uStaCha) annotation (Line(
        points={{78,-110},{82,-110},{82,-46},{84,-46}}, color={255,0,255}));
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
