within Buildings.Templates.Plants.HeatPumps.Validation;
model Testbed_airSource_largeOffice
  "Validation of AWHP plant template"
  extends Modelica.Icons.Example;
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Main medium (common for CHW and HW)";

  parameter Boolean have_chiWat=true
    "Set to true if the plant provides CHW"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));

  inner parameter UserProject.Data.AllSystems datAll(pla(
      final cfg=pla.cfg,
      ctl(THeaWatSup_nominal=333.15, TChiWatSup_nominal=279.85),
      hp(
        mHeaWatHp_flow_nominal=58/pla.nHp,
        capHeaHp_nominal=2.7e6/pla.nHp,
        THeaWatSupHp_nominal=333.15,
        mChiWatHp_flow_nominal=68/pla.nHp,
        capCooHp_nominal=2.4e6/pla.nHp,
        TChiWatSupHp_nominal=279.85)))
    "Plant parameters"
    annotation (Placement(transformation(extent={{160,160},{180,180}})));
  parameter Boolean allowFlowReversal=true
    "= true to allow flow reversal, false restricts to design direction (port_a -> port_b)"
    annotation (Dialog(tab="Assumptions"),
    Evaluate=true);
  parameter Modelica.Fluid.Types.Dynamics energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial
    "Type of energy balance: dynamic (3 initialization options) or steady state"
    annotation (Evaluate=true,
    Dialog(tab="Dynamics",group="Conservation equations"));
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(filNam=
        ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/weatherdata/USA_NY_Buffalo-Greater.Buffalo.Intl.AP.725280_TMY3.mos"))
    "Outdoor conditions"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=0,
      origin={-170,-60})));
  Fluid.HeatExchangers.SensibleCooler_T loaHeaWat(
    redeclare final package Medium=Medium,
    final m_flow_nominal=pla.mHeaWat_flow_nominal,
    show_T=true,
    final dp_nominal=0,
    final energyDynamics=energyDynamics,
    tau=300,
    QMin_flow=- pla.capHea_nominal)
    "HW system approximated by prescribed return temperature"
    annotation (Placement(transformation(extent={{70,-130},{90,-110}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage valDisHeaWat(
    redeclare final package Medium=Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal,
    dpValve_nominal=3E4,
    dpFixed_nominal=datAll.pla.ctl.dpHeaWatRemSet_max[1] - 3E4)
    "Distribution system approximated by variable flow resistance"
    annotation (Placement(transformation(extent={{110,-130},{130,-110}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage valDisChiWat(
    redeclare final package Medium=Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal,
    dpValve_nominal=3E4,
    dpFixed_nominal=datAll.pla.ctl.dpChiWatRemSet_max[1] - 3E4)
    if have_chiWat
    "Distribution system approximated by variable flow resistance"
    annotation (Placement(transformation(extent={{110,-70},{130,-50}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TDum(
    k=293.15,
    y(final unit="K",
      displayUnit="degC"))
    "Placeholder signal for request generator"
    annotation (Placement(transformation(extent={{-180,150},{-160,170}})));
  Buildings.Controls.OBC.ASHRAE.G36.AHUs.MultiZone.VAV.SetPoints.PlantRequests reqPlaRes(
    final heaCoi=Buildings.Controls.OBC.ASHRAE.G36.Types.HeatingCoil.WaterBased,
    final cooCoi=if have_chiWat then Buildings.Controls.OBC.ASHRAE.G36.Types.CoolingCoil.WaterBased
      else Buildings.Controls.OBC.ASHRAE.G36.Types.CoolingCoil.None)
    "Plant and reset request"
    annotation (Placement(transformation(extent={{220,-120},{240,-100}})));
  Interfaces.Bus busPla
    "Plant control bus"
    annotation (Placement(transformation(extent={{-100,-60},{-60,-20}}),
      iconTransformation(extent={{-370,-70},{-330,-30}})));
  Fluid.Sensors.MassFlowRate mChiWat_flow(
    redeclare final package Medium=Medium)
    if have_chiWat
    "CHW mass flow rate"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
      origin={160,-80})));
  Fluid.Sensors.MassFlowRate mHeaWat_flow(
    redeclare final package Medium=Medium)
    "HW mass flow rate"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
      origin={160,-140})));
  Buildings.Fluid.FixedResistances.PressureDrop pipHeaWat(
    redeclare final package Medium=Medium,
    final m_flow_nominal=pla.mHeaWat_flow_nominal,
    final dp_nominal=Buildings.Templates.Data.Defaults.dpHeaWatLocSet_max - max(datAll.pla.ctl.dpHeaWatRemSet_max))
    "Piping"
    annotation (Placement(transformation(extent={{20,-170},{0,-150}})));
  Buildings.Fluid.FixedResistances.PressureDrop pipChiWat(
    redeclare final package Medium=Medium,
    final m_flow_nominal=pla.mChiWat_flow_nominal,
    final dp_nominal=Buildings.Templates.Data.Defaults.dpChiWatLocSet_max - max(datAll.pla.ctl.dpChiWatRemSet_max))
    if have_chiWat
    "Piping"
    annotation (Placement(transformation(extent={{10,-110},{-10,-90}})));
  Modelica.Blocks.Sources.CombiTimeTable datRea(
    final fileName=ModelicaServices.ExternalReferences.loadResource("modelica://Buildings/Resources/Data/Templates/HeatPumpPlant/Validation/AirToWater_Buffalo.dat"),
    final tableOnFile=true,
    final columns=2:8,
    final tableName="EnergyPlus",
    final smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    timeScale=1)
    "Reader for EnergyPlus example results"
    annotation (Placement(transformation(extent={{-180,90},{-160,110}})));

  HeatPumps_PNNL.Components.Controls.RequiredFlowrate reqFloHea
    annotation (Placement(transformation(extent={{-120,90},{-100,110}})));
  HeatPumps_PNNL.Components.Controls.RequiredFlowrate reqFloCoo
    annotation (Placement(transformation(extent={{-120,20},{-100,40}})));
  Fluid.Sensors.TemperatureTwoPort senTemCooSup(redeclare package Medium =
        Medium, m_flow_nominal=pla.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{40,-70},{60,-50}})));
  Fluid.Sensors.TemperatureTwoPort senTemHeaSup(redeclare package Medium =
        Medium, m_flow_nominal=pla.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{40,-130},{60,-110}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar(p=273.15)
    annotation (Placement(transformation(extent={{-120,60},{-100,80}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=273.15)
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));

  HHW_CHW_plant hHW_CHW_plant(datAll=datAll)
    annotation (Placement(transformation(extent={{-86,-110},{-66,-90}})));
  Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(redeclare package Medium1 =
        Medium, redeclare package Medium2 = MediumA)
    annotation (Placement(transformation(extent={{78,-44},{98,-64}})));
  Fluid.Sources.MassFlowSource_T boundary(
    redeclare package Medium = MediumA,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{170,-40},{150,-20}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = MediumA,
                                nPorts=2)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Fluid.Sensors.TemperatureTwoPort senTemCooSup1(redeclare package Medium =
        MediumA, m_flow_nominal=pla.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{48,-40},{28,-20}})));
  Buildings.Controls.OBC.CDL.Reals.PID conValChiWat(
    each k=0.1,
    each Ti=60,
    each final reverseActing=false) "Chilled water valve controller"
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Fluid.HeatExchangers.WetCoilCounterFlow cooCoi1(redeclare package Medium1 =
        Medium, redeclare package Medium2 = MediumA)
    annotation (Placement(transformation(extent={{76,58},{96,38}})));
  Fluid.Sensors.TemperatureTwoPort senTemCooSup2(redeclare package Medium =
        Medium, m_flow_nominal=pla.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{38,32},{58,52}})));
  Fluid.Sensors.TemperatureTwoPort senTemCooSup3(redeclare package Medium =
        MediumA, m_flow_nominal=pla.mChiWat_flow_nominal)
    annotation (Placement(transformation(extent={{46,62},{26,82}})));
  Buildings.Controls.OBC.CDL.Reals.PID conValChiWat1(
    each k=0.1,
    each Ti=60,
    each final reverseActing=false) "Chilled water valve controller"
    annotation (Placement(transformation(extent={{78,102},{98,122}})));
  Fluid.Actuators.Valves.TwoWayEqualPercentage valDisChiWat1(
    redeclare final package Medium = Medium,
    m_flow_nominal=pla.mChiWat_flow_nominal,
    dpValve_nominal=3E4,
    dpFixed_nominal=datAll.pla.ctl.dpChiWatRemSet_max[1] - 3E4)
    if have_chiWat
    "Distribution system approximated by variable flow resistance"
    annotation (Placement(transformation(extent={{108,32},{128,52}})));
  Fluid.Sources.MassFlowSource_T boundary1(
    redeclare package Medium = MediumA,
    use_Xi_in=true,
    use_m_flow_in=true,
    use_T_in=true,
    nPorts=1)
    annotation (Placement(transformation(extent={{168,62},{148,82}})));
