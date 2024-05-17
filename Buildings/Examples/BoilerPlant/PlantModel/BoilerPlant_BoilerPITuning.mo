within Buildings.Examples.BoilerPlant.PlantModel;
model BoilerPlant_BoilerPITuning "Boiler plant model for closed loop testing"
  extends Modelica.Icons.Example;
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter Modelica.Units.SI.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal = boiEff1[1]*boiCap1 + boiEff2[1]*boiCap2
    "Nominal heat flow rate of radiator"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.HeatFlowRate boiCap1= 2200000
    "Boiler capacity for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.HeatFlowRate boiCap2= 2200000
    "Boiler capacity for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff1[6] = {0.6246, 0.7711, -1.2077*10e-15, 0.008576, -0.005933, 0.003156}
    "Efficiency for boiler-1"
    annotation(dialog(group="Boiler parameters"));

  parameter Real boiEff2[6] = {0.6246, 0.7711, -1.2077*10e-15, 0.008576, -0.005933, 0.003156}
    "Efficiency for boiler-2"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.Temperature TRadSup_nominal = 273.15+70
    "Radiator nominal supply water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Temperature TRadRet_nominal = 273.15+50
    "Radiator nominal return water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=0.096323 * 1000
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Temperature TBoiSup_nominal = 273.15+70
    "Boiler nominal supply water temperature"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.Temperature TBoiRet_min = 273.15+60
    "Boiler minimum return water temperature"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal1=mRad_flow_nominal
    "Boiler-1 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.MassFlowRate mBoi_flow_nominal2=mRad_flow_nominal
    "Boiler-2 nominal mass flow rate"
    annotation(dialog(group="Boiler parameters"));

  parameter Modelica.Units.SI.Volume V=126016.35
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Real zonTheCap = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));

  Buildings.Fluid.Boilers.BoilerPolynomial boi(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal=mRad_flow_nominal/2,
    final dp_nominal=5000,
    final Q_flow_nominal=3300000,
    final T_nominal=305.37,
    final effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant,
    final a={0.8},
    final fue=Fluid.Data.Fuels.NaturalGasHigherHeatingValue(),
    final UA=3300000/39.81)
    "Boiler"
    annotation (Placement(transformation(extent={{110,-160},{90,-140}})));

  Buildings.Fluid.Sources.Boundary_pT preSou(
    redeclare package Medium = MediumW, nPorts=1)
    "Source for pressure and to account for thermal expansion of water"
    annotation (Placement(transformation(extent={{260,-210},{240,-190}})));

  Buildings.Fluid.Boilers.BoilerPolynomial           boi1(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal=mRad_flow_nominal/2,
    final dp_nominal=5000,
    final Q_flow_nominal=1000000,
    final T_nominal=305.37,
    final effCur=Buildings.Fluid.Types.EfficiencyCurves.Constant,
    final a={0.8},
    final fue=Buildings.Fluid.Data.Fuels.HeatingOilLowerHeatingValue(),
    final UA=1000000/39.81)
    "Boiler"
    annotation (Placement(transformation(extent={{110,-220},{90,-200}})));

  Buildings.Fluid.Movers.SpeedControlled_y pum(
    redeclare package Medium = Media.Water,
    final allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.customPumpCurves_Buffalo per,
    final inputType=Buildings.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=false,
    use_inputFilter=false,
    final riseTime=300)
    "Hot water primary pump-1"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-70,-40})));

  Buildings.Fluid.FixedResistances.Junction spl1(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={mBoi_flow_nominal2,-mRad_flow_nominal,mBoi_flow_nominal1},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-30,-150})));

  Buildings.Fluid.Movers.SpeedControlled_y pum1(
    redeclare package Medium =Media.Water,
    final allowFlowReversal=true,
    redeclare Fluid.Movers.Data.Pumps.Wilo.customPumpCurves_Buffalo per,
    final inputType=Buildings.Fluid.Types.InputType.Continuous,
    final addPowerToMedium=false,
    use_inputFilter=false,
    final riseTime=300)
    "Hot water primary pump-2"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={10,-40})));

  Buildings.Fluid.FixedResistances.Junction spl2(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={mRad_flow_nominal,-mRad_flow_nominal/2,-
        mRad_flow_nominal/2},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-30,-100})));

  Buildings.Fluid.Actuators.Valves.TwoWayLinear val1(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mBoi_flow_nominal1,
    final dpValve_nominal=0.1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    "Isolation valve for boiler-2"
    annotation (Placement(transformation(extent={{0,-220},{20,-200}})));

  Buildings.Fluid.Actuators.Valves.TwoWayLinear val2(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mBoi_flow_nominal2,
    final dpValve_nominal=0.1,
    init=Modelica.Blocks.Types.Init.InitialState,
    y_start=0)
    "Isolation valve for boiler-1"
    annotation (Placement(transformation(extent={{0,-160},{20,-140}})));

  Buildings.Fluid.Actuators.Valves.TwoWayLinear val4(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal/2,
    final dpValve_nominal=0.1,
    use_inputFilter=false,
    riseTime=15)               "Valve to prevent reverse flow through pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
        origin={-70,-70})));
  Buildings.Fluid.Actuators.Valves.TwoWayLinear           val5(
    redeclare package Medium = Media.Water,
    final m_flow_nominal=mRad_flow_nominal/2,
    final dpValve_nominal=0.1,
    use_inputFilter=false,
    riseTime=15)               "Valve to prevent reverse flow through pump"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
        origin={10,-70})));
  Fluid.Sensors.TemperatureTwoPort           senTem2(redeclare package Medium =
        Media.Water, m_flow_nominal=mBoi_flow_nominal1)
    annotation (Placement(transformation(extent={{60,-160},{80,-140}})));
  Fluid.Sensors.TemperatureTwoPort           senTem3(redeclare package Medium =
        Media.Water, m_flow_nominal=mBoi_flow_nominal2)
    annotation (Placement(transformation(extent={{60,-220},{80,-200}})));
  Buildings.Controls.OBC.CDL.Reals.PID conPID[2](
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=fill(10e-3, 2),
    Ti={60,60},
    yMax=fill(1, 2),
    yMin=fill(0.1, 2),
    xi_start=fill(1, 2),
    reverseActing=true)
    "PI controller for regulating hot water supply temperature from boiler"
    annotation (Placement(transformation(extent={{-280,-120},{-260,-100}})));
  Fluid.FixedResistances.Junction           spl6(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={-mBoi_flow_nominal1,mRad_flow_nominal,-
        mBoi_flow_nominal2},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=0,
      origin={150,-150})));
  Fluid.FixedResistances.Junction           spl3(
    redeclare package Medium = MediumW,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final m_flow_nominal={mRad_flow_nominal/2,-mRad_flow_nominal,
        mRad_flow_nominal/2},
    final dp_nominal={0,0,-200})
    "Splitter"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-50,50})));
  Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
    tableOnFile=true,
    tableName="tab1",
    fileName=
        "C:/Users/deva713/OneDrive - PNNL/Documents/Git_repos/modelica-buildings/VM_script/inputTableTxt.txt",
    verboseRead=true,
    columns={9},
    timeScale=60) "Boiler thermal load from EnergyPlus simulation"
    annotation (Placement(transformation(extent={{-120,190},{-100,210}})));

  Buildings.Controls.OBC.CDL.Reals.Gain gai(k=-1)
    annotation (Placement(transformation(extent={{-80,190},{-60,210}})));
  ZoneModel_simplified            zoneModel_simplified(
    Q_flow_nominal=4359751.36,
    TRadSup_nominal=333.15,
    TRadRet_nominal=323.15,
    mRad_flow_nominal=96.323,
    V=126016.35,
    zonTheCap=6987976290)
    annotation (Placement(transformation(extent={{-20,140},{0,160}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con(k=0.5)
    annotation (Placement(transformation(extent={{-180,-20},{-160,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant con1(k=70)
    annotation (Placement(transformation(extent={{-300,-20},{-280,0}})));
  Buildings.Controls.OBC.CDL.Reals.AddParameter addPar[2](p=-273.15, k=1)
    annotation (Placement(transformation(extent={{-300,-160},{-280,-140}})));
equation
  connect(spl1.port_2, spl2.port_1)
    annotation (Line(points={{-30,-140},{-30,-110}},   color={0,127,255}));
  connect(val2.port_a, spl1.port_3)
    annotation (Line(points={{0,-150},{-20,-150}},    color={0,127,255}));
  connect(val1.port_a, spl1.port_1) annotation (Line(points={{0,-210},{-30,-210},
          {-30,-160}},        color={0,127,255}));

  connect(spl2.port_2, val4.port_a) annotation (Line(points={{-30,-90},{-30,-86},
          {-70,-86},{-70,-80}}, color={0,127,255}));
  connect(val4.port_b, pum.port_a)
    annotation (Line(points={{-70,-60},{-70,-50}}, color={0,127,255}));
  connect(val5.port_b, pum1.port_a)
    annotation (Line(points={{10,-60},{10,-50}}, color={0,127,255}));
  connect(spl2.port_3, val5.port_a) annotation (Line(points={{-20,-100},{10,-100},
          {10,-80}}, color={0,127,255}));
  connect(senTem2.port_b, boi.port_b)
    annotation (Line(points={{80,-150},{90,-150}}, color={0,127,255}));
  connect(senTem3.port_b, boi1.port_b)
    annotation (Line(points={{80,-210},{90,-210}}, color={0,127,255}));
  connect(boi.port_a, spl6.port_1)
    annotation (Line(points={{110,-150},{140,-150}}, color={0,127,255}));
  connect(boi1.port_a, spl6.port_3) annotation (Line(points={{110,-210},{150,
          -210},{150,-160}}, color={0,127,255}));
  connect(spl6.port_2, preSou.ports[1]) annotation (Line(points={{160,-150},{
          210,-150},{210,-200},{240,-200}}, color={0,127,255}));
  connect(senTem2.port_a, val2.port_b)
    annotation (Line(points={{60,-150},{20,-150}}, color={0,127,255}));
  connect(senTem3.port_a, val1.port_b)
    annotation (Line(points={{60,-210},{20,-210}}, color={0,127,255}));
  connect(pum.port_b, spl3.port_1) annotation (Line(points={{-70,-30},{-70,20},
          {-50,20},{-50,40}}, color={0,127,255}));
  connect(pum1.port_b, spl3.port_3)
    annotation (Line(points={{10,-30},{10,50},{-40,50}}, color={0,127,255}));
  connect(conPID[1].y, boi1.y) annotation (Line(points={{-258,-110},{120,-110},
          {120,-202},{112,-202}}, color={0,0,127}));
  connect(conPID[2].y, boi.y) annotation (Line(points={{-258,-110},{120,-110},{
          120,-142},{112,-142}}, color={0,0,127}));
  connect(combiTimeTable.y[1],gai. u)
    annotation (Line(points={{-99,200},{-82,200}},color={0,0,127}));
  connect(gai.y,zoneModel_simplified. u)
    annotation (Line(points={{-58,200},{-36,200},{-36,150},{-22,150}},
                                                 color={0,0,127}));
  connect(spl3.port_2, zoneModel_simplified.port_a) annotation (Line(points={{
          -50,60},{-50,120},{-14,120},{-14,140}}, color={0,127,255}));
  connect(zoneModel_simplified.port_b, spl6.port_2) annotation (Line(points={{
          -6,140},{-6,120},{180,120},{180,-150},{160,-150}}, color={0,127,255}));
  connect(con.y, pum.y) annotation (Line(points={{-158,-10},{-100,-10},{-100,
          -40},{-82,-40}}, color={0,0,127}));
  connect(con.y, val4.y) annotation (Line(points={{-158,-10},{-100,-10},{-100,
          -70},{-82,-70}}, color={0,0,127}));
  connect(con.y, pum1.y) annotation (Line(points={{-158,-10},{-10,-10},{-10,-40},
          {-2,-40}}, color={0,0,127}));
  connect(con.y, val5.y) annotation (Line(points={{-158,-10},{-10,-10},{-10,-70},
          {-2,-70}}, color={0,0,127}));
  connect(con.y, val2.y) annotation (Line(points={{-158,-10},{-10,-10},{-10,
          -120},{10,-120},{10,-138}}, color={0,0,127}));
  connect(con.y, val1.y) annotation (Line(points={{-158,-10},{-10,-10},{-10,
          -180},{10,-180},{10,-198}}, color={0,0,127}));
  connect(con1.y, conPID[1].u_s) annotation (Line(points={{-278,-10},{-270,-10},
          {-270,-80},{-300,-80},{-300,-110},{-282,-110}}, color={0,0,127}));
  connect(con1.y, conPID[2].u_s) annotation (Line(points={{-278,-10},{-270,-10},
          {-270,-80},{-300,-80},{-300,-110},{-282,-110}}, color={0,0,127}));
  connect(addPar.y, conPID.u_m) annotation (Line(points={{-278,-150},{-270,-150},
          {-270,-122}}, color={0,0,127}));
  connect(senTem3.T, addPar[1].u) annotation (Line(points={{70,-199},{70,-190},
          {-310,-190},{-310,-150},{-302,-150}}, color={0,0,127}));
  connect(senTem2.T, addPar[2].u) annotation (Line(points={{70,-139},{70,-130},
          {-60,-130},{-60,-190},{-310,-190},{-310,-150},{-302,-150}}, color={0,
          0,127}));
  annotation (defaultComponentName="boiPla",
    Documentation(info="<html>
      <p>
      This model implements a primary-only, condensing boiler plant with headered, 
      variable-speed primary pumps, as defined in ASHRAE RP-1711, March 2020 draft.
      </p>
      </html>", revisions="<html>
      <ul>
      <li>
      October 28, 2020, by Karthik Devaprasad:<br/>
      First implementation.
      </li>
      </ul>
      </html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false,
      extent={{-320,-240},{320,240}})),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Text(
          extent={{-100,160},{100,120}},
          lineColor={0,0,255},
          textString="%name")}),
    experiment(
      StopTime=864000,
      Interval=60,
      __Dymola_Algorithm="Cvode"));
end BoilerPlant_BoilerPITuning;
