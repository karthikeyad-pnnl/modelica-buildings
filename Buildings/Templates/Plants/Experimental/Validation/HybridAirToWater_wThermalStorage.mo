within Buildings.Templates.Plants.Experimental.Validation;
model HybridAirToWater_wThermalStorage "Validation of AWHP plant template"
  extends Modelica.Icons.Example;
  extends Buildings.Templates.Plants.Experimental.Validation.HybridAirToWater_PlantOnly(
    break junHWBypSup,
    break junHWBypRet,
    break connect(busPla.y1PlaEnaHea, staPumSecHea.u1Pla),
    break res2,
    pumHeaWatSec(dat(m_flow_nominal=fill(pla.mHeaWat_flow_nominal/(1.4*
            pumHeaWatSec.dat.nPum), pumHeaWatSec.dat.nPum))),
    senTemHeaWatSecSup(m_flow_nominal=pla.mHeaWat_flow_nominal/1.4),
    volHeaWat(m_flow_nominal=pla.mHeaWat_flow_nominal/1.4),
    VHeaWatSec_flow(m_flow_nominal=pla.mHeaWat_flow_nominal/1.4),
    senTemHeaWatSecRet(m_flow_nominal=pla.mHeaWat_flow_nominal/1.4),
    pipHeaWat(m_flow_nominal=pla.mHeaWat_flow_nominal/1.4));
  replaceable package Medium=Buildings.Media.Water
    constrainedby Modelica.Media.Interfaces.PartialMedium
    "Main medium (common for CHW and HW)";
  parameter Boolean have_chiWat=true
    "Set to true if the plant provides CHW"
    annotation (Evaluate=true,
    Dialog(group="Configuration"));
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
  Fluid.Storage.Stratified           tanSim(
    redeclare package Medium = Medium,
    hTan=3,
    dIns=0.3,
    nSeg=10,
    m_flow_nominal=pla.mHeaWat_flow_nominal*2/7,
    VTan=9.5)
            "Tank"
    annotation (Placement(transformation(extent={{160,-310},{140,-290}})));
  Fluid.FixedResistances.Junction junHWBypSup(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mHeaWat_flow_nominal,-pla.mHeaWat_flow_nominal/1.4,-pla.mHeaWat_flow_nominal
        *2/7},
    dp_nominal={0,0,0})
    "HW supply bypass leg junction"
    annotation (Placement(transformation(extent={{140,-190},{160,-170}})));
  Fluid.FixedResistances.Junction junHWBypRet(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mHeaWat_flow_nominal/1.4,-pla.mHeaWat_flow_nominal,pla.mHeaWat_flow_nominal
        *2/7},
    dp_nominal={0,0,0})
    "HW return bypass leg junction"
    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={150,-350})));
  BestInClass.ExperimentsFY26Q4.Controls.PrimaryWarmup primaryWarmup
    annotation (Placement(transformation(extent={{-160,-270},{-140,-250}})));
  Fluid.Sensors.Temperature senTem(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{200,-340},{220,-320}})));
  BestInClass.ExperimentsFY26Q4.Controls.TankCharging tankCharging(VHys_flow=
        pla.mHeaWat_flow_nominal*1e-5)
    annotation (Placement(transformation(extent={{220,-170},{240,-150}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = Medium,
      m_flow_nominal=pla.mHeaWat_flow_nominal*2/7)
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={150,-230})));
  Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal*2/7,
    dpValve_nominal=1000,
    dpFixed_nominal=0)    annotation (Placement(transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={150,-268})));
  Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Medium,
    m_flow_nominal=pla.mHeaWat_flow_nominal*2/7,
    dpValve_nominal=1000,
    dpFixed_nominal=0)    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={170,-270})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar1(p=1) annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={110,-286})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{60,-296},{80,-276}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = Medium,
      m_flow_nominal=pla.mHeaWat_flow_nominal*2/7)
                                               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={150,-206})));
  Fluid.Sensors.Temperature senTem2(redeclare package Medium = Medium)
    annotation (Placement(transformation(extent={{200,-300},{220,-280}})));
  Buildings.Controls.OBC.CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{-212,-130},{-192,-110}})));
  Fluid.FixedResistances.Junction junHWBypRet1(
    redeclare package Medium = Medium,
    energyDynamics=energyDynamics,
    m_flow_nominal={pla.mHeaWat_flow_nominal*2/7,-pla.mHeaWat_flow_nominal*2/7,
        pla.mHeaWat_flow_nominal*2/7},
    dp_nominal={0,0,0})
    "HW return bypass leg junction"
    annotation (Placement(
        transformation(
        extent={{-10,10},{10,-10}},
        rotation=270,
        origin={150,-324})));
