within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model ExternalEnergyLoopIntegration
  "Control Box Test"

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
    mHeaWatHp_flow_nominal=datHpAwNrv.capHeaHp_nominal / abs(datHpAwNrv.THeaWatSupHp_nominal -
      Buildings.Templates.Data.Defaults.THeaWatRetMed) / Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=4*1.2E6,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWatHp_flow_nominal=datHpAwNrv.capCooHp_nominal/abs(datHpAwNrv.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCooHp_nominal=4*2.5E6,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mSouWwHeaHp_flow_nominal=datHpAwNrv.capHeaHp_nominal/abs(datHpAwNrv.THeaWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpSouWwHeaHp_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpHeaWatHp,
    TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
    mSouWwCooHp_flow_nominal=datHpAwNrv.capCooHp_nominal/abs(datHpAwNrv.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    perFitHp(
      hea(
        P=datHpAwNrv.capHeaHp_nominal / Buildings.Templates.Data.Defaults.COPHpAwHea,
        coeQ={- 4.2670305442, - 0.7381077035, 6.0049480456, 0, 0},
        coeP={- 4.9107455513, 5.3665308366, 0.5447612754, 0, 0},
        TRefLoa=Buildings.Templates.Data.Defaults.THeaWatRetMed,
        TRefSou=Buildings.Templates.Data.Defaults.TOutHpHeaLow)))
    "Non-reversible AWHP parameters"
    annotation (Placement(transformation(extent={{-150,-190},{-130,-170}})));

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater
    hpAwNrv(
    redeclare final package MediumHeaWat = Medium,
    nHp=1,
    is_rev=true,
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
    mHeaWatHp_flow_nominal=datHp.capHeaHp_nominal/abs(datHp.THeaWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    dpHeaWatHp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatHp,
    capHeaHp_nominal=500E3,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    TSouHeaHp_nominal=Buildings.Templates.Data.Defaults.TOutHpHeaLow,
    mChiWatHp_flow_nominal=datHp.capCooHp_nominal/abs(datHp.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCooHp_nominal=500E3,
    TChiWatSupHp_nominal=Buildings.Templates.Data.Defaults.TChiWatSup,
    TSouCooHp_nominal=Buildings.Templates.Data.Defaults.TOutHpCoo,
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
    annotation (Placement(transformation(extent={{-50,110},{-70,130}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMulCoo,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{46,72},{66,92}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulCoo(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mChiWatHp_flow_nominal*10, pum.nPum),
    dp_nominal=fill(1E5, pum.nPum)) "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-110,-194},{-90,-174}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{14,72},{34,92}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou1(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{-58,36},{-78,56}})));
  Buildings.Templates.Components.Pumps.Multiple pum1(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMulHea,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{-104,36},{-124,56}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou2(
    redeclare package Medium = Medium,
    nPorts=pum1.nPum,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{-160,36},{-140,56}})));
  Fluid.FixedResistances.Junction jun(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mHeaWatHp_flow_nominal,-datHpAwNrv.mHeaWatHp_flow_nominal,
        -datHpAwNrv.mHeaWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-226,24})));
  Fluid.FixedResistances.Junction jun6(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mHeaWatHp_flow_nominal,-datHpAwNrv.mHeaWatHp_flow_nominal,
        -datHpAwNrv.mHeaWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={-212,94})));
  Buildings.Templates.Components.Actuators.Valve valve(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-214,56})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPHea(redeclare
      package Medium = Media.Water)           annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-270,62})));
  Buildings.Templates.Components.Sensors.Temperature TSupHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{-210,6},{-190,26}})));
  HeatPumps.Interfaces.Bus bus_sensor
    annotation (Placement(transformation(extent={{-340,110},{-300,150}})));
  Buildings.Templates.Components.Routing.SingleToMultiple rou3(
    redeclare package Medium = Medium,
    nPorts=pum.nPum,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{100,72},{80,92}})));
  Fluid.FixedResistances.Junction jun1(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mChiWatHp_flow_nominal,-datHpAwNrv.mChiWatHp_flow_nominal,
        -datHpAwNrv.mChiWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{10,10},{-10,-10}},
        rotation=180,
        origin={162,86})));
  Fluid.FixedResistances.Junction jun2(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal={datHpAwNrv.mChiWatHp_flow_nominal,-datHpAwNrv.mChiWatHp_flow_nominal,
        -datHpAwNrv.mChiWatHp_flow_nominal},
    dp_nominal={0,0,0}) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={164,22})));
  Buildings.Templates.Components.Actuators.Valve valve1(
    redeclare package Medium = Buildings.Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=90,
        origin={164,50})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y3(k=0.1)
    "Pump speed command"
    annotation (Placement(transformation(extent={{126,184},{146,204}})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPCoo(redeclare
      package Medium = Buildings.Media.Water) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={190,48})));
  Buildings.Templates.Components.Sensors.Temperature TSupCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{130,108},{150,128}})));

  Buildings.Templates.Components.Interfaces.Bus bus_HeaVal "Pump control bus"
    annotation (Placement(transformation(extent={{-262,166},{-222,206}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));

  Buildings.Templates.Components.Interfaces.Bus bus_CooVal "Pump control bus"
    annotation (Placement(transformation(extent={{150,122},{190,162}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Templates.Components.Sensors.Temperature TRetCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{144,14},{124,34}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop(datCoolingTowerWHE(CoolingCapacity_nominal=2*datHpAwNrv.capHeaHp_nominal))
    annotation (Placement(transformation(extent={{-2,210},{18,230}})));
  Controls.ExternalEnergy         externalEnergyOpenLoop
    annotation (Placement(transformation(extent={{48,240},{68,260}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-32,260},{-12,280}})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent=
            {{18,270},{58,310}}), iconTransformation(extent={{30,50},{70,90}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHea(redeclare package
      Medium = Buildings.Media.Water,
                            m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-178,104})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Buildings.Media.Water,
    T_start=338.15,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    V=datHpAwNrv.mHeaWatHp_flow_nominal*1200/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{-370,60},{-350,80}})));
  HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(extent={{-400,60},{-380,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y4(k=-20000)
    "Pump speed command"
    annotation (Placement(transformation(extent={{-460,60},{-440,80}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{-400,100},{-380,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-488,90},{-468,110}})));
  Fluid.Sensors.Temperature senTem(redeclare package Medium = Media.Water,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{-462,110},{-442,130}})));
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
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai2(k=-1)
    annotation (Placement(transformation(extent={{-400,190},{-380,210}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{-360,190},{-340,210}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=5)
    annotation (Placement(transformation(extent={{-440,32},{-420,52}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-400,0},{-380,20}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resCoo1(
    nSenDpRem=1,
    dpSet_max={6*6894},
    TSup_nominal=280.81,
    TSupSetLim=285.85,
    nReqResIgn=4)
    annotation (Placement(transformation(extent={{-340,-38},{-320,-18}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con5(k=false)
    annotation (Placement(transformation(extent={{-400,-38},{-380,-18}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = Buildings.Media.Water,
    T_start=285.85,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    V=datHpAwNrv.mHeaWatHp_flow_nominal*600/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{260,40},{280,60}})));
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
        origin={236,68})));
  HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo1
    annotation (Placement(transformation(extent={{254,100},{274,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y5(k=5000)
    "Pump speed command"
    annotation (Placement(transformation(extent={{222,100},{242,120}})));
  Fluid.Sensors.Temperature senTem1(redeclare package Medium = Media.Water,
      warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{300,60},{320,80}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID1(
    k=0.2,
    Ti=150,                                            reverseActing=false)
    annotation (Placement(transformation(extent={{410,40},{430,60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con2(k=273.15 + 12.7)
    annotation (Placement(transformation(extent={{320,30},{340,50}})));
  Buildings.Templates.Components.Interfaces.Bus bus_CooCoiVal
    "Valve control bus" annotation (Placement(transformation(extent={{270,100},{
            310,140}}), iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=-1)
    annotation (Placement(transformation(extent={{322,130},{342,150}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{362,130},{382,150}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resCoo(
    nSenDpRem=1,
    dpSet_max={6*6894},
    TSup_nominal=280.37,
    TSupSetLim=289.15)
    annotation (Placement(transformation(extent={{380,-10},{400,10}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai3(k=5)
    annotation (Placement(transformation(extent={{310,2},{330,22}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    annotation (Placement(transformation(extent={{344,6},{364,26}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con3(k=false)
    annotation (Placement(transformation(extent={{332,-60},{352,-40}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-86,54},{-66,74}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1) annotation (Placement(transformation(extent={{22,116},{42,136}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{-368,-14},{-348,6}})));
  Controls.ExternalEnergyLoopOperationMode extEneOpeMod(THotRetLim=273.15 + 65,
      TCooRetLim=273.15 + 11)
    annotation (Placement(transformation(extent={{-40,230},{-20,250}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulHea(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mHeaWatHp_flow_nominal*10, pum.nPum),
    dp_nominal=fill(1E5, pum.nPum)) "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-62,-198},{-42,-178}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con6(k=true)
    annotation (Placement(transformation(extent={{-300,-40},{-280,-20}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con7(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-300,-70},{-280,-50}})));
  Buildings.Templates.Plants.Controls.Enabling.Enable ena(typ=Buildings.Templates.Plants.Controls.Types.Application.Cooling,
      have_inpSch=true)
    annotation (Placement(transformation(extent={{-260,-50},{-240,-30}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resHea1(
    nSenDpRem=1,
    dpSet_max={6*6894},
    TSup_nominal=333.15,
    TSupSetLim=305.37)
    annotation (Placement(transformation(extent={{-340,-70},{-320,-50}})));

  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/Data/Templates/HeatPumpPlant/loads.dat"),
    final tableOnFile=true,
    final columns=2:3,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{-456,150},{-436,170}})));

  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai4(k=-1)
    annotation (Placement(transformation(extent={{-380,160},{-360,180}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{-134,96},{-154,116}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(
    redeclare package Medium1 = Buildings.Media.Water,
    redeclare package Medium2 = Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    dp1_nominal=5000,
    dp2_nominal=5000,
    eps=0.9)
    annotation (Placement(transformation(extent={{76,16},{96,36}})));
  Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{-196,132},{-176,152}})));
  Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{52,38},{72,58}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHeaCon(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-106,106})));
  Buildings.Templates.Components.Sensors.Temperature TRetCooCon(redeclare
      package Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{60,10},{40,30}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-288,14})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRate1(
    redeclare package Medium = Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={204,82})));
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
    annotation (Placement(transformation(extent={{60,180},{80,200}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=-2)
    annotation (Placement(transformation(extent={{20,170},{40,190}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{90,180},{110,200}})));
  Buildings.Templates.Components.Interfaces.Bus bus_CooHEBypVal
    "Pump control bus" annotation (Placement(transformation(extent={{104,-48},{
            144,-8}}), iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Templates.Components.Interfaces.Bus bus_HeaHEBypVal
    "Pump control bus" annotation (Placement(transformation(extent={{-180,170},
            {-140,210}}), iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1
    annotation (Placement(transformation(extent={{-190,220},{-170,240}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=3)
    annotation (Placement(transformation(extent={{-230,210},{-210,230}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-160,220},{-140,240}})));
equation
  connect(ctlHeaInl.bus, valIsoHeaInl.bus) annotation (Line(
      points={{-50,126.4},{-1.4,126.4},{-1.4,58.53}},
      color={255,204,51},
      thickness=0.5));
  connect(valIsoHeaInl.port_bChiWat, rou.port_a) annotation (Line(points={{20,54.12},
          {26,54.12},{26,66},{8,66},{8,82},{14,82}},             color={0,127,255}));
  connect(valIsoHeaInl.port_bHeaWat, rou1.port_a) annotation (Line(points={{-22,
          45.51},{-52,45.51},{-52,46},{-58,46}},      color={0,127,255}));
  connect(hpAwNrv.ports_bHotWat, valIsoHeaInl.ports_aHeaWatHp) annotation (Line(
        points={{-18,-113.8},{-18,-122},{-218,-122},{-218,6},{-16.6,6},{-16.6,18.21}},
                   color={0,127,255}));
  connect(valIsoHeaInl.ports_bHeaWatHp, hpAwNrv.ports_aHotWat) annotation (Line(
        points={{-6,18.21},{-6,10},{-222,10},{-222,-126},{82,-126},{82,-114}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_aChiWatHp, hpAwNrv.ports_bChiWat) annotation (Line(
        points={{4.6,18.42},{4.6,10},{34,10},{34,-26},{82,-26},{82,-34}},
        color={0,127,255}));
  connect(valIsoHeaInl.ports_bChiWatHp, hpAwNrv.ports_aChiWat) annotation (Line(
        points={{14.8,18.21},{14.8,-26},{-18,-26},{-18,-34}},color={0,127,255}));
  connect(jun.port_3, valve.port_a)
    annotation (Line(points={{-226,34},{-216,34},{-216,46},{-214,46}},
                                                   color={0,127,255}));
  connect(valve.port_b, jun6.port_3)
    annotation (Line(points={{-214,66},{-204,66},{-204,72},{-212,72},{-212,84}},
                                                   color={0,127,255}));
  connect(bus_HeaVal, valve.bus) annotation (Line(
      points={{-242,186},{-242,56},{-224,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(jun.port_2, dPHea.port_a) annotation (Line(points={{-236,24},{-270,24},
          {-270,52}},                     color={0,127,255}));
  connect(jun6.port_1, dPHea.port_b) annotation (Line(points={{-222,94},{-270,
          94},{-270,72}},                 color={0,127,255}));

  connect(jun2.port_3, valve1.port_a)
    annotation (Line(points={{164,32},{164,40}}, color={0,127,255}));
  connect(valve1.port_b, jun1.port_3) annotation (Line(points={{164,60},{162,60},
          {162,76}},          color={0,127,255}));
  connect(bus_CooVal, valve1.bus) annotation (Line(
      points={{170,142},{172,142},{172,104},{180,104},{180,68},{184,68},{184,50},
          {174,50}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(jun1.port_2, dPCoo.port_a)
    annotation (Line(points={{172,86},{190,86},{190,58}}, color={0,127,255}));
  connect(jun2.port_1, dPCoo.port_b) annotation (Line(points={{174,22},{190,22},
          {190,38}},                                   color={0,127,255}));

  connect(resCoo1.TSupSet, bus_sensor.TSupHeaSet);
connect(TSupHea.y, bus_sensor.TSupHea);
connect(TSupCoo.y, bus_sensor.TSupCoo);
connect(dPHea.y, bus_sensor.uDpHea);
connect(dPCoo.y, bus_sensor.uDpCoo);
connect(TRetHea.y,extEneOpeMod.THotRet);
connect(TRetCoo.y,extEneOpeMod.TCooRet);
  connect(ctlHeaInl.bus, hpAwNrv.bus) annotation (Line(
      points={{-50,126.4},{0,126.4},{0,62},{32,62},{32,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_sensor, ctlHeaInl.bus) annotation (Line(
      points={{-320,130},{-222,130},{-222,126},{-76,126},{-76,136},{-44,136},{
          -44,126.4},{-50,126.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pum1.bus, ctlHeaInl.bus_HeaPum) annotation (Line(
      points={{-114,56},{-116,56},{-116,92},{-44,92},{-44,114},{-49.8,114}},
      color={255,204,51},
      thickness=0.5));
  connect(pum.bus, ctlHeaInl.bus_CooPum) annotation (Line(
      points={{56,92},{56,100},{-38,100},{-38,120.2},{-50,120.2}},
      color={255,204,51},
      thickness=0.5));
  connect(rou.ports_b, pum.ports_a) annotation (Line(points={{34,82},{46,82}},
                           color={0,127,255}));
  connect(pum.ports_b, rou3.ports_b) annotation (Line(points={{66,82},{80,82}},
                                   color={0,127,255}));
  connect(rou1.ports_b, pum1.ports_a)
    annotation (Line(points={{-78,46},{-104,46}},          color={0,127,255}));
  connect(pum1.ports_b, rou2.ports_b) annotation (Line(points={{-124,46},{-140,
          46}},           color={0,127,255}));
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
    annotation (Line(points={{-380,70},{-370,70}}, color={191,0,0}));
  connect(senTem.T,conPID. u_m) annotation (Line(points={{-445,120},{-414,120},{
          -414,98},{-390,98}},      color={0,0,127}));
  connect(con.y,conPID. u_s)
    annotation (Line(points={{-466,100},{-426,100},{-426,110},{-402,110}},
                                                   color={0,0,127}));
  connect(valve2.port_a, vol.ports[1]) annotation (Line(points={{-358,24},{
          -361.333,24},{-361.333,60}},
                          color={0,127,255}));
  connect(bus_HeaCoiVal, valve2.bus) annotation (Line(
      points={{-350,120},{-342,120},{-342,40},{-348,40},{-348,34}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_HeaCoiVal.y, conPID.y) annotation (Line(
      points={{-350,120},{-372,120},{-372,110},{-378,110}},
      color={255,204,51},
      thickness=0.5));
  connect(vol.ports[2], senTem.port) annotation (Line(points={{-360,60},{-406,60},
          {-406,110},{-452,110}},     color={0,127,255}));
  connect(conPID.y, gai2.u) annotation (Line(points={{-378,110},{-390,110},{-390,
          200},{-402,200}}, color={0,0,127}));
  connect(addPar.y, bus_HeaVal.y) annotation (Line(points={{-338,200},{-298,200},
          {-298,186},{-242,186}}, color={0,0,127}));
  connect(gai.y,reaToInt. u) annotation (Line(points={{-418,42},{-410,42},{-410,
          10},{-402,10}},
                       color={0,0,127}));
  connect(con5.y, resCoo1.u1StaPro) annotation (Line(points={{-378,-28},{-350,-28},
          {-350,-34},{-342,-34}}, color={255,0,255}));
  connect(gai.u, bus_HeaCoiVal.y_actual) annotation (Line(points={{-442,42},{-304,
          42},{-304,104},{-294,104},{-294,120},{-350,120}}, color={0,0,127}));

  connect(jun6.port_2, TRetHea.port_a) annotation (Line(points={{-202,94},{-194,
          94},{-194,104},{-188,104}}, color={0,127,255}));
  connect(TSupHea.port_a, jun.port_1) annotation (Line(points={{-210,16},{-216,16},
          {-216,24}}, color={0,127,255}));
  connect(vol.ports[3], jun6.port_1) annotation (Line(points={{-358.667,60},{
          -358.667,54},{-290,54},{-290,94},{-222,94}},
                                              color={0,127,255}));
  connect(TSupCoo.port_b, jun1.port_1) annotation (Line(points={{150,118},{150,102},
          {146,102},{146,86},{152,86}}, color={0,127,255}));
  connect(TRetCoo.port_a, jun2.port_2)
    annotation (Line(points={{144,24},{150,24},{150,22},{154,22}},
                                                 color={0,127,255}));
  connect(valve3.port_b, vol1.ports[1]) annotation (Line(points={{246,68},{254,
          68},{254,40},{268.667,40}},
                              color={0,127,255}));
  connect(preHeaFlo1.port, vol1.heatPort) annotation (Line(points={{274,110},{280,
          110},{280,62},{252,62},{252,50},{260,50}}, color={191,0,0}));
  connect(senTem1.port, vol1.ports[2]) annotation (Line(points={{310,60},{310,
          34},{270,34},{270,40}},     color={0,127,255}));
  connect(con2.y, conPID1.u_s) annotation (Line(points={{342,40},{358,40},{358,50},
          {408,50}}, color={0,0,127}));
  connect(senTem1.T, conPID1.u_m) annotation (Line(points={{317,70},{354,70},{354,
          30},{420,30},{420,38}}, color={0,0,127}));
  connect(bus_CooCoiVal, valve3.bus) annotation (Line(
      points={{290,120},{248,120},{248,126},{216,126},{216,84},{236,84},{236,78}},
      color={255,204,51},
      thickness=0.5));

  connect(conPID1.y, bus_CooCoiVal.y) annotation (Line(points={{432,50},{440,50},
          {440,120},{290,120}}, color={0,0,127}));
  connect(bus_CooCoiVal.y_actual, gai1.u) annotation (Line(
      points={{290,120},{268,120},{268,158},{320,158},{320,140}},
      color={255,204,51},
      thickness=0.5));
  connect(gai1.y, addPar1.u)
    annotation (Line(points={{344,140},{360,140}}, color={0,0,127}));
  connect(addPar1.y, bus_CooVal.y) annotation (Line(points={{384,140},{354,140},
          {354,162},{196,162},{196,142},{170,142}}, color={0,0,127}));
  connect(gai3.y, reaToInt1.u)
    annotation (Line(points={{332,12},{338,12},{338,16},{342,16}},
                                               color={0,0,127}));
  connect(bus_CooCoiVal.y_actual, gai3.u) annotation (Line(
      points={{290,120},{268,120},{268,158},{320,158},{320,146},{312,146},{312,
          86},{294,86},{294,12},{308,12}},
      color={255,204,51},
      thickness=0.5));
  connect(con3.y, resCoo.u1StaPro) annotation (Line(points={{354,-50},{358,-50},
          {358,-6},{378,-6}}, color={255,0,255}));
  connect(bou.ports[1], rou1.port_a) annotation (Line(points={{-66,64},{-52,64},
          {-52,46},{-58,46}}, color={0,127,255}));
  connect(bou1.ports[1], rou.port_a) annotation (Line(points={{42,126},{48,126},
          {48,98},{8,98},{8,82},{14,82}}, color={0,127,255}));
  connect(reaToInt.y, addInt.u1) annotation (Line(points={{-378,10},{-374,10},{-374,
          2},{-370,2}},   color={255,127,0}));
  connect(reaToInt1.y, addInt.u2) annotation (Line(points={{366,16},{2,16},{2,
          -10},{-370,-10}},
                       color={255,127,0}));
  connect(reaToInt1.y, resCoo.nReqRes)
    annotation (Line(points={{366,16},{374,16},{374,6},{378,6}},
                                               color={255,127,0}));
  connect(extEneOpeMod.yOpeMod, bus.uOpeMod)
    annotation (Line(points={{-18,240},{38,240},{38,290}}, color={255,127,0}));
  connect(addInt.y, ena.nReqPla) annotation (Line(points={{-346,-4},{-266,-4},{-266,
          -40},{-262,-40}}, color={255,127,0}));
  connect(con6.y, ena.u1Sch) annotation (Line(points={{-278,-30},{-270,-30},{-270,
          -36},{-262,-36}}, color={255,0,255}));
  connect(con7.y, ena.TOut) annotation (Line(points={{-278,-60},{-268,-60},{-268,
          -44},{-262,-44}}, color={0,0,127}));
  connect(ena.y1, bus_sensor.uPlaEna) annotation (Line(points={{-238,-40},{-232,
          -40},{-232,8},{-246,8},{-246,130},{-320,130}}, color={255,0,255}));
  connect(ena.y1, resCoo1.u1Ena) annotation (Line(points={{-238,-40},{-232,-40},
          {-232,-80},{-346,-80},{-346,-28},{-342,-28}}, color={255,0,255}));
  connect(reaToInt.y, resHea1.nReqRes) annotation (Line(points={{-378,10},{-342,
          10},{-342,2},{-340,2},{-340,-16},{-346,-16},{-346,-20},{-348,-20},{-348,
          -54},{-342,-54}}, color={255,127,0}));
  connect(con5.y, resHea1.u1StaPro) annotation (Line(points={{-378,-28},{-350,-28},
          {-350,-66},{-342,-66}}, color={255,0,255}));
  connect(ena.y1, resHea1.u1Ena) annotation (Line(points={{-238,-40},{-232,-40},
          {-232,-80},{-346,-80},{-346,-60},{-342,-60}}, color={255,0,255}));
  connect(ena.y1, resCoo.u1Ena) annotation (Line(points={{-238,-40},{-232,-40},{
          -232,-80},{374,-80},{374,0},{378,0}}, color={255,0,255}));
  connect(resCoo1.TSupSet, bus_sensor.TSetHP) annotation (Line(points={{-318,-34},
          {-314,-34},{-314,60},{-292,60},{-292,100},{-290,100},{-290,130},{-320,
          130}}, color={0,0,127}));
  connect(addInt.y, resCoo1.nReqRes) annotation (Line(points={{-346,-4},{-342,-4},
          {-342,-22}}, color={255,127,0}));
  connect(datRea.y[1], gai4.u) annotation (Line(points={{-435,160},{-408,160},{-408,
          170},{-382,170}}, color={0,0,127}));
  connect(gai4.y, preHeaFlo.Q_flow) annotation (Line(points={{-358,170},{-380,170},
          {-380,70},{-400,70}}, color={0,0,127}));
  connect(datRea.y[2], preHeaFlo1.Q_flow) annotation (Line(points={{-435,160},{120,
          160},{120,106},{218,106},{218,94},{254,94},{254,110}}, color={0,0,127}));
  connect(gai2.y, addPar.u)
    annotation (Line(points={{-378,200},{-362,200}}, color={0,0,127}));
  connect(TSupHea.port_b, rou2.port_a) annotation (Line(points={{-190,16},{-166,
          16},{-166,46},{-160,46}}, color={0,127,255}));
  connect(TRetHea.port_b, hex.port_a2) annotation (Line(points={{-168,104},{-168,
          100},{-154,100}}, color={0,127,255}));
  connect(hex.port_a1, externalEnergyLoop.portCon_b) annotation (Line(points={{-134,
          112},{-126,112},{-126,204},{5,204},{5,210}}, color={0,127,255}));
  connect(hex.port_b1, externalEnergyLoop.portCon_a) annotation (Line(points={{-154,
          112},{-160,112},{-160,162},{1,162},{1,210}}, color={0,127,255}));
  connect(rou3.port_a, TSupCoo.port_a) annotation (Line(points={{100,82},{124,82},
          {124,118},{130,118}}, color={0,127,255}));
  connect(TRetCoo.port_b, hex1.port_a2) annotation (Line(points={{124,24},{102,24},
          {102,20},{96,20}}, color={0,127,255}));
  connect(externalEnergyLoop.portEva_b, hex1.port_a1) annotation (Line(points={{
          15,210},{14,210},{14,94},{40,94},{40,32},{76,32}}, color={0,127,255}));
  connect(hex1.port_b1, externalEnergyLoop.portEva_a) annotation (Line(points={{
          96,32},{102,32},{102,162},{11,162},{11,210}}, color={0,127,255}));
  connect(bou2.ports[1], hex.port_a1) annotation (Line(points={{-176,142},{-126,
          142},{-126,112},{-134,112}}, color={0,127,255}));
  connect(hex.port_b2, TRetHeaCon.port_a) annotation (Line(points={{-134,100},{-124,
          100},{-124,106},{-116,106}}, color={0,127,255}));
  connect(TRetHeaCon.port_b, valIsoHeaInl.port_aHeaWat) annotation (Line(points=
         {{-96,106},{-88,106},{-88,80},{-28,80},{-28,54.54},{-22,54.54}}, color=
         {0,127,255}));
  connect(hex1.port_b2, TRetCooCon.port_a)
    annotation (Line(points={{76,20},{60,20}}, color={0,127,255}));
  connect(TRetCooCon.port_b, valIsoHeaInl.port_aChiWat) annotation (Line(points=
         {{40,20},{26,20},{26,44.88},{20,44.88}}, color={0,127,255}));
  connect(resHea1.dpSet[1], bus_sensor.uDpHeaSet) annotation (Line(points={{-318,
          -54},{-308,-54},{-308,62},{-294,62},{-294,102},{-292,102},{-292,130},{
          -320,130}}, color={0,0,127}));
  connect(resCoo.dpSet[1], bus_sensor.uDpCooSet) annotation (Line(points={{402,6},
          {46,6},{46,130},{-320,130}}, color={0,0,127}));
  connect(TRetHeaCon.y, bus.coolingTowerSystemBus.TRetHea);
  connect(TRetCooCon.y, bus.TRetCoo);
  connect(volumeFlowRate.port_b, valve2.port_b) annotation (Line(points={{-298,
          14},{-332,14},{-332,24},{-338,24}}, color={0,127,255}));
  connect(volumeFlowRate.port_a, jun.port_2) annotation (Line(points={{-278,14},
          {-248,14},{-248,24},{-236,24}}, color={0,127,255}));
  connect(jun2.port_1, vol1.ports[3]) annotation (Line(points={{174,22},{190,22},
          {190,32},{271.333,32},{271.333,40}}, color={0,127,255}));
  connect(jun1.port_2, volumeFlowRate1.port_a) annotation (Line(points={{172,86},
          {190,86},{190,82},{194,82}}, color={0,127,255}));
  connect(volumeFlowRate1.port_b, valve3.port_a) annotation (Line(points={{214,
          82},{220,82},{220,68},{226,68}}, color={0,127,255}));
  connect(reaToInt.y, extEneOpeMod.uReqHea) annotation (Line(points={{-378,10},
          {-342,10},{-342,8},{-310,8},{-310,108},{-288,108},{-288,246},{-42,246}},
        color={255,127,0}));
  connect(reaToInt1.y, extEneOpeMod.uReqCoo) annotation (Line(points={{366,16},
          {164,16},{164,242},{-42,242}}, color={255,127,0}));
  connect(bou3.ports[1], hex1.port_b1) annotation (Line(points={{72,48},{102,48},
          {102,32},{96,32}}, color={0,127,255}));
  connect(valve4.port_a, TRetHea.port_b) annotation (Line(points={{-156,74},{
          -164,74},{-164,104},{-168,104}}, color={0,127,255}));
  connect(valve4.port_b, TRetHeaCon.port_a) annotation (Line(points={{-136,74},
          {-126,74},{-126,100},{-124,100},{-124,106},{-116,106}}, color={0,127,
          255}));
  connect(valve5.port_a, TRetCoo.port_b) annotation (Line(points={{96,-12},{102,
          -12},{102,24},{124,24}}, color={0,127,255}));
  connect(valve5.port_b, TRetCooCon.port_a) annotation (Line(points={{76,-12},{
          70,-12},{70,20},{60,20}}, color={0,127,255}));
  connect(extEneOpeMod.yOpeMod, intEqu.u1) annotation (Line(points={{-18,240},{
          42,240},{42,190},{58,190}}, color={255,127,0}));
  connect(conInt.y, intEqu.u2)
    annotation (Line(points={{42,180},{42,182},{58,182}}, color={255,127,0}));
  connect(not1.u, intEqu.y)
    annotation (Line(points={{88,190},{82,190}}, color={255,0,255}));
  connect(bus_CooHEBypVal, valve5.bus) annotation (Line(
      points={{124,-28},{124,-2},{86,-2}},
      color={255,204,51},
      thickness=0.5));
  connect(not1.y, bus_CooHEBypVal.y1) annotation (Line(points={{112,190},{120,
          190},{120,162},{118,162},{118,0},{124,0},{124,-28}}, color={255,0,255}));
  connect(valve4.bus, bus_HeaHEBypVal) annotation (Line(
      points={{-146,84},{-146,94},{-156,94},{-156,164},{-160,164},{-160,190}},
      color={255,204,51},
      thickness=0.5));
  connect(intEqu1.y, not2.u)
    annotation (Line(points={{-168,230},{-162,230}}, color={255,0,255}));
  connect(conInt1.y, intEqu1.u2) annotation (Line(points={{-208,220},{-208,222},
          {-192,222}}, color={255,127,0}));
  connect(extEneOpeMod.yOpeMod, intEqu1.u1) annotation (Line(points={{-18,240},
          {-14,240},{-14,252},{-194,252},{-194,244},{-200,244},{-200,230},{-192,
          230}}, color={255,127,0}));
  connect(not2.y, bus_HeaHEBypVal.y1) annotation (Line(points={{-138,230},{-132,
          230},{-132,190},{-160,190}}, color={255,0,255}));
  connect(extEneOpeMod.yOpeMod, bus_sensor.uOpeMod) annotation (Line(points={{
          -18,240},{-14,240},{-14,252},{-194,252},{-194,244},{-200,244},{-200,
          158},{-240,158},{-240,130},{-320,130}}, color={255,127,0}));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-300,-220},{300,220}})),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
        "Simulate and plot"),
    experiment(
      StartTime=18316800,
      StopTime=20908800,
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
</html>"));
end ExternalEnergyLoopIntegration;
