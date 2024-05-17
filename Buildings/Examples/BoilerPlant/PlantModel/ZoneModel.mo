within Buildings.Examples.BoilerPlant.PlantModel;
block ZoneModel "Zone model"
  extends Modelica.Icons.Example;
  replaceable package MediumA =
      Buildings.Media.Air;

  replaceable package MediumW =
      Buildings.Media.Water
    "Medium model";

  parameter HeatTransfer.Data.Solids.Plywood matFur(x=0.15, nStaRef=5)
    "Material for furniture"
    annotation (Placement(transformation(extent={{-40,160},{-20,180}})));
  parameter HeatTransfer.Data.Resistances.Carpet matCar "Carpet"
    annotation (Placement(transformation(extent={{0,160},{20,180}})));
  parameter HeatTransfer.Data.Solids.Concrete matCon(
    x=0.2032,
    k=2.31,
    c=832,
    d=2322,
    nStaRef=5)
    "Concrete"
    annotation (Placement(transformation(extent={{-40,120},{-20,140}})));

  parameter HeatTransfer.Data.Solids.Plywood matWoo(
    x=0.01,
    k=0.11,
    d=544,
    nStaRef=1) "Wood for exterior construction"
    annotation (Placement(transformation(extent={{-80,120},{-60,140}})));

  parameter HeatTransfer.Data.Solids.Generic matInsExtWal(
    x=10e-6,
    k=2e-5,
    c=10e-6,
    d=0.01,
    nStaRef=5) "Extrior wall insulation"
    annotation (Placement(transformation(extent={{0,120},{20,140}})));

  parameter HeatTransfer.Data.Solids.GypsumBoard matGypExt(
    x=0.0127,
    k=0.16,
    c=1090,
    d=800000,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{160,120},{180,140}})));
  parameter HeatTransfer.Data.Solids.GypsumBoard matGyp2(
    x=0.025,
    k=0.16,
    c=830,
    d=784,
    nStaRef=2) "Gypsum board"
    annotation (Placement(transformation(extent={{40,120},{60,140}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Generic conExtWal(
    final nLay=3,
    material={matCon,matInsExtWal,matGypExt},
    absSol_b=0.7) "Exterior construction"
    annotation (Placement(transformation(extent={{80,160},{100,180}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Generic conIntWal(
    final nLay=2,
    material={matGypExt,matGypExt},
    absSol_b=0.7)         "Interior wall construction"
    annotation (Placement(transformation(extent={{120,160},{140,180}})));
  parameter HeatTransfer.Data.OpaqueConstructions.Generic conFlo(
    final nLay=1, material={matConFlo})
    "Floor construction (opa_a is carpet)"
    annotation (Placement(transformation(extent={{80,120},{100,140}})));

  parameter HeatTransfer.Data.OpaqueConstructions.Generic conFur(
    final nLay=1,
    material={matFur})
    "Construction for internal mass of furniture"
    annotation (Placement(transformation(extent={{120,120},{140,140}})));

  parameter HeatTransfer.Data.Solids.Plywood matCarTra(
    k=0.11,
    d=544,
    nStaRef=1,
    x=0.215/0.11) "Wood for floor"
    annotation (Placement(transformation(extent={{-80,160},{-60,180}})));

  parameter HeatTransfer.Data.GlazingSystems.DoubleClearAir13Clear glaSys(
    UFra=2,
    shade=Buildings.HeatTransfer.Data.Shades.Gray(),
    haveInteriorShade=false,
    haveExteriorShade=false) "Data record for the glazing system"
    annotation (Placement(transformation(extent={{40,160},{60,180}})));

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

  ThermalZones.Detailed.MixedAir           nor(
    redeclare package Medium = MediumA,
    lat=0.748509,
    AFlo=V/hRoo,
    hRoo=hRoo,
    nConExt=0,
    nConExtWin=1,
    datConExtWin(
      each layers={conExtWal},
      each A={A},
      each glaSys={glaSys},
      each wWin={winWalRat*A/hWin},
      each hWin=1.586,
      each fFra={0.1},
      each til={Buildings.Types.Tilt.Wall},
      each azi={Buildings.Types.Azimuth.N}),
    nConPar=1,
    datConPar(
      layers={conFlo},
      A={V/hRoo},
      til={Buildings.Types.Tilt.Floor}),
    nSurBou=0,
    m_flow_nominal=mA_flow_nominal,
    nPorts=1,
    intConMod=Buildings.HeatTransfer.Types.InteriorConvection.Temperature,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    final sampleModel=false)       "North zone"
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));

  parameter Real A = 11589.54
    "Outer envelope area";

  parameter Real hWin = 1.586
    "Window height";

  Fluid.Sensors.Temperature           zonTem(redeclare package Medium =
        Media.Air)
    annotation (Placement(transformation(extent={{160,-10},{180,10}})));
  Fluid.HeatExchangers.Radiators.RadiatorEN442_2           rad(
    redeclare package Medium = MediumW,
    final m_flow_nominal=mRad_flow_nominal,
    final Q_flow_nominal=Q_flow_nominal,
    final T_a_nominal=TRadSup_nominal,
    final T_b_nominal=TRadRet_nominal,
    final TAir_nominal=TAir_nominal,
    final dp_nominal=20000)
    "Radiator"
    annotation (Placement(transformation(extent={{-10,-160},{10,-140}})));

  parameter HeatTransfer.Data.Solids.Concrete matConFlo(
    x=0.1016,
    k=2.31,
    c=832,
    d=2322,
    nStaRef=5) "Concrete"
    annotation (Placement(transformation(extent={{-120,120},{-100,140}})));

  parameter Modelica.Units.SI.Volume V=1200
    "Room volume"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.Length hRoo=4.545
    "Height of room";

  parameter Real zonTheCap = 2*V*1.2*1500
    "Zone thermal capacitance"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.Temperature TAir_nominal=273.15 + 23.9
    "Air temperature at nominal condition"
    annotation(dialog(group="Zone parameters"));

  parameter Modelica.Units.SI.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate"
    annotation(dialog(group="Zone parameters"));

  parameter Real winWalRat(
    min=0.01,
    max=0.99)= 0.5777 "Window to wall ratio for exterior walls";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput u annotation (Placement(transformation(
          extent={{-240,-20},{-200,20}}), iconTransformation(extent={{-140,-20},
            {-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y annotation (Placement(transformation(
          extent={{200,-20},{240,20}}), iconTransformation(extent={{100,-20},{140,
            20}})));
  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-160,40},{-120,80}}), iconTransformation(extent=
           {{-80,60},{-60,80}})));
  Modelica.Fluid.Interfaces.FluidPort_a port_a(redeclare package Medium =
        MediumW) annotation (Placement(transformation(extent={{-50,-210},{-30,
            -190}}), iconTransformation(extent={{-50,-110},{-30,-90}})));
  Modelica.Fluid.Interfaces.FluidPort_b port_b(redeclare package Medium =
        MediumW) annotation (Placement(transformation(extent={{30,-210},{50,
            -190}}), iconTransformation(extent={{30,-110},{50,-90}})));
equation
  connect(zonTem.T,y)
    annotation (Line(points={{177,0},{220,0}}, color={0,0,127}));
  connect(u,nor. qGai_flow[1]) annotation (Line(points={{-220,0},{-40,0},{-40,6.93333},
          {-21.6,6.93333}}, color={0,0,127}));
  connect(rad.heatPortCon,nor. heaPorAir)
    annotation (Line(points={{-2,-142.8},{-2,0},{-1,0}}, color={191,0,0}));
  connect(rad.heatPortRad,nor. heaPorAir) annotation (Line(points={{2,-142.8},{2,
          -120},{-2,-120},{-2,0},{-1,0}}, color={191,0,0}));
  connect(nor.ports[1],zonTem. port) annotation (Line(points={{-15,-10},{-20,-10},
          {-20,-20},{170,-20},{170,-10}}, color={0,127,255}));
  connect(weaBus,nor. weaBus) annotation (Line(
      points={{-140,60},{18,60},{18,17.9},{17.9,17.9}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(port_b, rad.port_b) annotation (Line(points={{40,-200},{40,-150},{10,-150}},
        color={0,127,255}));
  connect(port_a, rad.port_a) annotation (Line(points={{-40,-200},{-40,-150},{-10,
          -150}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})), Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-200},{200,200}})));
end ZoneModel;
