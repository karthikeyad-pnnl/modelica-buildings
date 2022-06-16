within Buildings.Examples.VAVReheat.BaseClasses;
partial model HVACBuilding
  "Partial model that contains the HVAC and building model"

  replaceable package MediumA = Buildings.Media.Air "Medium model for air";
  replaceable package MediumW = Buildings.Media.Water "Medium model for water";

  final parameter Modelica.Units.SI.Volume VRooCor=flo.VRooCor
    "Room volume corridor";
  final parameter Modelica.Units.SI.Volume VRooSou=flo.VRooSou
    "Room volume south";
  final parameter Modelica.Units.SI.Volume VRooNor=flo.VRooNor
    "Room volume north";
  final parameter Modelica.Units.SI.Volume VRooEas=flo.VRooEas
    "Room volume east";
  final parameter Modelica.Units.SI.Volume VRooWes=flo.VRooWes
    "Room volume west";

  final parameter Modelica.Units.SI.Area AFloCor=flo.AFloCor
    "Floor area corridor";
  final parameter Modelica.Units.SI.Area AFloSou=flo.AFloSou "Floor area south";
  final parameter Modelica.Units.SI.Area AFloNor=flo.AFloNor "Floor area north";
  final parameter Modelica.Units.SI.Area AFloEas=flo.AFloEas "Floor area east";
  final parameter Modelica.Units.SI.Area AFloWes=flo.AFloWes "Floor area west";

  constant Real conv=1.2/3600 "Conversion factor for nominal mass flow rate";

  parameter Modelica.Units.SI.MassFlowRate mCor_flow_nominal
    "Design mass flow rate core";
  parameter Modelica.Units.SI.MassFlowRate mSou_flow_nominal
    "Design mass flow rate south";
  parameter Modelica.Units.SI.MassFlowRate mEas_flow_nominal
    "Design mass flow rate east";
  parameter Modelica.Units.SI.MassFlowRate mNor_flow_nominal
    "Design mass flow rate north";
  parameter Modelica.Units.SI.MassFlowRate mWes_flow_nominal
    "Design mass flow rate west";

  final parameter Modelica.Units.SI.MassFlowRate mCooVAV_flow_nominal[5]={
      mSou_flow_nominal,mEas_flow_nominal,mNor_flow_nominal,mWes_flow_nominal,
      mCor_flow_nominal} "Design mass flow rate of each zone";


  parameter Modelica.Units.SI.Temperature THeaWatInl_nominal(displayUnit="degC")=
       45 + 273.15 "Reheat coil nominal inlet water temperature";

  replaceable Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC hvac
    constrainedby Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC(
    redeclare final package MediumA = MediumA,
    redeclare final package MediumW = MediumW,
    final VRoo={VRooSou,VRooEas,VRooNor,VRooWes,VRooCor},
    final AFlo={AFloSou,AFloEas,AFloNor,AFloWes,AFloCor},
    final mCooVAV_flow_nominal=mCooVAV_flow_nominal,
    final THeaWatInl_nominal=THeaWatInl_nominal) "HVAC system"
    annotation (Placement(transformation(extent={{-16,2},{72,52}})));
  replaceable
  Buildings.Examples.VAVReheat.BaseClasses.PartialFloor flo
    constrainedby Buildings.Examples.VAVReheat.BaseClasses.PartialFloor(
      redeclare final package Medium = MediumA)
    "Building"
    annotation (Placement(transformation(extent={{50,70},{120,110}})));

  Buildings.BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
   filNam=Modelica.Utilities.Files.loadResource(
        "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
      computeWetBulbTemperature=false) "Weather data reader"
    annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
  Fluid.Sources.Boundary_pT sinHea(
    redeclare package Medium = MediumW,
    p=300000,
    T=THeaWatInl_nominal,
    nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-50})));
  Fluid.Sources.Boundary_pT souHea(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=THeaWatInl_nominal,
    nPorts=1) "Source for heating coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-50})));
  Fluid.Sources.Boundary_pT sinCoo(
    redeclare package Medium = MediumW,
    p=300000,
    T=279.15,
    nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={50,-50})));
  Fluid.Sources.Boundary_pT souCoo(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=279.15,
    nPorts=1) "Source for cooling coil loop" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={20,-50})));
  Fluid.Sources.Boundary_pT souHeaTer(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000 + 6000,
    T=THeaWatInl_nominal,
    nPorts=1) "Source for heating of terminal boxes" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={80,-50})));
  Fluid.Sources.Boundary_pT sinHeaTer(
    redeclare package Medium = MediumW,
    p(displayUnit="Pa") = 300000,
    T=THeaWatInl_nominal,
    nPorts=1) "Source for heating of terminal boxes" annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={110,-50})));
