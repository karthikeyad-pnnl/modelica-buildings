within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Validation;
model ExternalEnergyLoopIntegration_Buffalo_012425
  "Plant model with heat-recovery chiller"

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
    capCoo_nominal=2.5*2.5E6,
    TChiWatSup_nominal=273.15 + 6.68,
    dpChiWat_nominal(displayUnit="Pa") = Buildings.Templates.Data.Defaults.dpChiWatChi,
    per(
      capFunT={5.211989E-01,7.968670E-02,-1.488365E-03,1.974850E-02,-4.643458E-04,
          -7.786719E-04},
      EIRFunT={6.970381E-01,5.701647E-02,-2.272629E-04,8.496805E-03,
          4.752264E-04,-2.759799E-03},
      EIRFunPLR={7.280764E-01,-5.949776E-02,3.161338E-05,8.871893E-01,-1.081399E+00,
          5.804626E-02,0.000000E+00,4.825053E-01,0.000000E+00,0.000000E+00}))
    "Non-reversible AWHP parameters"
    annotation (Placement(transformation(extent={{-150,-192},{-130,-172}})));

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

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.OpenLoopWithHeatRecoveryUnitController
  ctlHeaInl(final cfg=
       datCtlHeaInl.cfg, final dat=datCtlHeaInl,
    capacityLimiter(
      TSupHeaLim=273.15 + 70,
      TSupCooLim=273.15 + 5,
      greThr(h=5),
      lesThr(h=2)))
    "Plant controller"
    annotation (Placement(transformation(extent={{-60,-14},{-80,6}})));

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
  HeatPumps.Interfaces.Bus bus_sensor
    annotation (Placement(transformation(extent={{-22,-62},{18,-22}}),
        iconTransformation(extent={{-340,110},{-300,150}})));
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
      package Medium = Buildings.Media.Water) annotation (Placement(
        transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={196,50})));
  Buildings.Templates.Components.Sensors.Temperature TSupCoo(redeclare package
      Medium = MediumChiWat,          m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{174,90},{194,110}})));

  Buildings.Templates.Components.Interfaces.Bus bus_HeaVal "Pump control bus"
    annotation (Placement(transformation(extent={{-350,150},{-310,190}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));

  Buildings.Templates.Components.Interfaces.Bus bus_CooVal "Pump control bus"
    annotation (Placement(transformation(extent={{216,122},{256,162}}),
        iconTransformation(extent={{-318,-118},{-278,-78}})));
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
  Controls.ExternalEnergy         externalEnergyOpenLoop(TExtCooSet=273.15 + 18)
    annotation (Placement(transformation(extent={{46,240},{66,260}})));
  BoundaryConditions.WeatherData.ReaderTMY3           weaDat(filNam=
        Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"),
      computeWetBulbTemperature=true)  "Weather data reader"
    annotation (Placement(transformation(extent={{-32,260},{-12,280}})));
  Interface.ExternalEnergyLoop bus annotation (Placement(transformation(extent=
            {{18,270},{58,310}}), iconTransformation(extent={{30,50},{70,90}})));
  Buildings.Templates.Components.Sensors.Temperature TRetHea(redeclare package
      Medium = Buildings.Media.Water,
                            m_flow_nominal=datHpAwNrv.mCon_flow_nominal)
                                                        annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-188,98})));
  Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = Buildings.Media.Water,
    T_start=305.37,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    V=datHpAwNrv.mCon_flow_nominal*3600/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{-370,60},{-350,80}})));
  HeatTransfer.Sources.PrescribedHeatFlow preHeaFlo
    annotation (Placement(transformation(extent={{-408,30},{-388,50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minFloHea(k=0.5*datHpAwNrv.mCon_flow_nominal
        /1000) "Pump speed command"
    annotation (Placement(transformation(extent={{-420,160},{-400,180}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{-474,100},{-454,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=273.15 + 32.22)
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
      m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
      dpValve_nominal=50,
      dpFixed_nominal=500))
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-348,24})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=5)
    annotation (Placement(transformation(extent={{-512,0},{-492,20}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    annotation (Placement(transformation(extent={{-474,0},{-454,20}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con5(k=false)
    annotation (Placement(transformation(extent={{-480,-58},{-460,-38}})));
  Fluid.MixingVolumes.MixingVolume vol1(
    redeclare package Medium = MediumChiWat,
    T_start=285.85,
    m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    V=datHpAwNrv.mChiWat_flow_nominal*3600/1000,
    nPorts=3)
    annotation (Placement(transformation(extent={{320,40},{340,60}})));
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
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resCoo(
    nSenDpRem=1,
    dpSet_max={1000},
    dpSet_min=1000,
    TSup_nominal=279.85,
    TSupSetLim=285.15,
    resDp_max=0.01,
    dtDel=120,
    dtRes=120,
    nReqResIgn=2,
    tri=-0.02)
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
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = MediumChiWat,nPorts=
       1) annotation (Placement(transformation(extent={{22,116},{42,136}})));
  Controls.ExternalEnergyLoopOperationMode extEneOpeMod(
    THotRetLim=273.15 + 80,
    TCooRetLim=273.15 + 9,
    dTHotHys=5,
    dTCooHys=3,
    intGreThr(t=3),
    intGreThr1(t=3))
    annotation (Placement(transformation(extent={{-180,232},{-160,252}})));
  parameter Buildings.Templates.Components.Data.PumpMultiple datPumMulHea(
    final typ=Buildings.Templates.Components.Types.Pump.Multiple,
    final nPum=pum.nPum,
    m_flow_nominal=fill(datHpAwNrv.mCon_flow_nominal, pum.nPum),
    dp_nominal=fill(1.5*5E6, pum.nPum),
    redeclare Buildings.Fluid.Movers.Data.Pumps.Wilo.heatPumpPlant_Heating per)
                                    "Multiple pump parameters"
    annotation (Placement(transformation(extent={{-62,-200},{-42,-180}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con6(k=true)
    annotation (Placement(transformation(extent={{-520,-70},{-500,-50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con7(k=273.15 + 18)
    annotation (Placement(transformation(extent={{-520,-110},{-500,-90}})));
  Buildings.Templates.Plants.Controls.Enabling.Enable ena(typ=Buildings.Templates.Plants.Controls.Types.Application.Cooling,
      have_inpSch=true,
    nReqIgn=2)
    annotation (Placement(transformation(extent={{-480,-90},{-460,-70}})));
  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resHea(
    nSenDpRem=1,
    dpSet_max={1000},
    dpSet_min=1000,
    TSup_nominal=333.15,
    TSupSetLim=308.15,
    resDp_max=0.01,
    dtDel=120,
    dtRes=120,
    nReqResIgn=2,
    tri=-0.02)
    annotation (Placement(transformation(extent={{-372,-70},{-352,-50}})));

  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/Data/Templates/HeatPumpPlant/Buffalo/loads.dat"),
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
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant condPSet(k=1000)
    annotation (Placement(transformation(extent={{-370,-110},{-350,-90}})));
  Modelica.Blocks.Routing.RealPassThrough dPSetHea
    annotation (Placement(transformation(extent={{-320,-76},{-300,-56}})));
  Modelica.Blocks.Routing.RealPassThrough TSetHea
    annotation (Placement(transformation(extent={{-318,-40},{-298,-20}})));
  Modelica.Blocks.Routing.RealPassThrough dPSetCoo
    annotation (Placement(transformation(extent={{458,130},{478,150}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conTSetHP(k=273.15 + 60)
    annotation (Placement(transformation(extent={{-370,-150},{-350,-130}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant condPSet1(k=1000)
    annotation (Placement(transformation(extent={{418,160},{438,180}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPIDBypHea(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{-380,160},{-360,180}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateHeaPri(
    redeclare package Medium = Buildings.Media.Water,
    m_flow_nominal=datHpAwNrv.mCon_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-188,24})));
  Buildings.Controls.OBC.CDL.Reals.PID conPIDBypCoo(k=0.2, Ti=150)
    annotation (Placement(transformation(extent={{180,250},{200,270}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant minFloCoo(k=0.5*datHpAwNrv.mChiWat_flow_nominal
        /1000) "Pump speed command"
    annotation (Placement(transformation(extent={{140,250},{160,270}})));
  Buildings.Templates.Components.Sensors.VolumeFlowRate volumeFlowRateCooPri(
    redeclare package Medium = MediumChiWat,
    m_flow_nominal=datHpAwNrv.mChiWat_flow_nominal,
    final typ=Buildings.Templates.Components.Types.SensorVolumeFlowRate.FlowMeter)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={154,100})));
  Controls.DeEnergization deEnergization(
    THotRetLim=273.15 + 85.5,
    TCooRetLim=273.15 + 4,
    dTHotHys=10,
    dTCooHys=2)
    annotation (Placement(transformation(extent={{-452,-130},{-432,-110}})));
  Modelica.Blocks.Routing.RealPassThrough TSetCoo
    annotation (Placement(transformation(extent={{460,180},{480,200}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant conTSetHP1(k=273.15 + 6.7)
    annotation (Placement(transformation(extent={{420,200},{440,220}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{-440,-20},{-420,0}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=-1)
    annotation (Placement(transformation(extent={{300,200},{280,220}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{260,200},{240,220}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{-360,200},{-340,220}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai2(k=-1)
    annotation (Placement(transformation(extent={{-400,200},{-380,220}})));
  Buildings.Controls.OBC.CDL.Integers.Add addInt1
    annotation (Placement(transformation(extent={{-98,220},{-78,240}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant
                                                    minFloCoo1(k=0)
               "Pump speed command"
    annotation (Placement(transformation(extent={{-240,200},{-220,220}})));
  Modelica.Blocks.Routing.BooleanPassThrough booleanPassThrough
    annotation (Placement(transformation(extent={{-420,-80},{-400,-60}})));
equation
  connect(ctlHeaInl.bus, valIsoHeaInl.bus) annotation (Line(
      points={{-60,2.4},{-60,-20},{-44,-20},{-44,4},{-48,4},{-48,64},{-32,64},{-32,
          72},{-2,72},{-2,60}},
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
      points={{-330,170},{-330,74},{-268,74},{-268,56}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));

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

connect(TSupHea.y, bus_sensor.TSupHea);
connect(TSupCoo.y, bus_sensor.TSupCoo);
connect(dPHea.y, bus_sensor.uDpHea);
connect(dPCoo.y, bus_sensor.uDpCoo);
connect(TRetHea.y,extEneOpeMod.THotRet);
connect(TRetCoo.y,extEneOpeMod.TChiRet);
  connect(ctlHeaInl.bus, hpAwNrv.bus) annotation (Line(
      points={{-60,2.4},{-60,-20},{-24,-20},{-24,-16},{32,-16},{32,-34}},
      color={255,204,51},
      thickness=0.5));
  connect(bus_sensor, ctlHeaInl.bus) annotation (Line(
      points={{-2,-42},{-2,-16},{-24,-16},{-24,-20},{-60,-20},{-60,2.4}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(pum1.bus, ctlHeaInl.bus_HeaPum) annotation (Line(
      points={{-114,34},{-52,34},{-52,-10},{-59.8,-10}},
      color={255,204,51},
      thickness=0.5));
  connect(pum.bus, ctlHeaInl.bus_CooPum) annotation (Line(
      points={{96,110},{44,110},{44,104},{-52,104},{-52,-3.8},{-60,-3.8}},
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
      points={{56,260},{72,260},{72,290},{38,290}},
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
    annotation (Line(points={{182,24},{204,24}}, color={0,127,255}));
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
  connect(con3.y, resCoo.u1StaPro) annotation (Line(points={{378,136},{397,136},
          {397,134},{416,134}}, color={255,0,255}));
  connect(bou.ports[1], rou1.port_a) annotation (Line(points={{-46,18},{-58,18},
          {-58,24}},          color={0,127,255}));
  connect(bou1.ports[1], rou.port_a) annotation (Line(points={{42,126},{54,126},
          {54,100}},                      color={0,127,255}));
  connect(reaToInt1.y, resCoo.nReqRes) annotation (Line(points={{360,160},{408,160},
          {408,146},{416,146}}, color={255,127,0}));
  connect(con6.y, ena.u1Sch) annotation (Line(points={{-498,-60},{-482,-60},{
          -482,-76}},       color={255,0,255}));
  connect(con7.y, ena.TOut) annotation (Line(points={{-498,-100},{-482,-100},{
          -482,-84}},       color={0,0,127}));
  connect(reaToInt.y, resHea.nReqRes) annotation (Line(points={{-452,10},{-374,10},
          {-374,-54}}, color={255,127,0}));
  connect(con5.y, resHea.u1StaPro) annotation (Line(points={{-458,-48},{-380,-48},
          {-380,-66},{-374,-66}}, color={255,0,255}));
  connect(datRea.y[1], gai4.u) annotation (Line(points={{-543,52},{-516,52},{
          -516,40}},        color={0,0,127}));
  connect(gai4.y, preHeaFlo.Q_flow) annotation (Line(points={{-492,40},{-408,40}},
                                color={0,0,127}));
  connect(datRea.y[2], preHeaFlo1.Q_flow) annotation (Line(points={{-543,52},{
          -458,52},{-458,318},{264,318},{264,50},{286,50}},      color={0,0,127}));
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
  connect(TRetHeaCon.y, bus.coolingTowerSystemBus.TRetHea);
  connect(TRetCooCon.y, bus.TCooRet);
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
          {-452,8},{-372,8},{-372,0},{-284,0},{-284,248},{-182,248}},
        color={255,127,0}));
  connect(reaToInt1.y, extEneOpeMod.uReqCoo) annotation (Line(points={{360,160},
          {360,184},{-200,184},{-200,244},{-182,244}},
                                         color={255,127,0}));
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
  connect(TSetHea.y, bus_sensor.TSetHea) annotation (Line(points={{-297,-30},{-210,
          -30},{-210,-94},{-106,-94},{-106,-42},{-2,-42}}, color={0,0,127}),
      Text(
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
  connect(dPSetCoo.y, bus_sensor.uDpCooSet) annotation (Line(points={{479,140},{
          484,140},{484,-42},{-2,-42}},                      color={0,0,127}),
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
  connect(minFloHea.y, conPIDBypHea.u_s) annotation (Line(points={{-398,170},{-382,
          170}},                       color={0,0,127}));
  connect(minFloCoo.y, conPIDBypCoo.u_s)
    annotation (Line(points={{162,260},{178,260}}, color={0,0,127}));
  connect(volumeFlowRateCooPri.y, conPIDBypCoo.u_m);
  connect(rou3.port_a, volumeFlowRateCooPri.port_a) annotation (Line(points={{140,100},
          {144,100}},                                        color={0,127,255}));
  connect(volumeFlowRateCooPri.port_b, TSupCoo.port_a) annotation (Line(points={{164,100},
          {174,100}},                               color={0,127,255}));
  connect(ena.y1, deEnergization.uEna) annotation (Line(points={{-458,-80},{
          -448,-80},{-448,-100},{-464,-100},{-464,-124},{-454,-124}},
                                       color={255,0,255}));
  connect(TRetHeaCon.y,deEnergization.TRetHeaCon);
  connect(TRetCooCon.y,deEnergization.TRetCooCon);
  connect(TRetCooCon.y,bus_sensor.TRetCooCon);
  connect(TRetHeaCon.y,bus_sensor.TRetHeaCon);
  connect(TRetHeaCon.y,bus.THeaRet);
  connect(TSetCoo.y, bus_sensor.TSetCoo) annotation (Line(points={{481,190},{481,
          188},{488,188},{488,-42},{-2,-42}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(reaToInt.y, addInt.u1) annotation (Line(points={{-452,10},{-448,10},{-448,
          -4},{-442,-4}}, color={255,127,0}));
  connect(reaToInt1.y, addInt.u2) annotation (Line(points={{360,160},{360,184},{
          -44,184},{-44,36},{-88,36},{-88,4},{-176,4},{-176,-4},{-404,-4},{-404,
          -28},{-442,-28},{-442,-16}}, color={255,127,0}));
  connect(addInt.y, ena.nReqPla) annotation (Line(points={{-418,-10},{-408,-10},
          {-408,-36},{-452,-36},{-452,-28},{-528,-28},{-528,-80},{-482,-80}},
        color={255,127,0}));
  connect(TRetHea.port_b, valve4.portByp_a) annotation (Line(points={{-178,98},{
          -168,98},{-168,76},{-108,76},{-108,88}}, color={0,127,255}));
  connect(hex.port_b2, valve4.port_a)
    annotation (Line(points={{-136,98},{-118,98}}, color={0,127,255}));
  connect(TRetCoo.port_b, valve5.portByp_a) annotation (Line(points={{162,24},{154,
          24},{154,4},{82,4},{82,14}}, color={0,127,255}));
  connect(hex1.port_b2, valve5.port_a)
    annotation (Line(points={{126,24},{92,24}}, color={0,127,255}));
  connect(valve4.bus, bus.extCooModValveBus) annotation (Line(
      points={{-108,108},{-108,290.1},{38.1,290.1}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(bus.extHeaModValveBus, valve5.bus) annotation (Line(
      points={{38.1,290.1},{68,290.1},{68,290},{82,290},{82,34}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(conPID1.y, gai1.u) annotation (Line(points={{400,90},{404,90},{404,210},
          {302,210}}, color={0,0,127}));
  connect(addPar.u, gai1.y)
    annotation (Line(points={{262,210},{278,210}}, color={0,0,127}));
  connect(gai2.y, addPar1.u)
    annotation (Line(points={{-378,210},{-362,210}}, color={0,0,127}));
  connect(addPar1.y, bus_HeaVal.y) annotation (Line(points={{-338,210},{-330,210},
          {-330,170}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(conPID.y, gai2.u) annotation (Line(points={{-452,110},{-428,110},{-428,
          210},{-402,210}}, color={0,0,127}));
  connect(dPCoo.port_a, TSupCoo.port_b) annotation (Line(points={{196,60},{196,
          80},{194,80},{194,100}}, color={0,127,255}));
  connect(dPCoo.port_b, jun2.port_2) annotation (Line(points={{196,40},{196,32},
          {204,32},{204,24}}, color={0,127,255}));
  connect(dPHea.port_a, jun.port_1) annotation (Line(points={{-230,46},{-240,46},
          {-240,24},{-248,24}}, color={0,127,255}));
  connect(dPHea.port_b, jun6.port_2) annotation (Line(points={{-230,66},{-230,
          98},{-248,98}}, color={0,127,255}));
  connect(addPar.y, bus_CooVal.y) annotation (Line(points={{238,210},{228,210},
          {228,172},{236,172},{236,142}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(extEneOpeMod.yOpeMod, addInt1.u1) annotation (Line(points={{-158,242},
          {-158,236},{-100,236}}, color={255,127,0}));
  connect(addInt1.y, bus_sensor.uOpeMod) annotation (Line(points={{-76,230},{
          -76,228},{-60,228},{-60,128},{-16,128},{-16,76},{-2,76},{-2,-42}},
        color={255,127,0}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(addInt1.y, bus.uOpeMod) annotation (Line(points={{-76,230},{-76,212},
          {-52,212},{-52,290},{38,290}}, color={255,127,0}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(minFloCoo1.y, addInt1.u2) annotation (Line(points={{-218,210},{-112,
          210},{-112,224},{-100,224}}, color={255,127,0}));
  connect(booleanPassThrough.y, resHea.u1Ena) annotation (Line(points={{-399,
          -70},{-388,-70},{-388,-60},{-374,-60}}, color={255,0,255}));
  connect(booleanPassThrough.y, bus_sensor.uPlaEna) annotation (Line(points={{
          -399,-70},{-388,-70},{-388,-40},{-324,-40},{-324,-48},{-228,-48},{
          -228,-42},{-2,-42}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanPassThrough.y, bus.uPlaEna) annotation (Line(points={{-399,-70},
          {-388,-70},{-388,-40},{-324,-40},{-324,-48},{-228,-48},{-228,-40},{
          -212,-40},{-212,-28},{-40,-28},{-40,0},{-48,0},{-48,290},{38,290}},
        color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(booleanPassThrough.y, resCoo.u1Ena) annotation (Line(points={{-399,
          -70},{-388,-70},{-388,-40},{-324,-40},{-324,-48},{-228,-48},{-228,-40},
          {-212,-40},{-212,-28},{-40,-28},{-40,0},{-48,0},{-48,188},{380,188},{
          380,152},{400,152},{400,140},{416,140}}, color={255,0,255}));
  connect(ena.y1, booleanPassThrough.u) annotation (Line(points={{-458,-80},{
          -440,-80},{-440,-70},{-422,-70}}, color={255,0,255}));
  connect(bus, ctlHeaInl.bus_extEne) annotation (Line(
      points={{38,290},{36,290},{36,236},{24,236},{24,192},{4,192},{4,184},{-4,184},
          {-4,172},{-40,172},{-40,36},{-48,36},{-48,8},{-80,8},{-80,-3.8}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(resCoo.dpSet[1], dPSetCoo.u) annotation (Line(points={{440,146},{444,
          146},{444,140},{456,140}}, color={0,0,127}));
  connect(resCoo.TSupSet, TSetCoo.u) annotation (Line(points={{440,134},{440,
          132},{444,132},{444,148},{448,148},{448,190},{458,190}}, color={0,0,
          127}));
  connect(resHea.dpSet[1], dPSetHea.u) annotation (Line(points={{-350,-54},{
          -332,-54},{-332,-66},{-322,-66}}, color={0,0,127}));
  connect(resHea.TSupSet, TSetHea.u) annotation (Line(points={{-350,-66},{-336,
          -66},{-336,-30},{-320,-30}}, color={0,0,127}));
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
      StopTime=26265600,
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
end ExternalEnergyLoopIntegration_Buffalo_012425;
