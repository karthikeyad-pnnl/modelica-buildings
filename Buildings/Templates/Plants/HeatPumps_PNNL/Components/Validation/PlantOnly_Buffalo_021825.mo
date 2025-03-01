within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model PlantOnly_Buffalo_021825 "Plant model with heat-recovery chiller"

  extends Modelica.Icons.Example;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "HW medium";
  replaceable package MediumChiWat =
      Buildings.Media.Antifreeze.PropyleneGlycolWater (
         property_T=293.15, X_a=0.40)
    "CHW medium";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));

  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup_heatRecovery datHpAwNrv(
    final cpChiWat_default=hpAwNrv.cpChiWat_default,
    final cpCon_default=hpAwNrv.cpCon_default,
    final nHp=hpAwNrv.nHp,
    final typ=hpAwNrv.typ,
    mCon_flow_nominal=120,
    COP_nominal=3,
    dpCon_nominal=Buildings.Templates.Data.Defaults.dpConWatChi,
    capHea_nominal=1.2e6,
    TConLvg_nominal=273.15 + 60,
    TConEnt_nominal=273.15 + 45,
    mChiWat_flow_nominal=120,
    capCoo_nominal=2.5E6,
    TChiWatSup_nominal=273.15 + 6.68,
    dpChiWat_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpChiWatChi,
    per(
      capFunT={9.585465E-01,3.516870E-02,1.246624E-04,-2.745559E-03,-5.000232E-05,
          -1.723494E-04},
      EIRFunT={7.327001E-01,-8.343605E-03,6.385302E-04,-3.037535E-03,
          4.849529E-04,-8.358498E-04},
      EIRFunPLR={7.086284E-02,2.787561E-03,-8.917038E-06,2.309734E-01,
          1.250442E+00,-2.161029E-03,0.000000E+00,-5.630094E-01,0.000000E+00,
          0.000000E+00},
      TEvaLvgMin=279.15,
      TEvaLvgMax=285.85,
      TConLvgMin=303.15,
      TConLvgMax=343.15))
    "Non-reversible AWHP parameters"
    annotation (Placement(transformation(extent={{-152,-194},{-132,-174}})));

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater_heatRecovery
    hpAwNrv(
    nHp=1,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics) "Non reversible AWHP"
    annotation (Placement(transformation(extent={{272,-114},{-208,-34}})));
  parameter HeatPumps.Components.Data.Controller datCtlHeaInl(
    cfg(
      have_pumHeaWatPriVar=true,
      have_pumChiWatPriVar=false,
      have_inpSch=false,
      have_hrc=false,
      have_valHpOutIso=valIsoHeaInl.have_valHpOutIso,
      have_valHpInlIso=valIsoHeaInl.have_valHpInlIso,
      have_chiWat=valIsoHeaInl.have_chiWat,
      have_pumChiWatPriDed=valIsoHeaInl.have_pumChiWatPriDed,
      typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
      typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
      is_rev=true,
      typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
      nPumChiWatSec=0,
      rhoHeaWat_default=Buildings.Media.Water.d_const,
      typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
      typ=Buildings.Templates.Components.Types.HeatPump.WaterToWater,
      rhoChiWat_default=Buildings.Media.Water.d_const,
      cpChiWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      have_hotWat=false,
      have_valChiWatMinByp=false,
      have_valHeaWatMinByp=false,
      typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
      cpHeaWat_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      cpSou_default=Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
      have_senDpChiWatRemWir=true,
      typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
      nHp=1,
      nPumHeaWatPri=1,
      have_heaWat=true,
      nPumHeaWatSec=0,
      rhoSou_default=Buildings.Media.Air.dStp,
      have_senDpHeaWatRemWir=true,
      typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      nPumChiWatPri=1,
      nSenDpHeaWatRem=0,
      nSenDpChiWatRem=0,
      nAirHan=0,
      nEquZon=0),
    THeaWatSup_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TChiWatSup_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max,
        datCtlHeaInl.cfg.nSenDpChiWatRem),
    dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max,
        datCtlHeaInl.cfg.nSenDpHeaWatRem),
    staEqu={fill(1, datCtlHeaInl.cfg.nHp)})
    "Controller parameters"
    annotation (Placement(transformation(extent={{-284,-192},{-264,-172}})));

  ValvesIsolation_UpdatePorts
    valIsoHeaInl(
    redeclare final package Medium = Medium,
    nHp=1,
    have_chiWat=true,
    have_pumChiWatPriDed=false,
    have_valHpInlIso=true,
    have_valHpOutIso=false,
    final mHeaWatHp_flow_nominal=fill(datHpAwNrv.mCon_flow_nominal,
        valIsoHeaInl.nHp),
    dpHeaWatHp_nominal=fill(datHpAwNrv.dpCon_nominal, valIsoHeaInl.nHp),
    mChiWatHp_flow_nominal=fill(datHpAwNrv.mChiWat_flow_nominal, valIsoHeaInl.nHp),
    final energyDynamics=energyDynamics,
    y_start=0)
    "Isolation valves - Heating-only system with isolation valves at HP inlet"
    annotation (Placement(transformation(extent={{-22,18},{20,60}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMulCoo,
    redeclare final package Medium = MediumChiWat)
    annotation (Placement(transformation(extent={{86,90},{106,110}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulCoo(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mChiWat_flow_nominal, pum.nPum),
    dp_nominal=fill(3.5*2e7, pum.nPum),
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.heatPumpPlant_Cooling per)
                                                "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-110,-196},{-90,-176}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou(
    redeclare package Medium = MediumChiWat,
    nPorts=pum.nPum,
    m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{54,90},{74,110}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou1(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal)
    annotation (Placement(transformation(extent={{-58,14},{-78,34}})));
  Buildings.Templates.Components.Pumps.Multiple pum1(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMulHea,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-104,14},{-124,34}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou2(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal)
    annotation (Placement(transformation(extent={{-160,14},{-140,34}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mCon_flow_nominal,-datHpAwNrv.mCon_flow_nominal,
        -datHpAwNrv.mCon_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-258,24})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mCon_flow_nominal,-datHpAwNrv.mCon_flow_nominal,
        -datHpAwNrv.mCon_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-258,98})));
  Buildings.Templates.Components.Actuators.Valve valve(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-258,56})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPHea(redeclare
      package Medium = Media.Water)           annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-230,56})));
  Buildings.Templates.Components.Sensors.Temperature TSupHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mCon_flow_nominal)
    annotation (Placement(transformation(extent={{-232,14},{-212,34}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou3(
    redeclare package Medium = MediumChiWat,
    nPorts=pum.nPum,
    m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{140,90},{120,110}})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = MediumChiWat,
    m_flow_nominal={datHpAwNrv.mChiWat_flow_nominal,-datHpAwNrv.mChiWat_flow_nominal,
        -datHpAwNrv.mChiWat_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={214,100})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = MediumChiWat,
    m_flow_nominal={datHpAwNrv.mChiWat_flow_nominal,-datHpAwNrv.mChiWat_flow_nominal,
        -datHpAwNrv.mChiWat_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={214,24})));
  Buildings.Templates.Components.Actuators.Valve valve1(
    redeclare package Medium = MediumChiWat,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={214,60})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPCoo(redeclare
      package Medium = MediumChiWat)          annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={196,50})));
  Buildings.Templates.Components.Sensors.Temperature TSupCoo(redeclare package
      Medium = MediumChiWat,          m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{174,90},{194,110}})));

  Buildings.Templates.Components.Sensors.Temperature TRetCoo(redeclare package
      Medium = MediumChiWat,          m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{182,14},{162,34}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop(
    mConWat_flow=30*660,
    CoolingCapacity_nominal=30*15e6,
    mRehWat_flow=0.75*70.83,
    HeatingCapacity_nominal=1.2*9.52e6)
    annotation (Placement(transformation(extent={{-2,210},{18,230}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHea(redeclare package
      Medium = Buildings.Media.Water,
                            m_flow_nominal=datHpAwNrv.mCon_flow_nominal)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-188,98})));
  Buildings.Templates.Components.Actuators.Valve valve2(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={-348,24})));
  Buildings.Templates.Components.Actuators.Valve valve3(
    redeclare package Medium = MediumChiWat,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={280,100})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-26,8},{-46,28}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = MediumChiWat,nPorts=
       1) annotation (Placement(transformation(extent={{22,116},{42,136}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulHea(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mCon_flow_nominal, pum.nPum),
    dp_nominal=fill(1.5*5E6, pum.nPum),
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.heatPumpPlant_Heating per)
                                    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-62,-200},{-42,-180}})));

  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{-136,94},{-156,114}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = MediumChiWat,
    m1_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{126,20},{146,40}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHeaCon(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mCon_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,98})));
  Buildings.Templates.Components.Sensors.Temperature TRetCooCon(redeclare
      package Medium = MediumChiWat,          m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{60,14},{40,34}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-316,24})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate1(
    redeclare package Medium = MediumChiWat,
    m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={250,100})));
  Buildings.Templates.Components.Actuators.Valve valve4(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.ThreeWayModulating,
    chaThr=Buildings.Templates.Components.Types.ValveCharacteristicThreeWay.Linear,
    dat(
      m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-108,98})));
  Buildings.Templates.Components.Actuators.Valve valve5(
    redeclare package Medium = MediumChiWat,
    typ=Buildings.Templates.Components.Types.Valve.ThreeWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={82,24})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={14,150})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-22,150})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateHeaPri(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-188,24})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateCooPri(
    redeclare package Medium = MediumChiWat,
    m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={154,100})));
  Fluid.HeatExchangers.Heater_T loaChiWat(
    redeclare final package Medium = MediumChiWat,
    final m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    show_T=true,
    final dp_nominal=0,
    final energyDynamics=energyDynamics,
    tau=300,
    QMax_flow=datHpAwNrv.capCoo_nominal)
    "CHW system system approximated by prescribed return temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={310,70})));
  Fluid.HeatExchangers.SensibleCooler_T loaHeaWat(
    redeclare final package Medium = Buildings.Media.Water,
    final m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    show_T=true,
    final dp_nominal=0,
    final energyDynamics=energyDynamics,
    tau=300,
    QMin_flow=-datHpAwNrv.capHea_nominal)
    "HW system approximated by prescribed return temperature"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-360,68})));
  Fluid.Sensors.MassFlowRate senMasFlo(redeclare package Medium =
        Buildings.Media.Water) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-360,40})));
  Fluid.Sensors.MassFlowRate senMasFlo1(redeclare package Medium = MediumChiWat)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=-90,
        origin={310,40})));