equation
  connect(souHea.ports[1], hvac.portHeaCoiSup) annotation (Line(points={{-40,-40},
          {-40,-10},{8.75,-10},{8.75,2}},            color={0,127,255}));
  connect(sinHea.ports[1], hvac.portHeaCoiRet) annotation (Line(points={{-8,-40},
          {-8,-12},{17,-12},{17,2}},           color={0,127,255}));
  connect(hvac.portHeaTerSup, souHeaTer.ports[1]) annotation (Line(points={{47.25,2},
          {48,2},{48,-18},{80,-18},{80,-40}},              color={0,127,255}));
  connect(hvac.portHeaTerRet, sinHeaTer.ports[1]) annotation (Line(points={{55.5,2},
          {56,2},{56,-16},{110,-16},{110,-40}},           color={0,127,255}));
  connect(weaDat.weaBus, hvac.weaBus) annotation (Line(
      points={{-40,40},{-26,40},{-26,41.4444},{-10.225,41.4444}},
      color={255,204,51},
      thickness=0.5));
  connect(flo.TRooAir, hvac.TRoo) annotation (Line(points={{121.522,90},{126,90},
          {126,122},{-30,122},{-30,46.4444},{-18.75,46.4444}},
                                                            color={0,0,127}));
  connect(hvac.port_supAir[1], flo.portsSou[1]) annotation (Line(points={{72.275,
          49.2222},{75.5652,49.2222},{75.5652,78.6154}}, color={0,127,255}));
  connect(hvac.port_supAir[2], flo.portsEas[1]) annotation (Line(points={{72.275,
          49.2222},{110.261,49.2222},{110.261,90.9231}}, color={0,127,255}));
  connect(hvac.port_supAir[3], flo.portsNor[1]) annotation (Line(points={{72.275,
          49.2222},{86,49.2222},{86,101.385},{75.5652,101.385}}, color={0,127,255}));
  connect(hvac.port_supAir[4], flo.portsWes[1]) annotation (Line(points={{72.275,
          49.2222},{86,49.2222},{86,66},{56.6957,66},{56.6957,90.9231}}, color={
          0,127,255}));
  connect(hvac.port_supAir[5], flo.portsCor[1]) annotation (Line(points={{72.275,
          49.2222},{86,49.2222},{86,90.9231},{75.5652,90.9231}}, color={0,127,255}));
  connect(hvac.port_retAir[1], flo.portsSou[2]) annotation (Line(points={{72.275,
          25.6111},{78.6087,25.6111},{78.6087,78.6154}},   color={0,127,255}));
  connect(hvac.port_retAir[2], flo.portsEas[2]) annotation (Line(points={{72.275,
          25.6111},{113.304,25.6111},{113.304,90.9231}},   color={0,127,255}));
  connect(hvac.port_retAir[3], flo.portsNor[2]) annotation (Line(points={{72.275,
          25.6111},{88,25.6111},{88,101.385},{78.6087,101.385}},   color={0,127,
          255}));
  connect(hvac.port_retAir[4], flo.portsWes[2]) annotation (Line(points={{72.275,
          25.6111},{90,25.6111},{90,64},{59.7391,64},{59.7391,90.9231}},
        color={0,127,255}));
  connect(hvac.port_retAir[5], flo.portsCor[2]) annotation (Line(points={{72.275,
          25.6111},{90,25.6111},{90,88},{78.6087,88},{78.6087,90.9231}},
        color={0,127,255}));
  connect(weaDat.weaBus, flo.weaBus) annotation (Line(
      points={{-40,40},{-36,40},{-36,116.154},{94.1304,116.154}},
      color={255,204,51},
      thickness=0.5));
  connect(souCoo.ports[1], hvac.portCooCoiSup) annotation (Line(points={{20,-40},
          {20,-16},{28,-16},{28,2}},         color={0,127,255}));
  connect(sinCoo.ports[1], hvac.portCooCoiRet) annotation (Line(points={{50,-40},
          {50,-24},{36.25,-24},{36.25,2}},
                                     color={0,127,255}));
  annotation (
    Documentation(info="<html>
<p>
Partial model that contains an HVAC system connected to a building
with five conditioned thermal zones.
</p>
</html>", revisions="<html>
<ul>
<li>
December 20, 2021, by Michael Wetter:<br/>
Changed parameter declarations for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2829\">issue #2829</a>.
</li>
<li>
November 17, 2021, by David Blum:<br/>
Changed chilled water supply temperature from 12 C to 6 C.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2763\">issue #2763</a>.
</li>
<li>
October 4, 2021, by Michael Wetter:<br/>
Refactored <a href=\"modelica://Buildings.Examples.VAVReheat\">Buildings.Examples.VAVReheat</a>
and its base classes to separate building from HVAC model.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2652\">issue #2652</a>.
</li>
</ul>
</html>"),
    Icon(coordinateSystem(extent={{-140,-140},{140,140}})),
    Diagram(coordinateSystem(extent={{-140,-140},{140,140}})));
end HVACBuilding;
