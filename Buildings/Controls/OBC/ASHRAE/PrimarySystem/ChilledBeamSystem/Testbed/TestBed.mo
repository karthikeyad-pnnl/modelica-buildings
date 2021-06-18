within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed;
block TestBed
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
    annotation (Placement(transformation(extent={{160,66},{200,106}})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2           rad2(
    redeclare package Medium = MediumW,
    Q_flow_nominal=scaFacRad*Q_flow_nominal/nRoo,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a_nominal=323.15,
    T_b_nominal=313.15) "Radiator"
    annotation (Placement(transformation(extent={{170,30},{190,50}})));
  Fluid.Chillers.ElectricEIR chi
    annotation (Placement(transformation(extent={{170,-120},{190,-100}})));
  Fluid.Movers.SpeedControlled_y fan
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={120,-90})));
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
    annotation (Placement(transformation(extent={{160,-24},{200,16}})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2           rad1(
    redeclare package Medium = MediumW,
    Q_flow_nominal=scaFacRad*Q_flow_nominal/nRoo,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    T_a_nominal=323.15,
    T_b_nominal=313.15) "Radiator"
    annotation (Placement(transformation(extent={{170,-60},{190,-40}})));
  Fluid.FixedResistances.Junction jun
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = 90,
        origin={120,-50})));
  Fluid.FixedResistances.Junction jun1
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = 90,
        origin={120,40})));
  Fluid.FixedResistances.Junction jun2
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = -90,
        origin={240,40})));
  Fluid.FixedResistances.Junction jun3
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = -90,
        origin={240,-50})));
  Fluid.Actuators.Valves.TwoWayLinear val
    annotation (Placement(transformation(extent={{140,-60},{160,-40}})));
  Fluid.Actuators.Valves.TwoWayLinear val1
    annotation (Placement(transformation(extent={{140,30},{160,50}})));
  Fluid.Actuators.Valves.TwoWayLinear val2
    annotation (Placement(transformation(extent={{170,120},{190,140}})));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        Modelica.Utilities.Files.loadResource("modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"))
    annotation (Placement(transformation(extent={{-250,-10},{-230,10}})));
  BoundaryConditions.WeatherData.Bus weaBus "Weather Data Bus"
    annotation (Placement(transformation(extent={{-220,-10},{-200,10}}),
        iconTransformation(extent={{-360,170},{-340,190}})));
  Fluid.Sources.Outside           amb(redeclare package Medium = MediumA,
      nPorts=2) "Ambient conditions"
    annotation (Placement(transformation(extent={{-190,-10},{-168,12}})));
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
    annotation (Placement(transformation(extent={{-38,4},{-58,-16}})));
  Fluid.Sources.Boundary_pT           sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=318.15,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-168,-82})));
  Fluid.Sources.Boundary_pT           sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=285.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-68,-80})));
  Fluid.Sources.MassFlowSource_T           souCoo(
    redeclare package Medium = MediumW,
    T=279.15,
    nPorts=1,
    use_m_flow_in=true) "Source for cooling coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-18,-80})));
  Fluid.Sources.MassFlowSource_T           souHea(
    redeclare package Medium = MediumW,
    T=318.15,
    use_m_flow_in=true,
    nPorts=1)           "Source for heating coil" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-116,-80})));
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
    annotation (Placement(transformation(extent={{-130,4},{-150,-16}})));

  Fluid.FixedResistances.Junction jun4
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation = 90,
        origin={0,20})));
  Examples.VAVReheat.ThermalZones.VAVBranch           cor(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mCor_flow_nominal,
    VRoo=VRooCor,
    allowFlowReversal=allowFlowReversal)
    "Zone for core of buildings (azimuth will be neglected)"
    annotation (Placement(transformation(extent={{-10,40},{30,80}})));
  Examples.VAVReheat.ThermalZones.VAVBranch           cor1(
    redeclare package MediumA = MediumA,
    redeclare package MediumW = MediumW,
    m_flow_nominal=mCor_flow_nominal,
    VRoo=VRooCor,
    allowFlowReversal=allowFlowReversal)
    "Zone for core of buildings (azimuth will be neglected)"
    annotation (Placement(transformation(extent={{40,-20},{80,20}})));
  Fluid.FixedResistances.Junction jun5
    annotation (Placement(transformation(extent={{80,100},{100,120}})));