equation
  if have_chiWat then
  end if;
  connect(senTem.port, tanSim.fluPorVol[10]) annotation (Line(points={{210,-340},
          {210,-346},{174,-346},{174,-306},{168,-306},{168,-302},{166,-302},{
          166,-298.2},{155,-298.2}},
        color={0,127,255}));
  connect(senTem.T, tankCharging.TTanBot) annotation (Line(points={{217,-330},{226,
          -330},{226,-178},{200,-178},{200,-154.2},{218,-154.2}},
                                                              color={0,0,127}));
  connect(tankCharging.yChaZer, primaryWarmup.uChaZero) annotation (Line(points={{242,
          -160},{250,-160},{250,-318},{-168,-318},{-168,-268},{-162,-268},{-162,
          -267.8}},                                color={255,0,255}));
  connect(val1.port_a, senTem1.port_b)
    annotation (Line(points={{150,-258},{150,-240}}, color={0,127,255}));
  connect(senTem1.port_b, val2.port_a) annotation (Line(points={{150,-240},{170,
          -240},{170,-260}}, color={0,127,255}));
  connect(addPar1.y, val2.y) annotation (Line(points={{122,-286},{190,-286},{
          190,-270},{182,-270}}, color={0,0,127}));
  connect(gai.y, addPar1.u)
    annotation (Line(points={{82,-286},{98,-286}}, color={0,0,127}));
  connect(val1.port_b, tanSim.port_a)
    annotation (Line(points={{150,-278},{150,-290}}, color={0,127,255}));
  connect(senTem1.port_a, senVolFlo.port_b)
    annotation (Line(points={{150,-220},{150,-216}}, color={0,127,255}));
  connect(senTem2.port, tanSim.fluPorVol[1]) annotation (Line(points={{210,-300},
          {210,-306},{168,-306},{168,-301.8},{155,-301.8}}, color={0,127,255}));
  connect(senTem1.T, tankCharging.TTanInl) annotation (Line(points={{161,-230},{
          190,-230},{190,-158.2},{218,-158.2}},
                                             color={0,0,127}));
  connect(senTem2.T, tankCharging.TTanTop) annotation (Line(points={{217,-290},{
          224,-290},{224,-176},{202,-176},{202,-162.2},{218,-162.2}},
                                                                   color={0,0,
          127}));
  connect(senVolFlo.V_flow, tankCharging.VTan_flow) annotation (Line(points={{161,
          -206},{204,-206},{204,-166.2},{218,-166.2}}, color={0,0,127}));
  connect(tankCharging.yValTan, val1.y) annotation (Line(points={{242,-164},{252,
          -164},{252,-250},{130,-250},{130,-268},{138,-268}},     color={0,0,
          127}));
  connect(tankCharging.yValTan, gai.u) annotation (Line(points={{242,-164},{252,
          -164},{252,-250},{50,-250},{50,-286},{58,-286}}, color={0,0,127}));
  connect(senVolFlo.port_a, junHWBypSup.port_3)
    annotation (Line(points={{150,-196},{150,-190}}, color={0,127,255}));
  connect(VHeaWatPri_flow.port_b, junHWBypSup.port_1) annotation (Line(points={
          {-38,-80},{-38,-90},{-46,-90},{-46,-104},{104,-104},{104,-180},{140,
          -180}}, color={0,127,255}));
  connect(junHWBypSup.port_2, pumHeaWatSecInl.port_a) annotation (Line(points={
          {160,-180},{166,-180},{166,-140},{-14,-140},{-14,-80},{-8,-80}},
        color={0,127,255}));
  connect(senTemHeaWatSecRet.port_a, junHWBypRet.port_1) annotation (Line(
        points={{76,-120},{20,-120},{20,-356},{166,-356},{166,-350},{160,-350}},
        color={0,127,255}));
  connect(busWea.TDryBul, tankCharging.TOut) annotation (Line(
      points={{-99.9,180.1},{-99.9,160},{232,160},{232,-136},{200,-136},{200,-150.2},
          {218,-150.2}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-3,6},{-3,6}},
      horizontalAlignment=TextAlignment.Right));
  connect(busPla.y1PlaEnaHea, primaryWarmup.uPlaEna) annotation (Line(
      points={{-180,0},{-180,-26},{-190,-26},{-190,-88},{-176,-88},{-176,-260},
          {-162,-260}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(senTemHeaWatPriSup.T, primaryWarmup.TSup) annotation (Line(points={{
          -74,-69},{-74,-62},{-94,-62},{-94,-126},{-168,-126},{-168,-256},{-162,
          -256}}, color={0,0,127}));
  connect(tankCharging.nReqResHea, busPla.tankReqRes) annotation (Line(points={{242,
          -152},{32,-152},{32,0},{-180,0}},      color={255,127,0}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(tankCharging.nReqPlaHea, busPla.tankReq) annotation (Line(points={{242,
          -156},{32,-156},{32,0},{-180,0}},     color={255,127,0}), Text(
      string="%second",
      index=1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(busPla.THeaWatSupSet, primaryWarmup.TSupSet) annotation (Line(
      points={{-180,0},{-206,0},{-206,-90},{-166,-90},{-166,-244},{-162,-244},{
          -162,-252}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(junHWBypRet.port_2, senTemHeaWatPriRet.port_b) annotation (Line(
        points={{140,-350},{16,-350},{16,-120},{-62,-120}}, color={0,127,255}));
  connect(busAirHan[1].reqPlaHeaWat, tankCharging.nReqHeaPla) annotation (
      Line(
      points={{-40,180},{90,180},{90,-170},{218,-170}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(or2.y, staPumSecHea.u1Pla) annotation (Line(points={{-190,-120},{-164,
          -120},{-164,-142},{-42,-142}}, color={255,0,255}));
  connect(busPla.y1PlaEnaHea, or2.u1) annotation (Line(
      points={{-180,0},{-180,-26},{-190,-26},{-190,-88},{-176,-88},{-176,-192},{
          -224,-192},{-224,-120},{-214,-120}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(tankCharging.yPumHeaSecEna, or2.u2) annotation (Line(points={{242,-168},
          {14,-168},{14,-128},{-214,-128}}, color={255,0,255}));
  connect(junHWBypRet.port_3, junHWBypRet1.port_2)
    annotation (Line(points={{150,-340},{150,-334}}, color={0,127,255}));
  connect(junHWBypRet1.port_1, tanSim.port_b)
    annotation (Line(points={{150,-314},{150,-310}}, color={0,127,255}));
  connect(val2.port_b, junHWBypRet1.port_3) annotation (Line(points={{170,-280},
          {170,-324},{160,-324}}, color={0,127,255}));
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
        extent={{-240,-360},{260,180}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})));
end HybridAirToWater_wThermalStorage;
