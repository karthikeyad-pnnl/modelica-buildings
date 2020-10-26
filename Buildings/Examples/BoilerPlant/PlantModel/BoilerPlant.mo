within Buildings.Examples.BoilerPlant.PlantModel;
model BoilerPlant "Boiler plant model for closed loop testing"
  extends Modelica.Icons.Example;
  replaceable package MediumA =
      Buildings.Media.Air;
  replaceable package MediumW =
      Buildings.Media.Water "Medium model";

  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal = boiEff1[1]*boiCap1 + boiEff2[1]*boiCap2
    "Nominal heat flow rate of radiator"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.HeatFlowRate boiCap1= 15000
    "Boiler capacity for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.HeatFlowRate boiCap2= 15000
    "Boiler capacity for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff1[1] = {0.8}
    "Efficiency for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff2[1] = {0.8}
    "Efficiency for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.Temperature TRadSup_nominal = 273.15+70
    "Radiator nominal supply water temperature"
    annotation(dialog(group="Radiator parameters"));
  parameter Modelica.SIunits.Temperature TRadRet_nominal = 273.15+60
    "Radiator nominal return water temperature"
    annotation(dialog(group="Radiator parameters"));
  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=0.000604*1000
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.Temperature TBoiSup_nominal = 273.15+70
    "Boiler nominal supply water temperature"
    annotation(dialog(group="Boiler parameters"));
  parameter Modelica.SIunits.Temperature TBoiRet_min = 273.15+60
    "Boiler minimum return water temperature"
    annotation(dialog(group="Boiler parameters"));
  parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal1=boiCap1/4200/(TBoiSup_nominal-TBoiRet_min)
    "Boiler-1 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal2=boiCap2/4200/(TBoiSup_nominal-TBoiRet_min)
    "Boiler-2 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.SIunits.Volume V=1200
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.SIunits.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Real zonTheCap = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));
//------------------------------------------------------------------------------//

