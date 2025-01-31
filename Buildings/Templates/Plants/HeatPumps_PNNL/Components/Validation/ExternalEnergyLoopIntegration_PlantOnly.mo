within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model ExternalEnergyLoopIntegration_PlantOnly "Control Box Test"

  extends Modelica.Icons.Example;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "CHW/HW medium";
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.Controller datCtlPlaAwNrv(
    cfg(
      have_hrc = false,
      have_inpSch = false,
      have_chiWat=false,
      typPumHeaWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.Variable,
      typPumChiWatPri=Buildings.Templates.Plants.HeatPumps.Types.PumpsPrimary.None,
      typPumHeaWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      have_pumHeaWatPriVar=true,
      have_pumChiWatPriVar=false,
      typDis=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Constant1Only,
      have_pumChiWatPriDed=false,
      nPumChiWatSec=0,
      rhoHeaWat_default=Buildings.Media.Water.d_const,
      typCtl=Buildings.Templates.Plants.HeatPumps.Types.Controller.OpenLoop,
      is_rev=hpAwNrv.is_rev,
      typ=hpAwNrv.typ,
      rhoChiWat_default=Buildings.Media.Water.d_const,
      cpChiWat_default=hpAwNrv.cpChiWat_default,
      have_hotWat=false,
      have_valChiWatMinByp=false,
      have_valHeaWatMinByp=false,
      have_valHpInlIso=false,
      have_valHpOutIso=false,
      typMod=hpAwNrv.typMod,
      cpHeaWat_default=hpAwNrv.cpHeaWat_default,
      cpSou_default=hpAwNrv.cpSou_default,
      have_senDpChiWatRemWir=true,
      typArrPumPri=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
      nHp=hpAwNrv.nHp,
      nPumHeaWatPri=hpAwNrv.nHp,
      have_heaWat=true,
      nPumHeaWatSec=0,
      rhoSou_default=Buildings.Media.Air.dStp,
      have_senDpHeaWatRemWir=true,
      typPumChiWatSec=Buildings.Templates.Plants.HeatPumps.Types.PumpsSecondary.None,
      nPumChiWatPri=hpAwNrv.nHp,
      nSenDpHeaWatRem=1,
      nSenDpChiWatRem=1,
      nAirHan=0,
      nEquZon=0),
    THeaWatSup_nominal=datHpAwNrv.THeaWatSupHp_nominal,
    dpChiWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpChiWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpChiWatRem),
    dpHeaWatRemSet_max=fill(Buildings.Templates.Data.Defaults.dpHeaWatRemSet_max, datCtlPlaAwNrv.cfg.nSenDpHeaWatRem),
    staEqu={fill(1, hpAwNrv.nHp)})
    "Controller parameters"
    annotation (Placement(transformation(extent={{-192,-192},{-172,-172}})));

  parameter Buildings.Templates.Plants.HeatPumps.Components.Data.HeatPumpGroup datHpAwNrv(
    final cpHeaWat_default=hpAwNrv.cpHeaWat_default,
    final cpSou_default=hpAwNrv.cpSou_default,
    final nHp=hpAwNrv.nHp,
    final typ=hpAwNrv.typ,
    final is_rev=hpAwNrv.is_rev,
    final typMod=hpAwNrv.typMod,
    mHeaWatHp_flow_nominal=58,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=3*1.2e6,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWatHp_flow_nominal=120,
    capCooHp_nominal=3*2.5E6,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mSouWwHeaHp_flow_nominal=58,
    dpSouWwHeaHp_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpHeaWatHp,
    TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
    mSouWwCooHp_flow_nominal=58,
    perFitHp(hea(
        P=datHpAwNrv.capHeaHp_nominal/Buildings.Templates.Data.Defaults.COPHpWwHea,
        coeQ={-3.33491153,-0.51451946,4.51592706,0.01797107,0.155797661},
        coeP={-8.93121751,8.57035762,1.29660976,-0.21629222,0.033862378},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpHea),
        coo(
        P=datHpAwNrv.capCooHp_nominal/Buildings.Templates.Data.Defaults.COPHpWwCoo,
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TSouHpCoo,
        coeQ={-1.52030596,3.46625667,-1.32267797,0.09395678,0.038975504},
        coeP={-8.59564386,0.96265085,8.69489229,0.02501669,-0.20132665})))
    "Non-reversible AWHP parameters"
    annotation (Placement(transformation(extent={{-150,-192},{-130,-172}})));

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater
    hpAwNrv(
    redeclare final package MediumHeaWat = Medium,
    nHp=1,
    is_rev=false,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics) "Non reversible AWHP"
    annotation (Placement(transformation(extent={{272,-114},{-208,-34}})));
  parameter HeatPumps.Components.Data.Controller                            datCtlHeaInl(
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

  parameter HeatPumps.Components.Data.HeatPumpGroup                            datHp(
    final nHp=2,
    final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
    final is_rev=true,
    final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit,
    mHeaWatHp_flow_nominal=20,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=500E3,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mChiWatHp_flow_nominal=40,
    capCooHp_nominal=500E3,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCooHp_nominal=293.15,
    perFitHp(hea(
        P=datHp.capHeaHp_nominal/Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={-4.2670305442,-0.7381077035,6.0049480456,0,0},
        coeP={-4.9107455513,5.3665308366,0.5447612754,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow), coo(
        P=datHp.capCooHp_nominal/Buildings.Templates.Data.Defaults.COPHpAwCoo,
        coeQ={-2.2545246871,6.9089257665,-3.6548225094,0,0},
        coeP={-5.8086010402,1.6894933858,5.1167787436,0,0},
        TRefLoa=Buildings.Templates.Data.Defaults.TChiWatRet,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpCoo)))
    "HP parameters"
    annotation (Placement(transformation(extent={{-228,-192},{-208,-172}})));

  ValvesIsolation_UpdatePorts
    valIsoHeaInl(
    redeclare final package Medium = Medium,
    nHp=1,
    have_chiWat=true,
    have_pumChiWatPriDed=false,
    have_valHpInlIso=true,
    have_valHpOutIso=false,
    final mHeaWatHp_flow_nominal=fill(datHp.mHeaWatHp_flow_nominal,
        valIsoHeaInl.nHp),
    dpHeaWatHp_nominal=fill(datHp.dpHeaWatHp_nominal, valIsoHeaInl.nHp),
    mChiWatHp_flow_nominal=fill(datHp.mChiWatHp_flow_nominal, valIsoHeaInl.nHp),
    final energyDynamics=energyDynamics,
    y_start=0)
    "Isolation valves - Heating-only system with isolation valves at HP inlet"
    annotation (Placement(transformation(extent={{-22,18},{20,60}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMulCoo,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{86,90},{106,110}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulCoo(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mChiWatHp_flow_nominal, pum.nPum),
    dp_nominal=fill(3.5*2e7, pum.nPum),
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.heatPumpPlant_Cooling per)
                                                "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-110,-196},{-90,-176}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{54,90},{74,110}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou1(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
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
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{-160,14},{-140,34}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mHeaWatHp_flow_nominal,-datHpAwNrv.mHeaWatHp_flow_nominal,
        -datHpAwNrv.mHeaWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-258,24})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mHeaWatHp_flow_nominal,-datHpAwNrv.mHeaWatHp_flow_nominal,
        -datHpAwNrv.mHeaWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-258,98})));
  Buildings.Templates.Components.Actuators.Valve valve(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-258,56})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPHea(redeclare
      package Medium = Media.Water)           annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-292,56})));
  Buildings.Templates.Components.Sensors.Temperature TSupHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{-232,14},{-212,34}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou3(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{140,90},{120,110}})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mChiWatHp_flow_nominal,-datHpAwNrv.mChiWatHp_flow_nominal,
        -datHpAwNrv.mChiWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={214,100})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mChiWatHp_flow_nominal,-datHpAwNrv.mChiWatHp_flow_nominal,
        -datHpAwNrv.mChiWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={214,24})));
  Buildings.Templates.Components.Actuators.Valve valve1(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={214,60})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPCoo(redeclare
      package Medium = Buildings.Media.Water) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={232,48})));
  Buildings.Templates.Components.Sensors.Temperature TSupCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{174,90},{194,110}})));

  Buildings.Templates.Components.Sensors.Temperature TRetCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{144,14},{124,34}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop(datHpAwNrv(mHeaWat_flow_nominal=23, capHea_nominal=2*
          datHpAwNrv.capHeaHp_nominal), datCoolingTowerWHE(
        CoolingCapacity_nominal=1*datHpAwNrv.capCooHp_nominal))
    annotation (Placement(transformation(extent={{-2,210},{18,230}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-32,260},{-12,280}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHea(redeclare package
      Medium = Buildings.Media.Water,
                            m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-188,98})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Buildings.Media.Water,
    T_start=338.15,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    V=datHpAwNrv.mHeaWatHp_flow_nominal*3600/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{-370,60},{-350,80}})));
  HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(extent={{-408,30},{-388,50}})));
  Fluid.Sensors.Temperature senTem(redeclare package Medium = Media.Water,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{-440,60},{-420,80}})));
  Buildings.Templates.Components.Actuators.Valve valve2(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-348,24})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Buildings.Media.Water,
    T_start=285.85,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    V=datHpAwNrv.mHeaWatHp_flow_nominal*3600/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{320,40},{340,60}})));
  Buildings.Templates.Components.Actuators.Valve valve3(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={280,100})));
  HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo1
    annotation (Placement(transformation(extent={{286,40},{306,60}})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Media.Water,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{340,40},{360,60}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-26,8},{-46,28}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1) annotation (Placement(transformation(extent={{22,116},{42,136}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulHea(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mHeaWatHp_flow_nominal, pum.nPum),
    dp_nominal=fill(1.5*5E6, pum.nPum),
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.heatPumpPlant_Heating per)
                                    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-62,-200},{-42,-180}})));

  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{-136,94},{-156,114}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{76,20},{96,40}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHeaCon(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,100})));
  Buildings.Templates.Components.Sensors.Temperature TRetCooCon(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{60,14},{40,34}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-316,24})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate1(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={250,100})));
  Buildings.Templates.Components.Actuators.Valve valve4(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-146,74})));
  Buildings.Templates.Components.Actuators.Valve valve5(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayTwoPosition,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=0,
        origin={86,-12})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate2(
    redeclare package Medium = Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={14,150})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate3(
    redeclare package Medium = Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-22,150})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateHeaPri(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-188,24})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateCooPri(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={154,100})));
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
  connect(jun.port_2, dPHea.port_a) annotation (Line(points={{-268,24},{-292,24},
          {-292,46}},                     color={0,127,255}));
  connect(jun6.port_1, dPHea.port_b) annotation (Line(points={{-268,98},{-292,98},
          {-292,66}},                     color={0,127,255}));

  connect(jun2.port_3, valve1.port_a)
    annotation (Line(points={{214,34},{214,50}}, color={0,127,255}));
  connect(valve1.port_b, jun1.port_3) annotation (Line(points={{214,70},{214,90}},
                              color={0,127,255}));
  connect(jun1.port_2, dPCoo.port_a)
    annotation (Line(points={{224,100},{232,100},{232,58}},
                                                          color={0,127,255}));
  connect(jun2.port_1, dPCoo.port_b) annotation (Line(points={{224,24},{232,24},
          {232,38}},                                   color={0,127,255}));

  connect(rou.ports_b, pum.ports_a) annotation (Line(points={{74,100},{86,100}},
                           color={0,127,255}));
  connect(pum.ports_b, rou3.ports_b) annotation (Line(points={{106,100},{120,100}},
                                   color={0,127,255}));
  connect(rou1.ports_b, pum1.ports_a)
    annotation (Line(points={{-78,24},{-104,24}},          color={0,127,255}));
  connect(pum1.ports_b, rou2.ports_b) annotation (Line(points={{-124,24},{-140,24}},
                          color={0,127,255}));
  connect(weaDat.weaBus,externalEnergyLoop. busWea) annotation (Line(
      points={{-12,270},{4,270},{4,230}},
      color={255,204,51},
      thickness=0.5));
  connect(preHeaFlo.port, vol.heatPort)
    annotation (Line(points={{-388,40},{-376,40},{-376,70},{-370,70}},
                                                   color={191,0,0}));
  connect(valve2.port_a, vol.ports[1]) annotation (Line(points={{-358,24},{
          -361.333,24},{-361.333,60}},
                          color={0,127,255}));
  connect(vol.ports[2], senTem.port) annotation (Line(points={{-360,60},{-430,60}},
                                      color={0,127,255}));

  connect(jun6.port_2, TRetHea.port_a) annotation (Line(points={{-248,98},{-198,
          98}},                       color={0,127,255}));
  connect(TSupHea.port_a, jun.port_1) annotation (Line(points={{-232,24},{-248,24}},
                      color={0,127,255}));
  connect(vol.ports[3], jun6.port_1) annotation (Line(points={{-358.667,60},{
          -358.667,56},{-346,56},{-346,98},{-268,98}},
                                              color={0,127,255}));
  connect(TSupCoo.port_b, jun1.port_1) annotation (Line(points={{194,100},{204,100}},
                                        color={0,127,255}));
  connect(TRetCoo.port_a, jun2.port_2)
    annotation (Line(points={{144,24},{204,24}}, color={0,127,255}));
  connect(valve3.port_b, vol1.ports[1]) annotation (Line(points={{290,100},{312,
          100},{312,40},{328.667,40}},
                              color={0,127,255}));
  connect(preHeaFlo1.port, vol1.heatPort) annotation (Line(points={{306,50},{320,
          50}},                                      color={191,0,0}));
  connect(senTem1.port, vol1.ports[2]) annotation (Line(points={{350,40},{350,34},
          {330,34},{330,40}},         color={0,127,255}));

  connect(bou.ports[1], rou1.port_a) annotation (Line(points={{-46,18},{-58,18},
          {-58,24}},          color={0,127,255}));
  connect(bou1.ports[1], rou.port_a) annotation (Line(points={{42,126},{54,126},
          {54,100}},                      color={0,127,255}));
  connect(TRetHea.port_b, hex.port_a2) annotation (Line(points={{-178,98},{-156,
          98}},             color={0,127,255}));
  connect(hex.port_b1, externalEnergyLoop.portCon_a) annotation (Line(points={{-156,
          110},{-160,110},{-160,162},{1,162},{1,210}}, color={0,127,255}));
  connect(TRetCoo.port_b, hex1.port_a2) annotation (Line(points={{124,24},{96,24}},
                             color={0,127,255}));
  connect(hex1.port_b1, externalEnergyLoop.portEva_a) annotation (Line(points={{96,36},
          {102,36},{102,162},{11,162},{11,210}},        color={0,127,255}));
  connect(hex.port_b2, TRetHeaCon.port_a) annotation (Line(points={{-136,98},{-126,
          98},{-126,100},{-80,100}},   color={0,127,255}));
  connect(TRetHeaCon.port_b, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{-60,100},
          {-48,100},{-48,54.54},{-22,54.54}},                             color=
         {0,127,255}));
  connect(hex1.port_b2, TRetCooCon.port_a)
    annotation (Line(points={{76,24},{60,24}}, color={0,127,255}));
  connect(TRetCooCon.port_b, valIsoHeaInl.port_aChiWat) annotation (Line(points={{40,24},
          {34,24},{34,44.88},{20,44.88}},         color={0,127,255}));
  connect(volumeFlowRate.port_b, valve2.port_b) annotation (Line(points={{-326,24},
          {-338,24}},                         color={0,127,255}));
  connect(volumeFlowRate.port_a, jun.port_2) annotation (Line(points={{-306,24},
          {-268,24}},                     color={0,127,255}));
  connect(jun2.port_1, vol1.ports[3]) annotation (Line(points={{224,24},{
          331.333,24},{331.333,40}},           color={0,127,255}));
  connect(jun1.port_2, volumeFlowRate1.port_a) annotation (Line(points={{224,100},
          {240,100}},                  color={0,127,255}));
  connect(volumeFlowRate1.port_b, valve3.port_a) annotation (Line(points={{260,100},
          {270,100}},                      color={0,127,255}));
  connect(valve4.port_a, TRetHea.port_b) annotation (Line(points={{-156,74},{-172,
          74},{-172,98},{-178,98}},        color={0,127,255}));
  connect(valve4.port_b, TRetHeaCon.port_a) annotation (Line(points={{-136,74},{
          -90,74},{-90,100},{-80,100}},                           color={0,127,
          255}));
  connect(valve5.port_a, TRetCoo.port_b) annotation (Line(points={{96,-12},{102,
          -12},{102,24},{124,24}}, color={0,127,255}));
  connect(valve5.port_b, TRetCooCon.port_a) annotation (Line(points={{76,-12},{70,
          -12},{70,24},{60,24}},    color={0,127,255}));
  connect(volumeFlowRate2.port_a, externalEnergyLoop.portEva_b) annotation (
      Line(points={{14,160},{14,193},{15,193},{15,210}},
                 color={0,127,255}));
  connect(volumeFlowRate2.port_b, hex1.port_a1) annotation (Line(points={{14,140},
          {14,94},{40,94},{40,36},{76,36}},       color={0,127,255}));
  connect(externalEnergyLoop.portCon_b, volumeFlowRate3.port_a) annotation (
      Line(points={{5,210},{4,210},{4,204},{-22,204},{-22,160}},
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
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-460,-160},{380,300}}), graphics={
        Rectangle(
          extent={{-244,-16},{156,-132}},
          lineColor={0,140,72},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-212,-130},{144,-160}},
          textColor={0,140,72},
          textString="Central heat recovery"),
        Rectangle(
          extent={{-36,240},{40,196}},
          lineColor={0,0,0},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{-16,236},{340,206}},
          textColor={0,0,0},
          textString="External energy loop"),
        Text(
          extent={{-512,174},{-156,144}},
          textColor={238,46,47},
          textString="Hot water loop"),
        Rectangle(
          extent={{-450,138},{-52,-4}},
          lineColor={238,46,47},
          pattern=LinePattern.Dash,
          lineThickness=0.5),
        Text(
          extent={{86,176},{442,146}},
          textColor={28,108,200},
          textString="Chilled water loop"),
        Rectangle(
          extent={{0,140},{370,-2}},
          lineColor={28,108,200},
          pattern=LinePattern.Dash,
          lineThickness=0.5)}),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
        "Simulate and plot"),
    experiment(
      StartTime=18316800,
      StopTime=20908800,
      Interval=60,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
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
    Icon(coordinateSystem(extent={{-460,-160},{380,300}})));
end ExternalEnergyLoopIntegration_PlantOnly;
