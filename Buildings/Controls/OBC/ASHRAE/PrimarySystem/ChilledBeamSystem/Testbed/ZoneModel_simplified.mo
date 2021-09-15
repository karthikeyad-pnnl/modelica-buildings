within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed;
block ZoneModel_simplified "Zone model"
  replaceable package MediumA =Buildings.Media.Air
    "Air medium model";

  replaceable package MediumW =Buildings.Media.Water
    "Water medium model";

  Buildings.Fluid.Sensors.Temperature zonTem(redeclare package Medium = MediumA)
    "Zone temperature sensor"
    annotation (Placement(transformation(extent={{160,-10},{180,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput QFlo "Power gained by zone"
    annotation (Placement(transformation(extent={{-240,-20},{-200,20}}),
        iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TZon(
    final unit="K",
    displayUnit="degC",
    final quantity="ThermodynamicTemperature") "Measured zone temperature"
    annotation (Placement(transformation(extent={{200,-20},{240,20}}),
        iconTransformation(extent={{100,20},{140,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yRelHumZon "Zone relative humidity"
    annotation (Placement(transformation(extent={{200,70},{240,110}}),
        iconTransformation(extent={{100,60},{140,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput VDisAir_flow "Discharge air volume flow rate"
    annotation (Placement(transformation(extent={{200,-100},{240,-60}}),
        iconTransformation(extent={{100,-20},{140,20}})));
  Buildings.Fluid.HeatExchangers.Radiators.RadiatorEN442_2 rad(
    redeclare package Medium = MediumW,
    m_flow_nominal=mRad_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    T_a_nominal=TRadSup_nominal,
    T_b_nominal=TRadRet_nominal,
    TAir_nominal=TAir_nominal,
    dp_nominal=0) "Radiator"
    annotation (Placement(transformation(extent={{-10,-160},{10,-140}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=
        zonTheCap)
    "Heat capacity for furniture and walls"
    annotation (Placement(transformation(extent={{6,14},{26,34}})));
  Buildings.Fluid.MixingVolumes.MixingVolume vol(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=mA_flow_nominal,
    V=1.2*V,
    nPorts=4) "Zone air volume"
              annotation (Placement(transformation(extent={{6,-16},{26,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal = 4359751.36
    "Nominal heat flow rate of radiator"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.Temperature TRadSup_nominal = 273.15+70
    "Radiator nominal supply water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.Temperature TRadRet_nominal = 273.15+50
    "Radiator nominal return water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=0.000604*1000
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.SIunits.Volume V=1200
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Real zonTheCap(
    final unit="J/K",
    displayUnit="J/K",
    final quantity="HeatCapacity") = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.SIunits.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  Modelica.Fluid.Interfaces.FluidPort_a portChiWat_a(redeclare package Medium =
        MediumW) "CHW inlet port" annotation (Placement(transformation(extent={{
            -50,-210},{-30,-190}}), iconTransformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b portChiWat_b(redeclare package Medium =
        MediumW) "CHW outlet port" annotation (Placement(transformation(extent={
            {30,-210},{50,-190}}), iconTransformation(extent={{30,-110},{50,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_a portAir_a(redeclare package Medium =
        MediumA) "Air inlet port" annotation (Placement(transformation(extent={{
            -210,-60},{-190,-40}}), iconTransformation(extent={{90,-50},{110,
            -30}})));
  Modelica.Fluid.Interfaces.FluidPort_b portAir_b(redeclare package Medium =
        MediumA) "Air outlet port" annotation (Placement(transformation(extent={
            {190,-60},{210,-40}}), iconTransformation(extent={{-110,-50},{-90,
            -30}})));
  Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a port_a
    annotation (Placement(transformation(extent={{-10,90},{10,110}})));
  Fluid.Sensors.RelativeHumidity senRelHum(redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = MediumA,
      m_flow_nominal=mA_flow_nominal)
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));

  Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumW,
      m_flow_nominal=mRad_flow_nominal)
    annotation (Placement(transformation(extent={{-40,-160},{-20,-140}})));
  Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumW,
      m_flow_nominal=mRad_flow_nominal)
    annotation (Placement(transformation(extent={{20,-160},{40,-140}})));
equation
  connect(zonTem.T, TZon)
    annotation (Line(points={{177,0},{220,0}}, color={0,0,127}));
  connect(vol.ports[1], zonTem.port) annotation (Line(points={{13,-16},{13,-20},
          {170,-20},{170,-10}}, color={0,127,255}));
  connect(rad.heatPortCon, vol.heatPort)
    annotation (Line(points={{-2,-142.8},{-2,-6},{6,-6}}, color={191,0,0}));
  connect(rad.heatPortRad, vol.heatPort)
    annotation (Line(points={{2,-142.8},{2,-6},{6,-6}}, color={191,0,0}));
  connect(QFlo, preHea.Q_flow)
    annotation (Line(points={{-220,0},{-100,0}}, color={0,0,127}));
  connect(heaCap.port, vol.heatPort)
    annotation (Line(points={{16,14},{0,14},{0,-6},{6,-6}}, color={191,0,0}));
  connect(preHea.port, vol.heatPort)
    annotation (Line(points={{-80,0},{0,0},{0,-6},{6,-6}}, color={191,0,0}));
  connect(portAir_b, vol.ports[2])
    annotation (Line(points={{200,-50},{15,-50},{15,-16}}, color={0,127,255}));
  connect(port_a, vol.heatPort)
    annotation (Line(points={{0,100},{0,-6},{6,-6}}, color={191,0,0}));
  connect(senRelHum.port, vol.ports[3])
    annotation (Line(points={{90,80},{90,-16},{17,-16}}, color={0,127,255}));
  connect(portAir_a, senVolFlo.port_a)
    annotation (Line(points={{-200,-50},{-140,-50}}, color={0,127,255}));
  connect(senVolFlo.port_b, vol.ports[4]) annotation (Line(points={{-120,-50},{19,
          -50},{19,-16}}, color={0,127,255}));
  connect(senRelHum.phi, yRelHumZon) annotation (Line(points={{101,90},{220,90}},
                              color={0,0,127}));
  connect(senVolFlo.V_flow, VDisAir_flow) annotation (Line(points={{-130,-39},{-130,
          -20},{-40,-20},{-40,-80},{220,-80}}, color={0,0,127}));
  connect(portChiWat_a, senTem.port_a)
    annotation (Line(points={{-40,-200},{-40,-150}}, color={0,127,255}));
  connect(senTem.port_b, rad.port_a)
    annotation (Line(points={{-20,-150},{-10,-150}}, color={0,127,255}));
  connect(rad.port_b, senTem1.port_a)
    annotation (Line(points={{10,-150},{20,-150}}, color={0,127,255}));
  connect(senTem1.port_b, portChiWat_b)
    annotation (Line(points={{40,-150},{40,-200}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={          Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-114,32},{120,-20}},
          textString="%name",
          lineColor={0,0,255})}),
                          Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-200},{200,200}})));
end ZoneModel_simplified;