equation
  if have_chiWat then
  end if;
  connect(loaHeaWat.port_b, valDisHeaWat.port_a)
    annotation (Line(points={{90,-120},{110,-120}},color={0,127,255}));
  connect(TDum.y, reqPlaRes.TAirSup)
    annotation (Line(points={{-158,160},{154,160},{154,88},{218,88},{218,-102}},
                                                                      color={0,0,127}));
  connect(TDum.y, reqPlaRes.TAirSupSet)
    annotation (Line(points={{-158,160},{154,160},{154,88},{218,88},{218,-102},{
          208,-102},{208,-107},{218,-107}},                           color={0,0,127}));
  connect(valDisChiWat.y_actual, reqPlaRes.uCooCoiSet)
    annotation (Line(points={{125,-53},{210,-53},{210,-113},{218,-113}},
                                                                     color={0,0,127}));
  connect(valDisHeaWat.y_actual, reqPlaRes.uHeaCoiSet)
    annotation (Line(points={{125,-113},{208,-113},{208,-118},{218,-118}},
                                                                       color={0,0,127}));
  connect(valDisChiWat.port_b, mChiWat_flow.port_a)
    annotation (Line(points={{130,-60},{160,-60},{160,-70}},color={0,127,255}));
  connect(valDisHeaWat.port_b, mHeaWat_flow.port_a)
    annotation (Line(points={{130,-120},{160,-120},{160,-130}},color={0,127,255}));
  connect(mChiWat_flow.port_b, pipChiWat.port_a)
    annotation (Line(points={{160,-90},{160,-100},{10,-100}},color={0,127,255}));
  connect(mHeaWat_flow.port_b, pipHeaWat.port_a)
    annotation (Line(points={{160,-150},{160,-160},{20,-160}},color={0,127,255}));
  connect(datRea.y[7], reqFloHea.TSupRef) annotation (Line(points={{-159,100},{
          -130,100},{-130,108},{-122,108}}, color={0,0,127}));
  connect(datRea.y[4], reqFloHea.TRetRef) annotation (Line(points={{-159,100},{
          -130,100},{-130,104},{-122,104}}, color={0,0,127}));
  connect(datRea.y[5], reqFloHea.mRef_flow) annotation (Line(points={{-159,100},
          {-132,100},{-132,100},{-122,100}},
                                           color={0,0,127}));
  connect(senTemHeaSup.port_b, loaHeaWat.port_a)
    annotation (Line(points={{60,-120},{70,-120}}, color={0,127,255}));
  connect(senTemHeaSup.T, reqFloHea.TSupMea) annotation (Line(points={{50,-109},
          {50,-98},{56,-98},{56,-180},{-154,-180},{-154,96},{-122,96}}, color={
          0,0,127}));
  connect(datRea.y[4], addPar.u) annotation (Line(points={{-159,100},{-132,100},
          {-132,70},{-122,70}}, color={0,0,127}));
  connect(addPar.y, loaHeaWat.TSet) annotation (Line(points={{-98,70},{62,70},{
          62,-112},{68,-112}}, color={0,0,127}));
  connect(datRea.y[2], addPar1.u) annotation (Line(points={{-159,100},{-132,100},
          {-132,0},{-122,0}}, color={0,0,127}));
  connect(datRea.y[6], reqFloCoo.TSupRef) annotation (Line(points={{-159,100},{
          -132,100},{-132,38},{-122,38}}, color={0,0,127}));
  connect(datRea.y[2], reqFloCoo.TRetRef) annotation (Line(points={{-159,100},{
          -132,100},{-132,34},{-122,34}}, color={0,0,127}));
  connect(datRea.y[3], reqFloCoo.mRef_flow) annotation (Line(points={{-159,100},
          {-132,100},{-132,30},{-122,30}}, color={0,0,127}));
  connect(senTemCooSup.T, reqFloCoo.TSupMea) annotation (Line(points={{50,-49},
          {50,4},{-90,4},{-90,46},{-130,46},{-130,26},{-122,26}}, color={0,0,
          127}));
  connect(weaDat.weaBus, hHW_CHW_plant.weaBus) annotation (Line(
      points={{-160,-60},{-116.1,-60},{-116.1,-82.5}},
      color={255,204,51},
      thickness=0.5));
  connect(senTemCooSup.port_b, cooCoi.port_a1)
    annotation (Line(points={{60,-60},{78,-60}}, color={0,127,255}));
  connect(cooCoi.port_b1, valDisChiWat.port_a)
    annotation (Line(points={{98,-60},{110,-60}}, color={0,127,255}));
  connect(hHW_CHW_plant.port_b1, senTemCooSup.port_a) annotation (Line(points={{
          -66,-94},{-20,-94},{-20,-60},{40,-60}}, color={0,127,255}));
  connect(pipChiWat.port_b, hHW_CHW_plant.port_a1) annotation (Line(points={{-10,
          -100},{-12,-100},{-12,-150},{-108,-150},{-108,-94},{-86,-94}}, color={
          0,127,255}));
  connect(boundary.ports[1], cooCoi.port_a2) annotation (Line(points={{150,-30},
          {108,-30},{108,-48},{98,-48}},                   color={0,127,255}));
  connect(cooCoi.port_b2, senTemCooSup1.port_a) annotation (Line(points={{78,-48},
          {64,-48},{64,-30},{48,-30}}, color={0,127,255}));
  connect(senTemCooSup1.port_b, bou.ports[1])
    annotation (Line(points={{28,-30},{24,-30},{24,-31},{20,-31}},
                                                 color={0,127,255}));
  connect(conValChiWat.y, valDisChiWat.y)
    annotation (Line(points={{102,10},{120,10},{120,-48}}, color={0,0,127}));
  connect(senTemCooSup1.T, conValChiWat.u_m) annotation (Line(points={{38,-19},{
          38,-12},{90,-12},{90,-2}}, color={0,0,127}));
  connect(hHW_CHW_plant.port_b1, senTemCooSup2.port_a) annotation (Line(points={
          {-66,-94},{-20,-94},{-20,42},{38,42}}, color={0,127,255}));
  connect(senTemCooSup2.port_b, cooCoi1.port_a1)
    annotation (Line(points={{58,42},{76,42}}, color={0,127,255}));
  connect(cooCoi1.port_b1, valDisChiWat1.port_a)
    annotation (Line(points={{96,42},{108,42}}, color={0,127,255}));
  connect(valDisChiWat1.port_b, mChiWat_flow.port_a) annotation (Line(points={{128,
          42},{180,42},{180,-64},{160,-64},{160,-70}}, color={0,127,255}));
  connect(conValChiWat1.y, valDisChiWat1.y)
    annotation (Line(points={{100,112},{118,112},{118,54}}, color={0,0,127}));
  connect(senTemCooSup3.T, conValChiWat1.u_m) annotation (Line(points={{36,83},{
          36,90},{88,90},{88,100}}, color={0,0,127}));
  connect(senTemCooSup3.port_a, cooCoi1.port_b2) annotation (Line(points={{46,72},
          {70,72},{70,54},{76,54}}, color={0,127,255}));
  connect(cooCoi1.port_a2, boundary1.ports[1]) annotation (Line(points={{96,54},
          {102,54},{102,72},{148,72}}, color={0,127,255}));
  connect(senTemCooSup3.port_b, bou.ports[2])
    annotation (Line(points={{26,72},{20,72},{20,-29}}, color={0,127,255}));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps/Validation/AirToWater.mos"
        "Simulate and plot"),
    experiment(
      StopTime=172800,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
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
Three equally sized heat pumps are modeled, which can all be lead/lag alternated.
A heat recovery chiller is included (<code>pla.have_hrc_select=true</code>) 
and connected to the HW and CHW return pipes (sidestream integration).
A unique aggregated load is modeled on each loop by means of a cooling or heating
component controlled to maintain a constant <i>&Delta;T</i>
and a modulating valve controlled to track a prescribed flow rate.
An importance multiplier of <i>10</i> is applied to the plant requests
and reset requests generated from the valve position.
</p>
<p>
The user can toggle the top-level parameter <code>have_chiWat</code>
to switch between a cooling and heating system (the default setting)
to a heating-only system.
Advanced equipment and control options can be modified via the parameter
dialog of the plant component.
</p>
<p>
Simulating this model shows how the plant responds to a varying load by
</p>
<ul>
<li>
staging or unstaging the AWHPs and associated primary pumps,
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
May 31, 2024, by Antoine Gautier:<br/>
Added sidestream HRC and refactored the model after updating the HP plant template.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/3808\">#3808</a>.
</li>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(
      coordinateSystem(
        extent={{-200,-200},{200,200}})));
end Testbed_airSource_largeOffice;
