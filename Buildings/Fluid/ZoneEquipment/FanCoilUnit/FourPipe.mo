within Buildings.Fluid.ZoneEquipment.FanCoilUnit;
model FourPipe "System model for a four-pipe fan coil unit"
  replaceable package MediumA = Modelica.Media.Interfaces.PartialMedium
    "Medium model of air";
  replaceable package MediumHW = Modelica.Media.Interfaces.PartialMedium
    "Medium model of hot water";
  replaceable package MediumCHW = Modelica.Media.Interfaces.PartialMedium
    "Medium model of chilled water";
  parameter Buildings.Fluid.ZoneEquipment.FanCoilUnit.Types.HeaSou
    heaCoiTyp=Buildings.Fluid.ZoneEquipment.FanCoilUnit.Types.HeaSou.hotWat
    "Heating coil type"
    annotation (Dialog(group="System parameters"));
  parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal(
    final min = 0)
    "Nominal heat flow rate of electric heating coil"
    annotation(Dialog(enable=not has_HW, group="Heating coil parameters"));

  parameter Modelica.Units.SI.MassFlowRate mHotWat_flow_nominal
    "Nominal mass flow rate of heating hot water"
    annotation(Dialog(enable=has_HW, group="Heating coil parameters"));

  parameter Modelica.Units.SI.PressureDifference dpAir_nominal
    "Total pressure difference across supply and return ports in airloop"
    annotation(Dialog(group="System parameters"));

  parameter Modelica.Units.SI.ThermalConductance UAHeaCoi_nominal
    "Thermal conductance at nominal flow, used to compute heat capacity"
    annotation(Dialog(enable=has_HW, group="Heating coil parameters"));

  parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal
    "Nominal mass flow rate of chilled water"
    annotation(Dialog(group="Cooling coil parameters"));

  parameter Modelica.Units.SI.ThermalConductance UACooCoi_nominal
    "Nominal Thermal conductance, used to compute heat capacity"
    annotation(Dialog(group="Cooling coil parameters"));

  parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
    "Nominal mass flow rate of supply air"
    annotation(Dialog(group="System parameters"));

  Modelica.Blocks.Interfaces.RealInput uHea(
    final unit="1")
    "Heating loop control signal"
    annotation(Placement(transformation(extent={{-340,-20},{-300,20}}),
      iconTransformation(extent={{-240,-100},{-200,-60}})));

  Modelica.Blocks.Interfaces.RealInput uCoo(
    final unit="1")
    "Cooling loop control signal"
    annotation(Placement(transformation(extent={{-340,-130},{-300,-90}}),
      iconTransformation(extent={{-240,-20},{-200,20}})));

  Modelica.Blocks.Interfaces.RealInput uFan(
    final unit="1")
    "Fan control signal"
    annotation(Placement(transformation(extent={{-340,60},{-300,100}}),
      iconTransformation(extent={{-240,60},{-200,100}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_Air_a(
    redeclare final package Medium = MediumA)
    "Return air port from zone"
    annotation (Placement(transformation(extent={{290,30},{310,50}}),
      iconTransformation(extent={{190,30},{210,50}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_Air_b(
    redeclare final package Medium = MediumA)
    "Supply air port to the zone"
    annotation (Placement(transformation(extent={{290,-50},{310,-30}}),
      iconTransformation(extent={{190,-50},{210,-30}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_CHW_b(redeclare final package
      Medium = Buildings.Media.Water)
    "Chilled water return port"
    annotation (Placement(transformation(extent={{20,-190},{40,-170}}),
      iconTransformation(extent={{50,-210},{70,-190}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_CHW_a(redeclare package Medium =
        Buildings.Media.Water)
    "Chilled water supply port"
    annotation (Placement(transformation(extent={{60,-190},{80,-170}}),
      iconTransformation(extent={{110,-210},{130,-190}})));

  Modelica.Fluid.Interfaces.FluidPort_b port_HW_b(redeclare final package
      Medium = Buildings.Media.Water)          if has_HW
    "Hot water return port"
    annotation (Placement(transformation(extent={{-100,-190},{-80,-170}}),
      iconTransformation(extent={{-130,-210},{-110,-190}})));

  Modelica.Fluid.Interfaces.FluidPort_a port_HW_a(redeclare final package
      Medium = Buildings.Media.Water)          if has_HW
    "Hot water supply port"
    annotation (Placement(transformation(extent={{-60,-190},{-40,-170}}),
      iconTransformation(extent={{-70,-210},{-50,-190}})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TAirHea(
    redeclare final package Medium = MediumA,
    final m_flow_nominal=mAir_flow_nominal)
    "Heating coil discharge air temperature sensor"
    annotation (Placement(transformation(extent={{-20,-50},{0,-30}})));

  Buildings.Fluid.HeatExchangers.DryCoilCounterFlow heaCoiHW(
    redeclare final package Medium1 = MediumHW,
    redeclare final package Medium2 = MediumA,
    final m1_flow_nominal=mHotWat_flow_nominal,
    final m2_flow_nominal=mAir_flow_nominal,
    final dp1_nominal=0,
    final dp2_nominal=0,
    final UA_nominal=UAHeaCoi_nominal,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial) if has_HW
    "Hot water heating coil"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}},
      rotation=180,
      origin={-70,-50})));

  Buildings.Fluid.Actuators.Valves.TwoWayLinear valHW(
    redeclare final package Medium = MediumHW,
    final m_flow_nominal=mHotWat_flow_nominal,
    final dpValve_nominal=50) if has_HW
    "Hot water flow control valve"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}},
      rotation=90,
      origin={-90,-80})));

  Buildings.Fluid.Sensors.VolumeFlowRate VHW_flow(
    redeclare final package Medium = MediumHW,
    final m_flow_nominal=mHotWat_flow_nominal) if has_HW
    "Hot water volume flowrate sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-50,-80})));

  Buildings.Fluid.Sensors.TemperatureTwoPort THWRet(
    redeclare final package Medium = MediumHW,
    final m_flow_nominal=mHotWat_flow_nominal) if has_HW
    "Hot water return temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=-90,
      origin={-90,-130})));

  Buildings.Fluid.Sensors.TemperatureTwoPort THWSup(
    redeclare final package Medium = MediumHW,
    final m_flow_nominal=mHotWat_flow_nominal) if has_HW
    "Hot water supply temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={-50,-130})));

  Buildings.Fluid.HeatExchangers.WetCoilCounterFlow cooCoi(
    redeclare final package Medium1 = MediumCHW,
    redeclare final package Medium2 = MediumA,
    final m1_flow_nominal=mChiWat_flow_nominal,
    final m2_flow_nominal=mAir_flow_nominal,
    final dp1_nominal=0,
    final dp2_nominal=0,
    final UA_nominal=UACooCoi_nominal,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial)
    "Chilled-water cooling coil"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=180,
      origin={50,-46})));

  Buildings.Fluid.Actuators.Valves.TwoWayLinear valCHW(
    redeclare final package Medium = MediumCHW,
    final m_flow_nominal=mChiWat_flow_nominal,
    final dpValve_nominal=50)
    "Chilled-water flow control valve"
    annotation(Placement(transformation(extent={{10,-10},{-10,10}},
      rotation=90,
      origin={30,-110})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TCHWLvg(
    redeclare final package Medium = MediumCHW,
    final m_flow_nominal=mChiWat_flow_nominal)
    "Chilled-water return temperature sensor"
    annotation(Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=-90,
      origin={30,-146})));

  Buildings.Fluid.Sensors.VolumeFlowRate VCHW_flow(
    redeclare final package Medium = MediumCHW,
    final m_flow_nominal=mChiWat_flow_nominal)
    "Chilled-water volume flowrate sensor"
    annotation(Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={70,-120})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TCHWEnt(
    redeclare final package Medium = MediumCHW,
    final m_flow_nominal=mChiWat_flow_nominal)
    "Chilled-water supply temperature sensor"
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
      rotation=90,
      origin={70,-150})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TAirLvg(
    redeclare final package Medium = MediumA,
    final m_flow_nominal=mAir_flow_nominal)
    "Supply air temperature sensor"
    annotation (Placement(transformation(extent={{180,-50},{200,-30}})));

  Movers.Preconfigured.FlowControlled_m_flow   fan(
    redeclare final package Medium = MediumA,
    final energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    addPowerToMedium=false,
    final m_flow_nominal=mAir_flow_nominal,
    final dp_nominal=dpAir_nominal,
    dpMax=200)
    "Supply fan"
    annotation (Placement(transformation(extent={{140,-50},{160,-30}})));

  Buildings.Fluid.Sensors.VolumeFlowRate vAirSup(
    redeclare final package Medium = MediumA,
    final m_flow_nominal=mAir_flow_nominal)
    "Supply air volume flow rate"
    annotation (Placement(transformation(extent={{220,-50},{240,-30}})));

  Buildings.Fluid.FixedResistances.PressureDrop totRes(
    final m_flow_nominal=mAir_flow_nominal,
    final dp_nominal=dpAir_nominal,
    final allowFlowReversal=true,
    redeclare final package Medium = MediumA)
    "Total resistance"
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));

  Buildings.Fluid.Sensors.TemperatureTwoPort TAirRet(
    redeclare final package Medium = MediumA,
    final m_flow_nominal=mAir_flow_nominal)
    "Return air temperature sensor"
    annotation (Placement(transformation(extent={{-210,-50},{-190,-30}})));

  Buildings.Fluid.Sensors.VolumeFlowRate vAirRet(
    redeclare final package Medium = MediumA,
    final m_flow_nominal=mAir_flow_nominal)
    "Return air volume flowrate"
    annotation (Placement(transformation(extent={{-180,-50},{-160,-30}})));

  Buildings.Fluid.HeatExchangers.HeaterCooler_u heaCoiEle(
    redeclare final package Medium = MediumA,
    final m_flow_nominal=mAir_flow_nominal,
    final dp_nominal=0,
    final Q_flow_nominal=QHeaCoi_flow_nominal) if not has_HW
    "Electric heating coil"
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
  Modelica.Blocks.Math.Gain gai(
    final k=mAir_flow_nominal)
    "Find mass flowrate value by multiplying nominal flowrate by normalized fan speed signal"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput
                                        yFan_actual(
    final unit="1",
    displayUnit="1")
    "Normalized actual fan speed signal"
    annotation (Placement(transformation(extent={{300,100},{340,140}}),
      iconTransformation(extent={{200,160},{240,200}})));
  Modelica.Blocks.Math.Gain gaiFanNor(
    final k=1/mAir_flow_nominal)
    "Normalized fan signal"
    annotation (Placement(transformation(extent={{240,110},{260,130}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TAirSup
    "Measured supply air temperature"                      annotation (
      Placement(transformation(extent={{300,60},{340,100}}),
        iconTransformation(extent={{200,100},{240,140}})));
  Sources.Boundary_pT bou(redeclare package Medium = MediumA, nPorts=1)
    annotation (Placement(transformation(extent={{100,-100},{120,-80}})));
protected
  final parameter Boolean has_HW=(heaCoiTyp ==Buildings.Fluid.ZoneEquipment.FanCoilUnit.Types.HeaSou.hotWat)
    "Check if a hot water heating coil exists"
    annotation(Dialog(enable=false, tab="Non-configurable"));

equation
  connect(valHW.port_a, heaCoiHW.port_b1) annotation (Line(points={{-90,-70},{-90,
          -44},{-80,-44}}, color={0,127,255}));
  connect(THWRet.port_a, valHW.port_b)
    annotation (Line(points={{-90,-120},{-90,-90}},color={0,127,255}));
  connect(THWSup.port_b, VHW_flow.port_a)
    annotation (Line(points={{-50,-120},{-50,-90}},
                                                color={0,127,255}));
  connect(heaCoiHW.port_b2, TAirHea.port_a) annotation (Line(points={{-60,-56},{
          -26,-56},{-26,-40},{-20,-40}},
                                       color={0,127,255}));
  connect(uHea, valHW.y) annotation (Line(points={{-320,0},{-150,0},{-150,-80},{
          -102,-80}}, color={0,0,127}));
  connect(port_HW_a, THWSup.port_a)
    annotation (Line(points={{-50,-180},{-50,-140}},
                                                 color={0,127,255}));
  connect(port_HW_b, THWRet.port_b)
    annotation (Line(points={{-90,-180},{-90,-140}}, color={0,127,255}));
  connect(TCHWLvg.port_a, valCHW.port_b)
    annotation (Line(points={{30,-136},{30,-120}}, color={0,127,255}));
  connect(valCHW.port_a, cooCoi.port_b1) annotation (Line(points={{30,-100},{30,
          -52},{40,-52}},  color={0,127,255}));
  connect(VCHW_flow.port_b, cooCoi.port_a1) annotation (Line(points={{70,-110},{
          70,-52},{60,-52}},   color={0,127,255}));
  connect(TCHWEnt.port_b, VCHW_flow.port_a)
    annotation (Line(points={{70,-140},{70,-130}}, color={0,127,255}));
  connect(TAirHea.port_b, cooCoi.port_a2) annotation (Line(points={{0,-40},{40,-40}},
                                  color={0,127,255}));
  connect(port_CHW_b, TCHWLvg.port_b) annotation (Line(points={{30,-180},{30,-156}},
                                color={0,127,255}));
  connect(fan.port_b, TAirLvg.port_a)
    annotation (Line(points={{160,-40},{180,-40}}, color={0,127,255}));
  connect(uCoo, valCHW.y) annotation (Line(points={{-320,-110},{18,-110}},
                     color={0,0,127}));
  connect(TAirLvg.port_b, vAirSup.port_a)
    annotation (Line(points={{200,-40},{220,-40}}, color={0,127,255}));
  connect(vAirSup.port_b, port_Air_b) annotation (Line(points={{240,-40},{300,-40}},
                                color={0,127,255}));
  connect(cooCoi.port_b2, totRes.port_a)
    annotation (Line(points={{60,-40},{100,-40}},color={0,127,255}));
  connect(TAirRet.port_b, vAirRet.port_a)
    annotation (Line(points={{-190,-40},{-180,-40}},
                                                   color={0,127,255}));
  connect(TAirRet.port_a, port_Air_a) annotation (Line(points={{-210,-40},{-220,
          -40},{-220,40},{300,40}},              color={0,127,255}));
  connect(heaCoiEle.port_b, TAirHea.port_a) annotation (Line(points={{-60,10},{-26,
          10},{-26,-40},{-20,-40}},
                                  color={0,127,255}));
  connect(uHea, heaCoiEle.u) annotation (Line(points={{-320,0},{-150,0},{-150,16},
          {-82,16}},     color={0,0,127}));
  connect(uFan, gai.u)
    annotation (Line(points={{-320,80},{-82,80}}, color={0,0,127}));
  connect(gai.y, fan.m_flow_in)
    annotation (Line(points={{-59,80},{150,80},{150,-28}},
                                                       color={0,0,127}));
  connect(TCHWEnt.port_a, port_CHW_a)
    annotation (Line(points={{70,-160},{70,-180}},  color={0,127,255}));
  connect(gaiFanNor.y, yFan_actual)
    annotation (Line(points={{261,120},{320,120}}, color={0,0,127}));
  connect(fan.m_flow_actual, gaiFanNor.u) annotation (Line(points={{161,-35},{168,
          -35},{168,120},{238,120}},    color={0,0,127}));
  connect(heaCoiHW.port_a1, VHW_flow.port_b)
    annotation (Line(points={{-60,-44},{-50,-44},{-50,-70}},
                                                       color={0,127,255}));
  connect(TAirLvg.T, TAirSup)
    annotation (Line(points={{190,-29},{190,80},{320,80}}, color={0,0,127}));
  connect(TAirSup, TAirSup)
    annotation (Line(points={{320,80},{320,80}},   color={0,0,127}));
  connect(vAirRet.port_b, heaCoiEle.port_a) annotation (Line(points={{-160,-40},
          {-120,-40},{-120,10},{-80,10}},       color={0,127,255}));
  connect(vAirRet.port_b, heaCoiHW.port_a2) annotation (Line(points={{-160,-40},
          {-120,-40},{-120,-56},{-80,-56}},        color={0,127,255}));
  connect(totRes.port_b, fan.port_a) annotation (Line(points={{120,-40},{140,-40}},
                                color={0,127,255}));
  connect(bou.ports[1], fan.port_a) annotation (Line(points={{120,-90},{134,-90},
          {134,-40},{140,-40}}, color={0,127,255}));
  annotation (defaultComponentName = "fanCoiUni",
    Icon(coordinateSystem(preserveAspectRatio=false, extent={{-200,-200},{200,200}}),
                               graphics={Rectangle(
          extent={{-200,200},{200,-200}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,200},{100,240}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(coordinateSystem(preserveAspectRatio=false,
      extent={{-300,-180},{300,140}})),
    Documentation(info="<html>
    <p>
    This is a four-pipe fan coil unit system model. The system contains
    a supply fan, an electric or hot-water heating coil, a chilled-water cooling coil,
    and a mixing box. 
    </p>
    The control modules for the system are implemented separately in
    <a href=\"modelica://Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls\">
    Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls</a>:
    <ul>
    <li>
    <a href=\"modelica://Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls.ConstantFanVariableWaterFlowrate\">
    ConstantFanVariableWaterFlowrate</a>:
    Modulate the cooling coil and heating coil valve positions to regulate the zone temperature
    between the heating and cooling setpoints. The fan is enabled and operated at the 
    maximum speed when there are zone heating or cooling loads. It is run at minimum speed when
    zone is occupied but there are no loads.
    </li>
    <li>
    <a href=\"modelica://Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls.VariableFanConstantWaterFlowrate\">
    VariableFanConstantWaterFlowrate</a>:
    Modulate the fan speed to regulate the zone temperature between the heating 
    and cooling setpoints. It is run at minimum speed when zone is occupied but 
    there are no loads. The heating and cooling coil valves are completely opened 
    when there are zone heating or cooling loads, respectively.
    </li>
    <li>
    <a href=\"modelica://Buildings.Fluid.ZoneEquipment.FanCoilUnit.Controls.MultispeedFanConstantWaterFlowrate\">
    MultispeedFanConstantWaterFlowrate</a>:
    Modulate the fan speed to regulate the zone temperature between the heating 
    and cooling setpoints. It is set at a range of fixed values between the maximum 
    and minimum speed, based on the heating and cooling loop signals generated. 
    It is run at minimum speed when zone is occupied but there are no loads. The 
    heating and cooling coil valves are completely opened when there are zone 
    heating or cooling loads, respectively.
    </li>
    </ul>
    </html>
    ", revisions="<html>
    <ul>
    <li>
    August 03, 2022 by Karthik Devaprasad, Sen Huang:<br/>
    First implementation.
    </li>
    </ul>
    </html>"));
end FourPipe;
