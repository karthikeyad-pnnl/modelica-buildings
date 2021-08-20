within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed;
block TestBed

  replaceable package MediumA = Buildings.Media.Air "Medium model";
  replaceable package MediumW = Buildings.Media.Water "Medium model";
  ThermalZones.Detailed.MixedAir roo2(
    redeclare package Medium = MediumA,
    AFlo=6*4,
    hRoo=2.7,
    nConExt=0,
    nConExtWin=2,
    datConExtWin(
      layers={matLayExt,matLayExt},
      A={4*3,6*3},
      glaSys={glaSys,glaSys},
      wWin={2,2},
      each hWin=2,
      each fFra=0.1,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.S}),
    nConPar=2,
    datConPar(
      layers={matLayFlo,matLayPar},
      A={6*4,6*3/2},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.N}),
    nConBou=0,
    nSurBou=1,
    surBou(
      each A=4*3,
      each absIR=0.9,
      each absSol=0.9,
      each til=Buildings.Types.Tilt.Wall),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    linearizeRadiation=true,
    lat=0.73268921998722,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    nPorts=2)
    "Room model"
    annotation (Placement(transformation(extent={{220,76},{260,116}})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2           rad2(
    redeclare package Medium = MediumW,
    Q_flow_nominal=scaFacRad*Q_flow_nominal/nRoo,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a_nominal=323.15,
    T_b_nominal=313.15) "Radiator"
    annotation (Placement(transformation(extent={{230,40},{250,60}})));
  Fluid.Movers.SpeedControlled_y pum "Chilled water pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={180,-130})));
  ThermalZones.Detailed.MixedAir roo1(
    redeclare package Medium = MediumA,
    AFlo=6*4,
    hRoo=2.7,
    nConExt=0,
    nConExtWin=2,
    datConExtWin(
      layers={matLayExt,matLayExt},
      A={4*3,6*3},
      glaSys={glaSys,glaSys},
      wWin={2,2},
      each hWin=2,
      each fFra=0.1,
      til={Buildings.Types.Tilt.Wall,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.E,Buildings.Types.Azimuth.S}),
    nConPar=2,
    datConPar(
      layers={matLayFlo,matLayPar},
      A={6*4,6*3/2},
      til={Buildings.Types.Tilt.Floor,Buildings.Types.Tilt.Wall},
      azi={Buildings.Types.Azimuth.N,Buildings.Types.Azimuth.N}),
    nConBou=0,
    nSurBou=1,
    surBou(
      each A=4*3,
      each absIR=0.9,
      each absSol=0.9,
      each til=Buildings.Types.Tilt.Wall),
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    linearizeRadiation=true,
    lat=0.73268921998722,
    extConMod=Buildings.HeatTransfer.Types.ExteriorConvection.Fixed,
    nPorts=2)
    "Room model"
    annotation (Placement(transformation(extent={{220,-14},{260,26}})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2           rad1(
    redeclare package Medium = MediumW,
    Q_flow_nominal=scaFacRad*Q_flow_nominal/nRoo,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a_nominal=323.15,
    T_b_nominal=313.15) "Radiator"
    annotation (Placement(transformation(extent={{230,-50},{250,-30}})));
  Fluid.FixedResistances.Junction jun
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = 90,
        origin={180,-40})));
  Fluid.FixedResistances.Junction jun1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = 90,
        origin={180,50})));
  Fluid.FixedResistances.Junction jun2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = -90,
        origin={290,50})));
  Fluid.FixedResistances.Junction jun3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = -90,
        origin={290,-40})));
  Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{200,-50},{220,-30}})));
  Fluid.Actuators.Valves.TwoWayLinear val1
    annotation (Placement(transformation(extent={{200,40},{220,60}})));
  Fluid.Actuators.Valves.TwoWayLinear val2
    annotation (Placement(transformation(extent={{230,130},{250,150}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-310,-20},{-290,0}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-280,-20},{-260,0}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  Fluid.Sources.Outside           amb(redeclare package Medium = MediumA,
      nPorts=3) "Ambient conditions"
    annotation (Placement(transformation(extent={{-250,-20},{-228,2}})));
  Fluid.HeatExchangers.WetCoilCounterFlow           cooCoi(
    show_T=true,
    UA_nominal=3*m_flow_nominal*1000*15/
        Buildings.Fluid.HeatExchangers.BaseClasses.lmtd(
        T_a1=26.2,
        T_b1=12.8,
        T_a2=6,
        T_b2=16),
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=m_flow_nominal*1000*15/4200/10,
    m2_flow_nominal=m_flow_nominal,
    dp2_nominal=0,
    dp1_nominal=0,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    allowFlowReversal1=false,
    allowFlowReversal2=allowFlowReversal) "Cooling coil"
    annotation (Placement(transformation(extent={{-110,4},{-130,-16}})));
  Fluid.Sources.Boundary_pT           sinHea(
    redeclare package Medium = MediumW,
    p=100000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-210,-70})));
  Fluid.Sources.Boundary_pT           sinCoo(
    redeclare package Medium = MediumW,
    p=100000,
    T=285.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-140,-70})));
  Fluid.Sources.MassFlowSource_T           souCoo(
    redeclare package Medium = MediumW,
    T=279.15,
    nPorts=1,
    use_m_flow_in=true) "Source for cooling coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-100,-70})));
  Fluid.Sources.MassFlowSource_T           souHea(
    redeclare package Medium = MediumW,
    T=318.15,
    use_m_flow_in=true,
    nPorts=1)           "Source for heating coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-170,-70})));
  Fluid.HeatExchangers.DryCoilEffectivenessNTU           heaCoi(
    show_T=true,
    redeclare package Medium1 = MediumW,
    redeclare package Medium2 = MediumA,
    m1_flow_nominal=m_flow_nominal*1000*(10 - (-20))/4200/10,
    m2_flow_nominal=m_flow_nominal,
    configuration=Buildings.Fluid.Types.HeatExchangerConfiguration.CounterFlow,
    Q_flow_nominal=m_flow_nominal*1006*(16.7 - 8.5),
    dp1_nominal=0,
    dp2_nominal=200 + 200 + 100 + 40,
    allowFlowReversal1=false,
    allowFlowReversal2=allowFlowReversal,
    T_a1_nominal=318.15,
    T_a2_nominal=281.65) "Heating coil"
    annotation (Placement(transformation(extent={{-180,4},{-200,-16}})));

  Fluid.FixedResistances.Junction jun4
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Examples.VAVReheat.ThermalZones.VAVBranch           cor(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mCor_flow_nominal,
    VRoo=VRooCor,
    allowFlowReversal=allowFlowReversal)
    "Zone for core of buildings (azimuth will be neglected)"
    annotation (Placement(transformation(extent={{100,80},{140,120}})));
  Examples.VAVReheat.ThermalZones.VAVBranch           cor1(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mCor_flow_nominal,
    VRoo=VRooCor,
    allowFlowReversal=allowFlowReversal)
    "Zone for core of buildings (azimuth will be neglected)"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Fluid.FixedResistances.Junction jun5
    annotation (Placement(transformation(extent={{150,150},{170,170}})));
  Fluid.Sources.Boundary_pT           sinCoo1(
    redeclare package Medium = MediumW,
    p=100000,
    T=285.15,
    nPorts=2) "Sink for chillede water"
                                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={290,-170})));
  Fluid.Sources.Boundary_pT           souCoo1(
    redeclare package Medium = MediumW,
    p=100000,
    use_T_in=true,
    T=285.15,
    nPorts=1) "Source for chilled water to chilled beam manifolds"
                                      annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={180,-170})));
  Fluid.Sensors.TemperatureTwoPort senTem
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Fluid.Movers.SpeedControlled_y fan "DOAS fan" annotation (Placement(
        transformation(
        extent={{-80,-10},{-60,10}})));
  Fluid.Sensors.RelativePressure senRelPre(redeclare package Medium = MediumW)
    annotation (Placement(transformation(extent={{230,-80},{250,-60}})));
  Fluid.Sensors.RelativePressure senRelPre1(redeclare package Medium = MediumW)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-50,30})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor
    annotation (Placement(transformation(extent={{260,150},{280,170}})));
  Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor temperatureSensor1
    annotation (Placement(transformation(extent={{260,20},{280,40}})));
  Modelica.Blocks.Routing.Multiplex mux(n=2)
    annotation (Placement(transformation(extent={{300,150},{320,170}})));
  Modelica.Blocks.Routing.DeMultiplex demux(n=2)
    annotation (Placement(transformation(extent={{-320,130},{-300,150}})));
  CDL.Interfaces.RealOutput TZon[2] "Measured zone temperature"
    annotation (Placement(transformation(extent={{340,140},{380,180}})));
  CDL.Interfaces.RealOutput dPChiWat
    "Measured chilled water differential presure"
    annotation (Placement(transformation(extent={{340,-110},{380,-70}})));
  CDL.Interfaces.BooleanOutput yPumSta "Pump proven on"
    annotation (Placement(transformation(extent={{340,-140},{380,-100}})));
  CDL.Continuous.Hysteresis hys(uLow=0.04, uHigh=0.05)
    annotation (Placement(transformation(extent={{220,-120},{240,-100}})));
  CDL.Interfaces.BooleanInput uPumSta "Pump enable signal"
    annotation (Placement(transformation(extent={{-380,-130},{-340,-90}})));
  CDL.Interfaces.RealInput uPumSpe "Pump speed signal"
    annotation (Placement(transformation(extent={{-380,-160},{-340,-120}})));
  CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-320,-120},{-300,-100}})));
  CDL.Continuous.Product pro
    annotation (Placement(transformation(extent={{-280,-140},{-260,-120}})));
  CDL.Interfaces.RealInput TChiWatSup "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-380,-200},{-340,-160}})));
  CDL.Interfaces.RealInput uHeaCoi "Heating coil control signal"
    annotation (Placement(transformation(extent={{-380,-70},{-340,-30}})));
  CDL.Interfaces.RealInput uCooCoi "AHU cooling coil control signal"
    annotation (Placement(transformation(extent={{-380,-100},{-340,-60}})));
  CDL.Continuous.Gain gai(k=mHotWatCoi_nominal)
    annotation (Placement(transformation(extent={{-320,-60},{-300,-40}})));
  CDL.Continuous.Gain gai1(k=mChiWatCoi_nominal)
    annotation (Placement(transformation(extent={{-320,-90},{-300,-70}})));
  CDL.Interfaces.RealInput uCAVDam[2] "CAV damper signal"
    annotation (Placement(transformation(extent={{-380,90},{-340,130}})));
  CDL.Interfaces.RealInput uCAVReh[2] "CAV reheat signal"
    annotation (Placement(transformation(extent={{-380,50},{-340,90}})));
  CDL.Interfaces.RealInput uBypValPos "Bypass valve position signal"
    annotation (Placement(transformation(extent={{-380,150},{-340,190}})));
  CDL.Interfaces.RealInput uChiWatVal[2] "Chilled water valve position signal"
    annotation (Placement(transformation(extent={{-380,120},{-340,160}})));
  CDL.Interfaces.RealOutput dPDOASAir "Measured airloop differential presure"
    annotation (Placement(transformation(extent={{340,-40},{380,0}})));
  CDL.Interfaces.RealOutput TDOASDis "Measured DOAS discharge air temperature"
    annotation (Placement(transformation(extent={{340,-170},{380,-130}})));
  CDL.Interfaces.RealOutput yChiWatVal[2]
    "Measured chilled water valve position"
    annotation (Placement(transformation(extent={{340,60},{380,100}})));
  CDL.Interfaces.RealOutput yBypValPos "Measured bypass valve position"
    annotation (Placement(transformation(extent={{340,100},{380,140}})));
  CDL.Interfaces.BooleanInput uFanSta "Supply fan enable signal"
    annotation (Placement(transformation(extent={{-380,20},{-340,60}})));
  CDL.Interfaces.RealInput uFanSpe "Fan speed signal"
    annotation (Placement(transformation(extent={{-380,-10},{-340,30}})));
  CDL.Conversions.BooleanToReal booToRea1
    annotation (Placement(transformation(extent={{-320,30},{-300,50}})));
  CDL.Continuous.Product pro1
    annotation (Placement(transformation(extent={{-280,10},{-260,30}})));
  CDL.Interfaces.BooleanOutput yFanSta "Supply fan proven on"
    annotation (Placement(transformation(extent={{340,-70},{380,-30}})));
  CDL.Continuous.Hysteresis hys1(uLow=0.04, uHigh=0.05)
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));
  Modelica.Blocks.Routing.Multiplex mux1(n=2)
    annotation (Placement(transformation(extent={{310,70},{330,90}})));
  Modelica.Blocks.Routing.DeMultiplex demux1(n=2)
    annotation (Placement(transformation(extent={{-320,100},{-300,120}})));
  Modelica.Blocks.Routing.DeMultiplex demux2(n=2)
    annotation (Placement(transformation(extent={{-280,60},{-260,80}})));