equation
  connect(rad2.heatPortCon, roo2.heaPorRad) annotation (Line(points={{178,47.2},
          {178,56},{180,56},{180,82.2},{179,82.2}},
                                             color={191,0,0}));
  connect(rad2.heatPortRad, roo2.heaPorRad) annotation (Line(points={{182,47.2},
          {182,56},{180,56},{180,82.2},{179,82.2}},
                                          color={191,0,0}));
  connect(fan.port_a, chi.port_b2) annotation (Line(points={{120,-100},{120,-116},
          {170,-116}},color={0,127,255}));
  connect(rad1.heatPortCon,roo1. heaPorRad) annotation (Line(points={{178,-42.8},
          {178,16},{180,16},{180,-7.8},{179,-7.8}},
                                             color={191,0,0}));
  connect(rad1.heatPortRad,roo1. heaPorRad) annotation (Line(points={{182,-42.8},
          {182,16},{180,16},{180,-7.8},{179,-7.8}},
                                          color={191,0,0}));
  connect(jun.port_1, fan.port_b) annotation (Line(points={{120,-60},{120,-80}},
                               color={0,127,255}));
  connect(jun2.port_2, jun3.port_1)
    annotation (Line(points={{240,30},{240,-40}},      color={0,127,255}));
  connect(jun.port_2, jun1.port_1)
    annotation (Line(points={{120,-40},{120,30}},   color={0,127,255}));
  connect(val.port_b, rad1.port_a)
    annotation (Line(points={{160,-50},{170,-50}}, color={0,127,255}));
  connect(jun.port_3, val.port_a)
    annotation (Line(points={{130,-50},{140,-50}},   color={0,127,255}));
  connect(val1.port_b, rad2.port_a)
    annotation (Line(points={{160,40},{170,40}}, color={0,127,255}));
  connect(jun1.port_3, val1.port_a)
    annotation (Line(points={{130,40},{140,40}},   color={0,127,255}));
  connect(rad1.port_b, jun3.port_3)
    annotation (Line(points={{190,-50},{230,-50}}, color={0,127,255}));
  connect(rad2.port_b, jun2.port_3)
    annotation (Line(points={{190,40},{230,40}}, color={0,127,255}));
  connect(jun1.port_2, val2.port_a) annotation (Line(points={{120,50},{120,130},
          {170,130}}, color={0,127,255}));
  connect(val2.port_b, jun2.port_1) annotation (Line(points={{190,130},{240,130},
          {240,50}}, color={0,127,255}));
  connect(chi.port_a2, jun3.port_2) annotation (Line(points={{190,-116},{240,-116},
          {240,-60}}, color={0,127,255}));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-230,0},{-210,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus, amb.weaBus) annotation (Line(
      points={{-210,0},{-200,0},{-200,1.22},{-190,1.22}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(cooCoi.port_b1,sinCoo. ports[1]) annotation (Line(
      points={{-58,-12},{-68,-12},{-68,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(cooCoi.port_a1,souCoo. ports[1]) annotation (Line(
      points={{-38,-12},{-18,-12},{-18,-70}},
      color={28,108,200},
      thickness=0.5));
  connect(heaCoi.port_b2,cooCoi. port_a2) annotation (Line(
      points={{-130,0},{-58,0}},
      color={0,127,255},
      thickness=0.5));
  connect(souHea.ports[1],heaCoi. port_a1) annotation (Line(
      points={{-116,-70},{-116,-12},{-130,-12}},
      color={28,108,200},
      thickness=0.5));
  connect(heaCoi.port_b1,sinHea. ports[1]) annotation (Line(
      points={{-150,-12},{-168,-12},{-168,-72}},
      color={28,108,200},
      thickness=0.5));
  connect(amb.ports[1], heaCoi.port_a2) annotation (Line(points={{-168,3.2},{
          -156,3.2},{-156,0},{-150,0}},
                                 color={0,127,255}));
  connect(cooCoi.port_b2, jun4.port_1)
    annotation (Line(points={{-38,0},{0,0},{0,10}}, color={0,127,255}));
  connect(jun4.port_2, cor.port_a)
    annotation (Line(points={{0,30},{0,40}}, color={0,127,255}));
  connect(cor.port_b, roo2.ports[1]) annotation (Line(points={{0,80},{0,90},{80,
          90},{80,74},{165,74}}, color={0,127,255}));
  connect(jun4.port_3, cor1.port_a) annotation (Line(points={{10,20},{20,20},{20,
          -32},{50,-32},{50,-20}}, color={0,127,255}));
  connect(cor1.port_b, roo1.ports[1]) annotation (Line(points={{50,20},{50,32},
          {100,32},{100,-16},{165,-16}},color={0,127,255}));
  connect(jun5.port_2, roo2.ports[2]) annotation (Line(points={{100,110},{140,
          110},{140,78},{165,78}}, color={0,127,255}));
  connect(jun5.port_3, roo1.ports[2])
    annotation (Line(points={{90,100},{90,-12},{165,-12}}, color={0,127,255}));
  connect(jun5.port_1, amb.ports[2]) annotation (Line(points={{80,110},{-160,
          110},{-160,-1.2},{-168,-1.2}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-260,-160},
            {260,160}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-260,-160},{260,160}})));
end TestBed;
