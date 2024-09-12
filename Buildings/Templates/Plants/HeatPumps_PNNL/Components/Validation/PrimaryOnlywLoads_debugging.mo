within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model PrimaryOnlywLoads_debugging "Control Box Test"

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
    capHeaHp_nominal=500E3,
    THeaWatSupHp_nominal=Buildings.Templates.Data.Defaults.THeaWatSupMed,
    mChiWatHp_flow_nominal=datHpAwNrv.capCooHp_nominal/abs(datHpAwNrv.TChiWatSupHp_nominal
         - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
    capCooHp_nominal=500E3,
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
    annotation (Placement(transformation(extent={{-150,-192},{-130,-172}})));

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups.WaterToWater hpAwNrv(
    redeclare final package MediumHeaWat=Medium,
    nHp=1,
    is_rev=true,
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

  Controls.HeatRecoveryUnitController_wBus
  ctlHeaInl(final cfg=
       datCtlHeaInl.cfg, final dat=datCtlHeaInl)
    "Plant controller"
    annotation (Placement(transformation(extent={{-50,110},{-70,130}})));

  Buildings.Templates.Components.Pumps.Multiple pum(
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    nPum=1,
    dat=datPumMulHea,
    redeclare final package Medium = Medium)
    annotation (Placement(transformation(extent={{46,72},{66,92}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulHea(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mHeaWatHp_flow_nominal, pum.nPum),
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
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-214,56})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPHea(redeclare
      package Medium = Buildings.Media.Water) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-270,62})));
  Buildings.Templates.Components.Sensors.Temperature TSupHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{-308,14},{-328,34}})));
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
        origin={164,24})));
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
        origin={164,50})));
  Buildings.Templates.Components.Sensors.DifferentialPressure dPCoo(redeclare
      package Medium = Buildings.Media.Water) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={208,50})));
  Buildings.Templates.Components.Sensors.Temperature TSupCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{260,80},{280,100}})));

  Buildings.Templates.Components.Interfaces.Bus bus_HeaVal "Pump control bus"
    annotation (Placement(transformation(extent={{-262,166},{-222,206}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));

  Buildings.Templates.Components.Interfaces.Bus bus_CooVal "Pump control bus"
    annotation (Placement(transformation(extent={{150,122},{190,162}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Templates.Components.Sensors.Temperature TRetCoo(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal)
    annotation (Placement(transformation(extent={{248,12},{228,32}})));
  Buildings.Templates.Plants.HeatPumps_PNNL.Components.ExternalEnergyLoop
    externalEnergyLoop
    annotation (Placement(transformation(extent={{-2,210},{18,230}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-32,260},{-12,280}})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent={{18,270},
            {58,310}}),        iconTransformation(extent={{30,50},{70,90}})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    V=datHpAwNrv.mHeaWatHp_flow_nominal*600/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{-412,76},{-392,96}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex(redeclare package Medium1 =
        Buildings.Media.Water, redeclare package Medium2 =
        Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
    dp1_nominal=1500,
    dp2_nominal=1500)
    annotation (Placement(transformation(extent={{-150,86},{-130,106}})));
  Fluid.HeatExchangers.ConstantEffectiveness hex1(redeclare package Medium1 =
        Buildings.Media.Water, redeclare package Medium2 =
        Buildings.Media.Water,
    m1_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    m2_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
    dp1_nominal=1500,
    dp2_nominal=1500)
    annotation (Placement(transformation(extent={{100,14},{120,34}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHea(redeclare package
      Medium = Buildings.Media.Water, m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-330,98})));
  HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(extent={{-440,100},{-420,120}})));
  Fluid.Sensors.Temperature senTem(redeclare package Medium =
        Buildings.Media.Water, warnAboutOnePortConnection=false)
    annotation (Placement(transformation(extent={{-460,80},{-440,100}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID
    annotation (Placement(transformation(extent={{-430,20},{-410,40}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=10)
    annotation (Placement(transformation(extent={{-380,-10},{-360,10}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=32.22)
    annotation (Placement(transformation(extent={{-500,20},{-480,40}})));
  Controls.ExternalEnergy externalEnergyOpenLoop
    annotation (Placement(transformation(extent={{52,200},{72,220}})));
  Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl opeModCon
    annotation (Placement(transformation(extent={{-100,156},{-80,200}})));
  Buildings.Templates.Plants.Controls.Enabling.Enable ena(typ=Buildings.Templates.Plants.Controls.Types.Application.Cooling,
      have_inpSch=true)
    annotation (Placement(transformation(extent={{-180,180},{-160,200}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(k=true)
    annotation (Placement(transformation(extent={{-220,190},{-200,210}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con3(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-220,160},{-200,180}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-340,-42},{-320,-22}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{-280,-40},{-260,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con4(k=false)
    annotation (Placement(transformation(extent={{-220,230},{-200,250}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resHea(
    nSenDpRem=1,
    dpSet_max={6*6894},
    TSup_nominal=316.48,
    TSupSetLim=305.37,
    nReqResIgn=5)
    annotation (Placement(transformation(extent={{-280,-80},{-260,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con5(k=false)
    annotation (Placement(transformation(extent={{-340,-80},{-320,-60}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y1(k=-41000)
    "Pump speed command"
    annotation (Placement(transformation(extent={{-500,100},{-480,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant y4(k=0.1)
    "Pump speed command"
    annotation (Placement(transformation(extent={{100,140},{120,160}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai2(k=-1)
    annotation (Placement(transformation(extent={{-384,30},{-364,50}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{-340,40},{-320,60}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volFlowRateHea(
      redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
      typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(extent={{-278,14},{-298,34}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volFlowRateCoo(
      redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mChiWatHp_flow_nominal,
      typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(extent={{220,80},{240,100}})));
  Buildings.Controls.OBC.CDL.Integers.Change cha
    annotation (Placement(transformation(extent={{-60,180},{-40,200}})));
  Buildings.Controls.OBC.CDL.Logical.TrueFalseHold truFalHol(trueHoldDuration=
        600, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-26,180},{-6,200}})));
  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdg
    annotation (Placement(transformation(extent={{16,180},{36,200}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulCoo(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mChiWatHp_flow_nominal, pum.nPum),
    dp_nominal=fill(1E5, pum.nPum)) "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-60,-200},{-40,-180}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{60,170},{80,190}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{352,78},{332,98}})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water, nPorts=
       1) annotation (Placement(transformation(extent={{350,10},{330,30}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-146,158},{-126,178}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{-380,-60},{-360,-40}})));
  Buildings.Templates.Components.Actuators.Valve valve2(
    redeclare package Medium = Media.Water,
    typ=Buildings.Templates.Components.Types.Valve.TwoWayModulating,
    dat(
      m_flow_nominal=datHpAwNrv.mHeaWatHp_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=0))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-350,22})));
  Buildings.Templates.Components.Interfaces.Bus bus_HeaCoiVal
    "Valve control bus" annotation (Placement(transformation(extent={{-408,124},
            {-368,164}}), iconTransformation(extent={{-318,-118},{-278,-78}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt1(k=0)
    annotation (Placement(transformation(extent={{-62,284},{-42,304}})));
  Fluid.Sources.Boundary_pT bou2(redeclare package Medium =
        Buildings.Media.Water, nPorts=1)
    annotation (Placement(transformation(extent={{-80,-22},{-60,-2}})));
  Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water, nPorts=
       1) annotation (Placement(transformation(extent={{40,120},{60,140}})));
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
    annotation (Line(points={{164,34},{164,40}}, color={0,127,255}));
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
    annotation (Line(points={{172,86},{208,86},{208,60}}, color={0,127,255}));
  connect(jun2.port_1, dPCoo.port_b) annotation (Line(points={{174,24},{192,24},
          {192,36},{208,36},{208,40}},                 color={0,127,255}));

connect(TSupHea.y, bus_sensor.TSupHea);
connect(TSupCoo.y, bus_sensor.TSupCoo);
connect(dPHea.y, bus_sensor.uDpHea);
connect(dPCoo.y, bus_sensor.uDpCoo);
connect(resHea.dpSet[1], bus_sensor.uDpHeaSet);
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
  connect(TRetCoo.port_b, jun2.port_1) annotation (Line(points={{228,22},{196,
          22},{196,24},{174,24}}, color={0,127,255}));
  connect(rou.ports_b, pum.ports_a) annotation (Line(points={{34,82},{46,82}},
                           color={0,127,255}));
  connect(pum.ports_b, rou3.ports_b) annotation (Line(points={{66,82},{80,82}},
                                   color={0,127,255}));
  connect(rou1.ports_b, pum1.ports_a)
    annotation (Line(points={{-78,46},{-104,46}},          color={0,127,255}));
  connect(pum1.ports_b, rou2.ports_b) annotation (Line(points={{-124,46},{-140,
          46}},           color={0,127,255}));
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
  connect(jun6.port_2, hex.port_a1) annotation (Line(points={{-202,94},{-156,94},
          {-156,102},{-150,102}}, color={0,127,255}));
  connect(hex.port_b1, valIsoHeaInl.port_aHeaWat) annotation (Line(points={{-130,
          102},{-40,102},{-40,54.54},{-22,54.54}}, color={0,127,255}));
  connect(externalEnergyLoop.portCon_b, hex.port_a2) annotation (Line(points={{5,
          210},{4,210},{4,98},{-124,98},{-124,90},{-130,90}}, color={0,127,255}));
  connect(hex.port_b2, externalEnergyLoop.portCon_a) annotation (Line(points={{-150,
          90},{-152,90},{-152,204},{1,204},{1,210}}, color={0,127,255}));
  connect(jun2.port_2, hex1.port_a2) annotation (Line(points={{154,24},{126,24},
          {126,18},{120,18}}, color={0,127,255}));
  connect(hex1.port_b2, valIsoHeaInl.port_aChiWat) annotation (Line(points={{100,
          18},{26,18},{26,44.88},{20,44.88}}, color={0,127,255}));
  connect(externalEnergyLoop.portEva_b, hex1.port_a1) annotation (Line(points={{
          15,210},{14,210},{14,98},{40,98},{40,30},{100,30}}, color={0,127,255}));
  connect(hex1.port_b1, externalEnergyLoop.portEva_a) annotation (Line(points={{
          120,30},{126,30},{126,102},{11,102},{11,210}}, color={0,127,255}));
  connect(preHeaFlo.port, vol.heatPort) annotation (Line(points={{-420,110},{
          -416,110},{-416,86},{-412,86}},
                                     color={191,0,0}));
  connect(senTem.port, vol.ports[1]) annotation (Line(points={{-450,80},{-450,
          72},{-426,72},{-426,76},{-403.333,76}},
                                              color={0,127,255}));
  connect(senTem.T, conPID.u_m) annotation (Line(points={{-443,90},{-440,90},{-440,
          10},{-420,10},{-420,18}}, color={0,0,127}));
  connect(con.y, conPID.u_s)
    annotation (Line(points={{-478,30},{-432,30}}, color={0,0,127}));
  connect(externalEnergyOpenLoop.bus, bus) annotation (Line(
      points={{62,220},{62,262},{38,262},{38,290}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(ena.y1, opeModCon.uPlaEna) annotation (Line(points={{-158,190},{-110,190},
          {-110,186},{-102,186}}, color={255,0,255}));
  connect(con2.y, ena.u1Sch) annotation (Line(points={{-198,200},{-190,200},{-190,
          194},{-182,194}}, color={255,0,255}));
  connect(con3.y, ena.TOut) annotation (Line(points={{-198,170},{-188,170},{-188,
          186},{-182,186}}, color={0,0,127}));
  connect(gai.y, reaToInt.u) annotation (Line(points={{-358,0},{-350,0},{-350,-32},
          {-342,-32}}, color={0,0,127}));
  connect(reaToInt.y, addInt.u1) annotation (Line(points={{-318,-32},{-290,-32},
          {-290,-24},{-282,-24}}, color={255,127,0}));
  connect(addInt.y, ena.nReqPla) annotation (Line(points={{-258,-30},{-252,-30},
          {-252,156},{-226,156},{-226,154},{-192,154},{-192,190},{-182,190}},
        color={255,127,0}));
  connect(con4.y, opeModCon.uHotTanCha) annotation (Line(points={{-198,240},{-148,
          240},{-148,194},{-102,194}}, color={255,0,255}));
  connect(con4.y, opeModCon.uCooTanCha) annotation (Line(points={{-198,240},{-148,
          240},{-148,194},{-108,194},{-108,190},{-102,190}}, color={255,0,255}));
  connect(reaToInt.y, resHea.nReqRes) annotation (Line(points={{-318,-32},{-288,
          -32},{-288,-64},{-282,-64}}, color={255,127,0}));
  connect(ena.y1, resHea.u1Ena) annotation (Line(points={{-158,190},{-154,190},{
          -154,124},{-246,124},{-246,-86},{-286,-86},{-286,-82},{-288,-82},{-288,
          -70},{-282,-70}}, color={255,0,255}));
  connect(con5.y, resHea.u1StaPro) annotation (Line(points={{-318,-70},{-294,-70},
          {-294,-76},{-282,-76}}, color={255,0,255}));
  connect(opeModCon.yOpeMod, bus_sensor.uOpeMod) annotation (Line(points={{-78,178},
          {-72,178},{-72,150},{-240,150},{-240,130},{-320,130}}, color={255,127,
          0}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(y1.y, preHeaFlo.Q_flow)
    annotation (Line(points={{-478,110},{-440,110}}, color={0,0,127}));
  connect(conPID.y, gai2.u) annotation (Line(points={{-408,30},{-394,30},{-394,
          40},{-386,40}},
                      color={0,0,127}));
  connect(gai2.y, addPar.u)
    annotation (Line(points={{-362,40},{-350,40},{-350,50},{-342,50}},
                                                   color={0,0,127}));
  connect(addPar.y, bus_HeaVal.y) annotation (Line(points={{-318,50},{-290,50},{
          -290,186},{-242,186}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(resHea.TSupSet, opeModCon.THeaSupSet) annotation (Line(points={{-258,-76},
          {-244,-76},{-244,148},{-104,148},{-104,152},{-108,152},{-108,182},{-102,
          182}}, color={0,0,127}));
  connect(TRetHea.y, opeModCon.THeaRet);
  connect(TRetCoo.y, opeModCon.TChiRet);
  connect(TSupCoo.y, opeModCon.TChiSup);
  connect(volFlowRateHea.y, opeModCon.VWatHot_flow);
  connect(volFlowRateCoo.y, opeModCon.VWatChi_flow);
  connect(rou2.port_a, jun.port_1) annotation (Line(points={{-160,46},{-198,46},
          {-198,24},{-216,24}}, color={0,127,255}));
  connect(jun.port_2, volFlowRateHea.port_a)
    annotation (Line(points={{-236,24},{-278,24}}, color={0,127,255}));
  connect(volFlowRateHea.port_b, TSupHea.port_a)
    annotation (Line(points={{-298,24},{-308,24}}, color={0,127,255}));
  connect(TRetHea.port_b, jun6.port_1) annotation (Line(points={{-320,98},{-254,
          98},{-254,94},{-222,94}}, color={0,127,255}));
  connect(vol.ports[2], TRetHea.port_a) annotation (Line(points={{-402,76},{
          -346,76},{-346,98},{-340,98}}, color={0,127,255}));
  connect(rou3.port_a, jun1.port_1) annotation (Line(points={{100,82},{144,82},{
          144,86},{152,86}}, color={0,127,255}));
  connect(TSupCoo.port_a, volFlowRateCoo.port_b)
    annotation (Line(points={{260,90},{240,90}}, color={0,127,255}));
  connect(jun1.port_2, volFlowRateCoo.port_a) annotation (Line(points={{172,86},
          {212,86},{212,90},{220,90}}, color={0,127,255}));
  connect(opeModCon.yOpeMod, cha.u) annotation (Line(points={{-78,178},{-70,178},
          {-70,190},{-62,190}}, color={255,127,0}));
  connect(cha.y, truFalHol.u)
    annotation (Line(points={{-38,190},{-28,190}}, color={255,0,255}));
  connect(truFalHol.y, falEdg.u)
    annotation (Line(points={{-4,190},{14,190}}, color={255,0,255}));
  connect(falEdg.y, pre.u) annotation (Line(points={{38,190},{50,190},{50,180},
          {58,180}}, color={255,0,255}));
  connect(pre.y, opeModCon.uProCom) annotation (Line(points={{82,180},{88,180},
          {88,192},{46,192},{46,202},{-102,202},{-102,198}}, color={255,0,255}));
  connect(y4.y, bus_CooVal.y) annotation (Line(points={{122,150},{144,150},{144,
          142},{170,142}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bou.ports[1], TSupCoo.port_b) annotation (Line(points={{332,88},{330,
          88},{330,90},{280,90}}, color={0,127,255}));
  connect(bou1.ports[1], TRetCoo.port_a) annotation (Line(points={{330,20},{328,
          20},{328,22},{248,22}}, color={0,127,255}));
  connect(con1.y, opeModCon.TChiSupSet) annotation (Line(points={{-124,168},{
          -110,168},{-110,166},{-102,166}}, color={0,0,127}));
  connect(conInt.y, addInt.u2) annotation (Line(points={{-358,-50},{-320,-50},{
          -320,-36},{-282,-36}}, color={255,127,0}));
  connect(valve2.port_b, TSupHea.port_b) annotation (Line(points={{-340,22},{
          -340,24},{-328,24}}, color={0,127,255}));
  connect(valve2.port_a, vol.ports[3]) annotation (Line(points={{-360,22},{-402,
          22},{-402,50},{-400.667,50},{-400.667,76}}, color={0,127,255}));
  connect(conPID.y, bus_HeaCoiVal.y) annotation (Line(points={{-408,30},{-398,
          30},{-398,144},{-388,144}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus_HeaCoiVal, valve2.bus) annotation (Line(
      points={{-388,144},{-354,144},{-354,38},{-350,38},{-350,32}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_HeaCoiVal.y_actual, gai.u) annotation (Line(
      points={{-388,144},{-386,144},{-386,0},{-382,0}},
      color={255,204,51},
      thickness=0.5));
  connect(conInt1.y, bus.uOpeMod) annotation (Line(points={{-40,294},{-40,254},
          {38,254},{38,290}}, color={255,127,0}));
  connect(bou2.ports[1], rou1.port_a) annotation (Line(points={{-60,-12},{-54,
          -12},{-54,30},{-52,30},{-52,46},{-58,46}}, color={0,127,255}));
  connect(bou3.ports[1], rou.port_a) annotation (Line(points={{60,130},{66,130},
          {66,98},{8,98},{8,82},{14,82}}, color={0,127,255}));
  annotation (
    Diagram(
      coordinateSystem(
        extent={{-300,-220},{300,220}})),
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Components/Validation/HeatPumpGroupAirToWater.mos"
        "Simulate and plot"),
    experiment(
      Tolerance=1e-6,
      StartTime=10497600.0,
      StopTime=10505600.0),
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
end PrimaryOnlywLoads_debugging;