//----------------Radiator loop: Three-way valve: mass flow rate----------------//

  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=mA_flow_nominal,
    V=1.2*V,
    nPorts=1)
    annotation (Placement(transformation(extent={{140,150},{160,170}})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor theCon(G=20000/30)
    "Thermal conductance with the ambient"
    annotation (Placement(transformation(extent={{100,170},{120,190}})));

  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{100,200},{120,220}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=zonTheCap)
    "Heat capacity for furniture and walls"
    annotation (Placement(transformation(extent={{140,180},{160,200}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumW,
    m_flow_nominal=mRad_flow_nominal,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    Q_flow_nominal=Q_flow_nominal,
    T_a_nominal=TRadSup_nominal,
    T_b_nominal=TRadRet_nominal,
    TAir_nominal=TAir_nominal,
    dp_nominal=20000)            "Radiator"
    annotation (Placement(transformation(extent={{80,110},{100,130}})));

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

  Buildings.Fluid.Boilers.BoilerPolynomial boi(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=mBoi_flow_nominal1,
    dp_nominal=5000,
    Q_flow_nominal=boiCap1,
    T_nominal=TBoiSup_nominal,
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant,
    a=boiEff1,
    fue=Fluid.Data.Fuels.NaturalGasHigherHeatingValue(),
    UA=boiCap1/39.81)                                             "Boiler"
    annotation (Placement(transformation(extent={{90,-160},{70,-140}})));
//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

  Buildings.Fluid.Sources.Boundary_pT preSou(redeclare package Medium = MediumW,
      nPorts=1)
    "Source for pressure and to account for thermal expansion of water"
    annotation (Placement(transformation(extent={{260,-210},{240,-190}})));

//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//------------------------------------------------------------------------------//
//--- Weather data -------------------------------------------------------------//
//------------------------------------------------------------------------------//

  Fluid.Boilers.BoilerPolynomial           boi1(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=mBoi_flow_nominal2,
    dp_nominal=5000,
    Q_flow_nominal=boiCap2,
    T_nominal=TBoiSup_nominal,
    effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant,
    a=boiEff2,
    fue=Buildings.Fluid.Data.Fuels.HeatingOilLowerHeatingValue(),
    UA=boiCap2/39.81)             "Boiler"
    annotation (Placement(transformation(extent={{90,-220},{70,-200}})));
  Fluid.Movers.SpeedControlled_y pum(
    redeclare package Medium = Media.Water,
    allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.customPumpCurves per,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    riseTime=120)           "Hot water primary pump-1"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,
        origin={-70,-70})));
  Fluid.FixedResistances.Junction           spl1(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mBoi_flow_nominal2,-mRad_flow_nominal,mBoi_flow_nominal1},
    dp_nominal={0,0,-200}) "Splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-150})));
  Fluid.Movers.SpeedControlled_y pum1(redeclare package Medium = Media.Water,
    allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.customPumpCurves per,
    inputType=Buildings.Fluid.Types.InputType.Continuous,
    addPowerToMedium=false,
    riseTime=120)           "Hot water primary pump-2"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=90,
        origin={10,-70})));
  Fluid.FixedResistances.Junction           spl2(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mRad_flow_nominal,-mBoi_flow_nominal1,-mBoi_flow_nominal2},
    dp_nominal={0,0,-200}) "Splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,-100})));
  Fluid.FixedResistances.Junction           spl3(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mBoi_flow_nominal1,-mRad_flow_nominal,mBoi_flow_nominal2},
    dp_nominal={0,0,-200}) "Splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,0})));
  Fluid.FixedResistances.Junction           spl4(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mRad_flow_nominal,-mRad_flow_nominal,-mRad_flow_nominal},
    dp_nominal={0,0,-200}) "Splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-30,40})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dpValve_nominal=0.1) "Minimum flow bypass valve"
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  Fluid.FixedResistances.Junction           spl5(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mRad_flow_nominal,mRad_flow_nominal,-mRad_flow_nominal},
    dp_nominal={0,0,-200}) "Splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={210,40})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0003,
    dpValve_nominal=0.1) "Isolation valve for boiler-2"
    annotation (Placement(transformation(extent={{20,-220},{40,-200}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=0.0003,
    dpValve_nominal=0.1) "Isolation valve for boiler-1"
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
  Controls.OBC.CDL.Interfaces.BooleanInput uBoiSta[2] "Boiler status signal"
    annotation (Placement(transformation(extent={{-360,100},{-320,140}}),
        iconTransformation(extent={{-140,40},{-100,80}})));
  Controls.OBC.CDL.Interfaces.RealInput uHotIsoVal[2]
    "Hot water isolation valve signal" annotation (Placement(transformation(
          extent={{-360,60},{-320,100}}),  iconTransformation(extent={{-140,10},
            {-100,50}})));
  Controls.OBC.CDL.Interfaces.RealInput uPumSpe[2] "Pump speed signal"
    annotation (Placement(transformation(extent={{-360,-20},{-320,20}}),
        iconTransformation(extent={{-140,-50},{-100,-10}})));
  Controls.OBC.CDL.Interfaces.BooleanInput uPumSta[2] "Pump status signal"
    annotation (Placement(transformation(extent={{-360,20},{-320,60}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea[2]
    "Boolean to Real conversion"
    annotation (Placement(transformation(extent={{-300,30},{-280,50}})));
  Controls.OBC.CDL.Continuous.Product pro[2] "Element-wise product"
    annotation (Placement(transformation(extent={{-240,10},{-220,30}})));
  Controls.OBC.CDL.Interfaces.RealInput uBypValSig "Bypass valve signal"
    annotation (Placement(transformation(extent={{-360,-60},{-320,-20}}),
        iconTransformation(extent={{-140,-80},{-100,-40}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[2]
    "Boolean to Real conversion"
    annotation (Placement(transformation(extent={{-300,110},{-280,130}})));
  Controls.OBC.CDL.Interfaces.RealInput QRooInt_flowrate
    "Room internal load flowrate" annotation (Placement(transformation(extent={{-360,
            190},{-320,230}}),      iconTransformation(extent={{-140,70},{-100,
            110}})));
  Fluid.FixedResistances.Junction           spl6(
    redeclare package Medium = MediumW,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal={mRad_flow_nominal,-mBoi_flow_nominal1,-mBoi_flow_nominal2},
    dp_nominal={0,0,-200}) "Splitter" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={140,-150})));

  Fluid.Sensors.Temperature zonTem(redeclare package Medium = Media.Air)
    annotation (Placement(transformation(extent={{40,150},{60,170}})));
  Controls.OBC.CDL.Interfaces.RealOutput yZonTem(final unit="K", displayUnit=
        "degC") "Measured zone temperature" annotation (Placement(
        transformation(extent={{320,120},{360,160}}),iconTransformation(extent=
            {{100,60},{140,100}})));
  Controls.OBC.CDL.Interfaces.RealOutput ySupTem(final unit="K", displayUnit=
        "degC") "Measured supply temperature" annotation (Placement(
        transformation(extent={{320,80},{360,120}}),  iconTransformation(extent=
           {{100,20},{140,60}})));
  Controls.OBC.CDL.Interfaces.RealOutput yRetTem(final unit="K", displayUnit=
        "degC") "Measured return temperature" annotation (Placement(
        transformation(extent={{320,20},{360,60}}),    iconTransformation(
          extent={{100,-20},{140,20}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage val3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal,
    dpValve_nominal=0.1) "Isolation valve for radiator"
    annotation (Placement(transformation(extent={{20,110},{40,130}})));
  Controls.OBC.CDL.Interfaces.RealInput uRadIsoVal
    "Radiator isolation valve signal" annotation (Placement(transformation(
          extent={{-360,150},{-320,190}}),
                                         iconTransformation(extent={{-140,-110},
            {-100,-70}})));
  Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium =
        Media.Water)
    "Differential pressure sensor between hot water supply and return"
    annotation (Placement(transformation(extent={{80,70},{100,90}})));
  Controls.OBC.CDL.Interfaces.RealOutput yHotWatDp[1](final unit="Pa",
      displayUnit="Pa")
    "Hot water differential pressure between supply and return" annotation (
      Placement(transformation(extent={{320,-20},{360,20}}),
        iconTransformation(extent={{100,-60},{140,-20}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = Media.Water,
      m_flow_nominal=mRad_flow_nominal)
    "Volume flow-rate through primary circuit"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Controls.OBC.CDL.Interfaces.RealOutput VHotWat_flow(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate") "Measured flowrate in primary circuit"
    annotation (Placement(transformation(extent={{320,-50},{360,-10}}),
        iconTransformation(extent={{100,-100},{140,-60}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature TOut
    "Outside temperature"
    annotation (Placement(transformation(extent={{-280,-90},{-260,-70}})));
  Controls.OBC.CDL.Interfaces.RealInput TOutAir(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature")
    "Measured outdoor air temperature" annotation (Placement(transformation(
          extent={{-360,-100},{-320,-60}}),  iconTransformation(extent={{-140,
            70},{-100,110}}, rotation=90)));
  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium =
        Media.Water, m_flow_nominal=1000*0.0006)
    annotation (Placement(transformation(extent={{-20,110},{0,130}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium =
        Media.Water, m_flow_nominal=1000*0.0006)
    annotation (Placement(transformation(extent={{160,110},{180,130}})));
  Controls.OBC.CDL.Routing.RealReplicator reaRep(nout=1)
    annotation (Placement(transformation(extent={{260,-10},{280,10}})));
  Fluid.FixedResistances.CheckValve cheVal(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal/2,
    dpValve_nominal=1)
    "Check valve to prevent reverse-flow through disabled pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-70,-40})));
  Fluid.FixedResistances.CheckValve cheVal1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=mRad_flow_nominal/2,
    dpValve_nominal=1)
    "Check valve to prevent reverse-flow through disabled pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={10,-40})));
  Fluid.Sensors.RelativePressure senRelPre1(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-88,-40})));
  Fluid.Sensors.RelativePressure senRelPre2(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={40,-40})));
equation
  connect(theCon.port_b, vol.heatPort) annotation (Line(
      points={{120,180},{130,180},{130,160},{140,160}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(preHea.port, vol.heatPort) annotation (Line(
      points={{120,210},{130,210},{130,160},{140,160}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(heaCap.port, vol.heatPort) annotation (Line(
      points={{150,180},{130,180},{130,160},{140,160}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(rad.heatPortCon, vol.heatPort) annotation (Line(
      points={{88,127.2},{88,160},{140,160}},
      color={191,0,0},
      smooth=Smooth.None));
  connect(rad.heatPortRad, vol.heatPort) annotation (Line(
      points={{92,127.2},{92,160},{140,160}},
      color={191,0,0},
      smooth=Smooth.None));

  connect(spl1.port_2, spl2.port_1)
    annotation (Line(points={{-30,-140},{-30,-110}},   color={0,127,255}));
  connect(spl4.port_3, val.port_a)
    annotation (Line(points={{-20,40},{80,40}},     color={0,127,255}));
  connect(val.port_b, spl5.port_3)
    annotation (Line(points={{100,40},{200,40}},  color={0,127,255}));
  connect(val2.port_b, boi.port_b)
    annotation (Line(points={{40,-150},{70,-150}},   color={0,127,255}));
  connect(val1.port_b, boi1.port_b)
    annotation (Line(points={{40,-210},{70,-210}},   color={0,127,255}));
  connect(val2.port_a, spl1.port_3)
    annotation (Line(points={{20,-150},{-20,-150}},   color={0,127,255}));
  connect(val1.port_a, spl1.port_1) annotation (Line(points={{20,-210},{-30,-210},
          {-30,-160}},        color={0,127,255}));
  connect(uPumSta, booToRea.u)
    annotation (Line(points={{-340,40},{-302,40}},   color={255,0,255}));
  connect(booToRea.y, pro.u1) annotation (Line(points={{-278,40},{-260,40},{-260,
          26},{-242,26}},          color={0,0,127}));
  connect(uPumSpe, pro.u2) annotation (Line(points={{-340,0},{-260,0},{-260,14},
          {-242,14}},              color={0,0,127}));
  connect(pro[1].y, pum.y) annotation (Line(points={{-218,20},{-100,20},{-100,-70},
          {-82,-70}},              color={0,0,127}));
  connect(pro[2].y, pum1.y) annotation (Line(points={{-218,20},{-100,20},{-100,-16},
          {-20,-16},{-20,-70},{-2,-70}},                  color={0,0,127}));
  connect(uBypValSig, val.y) annotation (Line(points={{-340,-40},{-120,-40},{-120,
          60},{90,60},{90,52}},       color={0,0,127}));
  connect(uHotIsoVal[1], val1.y) annotation (Line(points={{-340,70},{-340,80},{-140,
          80},{-140,-190},{30,-190},{30,-198}},          color={0,0,127}));
  connect(uHotIsoVal[2], val2.y) annotation (Line(points={{-340,90},{-340,80},{-140,
          80},{-140,-130},{30,-130},{30,-138}},          color={0,0,127}));
  connect(uBoiSta, booToRea1.u)
    annotation (Line(points={{-340,120},{-302,120}}, color={255,0,255}));
  connect(booToRea1[1].y, boi1.y) annotation (Line(points={{-278,120},{-160,120},
          {-160,-180},{110,-180},{110,-202},{92,-202}},
                                                      color={0,0,127}));
  connect(booToRea1[2].y, boi.y) annotation (Line(points={{-278,120},{-160,120},
          {-160,-120},{110,-120},{110,-142},{92,-142}},
                                                      color={0,0,127}));
  connect(QRooInt_flowrate, preHea.Q_flow)
    annotation (Line(points={{-340,210},{100,210}},
                                                 color={0,0,127}));
  connect(spl6.port_1, boi.port_a)
    annotation (Line(points={{130,-150},{90,-150}},color={0,127,255}));
  connect(spl6.port_3, boi1.port_a) annotation (Line(points={{140,-160},{140,-210},
          {90,-210}}, color={0,127,255}));
  connect(zonTem.port, vol.ports[1]) annotation (Line(points={{50,150},{50,144},
          {150,144},{150,150}},
                            color={0,127,255}));
  connect(zonTem.T, yZonTem) annotation (Line(points={{57,160},{60,160},{60,140},
          {340,140}},color={0,0,127}));
  connect(val3.port_b, rad.port_a)
    annotation (Line(points={{40,120},{80,120}},   color={0,127,255}));
  connect(uRadIsoVal, val3.y)
    annotation (Line(points={{-340,170},{30,170},{30,132}},
                                                          color={0,0,127}));
  connect(spl4.port_2, senRelPre.port_a) annotation (Line(points={{-30,50},{-30,
          80},{80,80}},    color={0,127,255}));
  connect(senRelPre.port_b, spl5.port_1) annotation (Line(points={{100,80},{210,
          80},{210,50}},   color={0,127,255}));
  connect(spl3.port_2, senVolFlo.port_a) annotation (Line(points={{-30,10},{-30,
          16},{30,16},{30,0},{40,0}},              color={0,127,255}));
  connect(senVolFlo.port_b, spl4.port_1) annotation (Line(points={{60,0},{70,0},
          {70,22},{-30,22},{-30,30}},                color={0,127,255}));
  connect(senVolFlo.V_flow, VHotWat_flow) annotation (Line(points={{50,11},{50,16},
          {80,16},{80,-30},{340,-30}},             color={0,0,127}));
  connect(spl6.port_2, spl5.port_2) annotation (Line(points={{150,-150},{210,-150},
          {210,30}},   color={0,127,255}));
  connect(spl6.port_2, preSou.ports[1]) annotation (Line(points={{150,-150},{210,
          -150},{210,-200},{240,-200}}, color={0,127,255}));
  connect(TOutAir, TOut.T)
    annotation (Line(points={{-340,-80},{-282,-80}},   color={0,0,127}));
  connect(TOut.port, theCon.port_a) annotation (Line(points={{-260,-80},{-180,-80},
          {-180,180},{100,180}},
                              color={191,0,0}));
  connect(senTem.port_b, val3.port_a)
    annotation (Line(points={{0,120},{20,120}},    color={0,127,255}));
  connect(spl4.port_2, senTem.port_a) annotation (Line(points={{-30,50},{-30,120},
          {-20,120}},       color={0,127,255}));
  connect(senTem.T, ySupTem) annotation (Line(points={{-10,131},{-10,140},{10,
          140},{10,100},{340,100}},                 color={0,0,127}));
  connect(rad.port_b, senTem1.port_a)
    annotation (Line(points={{100,120},{160,120}},
                                                 color={0,127,255}));
  connect(senTem1.port_b, spl5.port_1) annotation (Line(points={{180,120},{210,120},
          {210,50}},       color={0,127,255}));
  connect(senTem1.T, yRetTem) annotation (Line(points={{170,131},{170,150},{280,
          150},{280,40},{340,40}},
                                color={0,0,127}));
  connect(reaRep.y, yHotWatDp)
    annotation (Line(points={{282,0},{340,0}},       color={0,0,127}));
  connect(senRelPre.p_rel, reaRep.u) annotation (Line(points={{90,71},{90,64},{240,
          64},{240,0},{258,0}},             color={0,0,127}));
  connect(pum.port_b, cheVal.port_a)
    annotation (Line(points={{-70,-60},{-70,-50}},
                                                 color={0,127,255}));
  connect(cheVal.port_b, spl3.port_1) annotation (Line(points={{-70,-30},{-70,
          -20},{-30,-20},{-30,-10}},
                                color={0,127,255}));
  connect(spl2.port_2, pum.port_a) annotation (Line(points={{-30,-90},{-30,-86},
          {-70,-86},{-70,-80}}, color={0,127,255}));
  connect(pum1.port_b, cheVal1.port_a)
    annotation (Line(points={{10,-60},{10,-50}}, color={0,127,255}));
  connect(cheVal1.port_b, spl3.port_3)
    annotation (Line(points={{10,-30},{10,0},{-20,0}}, color={0,127,255}));
  connect(spl2.port_3, pum1.port_a) annotation (Line(points={{-20,-100},{10,
          -100},{10,-80}}, color={0,127,255}));
  connect(senRelPre1.port_a, cheVal.port_a)
    annotation (Line(points={{-88,-50},{-70,-50}}, color={0,127,255}));
  connect(senRelPre1.port_b, cheVal.port_b)
    annotation (Line(points={{-88,-30},{-70,-30}}, color={0,127,255}));
  connect(cheVal1.port_b, senRelPre2.port_b)
    annotation (Line(points={{10,-30},{40,-30}}, color={0,127,255}));
  connect(cheVal1.port_a, senRelPre2.port_a)
    annotation (Line(points={{10,-50},{40,-50}}, color={0,127,255}));
  annotation (Documentation(info="<html>
<p>
This part of the system model adds to the model that is implemented in
<a href=\"modelica://Buildings.Examples.Tutorial.Boiler.System5\">
Buildings.Examples.Tutorial.Boiler.System5</a>
weather data, and it changes the control to PI control.
</p>
<h4>Implementation</h4>
<p>
This model was built as follows:
</p>
<ol>
<li>
<p>
First, we copied the model
<a href=\"modelica://Buildings.Examples.Tutorial.Boiler.System5\">
Buildings.Examples.Tutorial.Boiler.System5</a>
and called it
<code>Buildings.Examples.Tutorial.Boiler.System6</code>.
</p>
</li>
<li>
<p>
Next, we added the weather data as shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/Boiler/System6Weather.png\" border=\"1\"/>
</p>
<p>
The weather data reader is implemented using
</p>
<pre>
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=\"modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos\")
    \"Weather data reader\";
</pre>
<p>
The yellow icon in the middle of the figure is an instance of
<a href=\"modelica://Buildings.BoundaryConditions.WeatherData.Bus\">
Buildings.BoundaryConditions.WeatherData.Bus</a>.
This is required to extract the dry bulb temperature from the weather data bus.
</p>
<p>
Note that we changed the instance <code>TOut</code> from
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.FixedTemperature\">
Modelica.Thermal.HeatTransfer.Sources.FixedTemperature</a>
to
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature\">
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature</a>
in order to use the dry-bulb temperature as an input signal.
</p>
</li>
</ol>
<!-- ============================================== -->
<p>
This completes the closed loop control.
When simulating the model
for <i>2</i> days, or <i>172800</i> seconds, the
response shown below should be seen.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/Boiler/System6Temperatures1.png\" border=\"1\"/>
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/Boiler/System6Temperatures2.png\" border=\"1\"/>
</p>
<p>
The figure shows that the boiler temperature is regulated between
<i>70</i>&deg;C and
<i>90</i>&deg;C,
that
the boiler inlet temperature is above
<i>60</i>&deg;C,
and that the room temperature and the supply water temperature are
maintained at their set point.
</p>
</html>", revisions="<html>
<ul>
<li>
March 6, 2017, by Michael Wetter:<br/>
Added missing density to computation of air mass flow rate.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/673\">#673</a>.
</li>
<li>
July 2, 2015, by Michael Wetter:<br/>
Changed control input for <code>conPIDBoi</code> and set
<code>reverseActing=false</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/436\">#436</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
March 1, 2013, by Michael Wetter:<br/>
Added nominal pressure drop for valves as
this parameter no longer has a default value.
</li>
<li>
January 27, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-320,-240},{320,
            240}})),
    __Dymola_Commands(file=
     "modelica://Buildings/Resources/Scripts/Dymola/Examples/Tutorial/Boiler/System6.mos"
        "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=172800),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end BoilerPlant;