equation
  connect(valIsoHeaInl.port_bChiWat, rou.port_a) annotation (Line(points={{20,54.12},
          {34,54.12},{34,100},{54,100}},                         color={0,127,255}));
  connect(valIsoHeaInl.port_bHeaWat, rou1.port_a) annotation (Line(points={{-22,
          45.51},{-48,45.51},{-48,24},{-58,24}},      color={0,127,255}));
  connect(hpAwNrv.ports_bHotWat, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(
        points={{-18,-113.8},{-18,-122},{-32,-122},{-32,6},{-16.6,6},{-16.6,18.21}},
                   color={0,127,255}));
  connect(valIsoHeaInl.ports_bHeaWatHp, hpAwNrv.ports_aHotWat) annotation (Line(
        points={{-6,18.21},{-6,-18},{-222,-18},{-222,-126},{82,-126},{82,-114}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_aChiWatHp, hpAwNrv.ports_bChiWat) annotation (Line(
        points={{4.6,18.42},{4.6,10},{34,10},{34,-26},{82,-26},{82,-34}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_bChiWatHp, hpAwNrv.ports_aChiWat) annotation (Line(
        points={{14.8,18.21},{14.8,-26},{-18,-26},{-18,-34}},color={0,127,255}));
  connect(jun.port_3, valve.port_a)
    annotation (Line(points={{-258,34},{-258,46}}, color={0,127,255}));
  connect(valve.port_b, jun6.port_3)
    annotation (Line(points={{-258,66},{-258,88}}, color={0,127,255}));

  connect(jun2.port_3, valve1.port_a)
    annotation (Line(points={{214,34},{214,50}}, color={0,127,255}));
  connect(valve1.port_b, jun1.port_3) annotation (Line(points={{214,70},{214,90}},
                              color={0,127,255}));

  connect(rou.ports_b, pum.ports_a) annotation (Line(points={{74,100},{86,100}},
                           color={0,127,255}));
  connect(pum.ports_b, rou3.ports_b) annotation (Line(points={{106,100},{120,100}},
                                   color={0,127,255}));
  connect(rou1.ports_b, pum1.ports_a)
    annotation (Line(points={{-78,24},{-104,24}},          color={0,127,255}));
  connect(pum1.ports_b, rou2.ports_b) annotation (Line(points={{-124,24},{-140,24}},
                          color={0,127,255}));

  connect(jun6.port_2, TRetHea.port_a) annotation (Line(points={{-248,98},{-198,
          98}},                       color={0,127,255}));
  connect(TSupHea.port_a, jun.port_1) annotation (Line(points={{-232,24},{-248,24}},
                      color={0,127,255}));
  connect(TSupCoo.port_b, jun1.port_1) annotation (Line(points={{194,100},{204,100}},
                                        color={0,127,255}));
  connect(TRetCoo.port_a, jun2.port_2)
    annotation (Line(points={{182,24},{204,24}}, color={0,127,255}));

  connect(bou.ports[1], rou1.port_a) annotation (Line(points={{-46,18},{-58,18},
          {-58,24}},          color={0,127,255}));
  connect(bou1.ports[1], rou.port_a) annotation (Line(points={{42,126},{54,126},
          {54,100}},                      color={0,127,255}));
  connect(TRetHea.port_b, hex.port_a2) annotation (Line(points={{-178,98},{-156,
          98}},             color={0,127,255}));
  connect(hex.port_b1, externalEnergyLoop.portCon_a) annotation (Line(points={{-156,
          110},{-160,110},{-160,170},{1,170},{1,210}}, color={0,127,255}));
  connect(TRetCoo.port_b, hex1.port_a2) annotation (Line(points={{162,24},{146,24}},
                             color={0,127,255}));
  connect(hex1.port_b1, externalEnergyLoop.portEva_a) annotation (Line(points={{146,36},
          {152,36},{152,70},{8,70},{8,210},{11,210}},   color={0,127,255}));
  connect(TRetHeaCon.port_b, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{-60,98},
          {-48,98},{-48,54.54},{-22,54.54}},                              color=
         {0,127,255}));
  connect(TRetCooCon.port_b, valIsoHeaInl.port_aChiWat) annotation (Line(points={{40,24},
          {34,24},{34,44.88},{20,44.88}},         color={0,127,255}));
  connect(volumeFlowRate.port_a, jun.port_2) annotation (Line(points={{-306,24},
          {-268,24}},                     color={0,127,255}));
  connect(jun1.port_2, volumeFlowRate1.port_a) annotation (Line(points={{224,100},
          {240,100}},                  color={0,127,255}));
  connect(volumeFlowRate1.port_b, valve3.port_a) annotation (Line(points={{260,100},
          {270,100}},                      color={0,127,255}));
  connect(valve4.port_b, TRetHeaCon.port_a) annotation (Line(points={{-98,98},{-80,
          98}},                                                   color={0,127,
          255}));
  connect(valve5.port_b, TRetCooCon.port_a) annotation (Line(points={{72,24},{60,
          24}},                     color={0,127,255}));
  connect(volumeFlowRate2.port_a, externalEnergyLoop.portEva_b) annotation (
      Line(points={{14,160},{14,193},{15,193},{15,210}},
                 color={0,127,255}));
  connect(volumeFlowRate2.port_b, hex1.port_a1) annotation (Line(points={{14,140},
          {12,140},{12,64},{116,64},{116,36},{126,36}},
                                                  color={0,127,255}));
  connect(externalEnergyLoop.portCon_b, volumeFlowRate3.port_a) annotation (
      Line(points={{5,210},{4,210},{4,166},{-22,166},{-22,160}},
        color={0,127,255}));
  connect(volumeFlowRate3.port_b, hex.port_a1) annotation (Line(points={{-22,140},
          {-22,118},{-130,118},{-130,110},{-136,110}},                  color={
          0,127,255}));
  connect(volumeFlowRateHeaPri.port_b, TSupHea.port_b)
    annotation (Line(points={{-198,24},{-212,24}}, color={0,127,255}));
  connect(volumeFlowRateHeaPri.port_a, rou2.port_a) annotation (Line(points={{-178,24},
          {-160,24}},                                             color={0,127,255}));
  connect(rou3.port_a, volumeFlowRateCooPri.port_a) annotation (Line(points={{140,100},
          {144,100}},                                        color={0,127,255}));
  connect(volumeFlowRateCooPri.port_b, TSupCoo.port_a) annotation (Line(points={{164,100},
          {174,100}},                               color={0,127,255}));
  connect(TRetHea.port_b, valve4.portByp_a) annotation (Line(points={{-178,98},{
          -168,98},{-168,76},{-108,76},{-108,88}}, color={0,127,255}));
  connect(hex.port_b2, valve4.port_a)
    annotation (Line(points={{-136,98},{-118,98}}, color={0,127,255}));
  connect(TRetCoo.port_b, valve5.portByp_a) annotation (Line(points={{162,24},{154,
          24},{154,4},{82,4},{82,14}}, color={0,127,255}));
  connect(hex1.port_b2, valve5.port_a)
    annotation (Line(points={{126,24},{92,24}}, color={0,127,255}));
  connect(dPCoo.port_a, TSupCoo.port_b) annotation (Line(points={{196,60},{196,
          80},{194,80},{194,100}}, color={0,127,255}));
  connect(dPCoo.port_b, jun2.port_2) annotation (Line(points={{196,40},{196,32},
          {204,32},{204,24}}, color={0,127,255}));
  connect(dPHea.port_a, jun.port_1) annotation (Line(points={{-230,46},{-240,46},
          {-240,24},{-248,24}}, color={0,127,255}));
  connect(dPHea.port_b, jun6.port_2) annotation (Line(points={{-230,66},{-230,
          98},{-248,98}}, color={0,127,255}));
  connect(valve3.port_b, loaChiWat.port_a) annotation (Line(points={{290,100},{
          310,100},{310,80}}, color={0,127,255}));
  connect(loaHeaWat.port_b, jun6.port_1) annotation (Line(points={{-360,78},{
          -360,98},{-268,98}}, color={0,127,255}));
  connect(valve2.port_a, volumeFlowRate.port_b)
    annotation (Line(points={{-338,24},{-326,24}}, color={0,127,255}));
  connect(valve2.port_b, senMasFlo.port_a) annotation (Line(points={{-358,24},{-360,
          24},{-360,30}}, color={0,127,255}));
  connect(senMasFlo.port_b, loaHeaWat.port_a)
    annotation (Line(points={{-360,50},{-360,58}}, color={0,127,255}));
  connect(loaChiWat.port_b, senMasFlo1.port_a)
    annotation (Line(points={{310,60},{310,50}}, color={0,127,255}));
  connect(senMasFlo1.port_b, jun2.port_1)
    annotation (Line(points={{310,30},{310,24},{224,24}}, color={0,127,255}));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-580,-160},{500,320}}), graphics={
        Rectangle(
          extent={{-32,242},{44,198}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-12,238},{344,208}},
          textColor={0,0,0},
          textString="External energy loop"),
        Rectangle(
          extent={{-384,130},{-24,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-484,162},{-128,132}},
          textColor={238,46,47},
          textString="Hot water loop"),
        Text(
          extent={{66,174},{422,144}},
          textColor={28,108,200},
          textString="Chilled water loop"),
        Rectangle(
          extent={{24,142},{334,-4}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Rectangle(
          extent={{-228,-12},{180,-130}},
          lineColor={0,140,72},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-188,-128},{168,-158}},
          textColor={0,140,72},
          textString="Central heat recovery")}),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
        "Simulate and plot"),
    experiment(
      StopTime=2678400,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
    Documentation(
      info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater\">
Buildings.Templates.Plants.HeatPumps.Components.HeatPumpGroups.AirToWater</a>
in a configuration in which the heat pump components are exposed
to a constant differential pressure and a varying
return temperature.
</p>
<p>
The model is configured to represent either a non-reversible heat pump
(component <code>hpAwNrv</code>) or a reversible heat pump
(component <code>hpAw</code>) that switches between cooling and heating
mode.
</p>
</html>", revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-580,-160},{500,320}})));
end PlantOnly_Buffalo_021825;