equation
  connect(rad2.heatPortCon, roo2.heaPorRad) annotation (Line(points={{238,57.2},
          {238,66},{240,66},{240,92.2},{239,92.2}},
                                             color={191,0,0}));
  connect(rad2.heatPortRad, roo2.heaPorRad) annotation (Line(points={{242,57.2},
          {242,66},{240,66},{240,92.2},{239,92.2}},
                                          color={191,0,0}));
  connect(rad1.heatPortCon,roo1. heaPorRad) annotation (Line(points={{238,-32.8},
          {238,-26},{240,-26},{240,2.2},{239,2.2}},
                                             color={191,0,0}));
  connect(rad1.heatPortRad,roo1. heaPorRad) annotation (Line(points={{242,-32.8},
          {242,-26},{240,-26},{240,2.2},{239,2.2}},
                                          color={191,0,0}));
  connect(jun.port_1,pum. port_b) annotation (Line(points={{180,-50},{180,-120}},
                               color={0,127,255}));
  connect(jun2.port_2, jun3.port_1)
    annotation (Line(points={{290,40},{290,-30}},      color={0,127,255}));
  connect(jun.port_2, jun1.port_1)
    annotation (Line(points={{180,-30},{180,40}},   color={0,127,255}));
  connect(val.port_b, rad1.port_a)
    annotation (Line(points={{220,-40},{230,-40}}, color={0,127,255}));
  connect(jun.port_3, val.port_a)
    annotation (Line(points={{190,-40},{200,-40}},   color={0,127,255}));
  connect(val1.port_b, rad2.port_a)
    annotation (Line(points={{220,50},{230,50}}, color={0,127,255}));
  connect(jun1.port_3, val1.port_a)
    annotation (Line(points={{190,50},{200,50}},   color={0,127,255}));
  connect(rad1.port_b, jun3.port_3)
    annotation (Line(points={{250,-40},{280,-40}}, color={0,127,255}));
  connect(rad2.port_b, jun2.port_3)
    annotation (Line(points={{250,50},{280,50}}, color={0,127,255}));
  connect(jun1.port_2, val2.port_a) annotation (Line(points={{180,60},{180,140},
          {230,140}}, color={0,127,255}));
  connect(val2.port_b, jun2.port_1) annotation (Line(points={{250,140},{290,140},
          {290,60}}, color={0,127,255}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-290,-10},{-270,-10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, amb.weaBus) annotation (Line(
      points={{-270,-10},{-260,-10},{-260,-8.78},{-250,-8.78}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cooCoi.port_b1,sinCoo. ports[1]) annotation (Line(
      points={{-130,-12},{-140,-12},{-140,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(cooCoi.port_a1,souCoo. ports[1]) annotation (Line(
      points={{-110,-12},{-100,-12},{-100,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(heaCoi.port_b2,cooCoi. port_a2) annotation (Line(
      points={{-180,0},{-130,0}},
      color={0,127,255},
      thickness=0.5));
  connect(souHea.ports[1],heaCoi. port_a1) annotation (Line(
      points={{-170,-60},{-170,-12},{-180,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(heaCoi.port_b1,sinHea. ports[1]) annotation (Line(
      points={{-200,-12},{-210,-12},{-210,-60}},
      color={28,108,200},
      thickness=0.5));
  connect(amb.ports[1], heaCoi.port_a2) annotation (Line(points={{-228,-6.06667},
          {-206,-6.06667},{-206,0},{-200,0}},
                                 color={0,127,255}));
  connect(jun4.port_2, cor.port_a)
    annotation (Line(points={{40,0},{60,0},{60,34},{110,34},{110,80}},
                                             color={0,127,255}));
  connect(cor.port_b, roo2.ports[1]) annotation (Line(points={{110,120},{110,
          134},{190,134},{190,84},{225,84}},
                                 color={0,127,255}));
  connect(jun4.port_3, cor1.port_a) annotation (Line(points={{30,-10},{30,-30},{
          110,-30},{110,-20}},     color={0,127,255}));
  connect(cor1.port_b, roo1.ports[1]) annotation (Line(points={{110,20},{110,30},
          {150,30},{150,-6},{225,-6}},  color={0,127,255}));
  connect(jun5.port_2, roo2.ports[2]) annotation (Line(points={{170,160},{200,
          160},{200,88},{225,88}}, color={0,127,255}));
  connect(jun5.port_3, roo1.ports[2])
    annotation (Line(points={{160,150},{160,-2},{225,-2}}, color={0,127,255}));
  connect(jun5.port_1, amb.ports[2]) annotation (Line(points={{150,160},{-210,
          160},{-210,-9},{-228,-9}},     color={0,127,255}));
  connect(souCoo1.ports[1], pum.port_a)
    annotation (Line(points={{180,-160},{180,-140}}, color={0,127,255}));
  connect(jun3.port_2, sinCoo1.ports[1])
    annotation (Line(points={{290,-50},{290,-106},{290,-160},{288,-160}},
                                                    color={0,127,255}));
  connect(roo2.surf_surBou, roo1.surf_surBou) annotation (Line(points={{236.2,
          82},{236,82},{236,74},{196,74},{196,-10},{236.2,-10},{236.2,-8}},
                                                                         color={
          191,0,0}));
  connect(senTem.port_b, jun4.port_1)
    annotation (Line(points={{-20,0},{20,0}},         color={0,127,255}));
  connect(fan.port_b, senTem.port_a)
    annotation (Line(points={{-60,0},{-40,0}}, color={0,127,255}));
  connect(cooCoi.port_b2, fan.port_a)
    annotation (Line(points={{-110,0},{-80,0}}, color={0,127,255}));
  connect(senRelPre.port_a, pum.port_b) annotation (Line(points={{230,-70},{180,
          -70},{180,-120}},  color={0,127,255}));
  connect(senRelPre.port_b, sinCoo1.ports[2]) annotation (Line(points={{250,-70},
          {292,-70},{292,-160}},  color={0,127,255}));
  connect(fan.port_b, senRelPre1.port_a)
    annotation (Line(points={{-60,0},{-50,0},{-50,20}}, color={0,127,255}));
  connect(senRelPre1.port_b, amb.ports[3]) annotation (Line(points={{-50,40},{
          -50,60},{-212,60},{-212,-2},{-216,-2},{-216,-11.9333},{-228,-11.9333}},
        color={0,127,255}));
  connect(roo2.heaPorAir, temperatureSensor.port)
    annotation (Line(points={{239,96},{260,96},{260,160}}, color={191,0,0}));
  connect(roo1.heaPorAir, temperatureSensor1.port)
    annotation (Line(points={{239,6},{260,6},{260,30}}, color={191,0,0}));
  connect(temperatureSensor.T, mux.u[1]) annotation (Line(points={{280,160},{290,
          160},{290,163.5},{300,163.5}}, color={0,0,127}));
  connect(temperatureSensor1.T, mux.u[2]) annotation (Line(points={{280,30},{300,
          30},{300,148},{290,148},{290,156.5},{300,156.5}}, color={0,0,127}));
  connect(mux.y, TZon)
    annotation (Line(points={{321,160},{360,160}}, color={0,0,127}));
  connect(senRelPre.p_rel, dPChiWat)
    annotation (Line(points={{240,-79},{240,-90},{360,-90}}, color={0,0,127}));
  connect(pum.y_actual, hys.u) annotation (Line(points={{173,-119},{173,-110},{218,
          -110}}, color={0,0,127}));
  connect(hys.y, yPumSta) annotation (Line(points={{242,-110},{310,-110},{310,-120},
          {360,-120}}, color={255,0,255}));
  connect(uPumSta, booToRea.u)
    annotation (Line(points={{-360,-110},{-322,-110}}, color={255,0,255}));
  connect(booToRea.y, pro.u1) annotation (Line(points={{-298,-110},{-290,-110},{
          -290,-124},{-282,-124}}, color={0,0,127}));
  connect(uPumSpe, pro.u2) annotation (Line(points={{-360,-140},{-290,-140},{-290,
          -136},{-282,-136}}, color={0,0,127}));
  connect(pro.y, pum.y)
    annotation (Line(points={{-258,-130},{168,-130}}, color={0,0,127}));
  connect(TChiWatSup, souCoo1.T_in) annotation (Line(points={{-360,-180},{150,
          -180},{150,-194},{176,-194},{176,-182}}, color={0,0,127}));
  connect(uCooCoi, gai1.u)
    annotation (Line(points={{-360,-80},{-322,-80}}, color={0,0,127}));
  connect(gai1.y, souCoo.m_flow_in) annotation (Line(points={{-298,-80},{-270,
          -80},{-270,-110},{-108,-110},{-108,-82}}, color={0,0,127}));
  connect(uHeaCoi, gai.u)
    annotation (Line(points={{-360,-50},{-322,-50}}, color={0,0,127}));
  connect(gai.y, souHea.m_flow_in) annotation (Line(points={{-298,-50},{-260,
          -50},{-260,-92},{-178,-92},{-178,-82}}, color={0,0,127}));
  connect(uBypValPos, val2.y) annotation (Line(points={{-360,170},{140,170},{
          140,180},{240,180},{240,152}}, color={0,0,127}));
  connect(senRelPre1.p_rel, dPDOASAir) annotation (Line(points={{-41,30},{0,30},
          {0,-54},{308,-54},{308,-20},{360,-20}}, color={0,0,127}));
  connect(senTem.T, TDOASDis) annotation (Line(points={{-30,11},{-30,20},{-10,
          20},{-10,-150},{360,-150}}, color={0,0,127}));
  connect(val2.y_actual, yBypValPos) annotation (Line(points={{245,147},{280,
          147},{280,120},{360,120}}, color={0,0,127}));
  connect(uFanSta, booToRea1.u)
    annotation (Line(points={{-360,40},{-322,40}}, color={255,0,255}));
  connect(booToRea1.y, pro1.u1) annotation (Line(points={{-298,40},{-290,40},{
          -290,26},{-282,26}}, color={0,0,127}));
  connect(uFanSpe, pro1.u2) annotation (Line(points={{-360,10},{-300,10},{-300,
          14},{-282,14}}, color={0,0,127}));
  connect(pro1.y, fan.y)
    annotation (Line(points={{-258,20},{-70,20},{-70,12}}, color={0,0,127}));
  connect(fan.y_actual, hys1.u) annotation (Line(points={{-59,7},{-54,7},{-54,
          -60},{-42,-60}}, color={0,0,127}));
  connect(hys1.y, yFanSta) annotation (Line(points={{-18,-60},{320,-60},{320,
          -50},{360,-50}}, color={255,0,255}));
  connect(val1.y_actual, mux1.u[1]) annotation (Line(points={{215,57},{226,57},
          {226,70},{280,70},{280,83.5},{310,83.5}}, color={0,0,127}));
  connect(val.y_actual, mux1.u[2]) annotation (Line(points={{215,-33},{220,-33},
          {220,-20},{304,-20},{304,76.5},{310,76.5}}, color={0,0,127}));
  connect(mux1.y, yChiWatVal)
    annotation (Line(points={{331,80},{360,80}}, color={0,0,127}));
  connect(uChiWatVal, demux.u)
    annotation (Line(points={{-360,140},{-322,140}}, color={0,0,127}));
  connect(demux.y[1], val1.y) annotation (Line(points={{-300,143.5},{148,143.5},
          {148,80},{210,80},{210,62}}, color={0,0,127}));
  connect(demux.y[2], val.y) annotation (Line(points={{-300,136.5},{156,136.5},
          {156,-20},{210,-20},{210,-28}}, color={0,0,127}));
  connect(uCAVDam, demux1.u)
    annotation (Line(points={{-360,110},{-322,110}}, color={0,0,127}));
  connect(demux1.y[1], cor.yVAV) annotation (Line(points={{-300,113.5},{96,
          113.5},{96,108}}, color={0,0,127}));
  connect(demux1.y[2], cor1.yVAV) annotation (Line(points={{-300,106.5},{70,
          106.5},{70,8},{96,8}}, color={0,0,127}));
  connect(uCAVReh, demux2.u)
    annotation (Line(points={{-360,70},{-282,70}}, color={0,0,127}));
  connect(demux2.y[1], cor.yVal) annotation (Line(points={{-260,73.5},{-240,
          73.5},{-240,92},{96,92}}, color={0,0,127}));
  connect(demux2.y[2], cor1.yVal) annotation (Line(points={{-260,66.5},{80,66.5},
          {80,-8},{96,-8}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-340,-200},
            {340,200}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-200},{340,200}})));
end TestBed;
