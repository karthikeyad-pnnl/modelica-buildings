within Buildings.Examples.BoilerPlant.PlantModel;
block ZoneModel_simplified "Zone model"
  extends Modelica.Icons.Example;
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  Fluid.Sensors.Temperature           zonTem(redeclare package Medium =
        MediumA)
    annotation (Placement(transformation(extent={{160,-10},{180,10}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-240,-20},{-200,20}}), iconTransformation(extent={{-140,-20},
            {-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y(
    final unit = "K",
    displayUnit = "degC",
    final quantity = "ThermodynamicTemperature") annotation (Placement(transformation(
          extent={{200,-20},{240,20}}), iconTransformation(extent={{100,-20},{140,
            20}})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2           rad(
    redeclare package Medium = MediumW,
    m_flow_nominal=mRad_flow_nominal,
    Q_flow_nominal=Q_flow_nominal,
    T_a_nominal=TRadSup_nominal,
    T_b_nominal=TRadRet_nominal,
    TAir_nominal=TAir_nominal,
    dp_nominal=0)
    "Radiator"
    annotation (Placement(transformation(extent={{-10,-160},{10,-140}})));

  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heaCap(C=
        zonTheCap)
    "Heat capacity for furniture and walls"
    annotation (Placement(transformation(extent={{6,14},{26,34}})));
  Fluid.MixingVolumes.MixingVolume           vol(
    redeclare package Medium = MediumA,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    m_flow_nominal=mA_flow_nominal,
    V=1.2*V,
    nPorts=1)
    annotation (Placement(transformation(extent={{6,-16},{26,4}})));
  Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow preHea
    "Prescribed heat flow"
    annotation (Placement(transformation(extent={{-100,-10},{-80,10}})));

  parameter Modelica.Units.SI.HeatFlowRate Q_flow_nominal = 4359751.36
    "Nominal heat flow rate of radiator"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Temperature TRadSup_nominal = 273.15+70
    "Radiator nominal supply water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Temperature TRadRet_nominal = 273.15+50
    "Radiator nominal return water temperature"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.MassFlowRate mRad_flow_nominal=0.000604*1000
    "Radiator nominal mass flow rate"
    annotation(dialog(group="Radiator parameters"));

  parameter Modelica.Units.SI.Volume V=1200
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Real zonTheCap = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumW) annotation (Placement(transformation(extent={{-50,-210},{-30,
            -190}}), iconTransformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumW) annotation (Placement(transformation(extent={{30,-210},{50,
            -190}}), iconTransformation(extent={{30,-110},{50,-90}})));
equation
  connect(zonTem.T, y)
    annotation (Line(points={{177,0},{220,0}}, color={0,0,127}));
  connect(vol.ports[1], zonTem.port) annotation (Line(points={{16,-16},{16,-20},
          {170,-20},{170,-10}}, color={0,127,255}));
  connect(rad.heatPortCon, vol.heatPort)
    annotation (Line(points={{-2,-142.8},{-2,-6},{6,-6}}, color={191,0,0}));
  connect(rad.heatPortRad, vol.heatPort)
    annotation (Line(points={{2,-142.8},{2,-6},{6,-6}}, color={191,0,0}));
  connect(u, preHea.Q_flow)
    annotation (Line(points={{-220,0},{-100,0}}, color={0,0,127}));
  connect(port_a, rad.port_a) annotation (Line(points={{-40,-200},{-40,-150},{-10,
          -150}}, color={0,127,255}));
  connect(port_b, rad.port_b) annotation (Line(points={{40,-200},{40,-150},{10,-150}},
        color={0,127,255}));
  connect(heaCap.port, vol.heatPort)
    annotation (Line(points={{16,14},{0,14},{0,-6},{6,-6}}, color={191,0,0}));
  connect(preHea.port, vol.heatPort)
    annotation (Line(points={{-80,0},{0,0},{0,-6},{6,-6}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-200},{200,200}})));
end ZoneModel_simplified;
