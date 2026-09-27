within Buildings.Templates.Plants.Experimental.Validation;
model HybridAirToWater_PlantOnly "Validation of AWHP plant template"
  extends Modelica.Icons.Example;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Main medium (common for CHW and HW)";
  parameter Boolean have_chiWat=true
    "Set to true if the plant provides CHW"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
  inner parameter Buildings.Templates.Plants.HeatPumps.Validation.UserProject.Data.AirToWaterReversiblePolyvalent datAll(pla(
        final cfg=pla.cfg, hp(
        mHeaWatHp_flow_nominal=0.8*datAll.pla.hp.capHeaHp_nominal/abs(datAll.pla.ctl.THeaWatSup_nominal
             - Buildings.Templates.Data.Defaults.THeaWatRetMed)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        capHeaHp_nominal=1e5,
        mChiWatHp_flow_nominal=datAll.pla.hp.capCooHp_nominal/abs(datAll.pla.ctl.TChiWatSup_nominal
             - Buildings.Templates.Data.Defaults.TChiWatRet)/Buildings.Utilities.Psychrometrics.Constants.cpWatLiq,
        capCooHp_nominal=1.2e5)))
                          "Plant parameters"
    annotation (Placement(transformation(extent={{-220,140},{-200,160}})));
  parameter Modelica.Units.SI.PressureDifference dpTer_nominal(
    displayUnit="Pa")=3E4
    "Liquid pressure drop across terminal unit at design conditions";
  parameter Modelica.Units.SI.PressureDifference dpValve_nominal(
    displayUnit="Pa")=dpTer_nominal
    "Terminal unit control valve pressure drop at design conditions";
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"),
    Evaluate=true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  Buildings.Templates.Plants.HeatPumps.AirToWater pla(
    redeclare final package MediumHeaWat=Medium,
    redeclare package MediumHotWat = Medium,
    typ=Buildings.Templates.Plants.Controls.Types.PlantHeatPump.ReversiblePolyvalent,
    nHp_select=2,
    nPhp_select=1,
    typArrPumPri_select=Buildings.Templates.Components.Types.PumpArrangement.Dedicated,
    have_pumPriDedComHp_select=true,
    typDis_select1=Buildings.Templates.Plants.HeatPumps.Types.Distribution.Variable1Only,
    typTanHeaWat_select=Buildings.Templates.Components.Types.IntegrationPoint.None,
    typTanChiWat_select=Buildings.Templates.Components.Types.IntegrationPoint.None,
    ctl(
      nAirHan=1,
      nEquZon=0,
      have_senDpHeaWatRemWir=true),
    final dat=datAll.pla,
    final allowFlowReversal=allowFlowReversal,
    linearized=true,
    show_T=true,
    is_dpBalYPumSetCal=true)
    "Heat pump plant"
    annotation (Placement(transformation(extent={{-180,-80},{-140,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TDum(
    k=293.15,
    y(final unit="K",
      displayUnit="degC"))
    "Placeholder signal for request generator"
    annotation (Placement(transformation(extent={{-220,90},{-200,110}})));
  Buildings.Fluid.Sensors.RelativePressure dpHeaWatRem[1](
    redeclare each final package Medium=Medium)
    "HW differential pressure at one remote location"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
      origin={160,-98})));
  Buildings.Fluid.Sensors.RelativePressure dpChiWatRem[1](
    redeclare each final package Medium=Medium)
    "CHW differential pressure at one remote location"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
      origin={160,-18})));
  AirHandlersFans.Interfaces.Bus busAirHan[pla.ctl.nAirHan] "AHU control bus"
    annotation (Placement(transformation(extent={{-60,160},{-20,200}}),
        iconTransformation(extent={{-80,80},{-40,120}})));
  Buildings.Templates.Plants.HeatPumps.Interfaces.Bus busPla "Plant control bus"
    annotation (Placement(transformation(extent={{-200,-20},{-160,20}}),
      iconTransformation(extent={{-120,40},{-80,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratLoa(
    table=[
    0, 0, 0;
    5, 0, 0;
    7, 1, 0;
    10, 0.5, 0;
    14, 0, 0.6;
    16, 0, 1;
    18, 0, 0.6;
    22, 0.1, 0.1;
    24, 0, 0],
    timeScale=3600)
    "Fraction of design load – Index 1 for heating, 2 for cooling"
    annotation (Placement(transformation(extent={{-220,50},{-200,70}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant enaLoa(k=true)
    "Load enable"
    annotation (Placement(transformation(extent={{-220,10},{-200,30}})));
  Buildings.Fluid.FixedResistances.PressureDrop pipHeaWat(
    redeclare final package Medium=Medium,
    final m_flow_nominal=pla.mHeaWat_flow_nominal,
    final dp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatLocSet_max -
      max(datAll.pla.ctl.dpHeaWatRemSet_max))
    "Piping"
    annotation (Placement(transformation(extent={{140,-130},{120,-110}})));
  Buildings.Fluid.FixedResistances.PressureDrop pipChiWat(
    redeclare final package Medium=Medium,
    final m_flow_nominal=pla.mChiWat_flow_nominal,
    final dp_nominal=Buildings.Templates.Data.Defaults.dpChiWatLocSet_max -
      max(datAll.pla.ctl.dpChiWatRemSet_max))
    "Piping"
    annotation (Placement(transformation(extent={{140,-50},{120,-30}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volHeaWat(
    energyDynamics=energyDynamics,
    final m_flow_nominal=pla.mHeaWat_flow_nominal,
    V=Buildings.Templates.Data.Defaults.ratVLiqByCap*pla.capHea_nominal,
    redeclare package Medium = Medium,
    nPorts=3)
    "Fluid volume in distribution system"
    annotation (Placement(transformation(extent={{110,-80},{130,-100}})));
  Buildings.Fluid.MixingVolumes.MixingVolume volChiWat(
    energyDynamics=energyDynamics,
    final m_flow_nominal=pla.mChiWat_flow_nominal,
    V=Buildings.Templates.Data.Defaults.ratVLiqByCap*pla.capCoo_nominal,
    redeclare package Medium = Medium,
    nPorts=2)
    "Fluid volume in distribution system"
    annotation (Placement(transformation(extent={{110,0},{130,-20}})));
  Fluid.FixedResistances.Junction junCHWBypSup(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mChiWat_flow_nominal,-pla.mChiWat_flow_nominal,-pla.mChiWat_flow_nominal},
    dp_nominal={0,0,0})
    "CHW supply bypass leg junction"
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  Fluid.FixedResistances.Junction junCHWBypRet(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mChiWat_flow_nominal,-pla.mChiWat_flow_nominal,pla.mChiWat_flow_nominal},
    dp_nominal={0,0,0})
    "CHW return bypass leg junction"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-14,-40})));
  Fluid.FixedResistances.Junction junHWBypSup(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mHeaWat_flow_nominal,-pla.mHeaWat_flow_nominal,-pla.mHeaWat_flow_nominal},
    dp_nominal={0,0,0})
    "HW supply bypass leg junction"
    annotation (Placement(transformation(extent={{-34,-90},{-14,-70}})));
  Fluid.FixedResistances.Junction junHWBypRet(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mHeaWat_flow_nominal,-pla.mHeaWat_flow_nominal,pla.mHeaWat_flow_nominal},
    dp_nominal={0,0,0})
    "HW return bypass leg junction"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-24,-120})));
  Buildings.Templates.Components.Pumps.Multiple pumChiWatSec(
    energyDynamics=energyDynamics,
    redeclare package Medium = Medium,
    nPum=2,
    dat(m_flow_nominal=fill(pla.mChiWat_flow_nominal/pumChiWatSec.dat.nPum,
          pumChiWatSec.dat.nPum), dp_nominal=fill(max(pla.hp.dpHeaWatHp_nominal,
          pla.hp.dpChiWatHp_nominal), pumChiWatSec.dat.nPum)),
    sigSta(realFalse=1))
    "CHW secondary pumps"
    annotation (Placement(transformation(extent={{18,-10},{38,10}})));
  Buildings.Templates.Components.Pumps.Multiple pumHeaWatSec(
    energyDynamics=energyDynamics,
    redeclare package Medium = Medium,
    nPum=2,
    dat(m_flow_nominal=fill(pla.mHeaWat_flow_nominal/pumHeaWatSec.dat.nPum,
          pumHeaWatSec.dat.nPum), dp_nominal=fill(max(pla.hp.dpHeaWatHp_nominal,
          pla.hp.dpChiWatHp_nominal), pumHeaWatSec.dat.nPum)),
    sigSta(realFalse=1))
    "HW secondary pumps"
    annotation (Placement(transformation(extent={{18,-90},{38,-70}})));
  Buildings.Templates.Components.Routing.SingleToMultiple pumChiWatSecInl(
    redeclare package Medium = Medium,
    nPorts=pumChiWatSec.nPum,
    m_flow_nominal=pla.mChiWat_flow_nominal,
    energyDynamics=energyDynamics)
    "Inlet to CHW secondary pumps"
    annotation (Placement(transformation(extent={{-8,-10},{12,10}})));
  Buildings.Templates.Components.Routing.MultipleToSingle pumChiWatSecOut(
    redeclare package Medium = Medium,
    nPorts=pumChiWatSec.nPum,
    m_flow_nominal=pla.mChiWat_flow_nominal,
    energyDynamics=energyDynamics)
    "Outlet from CHW secondary pumps"
    annotation (Placement(transformation(extent={{46,-10},{66,10}})));
  Buildings.Templates.Components.Routing.SingleToMultiple pumHeaWatSecInl(
    redeclare package Medium = Medium,
    nPorts=pumHeaWatSec.nPum,
    m_flow_nominal=pla.mHeaWat_flow_nominal,
    energyDynamics=energyDynamics)
    "Inlet to HW secondary pumps"
    annotation (Placement(transformation(extent={{-8,-90},{12,-70}})));
  Buildings.Templates.Components.Routing.MultipleToSingle pumHeaWatSecOut(
    redeclare package Medium = Medium,
    nPorts=pumHeaWatSec.nPum,
    m_flow_nominal=pla.mHeaWat_flow_nominal,
    energyDynamics=energyDynamics)
    "Outlet from HW secondary pumps"
    annotation (Placement(transformation(extent={{46,-90},{66,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemChiWatPriSup(
    redeclare package Medium= Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal)
    "Chilled water primary supply temperature"
    annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemChiWatPriRet(
    redeclare package Medium = Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal)
    "Chilled water primary return temperature"
    annotation (Placement(transformation(extent={{-84,-50},{-64,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemChiWatSecSup(
    redeclare package Medium=Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal)
    "Chilled water secondary supply temperature"
    annotation (Placement(transformation(extent={{70,-10},{90,10}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemChiWatSecRet(
    redeclare package Medium=Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal)
    "Chilled water secondary return temperature"
    annotation (Placement(transformation(extent={{72,-50},{92,-30}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemHeaWatPriSup(
    redeclare package Medium=Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal)
    "Hot water primary supply temperature"
    annotation (Placement(transformation(extent={{-84,-90},{-64,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemHeaWatPriRet(
    redeclare package Medium=Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal)
    "Hot water primary return temperature"
    annotation (Placement(transformation(extent={{-82,-130},{-62,-110}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemHeaWatSecSup(
    redeclare package Medium=Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal)
    "Hot water secondary supply temperature"
    annotation (Placement(transformation(extent={{74,-90},{94,-70}})));
  Buildings.Fluid.Sensors.TemperatureTwoPort senTemHeaWatSecRet(
    redeclare package Medium = Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal)
    "Hot water secondary return temperature"
    annotation (Placement(transformation(extent={{76,-130},{96,-110}})));
  Buildings.Fluid.Sensors.VolumeFlowRate VChiWatPri_flow(
    redeclare final package Medium = Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal)
    "CHW primary volume flow rate"
    annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={-48,0})));
  Buildings.Fluid.Sensors.VolumeFlowRate VHeaWatPri_flow(
    redeclare final package Medium = Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal) "HW primary volume flow rate"
    annotation (Placement(transformation(
      extent={{-10,-10},{10,10}},
      rotation=0,
      origin={-48,-80})));
  ZoneEquipment.Interfaces.Bus busEquZon[pla.ctl.nEquZon] if pla.ctl.nEquZon >
    0 "Terminal control bus" annotation (Placement(transformation(extent={{0,
            160},{40,200}}), iconTransformation(extent={{40,80},{80,120}})));
  Modelica.Fluid.Interfaces.FluidPort_a CHWReturn_a(redeclare package Medium =
        Medium) "CHW return port" annotation (Placement(transformation(extent={
            {250,-50},{270,-30}}), iconTransformation(extent={{90,30},{110,50}})));
  Modelica.Fluid.Interfaces.FluidPort_b CHWSupply_b(redeclare package Medium =
        Medium) "CHW supply port" annotation (Placement(transformation(extent={
            {250,-10},{270,10}}), iconTransformation(extent={{90,70},{110,90}})));
  Modelica.Fluid.Interfaces.FluidPort_a HHWReturn_a(redeclare package Medium =
        Medium) "HHW return port" annotation (Placement(transformation(extent={
            {250,-130},{270,-110}}), iconTransformation(extent={{90,-90},{110,
            -70}})));
  Modelica.Fluid.Interfaces.FluidPort_b HHWSupply_b(redeclare package Medium =
        Medium) "HHW supply port" annotation (Placement(transformation(extent={
            {250,-90},{270,-70}}), iconTransformation(extent={{90,-50},{110,-30}})));
  BoundaryConditions.WeatherData.Bus busWea
    "Weather bus"
    annotation (Placement(transformation(extent={{-120,160},{-80,200}}),
      iconTransformation(extent={{-20,80},{20,120}})));
  Controls.Pumps.Generic.StagingHeadered staPumSecHea(
    is_pri=false,
    is_hdr=true,
    is_ctlDp=true,
    nEqu=3,
    nPum=2,
    nSenDp=1,
    V_flow_nominal=pla.mHeaWat_flow_nominal/1000)
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Controls.Pumps.Generic.ControlDifferentialPressure ctlDpSecHea(
    have_senDpRemWir=true,
    nPum=2,
    nSenDpRem=1)
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));
  Components.Interfaces.Bus busPumSecHea annotation (Placement(transformation(
          extent={{20,-200},{60,-160}}), iconTransformation(extent={{-274,-90},{
            -234,-50}})));
  Components.Interfaces.Bus busPumSecCoo annotation (Placement(transformation(
          extent={{96,60},{136,100}}), iconTransformation(extent={{-274,-90},{-234,
            -50}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant dPSetSecHea(k=60000)
    annotation (Placement(transformation(extent={{-160,-216},{-140,-196}})));
  Fluid.Sensors.VolumeFlowRate VHeaWatSec_flow(redeclare final package Medium
      = Medium, m_flow_nominal=pla.mHeaWat_flow_nominal)
    "HW secondary volume flow rate" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={204,-80})));
  Fluid.Sensors.VolumeFlowRate VChiWatSec_flow(redeclare final package Medium
      = Medium, m_flow_nominal=pla.mChiWat_flow_nominal)
    "CHW primary volume flow rate" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={210,0})));
  Controls.Pumps.Generic.StagingHeadered staPumSecCoo(
    is_pri=false,
    is_hdr=true,
    is_ctlDp=true,
    nEqu=3,
    nPum=2,
    nSenDp=1,
    V_flow_nominal=pla.mChiWat_flow_nominal/1000)
    annotation (Placement(transformation(extent={{40,100},{60,120}})));
  Controls.Pumps.Generic.ControlDifferentialPressure ctlDpSecCoo(
    have_senDpRemWir=true,
    nPum=2,
    nSenDpRem=1)
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant dPSetSecCoo(k=70000)
    annotation (Placement(transformation(extent={{-32,90},{-12,110}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant dPPri(k=0)
    annotation (Placement(transformation(extent={{-160,80},{-140,100}})));
equation
  connect(pla.bus, busPla)
    annotation (Line(points={{-180,-42},{-180,0}},color={255,204,51},thickness=0.5));
  connect(junCHWBypRet.port_3, junCHWBypSup.port_3)
    annotation (Line(points={{-14,-30},{-14,-20},{-22,-20},{-22,-10}},
                                               color={0,127,255}));
  connect(junHWBypRet.port_3, junHWBypSup.port_3)
    annotation (Line(points={{-24,-110},{-24,-90}},
                                                 color={0,127,255}));
  connect(junCHWBypSup.port_2, pumChiWatSecInl.port_a)
    annotation (Line(points={{-12,0},{-8,0}},color={0,127,255}));
  connect(pumChiWatSecInl.ports_b, pumChiWatSec.ports_a)
    annotation (Line(points={{12,0},{18,0}}, color={0,127,255}));
  connect(pumChiWatSec.ports_b, pumChiWatSecOut.ports_a)
    annotation (Line(points={{38,0},{46,0}}, color={0,127,255}));
  connect(junHWBypSup.port_2, pumHeaWatSecInl.port_a)
    annotation (Line(points={{-14,-80},{-8,-80}},color={0,127,255}));
  connect(pumHeaWatSecInl.ports_b, pumHeaWatSec.ports_a)
    annotation (Line(points={{12,-80},{18,-80}}, color={0,127,255}));
  connect(pumHeaWatSec.ports_b, pumHeaWatSecOut.ports_a)
    annotation (Line(points={{38,-80},{46,-80}}, color={0,127,255}));
  connect(junCHWBypRet.port_2, senTemChiWatPriRet.port_b)
    annotation (Line(points={{-24,-40},{-64,-40}}, color={0,127,255}));
  connect(pumChiWatSecOut.port_b, senTemChiWatSecSup.port_a)
    annotation (Line(points={{66,0},{70,0}}, color={0,127,255}));
  connect(senTemChiWatSecSup.port_b, volChiWat.ports[1])
    annotation (Line(points={{90,0},{119,0}}, color={0,127,255}));
  connect(pipChiWat.port_b, senTemChiWatSecRet.port_b)
    annotation (Line(points={{120,-40},{92,-40}}, color={0,127,255}));
  connect(senTemChiWatSecRet.port_a, junCHWBypRet.port_1)
    annotation (Line(points={{72,-40},{-4,-40}}, color={0,127,255}));
  connect(senTemHeaWatPriRet.port_b, junHWBypRet.port_2)
    annotation (Line(points={{-62,-120},{-34,-120}}, color={0,127,255}));
  connect(pumHeaWatSecOut.port_b, senTemHeaWatSecSup.port_a)
    annotation (Line(points={{66,-80},{74,-80}}, color={0,127,255}));
  connect(senTemHeaWatSecSup.port_b, volHeaWat.ports[1])
    annotation (Line(points={{94,-80},{118.667,-80}},
                                                  color={0,127,255}));
  connect(junHWBypRet.port_1, senTemHeaWatSecRet.port_a)
    annotation (Line(points={{-14,-120},{76,-120}}, color={0,127,255}));
  connect(senTemHeaWatSecRet.port_b, pipHeaWat.port_b)
    annotation (Line(points={{96,-120},{120,-120}}, color={0,127,255}));
  connect(senTemChiWatPriSup.port_b, VChiWatPri_flow.port_a)
    annotation (Line(points={{-64,0},{-58,0}}, color={0,127,255}));
  connect(VChiWatPri_flow.port_b, junCHWBypSup.port_1)
    annotation (Line(points={{-38,0},{-32,0}}, color={0,127,255}));
  connect(senTemHeaWatPriSup.port_b, VHeaWatPri_flow.port_a)
    annotation (Line(points={{-64,-80},{-58,-80}}, color={0,127,255}));
  connect(VHeaWatPri_flow.port_b, junHWBypSup.port_1)
    annotation (Line(points={{-38,-80},{-34,-80}}, color={0,127,255}));
  connect(senTemChiWatSecSup.T, busPla.TChiWatSecSup) annotation (Line(points={
          {80,11},{80,16},{-154,16},{-154,0},{-180,0}}, color={0,0,127}));
  connect(senTemHeaWatSecSup.T, busPla.THeaWatSecSup) annotation (Line(points={
          {84,-69},{84,-64},{-126,-64},{-126,16},{-154,16},{-154,0},{-180,0}},
        color={0,0,127}));
  connect(busEquZon, pla.busEquZon) annotation (Line(
      points={{20,180},{20,74},{-136,74},{-136,-48},{-140,-48}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(CHWReturn_a, pipChiWat.port_a)
    annotation (Line(points={{260,-40},{140,-40}}, color={0,127,255}));
  connect(volChiWat.ports[2], dpChiWatRem[1].port_a)
    annotation (Line(points={{121,0},{160,0},{160,-8}}, color={0,127,255}));
  connect(dpChiWatRem[1].port_b, pipChiWat.port_a) annotation (Line(points={{
          160,-28},{160,-40},{140,-40}}, color={0,127,255}));
  connect(pipHeaWat.port_a, HHWReturn_a)
    annotation (Line(points={{140,-120},{260,-120}}, color={0,127,255}));
  connect(pipHeaWat.port_a, dpHeaWatRem[1].port_b) annotation (Line(points={{
          140,-120},{160,-120},{160,-108}}, color={0,127,255}));
  connect(volHeaWat.ports[2], dpHeaWatRem[1].port_a) annotation (Line(points={{
          120,-80},{160,-80},{160,-88}}, color={0,127,255}));
  connect(busWea, pla.busWea) annotation (Line(
      points={{-100,180},{-100,18},{-150,18},{-150,-32},{-160,-32},{-160,-40}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(busAirHan, pla.busAirHan) annotation (Line(
      points={{-40,180},{-40,46},{-152,46},{-152,-34},{-140,-34},{-140,-42}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(pla.port_bChiWat, senTemChiWatPriSup.port_a) annotation (Line(points={
          {-140,-56},{-90,-56},{-90,0},{-84,0}}, color={0,127,255}));
  connect(pla.port_aChiWat, senTemChiWatPriRet.port_a) annotation (Line(points={
          {-140,-64},{-128,-64},{-128,-62},{-92,-62},{-92,-40},{-84,-40}},
        color={0,127,255}));
  connect(pla.port_bHeaWat, senTemHeaWatPriSup.port_a) annotation (Line(points={
          {-140,-70},{-90,-70},{-90,-80},{-84,-80}}, color={0,127,255}));
  connect(pla.port_aHeaWat, senTemHeaWatPriRet.port_a) annotation (Line(points={
          {-140,-78},{-118,-78},{-118,-120},{-82,-120}}, color={0,127,255}));
  connect(busPumSecCoo, pumChiWatSec.bus) annotation (Line(
      points={{116,80},{116,20},{28,20},{28,10}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(busPumSecHea, pumHeaWatSec.bus) annotation (Line(
      points={{40,-180},{40,-96},{100,-96},{100,-60},{28,-60},{28,-70}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,-6},{-3,-6}},
      horizontalAlignment=TextAlignment.Right));
  connect(ctlDpSecHea.y, busPumSecHea.y) annotation (Line(points={{-18,-190},{14,
          -190},{14,-180},{40,-180}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(staPumSecHea.y1, busPumSecHea.y1) annotation (Line(points={{-18,-150},
          {66,-150},{66,-180},{40,-180}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctlDpSecHea.y, staPumSecHea.y) annotation (Line(points={{-18,-190},{-10,
          -190},{-10,-166},{-46,-166},{-46,-158},{-42,-158}}, color={0,0,127}));
  connect(busPumSecHea.y1_actual, ctlDpSecHea.y1_actual) annotation (Line(
      points={{40,-180},{40,-206},{-50,-206},{-50,-182},{-42,-182}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(dPSetSecHea.y, ctlDpSecHea.dpRemSet[1]) annotation (Line(points={{-138,
          -206},{-52,-206},{-52,-186},{-42,-186}}, color={0,0,127}));
  connect(dPSetSecHea.y, staPumSecHea.dpSet[1]) annotation (Line(points={{-138,-206},
          {-52,-206},{-52,-154},{-42,-154}}, color={0,0,127}));
  connect(busPumSecHea.y1_actual, staPumSecHea.u1Pum_actual) annotation (Line(
      points={{40,-180},{40,-206},{-50,-206},{-50,-204},{-104,-204},{-104,-186},
          {-106,-186},{-106,-150},{-42,-150}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(busPla.dpHeaWatRemSec, ctlDpSecHea.dpRem) annotation (Line(
      points={{-180,0},{-180,-190},{-42,-190}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(busPla.dpHeaWatRemSec, staPumSecHea.dp) annotation (Line(
      points={{-180,0},{-180,-156},{-42,-156}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(volHeaWat.ports[3], VHeaWatSec_flow.port_a)
    annotation (Line(points={{121.333,-80},{194,-80}}, color={0,127,255}));
  connect(VHeaWatSec_flow.port_b, HHWSupply_b)
    annotation (Line(points={{214,-80},{260,-80}}, color={0,127,255}));
  connect(VHeaWatSec_flow.V_flow, staPumSecHea.V_flow) annotation (Line(points={
          {204,-69},{204,-64},{180,-64},{180,-132},{-50,-132},{-50,-152},{-42,-152}},
        color={0,0,127}));
  connect(volChiWat.ports[2], VChiWatSec_flow.port_a)
    annotation (Line(points={{121,0},{200,0}}, color={0,127,255}));
  connect(VChiWatSec_flow.port_b, CHWSupply_b)
    annotation (Line(points={{220,0},{260,0}}, color={0,127,255}));
  connect(ctlDpSecCoo.y, busPumSecCoo.y) annotation (Line(points={{62,70},{90,70},
          {90,80},{116,80}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(staPumSecCoo.y1, busPumSecCoo.y1) annotation (Line(points={{62,110},{116,
          110},{116,80}}, color={255,0,255}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(ctlDpSecCoo.y, staPumSecCoo.y) annotation (Line(points={{62,70},{70,70},
          {70,96},{30,96},{30,102},{38,102}}, color={0,0,127}));
  connect(busPumSecCoo.y1_actual, staPumSecCoo.u1Pum_actual) annotation (Line(
      points={{116,80},{116,106},{138,106},{138,118},{140,118},{140,126},{30,126},
          {30,110},{38,110}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(busPumSecCoo.y1_actual, ctlDpSecCoo.y1_actual) annotation (Line(
      points={{116,80},{116,106},{138,106},{138,118},{140,118},{140,126},{30,126},
          {30,104},{28,104},{28,78},{38,78}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(busPla.y1PlaEnaCoo, staPumSecCoo.u1Pla) annotation (Line(
      points={{-180,0},{-180,26},{-38,26},{-38,72},{24,72},{24,118},{38,118}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(busPla.y1PlaEnaHea, staPumSecHea.u1Pla) annotation (Line(
      points={{-180,0},{-180,-26},{-190,-26},{-190,-88},{-176,-88},{-176,-142},{
          -42,-142}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(dPSetSecCoo.y, ctlDpSecCoo.dpRemSet[1]) annotation (Line(points={{-10,
          100},{26,100},{26,74},{38,74}}, color={0,0,127}));
  connect(dpChiWatRem.p_rel, ctlDpSecCoo.dpRem) annotation (Line(points={{151,-18},
          {144,-18},{144,22},{28,22},{28,70},{38,70}}, color={0,0,127}));
  connect(dpChiWatRem.p_rel, staPumSecCoo.dp) annotation (Line(points={{151,-18},
          {144,-18},{144,52},{22,52},{22,104},{38,104}}, color={0,0,127}));
  connect(dPSetSecCoo.y, staPumSecCoo.dpSet[1]) annotation (Line(points={{-10,100},
          {26,100},{26,106},{38,106}}, color={0,0,127}));
  connect(VChiWatSec_flow.V_flow, staPumSecCoo.V_flow) annotation (Line(points={
          {210,11},{210,128},{28,128},{28,108},{38,108}}, color={0,0,127}));
  connect(dPPri.y, busPla.dpHeaWatRem[1]) annotation (Line(points={{-138,90},{
          -130,90},{-130,52},{-136,52},{-136,50},{-180,50},{-180,0}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dPPri.y, busPla.dpChiWatRem[1]) annotation (Line(points={{-138,90},{
          -130,90},{-130,52},{-136,52},{-136,50},{-180,50},{-180,0}}, color={0,
          0,127}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(busPumSecHea, busPla.pumHeaWatSec) annotation (Line(
      points={{40,-180},{40,-96},{100,-96},{100,-60},{-130,-60},{-130,-92},{
          -208,-92},{-208,0},{-180,0}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/Experimental/Validation/HybridAirToWater.mos"
        "Simulate and plot"),
    experiment(
      Tolerance=1e-6,
      StopTime=86400.0),
    Documentation(
      info="<html>
<p>
This model validates
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps.AirToWater\">
Buildings.Templates.Plants.HeatPumps.AirToWater</a>
by simulating a <i>24</i>-hour period with overlapping heating and
cooling loads.
The heating loads reach their peak value first, the cooling loads reach it last.
</p>
<p>
The plant consists of two 2-pipe air-source heat pumps (ASHPs) combined with a 4-pipe
ASHP. The 2-pipe ASHPs can be lead/lag alternated. The plant uses a constant-primary,
variable-secondary hydronic distribution system.
A unique aggregated load is modeled on each loop using a heat exchanger component
exposed to conditioned space air, and a two-way modulating valve.
An importance multiplier of <i>10</i> is applied to the plant requests
and reset requests generated from the valve position.
</p>
<p>
Some of the advanced equipment and control options can be modified via the parameter
dialog of the plant component.
</p>
<p>
Simulating this model shows how the plant responds to a varying load by
</p>
<ul>
<li>
staging or unstaging the AWHPs with the associated primary pumps,
</li>
<li>
rotating lead/lag alternate equipment to ensure even wear,
</li>
<li>
resetting the supply temperature and remote differential pressure
in both the CHW and HW loops based on the valve position,
</li>
<li>
staging and controlling the secondary pumps to meet the
remote differential pressure setpoint.
</li>
</ul>
<h4>Details</h4>
<p>
By default, all valves within the plant are modeled considering a linear
variation of the pressure drop with the flow rate (<code>pla.linearized=true</code>),
as opposed to the quadratic relationship usually considered for
a turbulent flow regime.
By limiting the size of the system of nonlinear equations, this setting
reduces the risk of solver failure and the time to solution for testing
various plant configurations.
</p>
</html>",
      revisions="<html>
<ul>
<li>
February 18, 2026, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(
      coordinateSystem(
        extent={{-240,-220},{260,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HybridAirToWater_PlantOnly;
