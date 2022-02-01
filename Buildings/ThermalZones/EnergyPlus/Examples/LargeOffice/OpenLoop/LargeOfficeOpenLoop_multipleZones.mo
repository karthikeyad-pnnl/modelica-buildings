within Buildings.ThermalZones.EnergyPlus.Examples.LargeOffice.OpenLoop;
model LargeOfficeOpenLoop_multipleZones
  "Validation model for 15 zone large office model"
  extends Modelica.Icons.Example;
  constant String modelicaNameBuilding=getInstanceName()
    "Name of the building";
  parameter String idfName=Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/Data/ThermalZones/EnergyPlus/Examples/LargeOffice/wholebuilding_noHVACObjects.idf")
    "Name of the IDF file";
  parameter String weaName=Modelica.Utilities.Files.loadResource(
    "modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos")
    "Name of the weather file";
//   parameter Modelica.SIunits.HeatCapacity CZon[15]=1.2*1006*{6948.69, 6948.69, 6948.69,
//     860.02, 554.22, 860, 554.22,
//     860.02, 554.22, 860, 554.22,
//     860.02, 554.22, 860, 554.22}
//     "Heat capacity of zone air";
  parameter Real CZon[15]=1/(1.2*1006)*{1/6948.69, 1/6948.69, 1/6948.69,
    1/860.02, 1/554.22, 1/860, 1/554.22,
    1/860.02, 1/554.22, 1/860, 1/554.22,
    1/860.02, 1/554.22, 1/860, 1/554.22}
    "Heat capacity of zone air";
  inner Building building(
    idfName=idfName,
    weaName=weaName,
    usePrecompiledFMU=false,
    showWeatherData=false)
    "Building model"
    annotation (Placement(transformation(extent={{-80,70},{-60,90}})));
  Buildings.ThermalZones.EnergyPlus.BaseClasses.FMUZoneAdapter fmuZonCor[15](
    spawnLinuxExecutable=spawnLinuxExecutable,
    modelicaNameBuilding=fill(modelicaNameBuilding, 15),
    final idfName=fill(idfName, 15),
    final weaName=fill(weaName, 15),
    final zoneName={"Core_bottom","Core_mid","Core_top","Perimeter_bot_ZN_1","Perimeter_bot_ZN_2",
        "Perimeter_bot_ZN_3","Perimeter_bot_ZN_4","Perimeter_mid_ZN_1","Perimeter_mid_ZN_2",
        "Perimeter_mid_ZN_3","Perimeter_mid_ZN_4","Perimeter_top_ZN_1","Perimeter_top_ZN_2",
        "Perimeter_top_ZN_3","Perimeter_top_ZN_4"},
    final nFluPor=fill(2, 15)) "Adapter to EnergyPlus"
    annotation (Placement(transformation(extent={{20,20},{40,40}})));

  parameter String spawnLinuxExecutable=building.linux64Binaries.spawnLinuxExecutable
    "Path to the spawn executable"
    annotation(HideResult=true);

//     fmuName=Modelica.Utilities.Files.loadResource(
//       "modelica://Buildings/Resources/src/ThermalZones/EnergyPlus/FMUs/Zones1.fmu"),
  Modelica.Blocks.Sources.RealExpression X_w[15](y=fill(0.01, 15))
    "Zone absolute humidity"
    annotation (Placement(transformation(extent={{-90,40},{-70,60}})));
  Modelica.Blocks.Sources.RealExpression mIn_flow[15](y=fill(1, 15))
    "Inlet mass flow rate"
    annotation (Placement(transformation(extent={{-90,0},{-70,20}})));
  Modelica.Blocks.Math.Gain mOut_flow[15](k=fill(-1, 15))
    "Outlet mass flow rate"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.RealExpression QGaiRad_flow[15](y=fill(0, 15))
    "Radiative heat gain for the zone"
    annotation (Placement(transformation(extent={{-90,-50},{-70,-30}})));
  Modelica.Blocks.Continuous.Integrator TZonCor[15](
    k=CZon,
    initType=fill(Modelica.Blocks.Types.Init.InitialState, 15),
    y_start=fill(294.15, 15),
    y(final unit="K", displayUnit="degC")) "Zone air temperature"
    annotation (Placement(transformation(extent={{60,20},{80,40}})));

  Controls.OBC.CDL.Continuous.Sources.Sine sin[15](
    amplitude=fill(20, 15),
    freqHz=fill(1/28800, 15),
    phase=fill(3.14/2, 15),
    offset=fill(293.15, 15))
    annotation (Placement(transformation(extent={{-90,-20},{-70,0}})));
  Modelica.Blocks.Sources.RealExpression TOutlet[15](y=fill(293.15, 15))
    "Air outlet temperature"
    annotation (Placement(transformation(extent={{-90,-70},{-70,-50}})));
  OutputVariable out(name="Site Outdoor Air Drybulb Temperature", key=
        "Environment")
    annotation (Placement(transformation(extent={{20,70},{40,90}})));
equation
  connect(mOut_flow.u,mIn_flow.y)
    annotation (Line(points={{-42,30},{-60,30},{-60,10},{-69,10}},color={0,0,127}));
  connect(mIn_flow.y, fmuZonCor.m_flow[1]) annotation (Line(points={{-69,10},{-8,
          10},{-8,30},{18,30}}, color={0,0,127}));
  connect(mOut_flow.y, fmuZonCor.m_flow[2])
    annotation (Line(points={{-19,30},{18,30}}, color={0,0,127}));
  connect(fmuZonCor.QCon_flow, TZonCor.u) annotation (Line(points={{41,32},{50,32},
          {50,30},{58,30}}, color={0,0,127}));
  connect(X_w.y, fmuZonCor.X_w) annotation (Line(points={{-69,50},{0,50},{0,34},
          {18,34}}, color={0,0,127}));
  connect(QGaiRad_flow.y, fmuZonCor.QGaiRad_flow) annotation (Line(points={{-69,
          -40},{10,-40},{10,22},{18,22}}, color={0,0,127}));
  connect(sin.y, fmuZonCor.TInlet[1]) annotation (Line(points={{-68,-10},{0,-10},
          {0,26},{18,26}}, color={0,0,127}));
  connect(TOutlet.y, fmuZonCor.TInlet[2]) annotation (Line(points={{-69,-60},{0,
          -60},{0,26},{18,26}}, color={0,0,127}));
  annotation (
    Documentation(
      info="<html>
<p>
Validation model that communicates with an FMU that emulates simple thermal zones.
All thermal zones are identical.
</p>
<p>
This test is done to validate the FMI API, using an FMU 2.0 for Model Exchange, compiled
for Linux 64 bit by JModelica.
</p>
</html>",
      revisions="<html>
<ul><li>
March 19, 2018, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    __Dymola_Commands(
      file="modelica://Buildings/Resources/Scripts/Dymola/ThermalZones/EnergyPlus/BaseClasses/Validation/FMUZoneAdapterZones1.mos" "Simulate and plot"),
    experiment(
      StartTime=35.7,
      StopTime=86400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Diagram(
      coordinateSystem(
        extent={{-100,-100},{100,100}})),
    Icon(
      coordinateSystem(
        extent={{-100,-100},{100,100}})));
end LargeOfficeOpenLoop_multipleZones;
