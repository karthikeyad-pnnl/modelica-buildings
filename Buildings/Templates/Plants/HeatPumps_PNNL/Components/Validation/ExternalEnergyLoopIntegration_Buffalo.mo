within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model ExternalEnergyLoopIntegration_Buffalo "Control Box Test"

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

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
    redeclare final package MediumHeaWat=Medium,
    nHp=1,
    is_rev=false,
    final dat=datHpAwNrv,
    final energyDynamics=energyDynamics)
    "Non reversible AWHP"
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

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoopWithHeatRecoveryUnitController
  ctlHeaInl(final cfg=
       datCtlHeaInl.cfg, final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{-68,-24},{-88,-4}})));

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
  HeatPumps.Interfaces.Bus bus_sensor
    annotation (Placement(transformation(extent={{-22,-62},{18,-22}}),
        iconTransformation(extent={{-340,110},{-300,150}})));
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

  Buildings.Templates.Components.Interfaces.Bus bus_HeaVal "Pump control bus"
    annotation (Placement(transformation(extent={{-346,154},{-306,194}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));

  Buildings.Templates.Components.Interfaces.Bus bus_CooVal "Pump control bus"
    annotation (Placement(transformation(extent={{216,122},{256,162}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Templates.Components.Sensors.Temperature TRetCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{144,14},{124,34}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop(datHpAwNrv(mHeaWat_flow_nominal=23, capHea_nominal=2*
          datHpAwNrv.capHeaHp_nominal), datCoolingTowerWHE(
        CoolingCapacity_nominal=1*datHpAwNrv.capCooHp_nominal))
    annotation (Placement(transformation(extent={{-2,210},{18,230}})));
  Controls.ExternalEnergy         externalEnergyOpenLoop
    annotation (Placement(transformation(extent={{48,240},{68,260}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-32,260},{-12,280}})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={{18,270},
            {58,310}}),        iconTransformation(extent={{30,50},{70,90}})));
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minFloHea(k=0.1*datHpAwNrv.mHeaWatHp_flow_nominal
        /1000) "Pump speed command"
    annotation (Placement(transformation(extent={{-412,164},{-392,184}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{-474,100},{-454,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-514,100},{-494,120}})));
  Fluid.Sensors.Temperature senTem(redeclare package Medium = Media.Water,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{-440,60},{-420,80}})));
  Buildings.Templates.Components.Interfaces.Bus bus_HeaCoiVal
    "Valve control bus" annotation (Placement(transformation(extent={{-370,100},
            {-330,140}}), iconTransformation(extent={{-318,-118},{-278,-78}})));
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
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=5)
    annotation (Placement(transformation(extent={{-512,0},{-492,20}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-474,0},{-454,20}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resTSetCoo(
    nSenDpRem=1,
    dpSet_max={6*6894},
    TSup_nominal=279.85,
    TSupSetLim=285.85,
    nReqResIgn=2)
    annotation (Placement(transformation(extent={{-406,-42},{-386,-22}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con5(k=false)
    annotation (Placement(transformation(extent={{-480,-58},{-460,-38}})));
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
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
    k=0.2,
    Ti=150,                                            reverseActing=false)
    annotation (Placement(transformation(extent={{378,80},{398,100}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=273.15 + 12.7)
    annotation (Placement(transformation(extent={{348,80},{368,100}})));
  Buildings.Templates.Components.Interfaces.Bus bus_CooCoiVal
    "Valve control bus" annotation (Placement(transformation(extent={{280,100},{
            320,140}}), iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resdPSetCoo(
    nSenDpRem=1,
    dpSet_max={1000},
    dpSet_min=500,
    TSup_nominal=280.37,
    TSupSetLim=289.15)
    annotation (Placement(transformation(extent={{418,130},{438,150}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai3(k=5)
    annotation (Placement(transformation(extent={{308,150},{328,170}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{338,150},{358,170}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con3(k=false)
    annotation (Placement(transformation(extent={{356,126},{376,146}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-26,8},{-46,28}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1) annotation (Placement(transformation(extent={{22,116},{42,136}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{-442,-14},{-422,6}})));
  Controls.ExternalEnergyLoopOperationMode extEneOpeMod(THotRetLim=273.15 + 70,
      TCooRetLim=273.15 + 11)
    annotation (Placement(transformation(extent={{-40,230},{-20,250}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulHea(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mHeaWatHp_flow_nominal, pum.nPum),
    dp_nominal=fill(1.5*5E6, pum.nPum),
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.heatPumpPlant_Heating per)
                                    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-62,-200},{-42,-180}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con6(k=true)
    annotation (Placement(transformation(extent={{-520,-70},{-500,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con7(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-520,-110},{-500,-90}})));
  Buildings.Templates.Plants.Controls.Enabling.Enable ena(typ=Buildings.Templates.Plants.Controls.Types.Application.Cooling,
      have_inpSch=true)
    annotation (Placement(transformation(extent={{-480,-90},{-460,-70}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resdPSetHea(
    nSenDpRem=1,
    dpSet_max={1000},
    dpSet_min=500,
    TSup_nominal=333.15,
    TSupSetLim=305.37)
    annotation (Placement(transformation(extent={{-372,-70},{-352,-50}})));

  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/Data/Templates/HeatPumpPlant/loads.dat"),
    final tableOnFile=true,
    final columns=2:3,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{-564,42},{-544,62}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai4(k=-1)
    annotation (Placement(transformation(extent={{-514,30},{-494,50}})));
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
  Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{-196,108},{-176,128}})));
  Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{50,60},{70,80}})));
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
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu
    annotation (Placement(transformation(extent={{100,210},{120,230}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{60,190},{80,210}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{140,210},{160,230}})));
  Buildings.Templates.Components.Interfaces.Bus bus_CooHEBypVal
    "Pump control bus" annotation (Placement(transformation(extent={{92,-50},{132,
            -10}}),    iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Templates.Components.Interfaces.Bus bus_HeaHEBypVal
    "Pump control bus" annotation (Placement(transformation(extent={{-186,170},{
            -146,210}}),  iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-228,220},{-208,240}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=3)
    annotation (Placement(transformation(extent={{-278,210},{-258,230}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-198,220},{-178,240}})));
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant condPSet(k=1000)
    annotation (Placement(transformation(extent={{-370,-110},{-350,-90}})));
  Modelica.Blocks.Routing.RealPassThrough dPSetHea
    annotation (Placement(transformation(extent={{-320,-76},{-300,-56}})));
  Modelica.Blocks.Routing.RealPassThrough TSetHP
    annotation (Placement(transformation(extent={{-318,-40},{-298,-20}})));
  Modelica.Blocks.Routing.RealPassThrough dPSetCoo
    annotation (Placement(transformation(extent={{458,130},{478,150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conTSetHP(k=273.15 + 6.7)
    annotation (Placement(transformation(extent={{-370,-150},{-350,-130}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant condPSet1(k=1000)
    annotation (Placement(transformation(extent={{418,160},{438,180}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPIDBypHea(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{-376,164},{-356,184}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateHeaPri(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-188,24})));
  Buildings.Controls.OBC.CDL.Reals.PID conPIDBypCoo(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{206,210},{226,230}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minFloCoo(k=0.1*datHpAwNrv.mChiWatHp_flow_nominal
        /1000) "Pump speed command"
    annotation (Placement(transformation(extent={{176,210},{196,230}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateCooPri(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={154,100})));
equation
  connect(ctlHeaInl.bus, valIsoHeaInl.bus) annotation (Line(
      points={{-68,-7.6},{-68,-6},{-24,-6},{-24,60},{-2,60}},
      color={255,204,51},
      thickness=0.5));
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
  connect(bus_HeaVal, valve.bus) annotation (Line(
      points={{-326,174},{-326,78},{-268,78},{-268,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(jun.port_2, dPHea.port_a) annotation (Line(points={{-268,24},{-292,24},
          {-292,46}},                     color={0,127,255}));
  connect(jun6.port_1, dPHea.port_b) annotation (Line(points={{-268,98},{-292,98},
          {-292,66}},                     color={0,127,255}));

  connect(jun2.port_3, valve1.port_a)
    annotation (Line(points={{214,34},{214,50}}, color={0,127,255}));
  connect(valve1.port_b, jun1.port_3) annotation (Line(points={{214,70},{214,90}},
                              color={0,127,255}));
  connect(bus_CooVal, valve1.bus) annotation (Line(
      points={{236,142},{236,60},{224,60}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(jun1.port_2, dPCoo.port_a)
    annotation (Line(points={{224,100},{232,100},{232,58}},
                                                          color={0,127,255}));
  connect(jun2.port_1, dPCoo.port_b) annotation (Line(points={{224,24},{232,24},
          {232,38}},                                   color={0,127,255}));

  connect(resTSetCoo.TSupSet, bus_sensor.TSupHeaSet);
connect(TSupHea.y, bus_sensor.TSupHea);
connect(TSupCoo.y, bus_sensor.TSupCoo);
connect(dPHea.y, bus_sensor.uDpHea);
connect(dPCoo.y, bus_sensor.uDpCoo);
connect(TRetHea.y,extEneOpeMod.THotRet);
  connect(ctlHeaInl.bus, hpAwNrv.bus) annotation (Line(
      points={{-68,-7.6},{-68,-6},{-24,-6},{-24,8},{32,8},{32,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_sensor, ctlHeaInl.bus) annotation (Line(
      points={{-2,-42},{-2,8},{-24,8},{-24,-7.6},{-68,-7.6}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pum1.bus, ctlHeaInl.bus_HeaPum) annotation (Line(
      points={{-114,34},{-114,40},{-64,40},{-64,-6},{-67.8,-6},{-67.8,-20}},
      color={255,204,51},
      thickness=0.5));
  connect(pum.bus, ctlHeaInl.bus_CooPum) annotation (Line(
      points={{96,110},{-52,110},{-52,-13.8},{-68,-13.8}},
      color={255,204,51},
      thickness=0.5));
  connect(rou.ports_b, pum.ports_a) annotation (Line(points={{74,100},{86,100}},
                           color={0,127,255}));
  connect(pum.ports_b, rou3.ports_b) annotation (Line(points={{106,100},{120,100}},
                                   color={0,127,255}));
  connect(rou1.ports_b, pum1.ports_a)
    annotation (Line(points={{-78,24},{-104,24}},          color={0,127,255}));
  connect(pum1.ports_b, rou2.ports_b) annotation (Line(points={{-124,24},{-140,24}},
                          color={0,127,255}));
  connect(externalEnergyOpenLoop.bus,bus)  annotation (Line(
      points={{58,260},{58,266},{38,266},{38,290}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(bus,externalEnergyLoop. bus) annotation (Line(
      points={{38,290},{38,236},{12,236},{12,230}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaDat.weaBus,externalEnergyLoop. busWea) annotation (Line(
      points={{-12,270},{4,270},{4,230}},
      color={255,204,51},
      thickness=0.5));
  connect(preHeaFlo.port, vol.heatPort)
    annotation (Line(points={{-388,40},{-376,40},{-376,70},{-370,70}},
                                                   color={191,0,0}));
  connect(senTem.T,conPID. u_m) annotation (Line(points={{-423,70},{-464,70},{
          -464,98}},                color={0,0,127}));
  connect(con.y,conPID. u_s)
    annotation (Line(points={{-492,110},{-476,110}},
                                                   color={0,0,127}));
  connect(valve2.port_a, vol.ports[1]) annotation (Line(points={{-358,24},{
          -361.333,24},{-361.333,60}},
                          color={0,127,255}));
  connect(bus_HeaCoiVal, valve2.bus) annotation (Line(
      points={{-350,120},{-342,120},{-342,40},{-348,40},{-348,34}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_HeaCoiVal.y, conPID.y) annotation (Line(
      points={{-350,120},{-372,120},{-372,110},{-452,110}},
      color={255,204,51},
      thickness=0.5));
  connect(vol.ports[2], senTem.port) annotation (Line(points={{-360,60},{-430,60}},
                                      color={0,127,255}));
  connect(gai.y,reaToInt. u) annotation (Line(points={{-490,10},{-476,10}},
                       color={0,0,127}));
  connect(con5.y, resTSetCoo.u1StaPro) annotation (Line(points={{-458,-48},{
          -408,-48},{-408,-38}},       color={255,0,255}));
  connect(gai.u, bus_HeaCoiVal.y_actual) annotation (Line(points={{-514,10},{
          -514,138},{-348,138},{-348,120},{-350,120}},      color={0,0,127}));

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
  connect(con2.y, conPID1.u_s) annotation (Line(points={{370,90},{376,90}},
                     color={0,0,127}));
  connect(senTem1.T, conPID1.u_m) annotation (Line(points={{357,50},{388,50},{
          388,78}},               color={0,0,127}));
  connect(bus_CooCoiVal, valve3.bus) annotation (Line(
      points={{300,120},{280,120},{280,110}},
      color={255,204,51},
      thickness=0.5));

  connect(conPID1.y, bus_CooCoiVal.y) annotation (Line(points={{400,90},{410,90},
          {410,120},{300,120}}, color={0,0,127}));
  connect(gai3.y, reaToInt1.u)
    annotation (Line(points={{330,160},{336,160}},
                                               color={0,0,127}));
  connect(bus_CooCoiVal.y_actual, gai3.u) annotation (Line(
      points={{300,120},{274,120},{274,160},{306,160}},
      color={255,204,51},
      thickness=0.5));
  connect(con3.y, resdPSetCoo.u1StaPro) annotation (Line(points={{378,136},{397,
          136},{397,134},{416,134}},
                                   color={255,0,255}));
  connect(bou.ports[1], rou1.port_a) annotation (Line(points={{-46,18},{-58,18},
          {-58,24}},          color={0,127,255}));
  connect(bou1.ports[1], rou.port_a) annotation (Line(points={{42,126},{54,126},
          {54,100}},                      color={0,127,255}));
  connect(reaToInt.y, addInt.u1) annotation (Line(points={{-452,10},{-444,10},{
          -444,2}},       color={255,127,0}));
  connect(reaToInt1.y, addInt.u2) annotation (Line(points={{360,160},{408,160},
          {408,-118},{-444,-118},{-444,-10}},
                       color={255,127,0}));
  connect(reaToInt1.y, resdPSetCoo.nReqRes) annotation (Line(points={{360,160},
          {408,160},{408,146},{416,146}},
                                    color={255,127,0}));
  connect(extEneOpeMod.yOpeMod, bus.uOpeMod)
    annotation (Line(points={{-18,240},{38,240},{38,290}}, color={255,127,0}));
  connect(addInt.y, ena.nReqPla) annotation (Line(points={{-420,-4},{-414,-4},{
          -414,-20},{-528,-20},{-528,-80},{-482,-80}},
                            color={255,127,0}));
  connect(con6.y, ena.u1Sch) annotation (Line(points={{-498,-60},{-482,-60},{
          -482,-76}},       color={255,0,255}));
  connect(con7.y, ena.TOut) annotation (Line(points={{-498,-100},{-482,-100},{
          -482,-84}},       color={0,0,127}));
  connect(ena.y1, bus_sensor.uPlaEna) annotation (Line(points={{-458,-80},{-2,
          -80},{-2,-42}},                                color={255,0,255}));
  connect(ena.y1, resTSetCoo.u1Ena) annotation (Line(points={{-458,-80},{-420,
          -80},{-420,-32},{-408,-32}},                  color={255,0,255}));
  connect(reaToInt.y, resdPSetHea.nReqRes) annotation (Line(points={{-452,10},{
          -374,10},{-374,-54}},   color={255,127,0}));
  connect(con5.y, resdPSetHea.u1StaPro) annotation (Line(points={{-458,-48},{
          -380,-48},{-380,-66},{-374,-66}},
                                       color={255,0,255}));
  connect(ena.y1, resdPSetHea.u1Ena) annotation (Line(points={{-458,-80},{-420,
          -80},{-420,-60},{-374,-60}},                       color={255,0,255}));
  connect(ena.y1, resdPSetCoo.u1Ena) annotation (Line(points={{-458,-80},{386,
          -80},{386,140},{416,140}},                  color={255,0,255}));
  connect(addInt.y, resTSetCoo.nReqRes) annotation (Line(points={{-420,-4},{
          -408,-4},{-408,-26}},
                           color={255,127,0}));
  connect(datRea.y[1], gai4.u) annotation (Line(points={{-543,52},{-516,52},{
          -516,40}},        color={0,0,127}));
  connect(gai4.y, preHeaFlo.Q_flow) annotation (Line(points={{-492,40},{-408,40}},
                                color={0,0,127}));
  connect(datRea.y[2], preHeaFlo1.Q_flow) annotation (Line(points={{-543,52},{
          -458,52},{-458,318},{264,318},{264,50},{286,50}},      color={0,0,127}));
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
  connect(TRetHeaCon.y, bus.coolingTowerSystemBus.TRetHea);
  connect(TRetCooCon.y, bus.TRetCoo);
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
  connect(reaToInt.y, extEneOpeMod.uReqHea) annotation (Line(points={{-452,10},
          {-342,10},{-342,8},{-310,8},{-310,108},{-288,108},{-288,246},{-42,246}},
        color={255,127,0}));
  connect(reaToInt1.y, extEneOpeMod.uReqCoo) annotation (Line(points={{360,160},
          {360,186},{-48,186},{-48,242},{-42,242}},
                                         color={255,127,0}));
  connect(bou3.ports[1], hex1.port_b1) annotation (Line(points={{70,70},{104,70},
          {104,36},{96,36}}, color={0,127,255}));
  connect(valve4.port_a, TRetHea.port_b) annotation (Line(points={{-156,74},{-172,
          74},{-172,98},{-178,98}},        color={0,127,255}));
  connect(valve4.port_b, TRetHeaCon.port_a) annotation (Line(points={{-136,74},{
          -90,74},{-90,100},{-80,100}},                           color={0,127,
          255}));
  connect(valve5.port_a, TRetCoo.port_b) annotation (Line(points={{96,-12},{102,
          -12},{102,24},{124,24}}, color={0,127,255}));
  connect(valve5.port_b, TRetCooCon.port_a) annotation (Line(points={{76,-12},{70,
          -12},{70,24},{60,24}},    color={0,127,255}));
  connect(extEneOpeMod.yOpeMod, intEqu.u1) annotation (Line(points={{-18,240},{
          38,240},{38,220},{98,220}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2)
    annotation (Line(points={{82,200},{92,200},{92,212},{98,212}},
                                                          color={255,127,0}));
  connect(not1.u, intEqu.y)
    annotation (Line(points={{138,220},{122,220}},
                                                 color={255,0,255}));
  connect(bus_CooHEBypVal, valve5.bus) annotation (Line(
      points={{112,-30},{112,-2},{86,-2}},
      color={255,204,51},
      thickness=0.5));
  connect(not1.y, bus_CooHEBypVal.y1) annotation (Line(points={{162,220},{168,
          220},{168,156},{112,156},{112,-30}},                 color={255,0,255}));
  connect(valve4.bus, bus_HeaHEBypVal) annotation (Line(
      points={{-146,84},{-146,94},{-166,94},{-166,190}},
      color={255,204,51},
      thickness=0.5));
  connect(intEqu1.y, not2.u)
    annotation (Line(points={{-206,230},{-200,230}}, color={255,0,255}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{-256,220},{-256,222},
          {-230,222}}, color={255,127,0}));
  connect(extEneOpeMod.yOpeMod, intEqu1.u1) annotation (Line(points={{-18,240},{
          -14,240},{-14,252},{-194,252},{-194,244},{-230,244},{-230,230}},
                 color={255,127,0}));
  connect(not2.y, bus_HeaHEBypVal.y1) annotation (Line(points={{-176,230},{-166,
          230},{-166,190}},            color={255,0,255}));
  connect(extEneOpeMod.yOpeMod, bus_sensor.uOpeMod) annotation (Line(points={{-18,240},
          {-2,240},{-2,-42}},                     color={255,127,0}));
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
  connect(bou2.ports[1], hex.port_b1) annotation (Line(points={{-176,118},{-160,
          118},{-160,110},{-156,110}}, color={0,127,255}));
  connect(TSetHP.y, bus_sensor.TSetHP) annotation (Line(points={{-297,-30},{
          -210,-30},{-210,-94},{-106,-94},{-106,-42},{-2,-42}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dPSetHea.y, bus_sensor.uDpHeaSet) annotation (Line(points={{-299,-66},
          {-210,-66},{-210,-94},{-106,-94},{-106,-42},{-2,-42}},
                                       color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dPSetCoo.y, bus_sensor.uDpCooSet) annotation (Line(points={{479,140},
          {470,140},{470,-42},{-2,-42}},                     color={0,0,127}),
      Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(volumeFlowRateHeaPri.port_b, TSupHea.port_b)
    annotation (Line(points={{-198,24},{-212,24}}, color={0,127,255}));
  connect(volumeFlowRateHeaPri.port_a, rou2.port_a) annotation (Line(points={{-178,24},
          {-160,24}},                                             color={0,127,255}));
  connect(volumeFlowRateHeaPri.y, conPIDBypHea.u_m);
  connect(conPIDBypHea.y, bus_HeaVal.y) annotation (Line(points={{-354,174},{-326,
          174}},            color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(minFloHea.y, conPIDBypHea.u_s) annotation (Line(points={{-390,174},{-378,
          174}},                       color={0,0,127}));
  connect(minFloCoo.y, conPIDBypCoo.u_s)
    annotation (Line(points={{198,220},{204,220}}, color={0,0,127}));
  connect(conPIDBypCoo.y, bus_CooVal.y) annotation (Line(points={{228,220},{236,
          220},{236,142}},                     color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(volumeFlowRateCooPri.y, conPIDBypCoo.u_m);
  connect(rou3.port_a, volumeFlowRateCooPri.port_a) annotation (Line(points={{140,100},
          {144,100}},                                        color={0,127,255}));
  connect(volumeFlowRateCooPri.port_b, TSupCoo.port_a) annotation (Line(points={{164,100},
          {174,100}},                               color={0,127,255}));
  connect(resdPSetCoo.dpSet[1], dPSetCoo.u) annotation (Line(points={{440,146},
          {440,140},{456,140}},    color={0,0,127}));
  connect(resdPSetHea.dpSet[1], dPSetHea.u) annotation (Line(points={{-350,-54},
          {-330,-54},{-330,-66},{-322,-66}},                       color={0,0,
          127}));
  connect(resTSetCoo.TSupSet, TSetHP.u) annotation (Line(points={{-384,-38},{
          -328,-38},{-328,-30},{-320,-30}},                           color={0,
          0,127}));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-580,-160},{500,320}})),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
        "Simulate and plot"),
    experiment(
      StartTime=23587200,
      StopTime=26179200,
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
    Icon(coordinateSystem(extent={{-580,-160},{500,320}})));
end ExternalEnergyLoopIntegration_Buffalo;
