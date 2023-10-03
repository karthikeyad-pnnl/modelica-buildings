within Buildings.Examples.ChillerPlant.BaseClasses;
partial model DataCenter
  "Primary only chiller plant system with water-side economizer"
  replaceable package MediumA = Buildings.Media.Air "Medium model";
  replaceable package MediumW = Buildings.Media.Water "Medium model";
  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal=roo.QRoo_flow/(
      1005*15) "Nominal mass flow rate at fan";
  parameter Modelica.Units.SI.Power P_nominal=80E3
    "Nominal compressor power (at y=1)";
  parameter Modelica.Units.SI.TemperatureDifference dTEva_nominal=10
    "Temperature difference evaporator inlet-outlet";
  parameter Modelica.Units.SI.TemperatureDifference dTCon_nominal=10
    "Temperature difference condenser outlet-inlet";
  parameter Real COPc_nominal=3 "Chiller COP";
  parameter Modelica.Units.SI.MassFlowRate mCHW_flow_nominal=2*roo.QRoo_flow/(
      4200*20) "Nominal mass flow rate at chilled water";

  parameter Modelica.Units.SI.MassFlowRate mCW_flow_nominal=2*roo.QRoo_flow/(
      4200*6) "Nominal mass flow rate at condenser water";

  parameter Modelica.Units.SI.PressureDifference dp_nominal=500
    "Nominal pressure difference";
  Buildings.Fluid.Movers.FlowControlled_m_flow fan(
    redeclare package Medium = MediumA,
    m_flow_nominal=mAir_flow_nominal,
    dp(start=249),
    m_flow(start=mAir_flow_nominal),
    nominalValuesDefineDefaultPressureCurve=true,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.SteadyState,
    T_start=293.15,
    dp_nominal=750) "Fan for air flow through the data center"
    annotation (Placement(transformation(extent={{348,-235},{328,-215}})));
  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow cooCoi(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m2_flow_nominal=mAir_flow_nominal,
    m1_flow_nominal=mCHW_flow_nominal,
    m1_flow(start=mCHW_flow_nominal),
    m2_flow(start=mAir_flow_nominal),
    dp2_nominal=249*3,
    UA_nominal=mAir_flow_nominal*1006*5,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp1_nominal(displayUnit="Pa") = 1000 + 89580)
    "Cooling coil"
    annotation (Placement(transformation(extent={{300,-180},{280,-160}})));
  Buildings.Examples.ChillerPlant.BaseClasses.SimplifiedRoom_customLoad roo(
    redeclare package Medium = MediumA,
    nPorts=2,
    rooLen=50,
    rooWid=30,
    rooHei=3,
    m_flow_nominal=mAir_flow_nominal,
    QRoo_flow=500000) "Room model" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        origin={248,-238})));
  Fluid.Movers.FlowControlled_dp      pumCHW(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCHW_flow_nominal,
    m_flow(start=mCHW_flow_nominal),
    dp(start=325474),
    nominalValuesDefineDefaultPressureCurve=true,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp_nominal=130000)
    "Chilled water pump" annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={218,-120})));
  Buildings.Fluid.Storage.ExpansionVessel expVesCHW(redeclare package Medium =
        MediumW, V_start=1) "Expansion vessel"
    annotation (Placement(transformation(extent={{248,-147},{268,-127}})));
  Buildings.Fluid.HeatExchangers.CoolingTowers.YorkCalc cooTow(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCW_flow_nominal,
    PFan_nominal=6000,
    TAirInWB_nominal(displayUnit="degC") = 283.15,
    TApp_nominal=6,
    dp_nominal=14930 + 14930 + 74650,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Cooling tower"                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        origin={269,239})));
  Buildings.Fluid.Movers.FlowControlled_m_flow pumCW(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCW_flow_nominal,
    dp(start=214992),
    nominalValuesDefineDefaultPressureCurve=true,
    use_inputFilter=false,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    dp_nominal=130000)
    "Condenser water pump" annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={358,200})));
  Buildings.Fluid.HeatExchangers.ConstantEffectiveness wse(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumW,
    m1_flow_nominal=mCW_flow_nominal,
    m2_flow_nominal=mCHW_flow_nominal,
    eps=0.8,
    dp2_nominal=0,
    dp1_nominal=0) "Water side economizer (Heat exchanger)"
    annotation (Placement(transformation(extent={{126,83},{106,103}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val5(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCW_flow_nominal,
    dpValve_nominal=20902,
    dpFixed_nominal=89580,
    y_start=1,
    use_inputFilter=false) "Control valve for condenser water loop of chiller"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={218,180})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=20902,
    use_inputFilter=false)
    "Bypass control valve for economizer. 1: disable economizer, 0: enable economoizer"
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={218,-40})));
  Buildings.Fluid.Storage.ExpansionVessel expVesChi(redeclare package Medium =
        MediumW, V_start=1)
    annotation (Placement(transformation(extent={{236,143},{256,163}})));
  Buildings.Examples.ChillerPlant.BaseClasses.Controls.WSEControl wseCon
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-150,-29})));
  Modelica.Blocks.Sources.RealExpression expTowTApp(y=cooTow.TApp_nominal)
    "Cooling tower approach" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-212,-20})));
  Buildings.Fluid.Chillers.ElectricEIR chi(
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumW,
    m1_flow_nominal=mCW_flow_nominal,
    m2_flow_nominal=mCHW_flow_nominal,
    dp2_nominal=0,
    dp1_nominal=0,
    per=Buildings.Fluid.Chillers.Data.ElectricEIR.ElectricEIRChiller_Carrier_19XR_742kW_5_42COP_VSD(),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    annotation (Placement(transformation(extent={{274,83},{254,103}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val6(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=20902,
    dpFixed_nominal=14930 + 89580,
    y_start=1,
    use_inputFilter=false,
    from_dp=true)
    "Control valve for chilled water leaving from chiller" annotation (
      Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={360,40})));
  Buildings.Examples.ChillerPlant.BaseClasses.Controls.ChillerSwitch chiSwi(
      deaBan(displayUnit="K") = 2.2)
    "Control unit switching chiller on or off "
    annotation (Placement(transformation(extent={{-226,83},{-206,103}})));
  Buildings.Examples.ChillerPlant.BaseClasses.Controls.LinearPiecewiseTwo
    linPieTwo(
    x0=0,
    x2=1,
    x1=0.5,
    y11=1,
    y21=273.15 + 5.56,
    y10=0.2,
    y20=273.15 + 22) "Translate the control signal for chiller setpoint reset"
    annotation (Placement(transformation(extent={{-120,190},{-100,210}})));
  Modelica.Blocks.Sources.Constant TAirSet(k=273.15 + 27)
    "Set temperature for air supply to the room" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-230,170})));
  Modelica.Blocks.Math.BooleanToReal chiCon "Contorl signal for chiller"
    annotation (Placement(transformation(extent={{-160,40},{-140,60}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val4(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCW_flow_nominal,
    dpValve_nominal=20902,
    dpFixed_nominal=59720,
    y_start=0,
    use_inputFilter=false)
    "Control valve for condenser water loop of economizer" annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={98,180})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium =
        MediumA, m_flow_nominal=mAir_flow_nominal)
    "Supply air temperature to data center" annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        origin={288,-225})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCHWEntChi(redeclare package
      Medium = MediumW, m_flow_nominal=mCHW_flow_nominal)
    "Temperature of chilled water entering chiller" annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={218,0})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCWLeaTow(redeclare package Medium =
        MediumW, m_flow_nominal=mCW_flow_nominal)
    "Temperature of condenser water leaving the cooling tower"      annotation (
     Placement(transformation(
        extent={{10,-10},{-10,10}},
        origin={330,119})));
  Buildings.Fluid.Actuators.Valves.TwoWayEqualPercentage valByp(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=20902,
    dpFixed_nominal=14930,
    y_start=0,
    use_inputFilter=false,
    from_dp=true)          "Bypass valve for chiller." annotation (Placement(
        transformation(extent={{-10,-10},{10,10}}, origin={288,20})));
  Buildings.Examples.ChillerPlant.BaseClasses.Controls.KMinusU KMinusU(k=1)
    annotation (Placement(transformation(extent={{-60,28},{-40,48}})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear val3(
    redeclare package Medium = MediumW,
    m_flow_nominal=mCHW_flow_nominal,
    dpValve_nominal=20902,
    dpFixed_nominal=59720 + 1000,
    use_inputFilter=false)
    "Control valve for economizer. 0: disable economizer, 1: enable economoizer"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}}, origin={
            118,-60})));
  Buildings.Fluid.Sensors.TemperatureTwoPort TCHWLeaCoi(redeclare package
      Medium = MediumW, m_flow_nominal=mCHW_flow_nominal)
    "Temperature of chilled water leaving the cooling coil"
                                                     annotation (Placement(
        transformation(
        extent={{10,10},{-10,-10}},
        rotation=270,
        origin={218,-80})));
  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaData(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_CA_San.Francisco.Intl.AP.724940_TMY3.mos"))
    annotation (Placement(transformation(extent={{-360,-100},{-340,-80}})));
  BoundaryConditions.WeatherData.Bus weaBus
    annotation (Placement(transformation(extent={{-332,-98},{-312,-78}}),
        iconTransformation(extent={{-90,70},{-70,90}})));
  Modelica.Blocks.Math.Gain gain(k=20*6485)
    annotation (Placement(transformation(extent={{-60,90},{-40,110}})));
  Modelica.Blocks.Math.Feedback feedback
    annotation (Placement(transformation(extent={{-210,190},{-190,210}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold
    annotation (Placement(transformation(extent={{-10,190},{10,210}})));
  Modelica.Blocks.Logical.Or or1
    annotation (Placement(transformation(extent={{20,190},{40,210}})));
  Modelica.Blocks.Math.BooleanToReal mCWFlo(realTrue=mCW_flow_nominal)
    "Mass flow rate of condenser loop"
    annotation (Placement(transformation(extent={{60,190},{80,210}})));
  Modelica.Blocks.Sources.RealExpression PHVAC(y=fan.P + pumCHW.P + pumCW.P +
        cooTow.PFan + chi.P) "Power consumed by HVAC system"
                             annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-290,-250})));
  Modelica.Blocks.Sources.RealExpression PIT(y=roo.QSou.Q_flow)
    "Power consumed by IT"   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        origin={-290,-280})));
  Modelica.Blocks.Continuous.Integrator EHVAC(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Energy consumed by HVAC"
    annotation (Placement(transformation(extent={{-240,-260},{-220,-240}})));
  Modelica.Blocks.Continuous.Integrator EIT(initType=Modelica.Blocks.Types.Init.InitialState,
      y_start=0) "Energy consumed by IT"
    annotation (Placement(transformation(extent={{-240,-290},{-220,-270}})));
  Fluid.Sensors.TemperatureTwoPort TCHWEntCoi(redeclare package Medium =
        MediumW, m_flow_nominal=mCHW_flow_nominal)
    "Temperature of chilled water entering the cooling coil" annotation (
      Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=90,
        origin={360,-132})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uFan
    "Chilled water supply temperature setpoint" annotation (Placement(
        transformation(extent={{-438.0,-40.0},{-398.0,0.0}},rotation = 0.0,origin = {0.0,0.0}), iconTransformation(extent={{-140,40},
            {-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TEntCoi
    "Chilled water temperature entering the coil" annotation (Placement(
        transformation(extent={{400,-60},{440,-20}}), iconTransformation(extent={{100,-40},
            {140,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput mCHWEntCoi_flow
    "Chilled water mass flowrate enterign the coil" annotation (Placement(
        transformation(extent={{400,-20},{440,20}}), iconTransformation(extent={{100,0},
            {140,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TEntChi
    "Chilled water temperature returned to the chiller" annotation (Placement(
        transformation(extent={{404.0,36.0},{444.0,76.0}},rotation = 0.0,origin = {0.0,0.0}), iconTransformation(extent={{100,40},
            {140,80}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput uLoad annotation(Placement(transformation(extent = {{-438,-82},{-398,-42}},origin = {0,0},rotation = 0),
        iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSupAirDelta
    "Difference between measured supply air temperature and setpoint"
    annotation (Placement(transformation(extent={{406.0,-156.0},{446.0,-116.0}},rotation = 0.0,origin = {0.0,0.0}),
        iconTransformation(extent={{100,-122},{140,-82}})));
    .Modelica.Blocks.Math.Gain gain2(k = mAir_flow_nominal) annotation(Placement(transformation(extent = {{312.0,-208.0},{332.0,-188.0}},rotation = 0.0,origin = {0.0,0.0})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput TRooSet annotation(Placement(transformation(extent = {{-438.0,-142.0},{-398.0,-102.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent={{-140,
            -80},{-100,-40}})));
    .Buildings.Controls.OBC.CDL.Continuous.PID conPID(Ti = 1000,reverseActing = false) annotation(Placement(transformation(extent = {{276.0,-290.0},{296.0,-270.0}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Fluid.Sensors.MassFlowRate senMasFlo(redeclare replaceable
      package                                                                     Medium = MediumW) annotation(Placement(transformation(extent = {{-10.0,-10.0},{10.0,10.0}},origin = {360.0,-56.0},rotation = -90.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput TRoo "Difference between measured supply air temperature and setpoint" annotation(Placement(transformation(extent = {{412.0,-258.0},{452.0,-218.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent={{100,
            -202},{140,-162}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput yValByp "Chilled water temperature returned to the chiller" annotation(Placement(transformation(extent = {{400.0,96.0},{440.0,136.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{100,80},{140,120}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput mSupAir_flow "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{406.0,-226.0},{446.0,-186.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent={{100,
            -162},{140,-122}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput mCW_flow "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{396.0,140.0},{436.0,180.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{100,120},{140,160}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput PChi "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{408.0,190.0},{448.0,230.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent = {{100,160},{140,200}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput PCHWPum "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{394.0,230.0},{434.0,270.0}},rotation = 0.0,origin={6,0}),      iconTransformation(extent={{100,200},
            {140,240}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput TWetBul "Chilled water supply temperature setpoint" annotation(Placement(transformation(extent = {{-438.0,-110.0},{-398.0,-70.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent={{-140,
            -40},{-100,0}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput PCWPum "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{394.0,272.0},{434.0,312.0}},rotation = 0.0,origin={6,-2}),     iconTransformation(extent={{100,240},
            {140,280}})));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput PFan "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{404.0,-102.0},{444.0,-62.0}},rotation = 0.0,origin = {0.0,0.0}),iconTransformation(extent={{100,-80},
            {140,-40}})));
    Buildings.Controls.OBC.CDL.Interfaces.RealOutput  PCooTow
                                                             "Chilled water mass flowrate enterign the coil" annotation(Placement(transformation(extent = {{394.0,272.0},{434.0,312.0}},rotation = 0.0,origin={6,48}),     iconTransformation(extent={{100,280},
            {140,320}})));
equation
  connect(expVesCHW.port_a, cooCoi.port_b1) annotation (Line(
      points={{258,-147},{258,-164},{280,-164}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(expTowTApp.y, wseCon.towTApp) annotation (Line(
      points={{-201,-20},{-178,-20},{-178,-31.9412},{-162,-31.9412}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(chiSwi.y, chiCon.u) annotation (Line(
      points={{-205,92.4},{-182,92.4},{-182,50},{-162,50}},
      color={255,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooTow.port_b, pumCW.port_a) annotation (Line(
      points={{279,239},{358,239},{358,210}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(val5.port_a, chi.port_b1) annotation (Line(
      points={{218,170},{218,99},{254,99}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(expVesChi.port_a, chi.port_b1) annotation (Line(
      points={{246,143},{246,99},{254,99}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(val4.port_a, wse.port_b1) annotation (Line(
      points={{98,170},{98,99},{106,99}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(chiSwi.y, chi.on) annotation (Line(
      points={{-205,92.4},{-182,92.4},{-182,129},{276,129},{276,96}},
      color={255,0,255},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(cooCoi.port_b2, fan.port_a) annotation (Line(
      points={{300,-176},{359,-176},{359,-225},{348,-225}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));

  connect(wse.port_a2, val3.port_b) annotation (Line(
      points={{106,87},{98,87},{98,-60},{108,-60}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TAirSup.port_a, fan.port_b) annotation (Line(
      points={{298,-225},{328,-225}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(roo.airPorts[1],TAirSup. port_b) annotation (Line(
      points={{250.475,-229.3},{250.475,-225},{278,-225}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(roo.airPorts[2], cooCoi.port_a2) annotation (Line(
      points={{246.425,-229.3},{246.425,-225},{218,-225},{218,-176},{280,-176}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCHWLeaCoi.port_a, pumCHW.port_b)
                                           annotation (Line(
      points={{218,-90},{218,-110}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCHWEntChi.port_b, valByp.port_a)
                                         annotation (Line(
      points={{218,10},{218,20},{278,20}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCHWEntChi.port_a, val1.port_b)
                                         annotation (Line(
      points={{218,-10},{218,-30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(val1.port_a, TCHWLeaCoi.port_b)
                                         annotation (Line(
      points={{218,-50},{218,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(val3.port_a, TCHWLeaCoi.port_b)
                                         annotation (Line(
      points={{128,-60},{218,-60},{218,-70}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCWLeaTow.port_b, chi.port_a1)
                                        annotation (Line(
      points={{320,119},{300,119},{300,99},{274,99}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCWLeaTow.port_b, wse.port_a1)
                                        annotation (Line(
      points={{320,119},{138,119},{138,99},{126,99}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCHWEntChi.T, chiSwi.chiCHWST)
                                        annotation (Line(
      points={{207,1.40998e-15},{-18,0},{-18,0},{-242,-2},{-242,100},{-227,100}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(wseCon.wseCWST, TCWLeaTow.T)
                                      annotation (Line(
      points={{-162,-36.5294},{-300,-36.5294},{-300,290},{380,290},{380,137},{
          330,137},{330,130}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(wseCon.wseCHWST, TCHWLeaCoi.T)
                                        annotation (Line(
      points={{-162,-22.5294},{-176,-22.5294},{-176,-80},{207,-80}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(weaData.weaBus, weaBus) annotation (Line(
      points={{-340,-90},{-331,-90},{-331,-88},{-322,-88}},
      color={255,204,51},
      thickness=0.5,
      smooth=Smooth.None), Text(
      textString="%second",
      index=1,
      extent={{6,3},{6,3}}));
  connect(TCHWEntChi.port_a, wse.port_b2)
                                         annotation (Line(
      points={{218,-10},{218,-20},{138,-20},{138,87},{126,87}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(valByp.port_b, val6.port_b)
                                    annotation (Line(
      points={{298,20},{360,20},{360,30}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(TCHWEntChi.port_b, chi.port_a2)
                                         annotation (Line(
      points={{218,10},{218,88},{254,88},{254,87}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(val5.port_b, cooTow.port_a) annotation (Line(
      points={{218,190},{218,239},{259,239}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(val4.port_b, cooTow.port_a) annotation (Line(
      points={{98,190},{98,239},{259,239}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(pumCW.port_b, TCWLeaTow.port_a)
                                         annotation (Line(
      points={{358,190},{358,119},{340,119}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));

  connect(chiCon.y, KMinusU.u) annotation (Line(
      points={{-139,50},{-80,50},{-80,38},{-61.8,38}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(KMinusU.y, valByp.y)
                             annotation (Line(
      points={{-39,38},{288,38},{288,32}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(chiCon.y, val6.y) annotation (Line(
      points={{-139,50},{-80,50},{-80,54},{336,54},{336,40},{348,40}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(linPieTwo.y[1], gain.u) annotation (Line(
      points={{-99,199.3},{-74,199.3},{-74,100},{-62,100}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));

  connect(TAirSet.y, feedback.u2) annotation (Line(
      points={{-219,170},{-200,170},{-200,192}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(TAirSup.T, feedback.u1) annotation (Line(
      points={{288,-214},{288,-202},{-264,-202},{-264,200},{-208,200}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(chi.port_b2, val6.port_a) annotation (Line(
      points={{274,87},{360,87},{360,50}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(pumCHW.port_a, cooCoi.port_b1) annotation (Line(
      points={{218,-130},{218,-164},{280,-164}},
      color={0,127,255},
      smooth=Smooth.None,
      thickness=0.5));
  connect(greaterThreshold.u, wseCon.y1) annotation (Line(
      points={{-12,200},{-20,200},{-20,-27.2353},{-139,-27.2353}},
      color={0,0,127},
      smooth=Smooth.None,
      pattern=LinePattern.Dash));
  connect(or1.u1, greaterThreshold.y) annotation (Line(
      points={{18,200},{11,200}},
      color={255,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(or1.u2, chiSwi.y) annotation (Line(
      points={{18,192},{18,192},{16,192},{16,192},{12,192},{12,128},{-182,128},
          {-182,92},{-205,92},{-205,92.4}},
      color={255,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(or1.y, mCWFlo.u) annotation (Line(
      points={{41,200},{58,200}},
      color={255,0,255},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(mCWFlo.y, pumCW.m_flow_in) annotation (Line(
      points={{81,200},{218,200},{218,200},{346,200}},
      color={0,0,127},
      pattern=LinePattern.Dash,
      smooth=Smooth.None));
  connect(PHVAC.y, EHVAC.u) annotation (Line(
      points={{-279,-250},{-242,-250}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PIT.y, EIT.u) annotation (Line(
      points={{-279,-280},{-242,-280}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(cooCoi.port_a1, TCHWEntCoi.port_b) annotation (Line(points={{300,-164},
          {360,-164},{360,-142}}, color={0,127,255}));
  connect(TCHWEntCoi.T, TEntCoi) annotation (Line(points={{371,-132},{390,-132},
          {390,-40},{420,-40}}, color={0,0,127}));
  connect(TCHWEntChi.T, TEntChi) annotation (Line(points={{207,0},{188,0},{188,56},{424,56}}, color={0,0,127}));
    connect(uLoad,roo.uLoad) annotation(Line(points = {{-418,-62},{-88.7,-62},{-88.7,-235},{240.6,-235}},color = {0,0,127}));
    connect(gain2.y,fan.m_flow_in) annotation(Line(points = {{333,-198},{338,-198},{338,-213}},color = {0,0,127}));
    connect(roo.TRooAir,conPID.u_m) annotation(Line(points = {{259,-238},{264,-238},{264,-298},{286,-298},{286,-292}},color = {0,0,127}));
    connect(TRooSet,conPID.u_s) annotation(Line(points = {{-418,-122},{-182,-122},{-182,-280},{274,-280}},color = {0,0,127}));
    connect(conPID.y,gain2.u) annotation(Line(points = {{298,-280},{304,-280},{304,-198},{310,-198}},color = {0,0,127}));
    connect(val6.port_b,senMasFlo.port_a) annotation(Line(points = {{360,30},{360,-46}},color = {0,127,255}));
    connect(TCHWEntCoi.port_a,senMasFlo.port_b) annotation(Line(points = {{360,-122},{360,-66}},color = {0,127,255}));
    connect(senMasFlo.m_flow,mCHWEntCoi_flow) annotation(Line(points = {{371,-56},{382,-56},{382,0},{420,0}},color = {0,0,127}));
    connect(roo.TRooAir,TRoo) annotation(Line(points = {{259,-238},{432,-238}},color = {0,0,127}));
    connect(valByp.y_actual,yValByp) annotation(Line(points = {{293,27},{378,27},{378,116},{420,116}},color = {0,0,127}));
    connect(feedback.y,TSupAirDelta) annotation(Line(points = {{-191,200},{-130,200},{-130,-260},{382,-260},{382,-136},{426,-136}},color = {0,0,127}));
    connect(fan.m_flow_actual,mSupAir_flow) annotation(Line(points = {{327,-220},{321,-220},{321,-206},{426,-206}},color = {0,0,127}));
    connect(pumCW.m_flow_actual,mCW_flow) annotation(Line(points = {{353,189},{353,160},{416,160}},color = {0,0,127}));
    connect(chi.P,PChi) annotation(Line(points = {{253,102},{253,140},{386,140},{386,210},{428,210}},color = {0,0,127}));
    connect(pumCHW.P,PCHWPum) annotation(Line(points={{209,-109},{203,-109},{
          203,250},{420,250}},                                                                     color = {0,0,127}));
    connect(gain.y,pumCHW.dp_in) annotation(Line(points = {{-39,100},{83.5,100},{83.5,-120},{206,-120}},color = {0,0,127}));
    connect(linPieTwo.y[2],chi.TSet) annotation(Line(points={{-99,200.3},{-88,
          200.3},{-88,70},{276,70},{276,90}},                                                                      color = {0,0,127}));
    connect(linPieTwo.y[2],chiSwi.TSet) annotation(Line(points={{-99,200.3},{
          -93,200.3},{-93,143.9},{-232,143.9},{-232,88},{-227,88}},                                                                     color = {0,0,127}));
    connect(wseCon.y1,val3.y) annotation(Line(points = {{-139,-27.235294117647058},{118,-27.235294117647058},{118,-48}},color = {0,0,127}));
    connect(wseCon.y2,val1.y) annotation(Line(points = {{-139,-31.941176470588236},{33.5,-31.941176470588236},{33.5,-40},{206,-40}},color = {0,0,127}));
    connect(wseCon.y1,val4.y) annotation(Line(points = {{-139,-27.235294117647058},{-26.5,-27.235294117647058},{-26.5,180},{86,180}},color = {0,0,127}));
    connect(chiCon.y,val5.y) annotation(Line(points = {{-139,50},{-80,50},{-80,164},{206,164},{206,180}},color = {0,0,127}));
    connect(uFan,cooTow.y) annotation(Line(points = {{-418,-20},{-344,-20},{-344,247},{257,247}},color = {0,0,127}));
    connect(TWetBul,wseCon.TWetBul) annotation(Line(points = {{-418,-90},{-290,-90},{-290,-28.41176470588235},{-162,-28.41176470588235}},color = {0,0,127}));
    connect(TWetBul,cooTow.TAir) annotation(Line(points = {{-418,-90},{-290,-90},{-290,230},{257,230},{257,243}},color = {0,0,127}));
    connect(pumCW.P,PCWPum) annotation(Line(points={{349,189},{343,189},{343,
          290},{420,290}},                                                                     color = {0,0,127}));
    connect(fan.P,PFan) annotation(Line(points = {{327,-216},{327,-82},{424,-82}},color = {0,0,127}));
  connect(cooTow.PFan, PCooTow) annotation (Line(points={{280,247},{342,247},{
          342,340},{420,340}}, color={0,0,127}));
  annotation (
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-400,-300},{400,
            300}})),
Documentation(info="<HTML>
<p>
This model is the chilled water plant with discrete time control and
trim and respond logic for a data center. The model is described at
<a href=\"modelica://Buildings.Examples.ChillerPlant\">
Buildings.Examples.ChillerPlant</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
December 6, 2021, by Michael Wetter:<br/>
Changed initialization from steady-state initial to fixed initial.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2798\">issue 2798</a>.
</li>
<li>
November 18, 2021, by Michael Wetter:<br/>
Set <code>dp_nominal</code> for pumps and fan to a realistic value.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2761\">#2761</a>.
</li>
<li>
September 21, 2017, by Michael Wetter:<br/>
Set <code>from_dp = true</code> in <code>val6</code> and in <code>valByp</code>
which is needed for Dymola 2018FD01 beta 2 for
<a href=\"modelica://Buildings.Examples.ChillerPlant.DataCenterDiscreteTimeControl\">
Buildings.Examples.ChillerPlant.DataCenterDiscreteTimeControl</a>
to converge.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">IBPSA, #404</a>.
</li>
<li>
January 13, 2015 by Michael Wetter:<br/>
Moved model to <code>BaseClasses</code> because the continuous and discrete time
implementation of the trim and respond logic do not extend from a common class,
and hence the <code>constrainedby</code> operator is not applicable.
Moving the model here allows to implement both controllers without using a
<code>replaceable</code> class.
</li>
<li>
January 12, 2015 by Michael Wetter:<br/>
Made media instances replaceable, and used the same instance for both
water loops.
This was done to simplify the numerical benchmarks.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
March 25, 2014, by Michael Wetter:<br/>
Updated model with new expansion vessel.
</li>
<li>
December 5, 2012, by Michael Wetter:<br/>
Removed the filtered speed calculation for the valves to reduce computing time by 25%.
</li>
<li>
October 16, 2012, by Wangda Zuo:<br/>
Reimplemented the controls.
</li>
<li>
July 20, 2011, by Wangda Zuo:<br/>
Added comments and merge to library.
</li>
<li>
January 18, 2011, by Wangda Zuo:<br/>
First implementation.
</li>
</ul>
</html>"));
end DataCenter;
