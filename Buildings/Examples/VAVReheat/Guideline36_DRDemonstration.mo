within Buildings.Examples.VAVReheat;
model Guideline36_DRDemonstration
  "Variable air volume flow system with terminal reheat and five thermal zones"
  extends Modelica.Icons.Example;
  extends Buildings.Examples.VAVReheat.BaseClasses.HVACBuilding(
    mCor_flow_nominal=ACHCor*VRooCor*conv,
    mSou_flow_nominal=ACHSou*VRooSou*conv,
    mEas_flow_nominal=ACHEas*VRooEas*conv,
    mNor_flow_nominal=ACHNor*VRooNor*conv,
    mWes_flow_nominal=ACHWes*VRooWes*conv,
    redeclare Buildings.Examples.VAVReheat.BaseClasses.Guideline36_DRInput hvac,
    redeclare Buildings.Examples.VAVReheat.BaseClasses.Floor flo(
      sampleModel=true));

  parameter Real ACHCor(final unit="1/h")=6
    "Design air change per hour core";
  parameter Real ACHSou(final unit="1/h")=6
    "Design air change per hour south";
  parameter Real ACHEas(final unit="1/h")=9
    "Design air change per hour east";
  parameter Real ACHNor(final unit="1/h")=6
    "Design air change per hour north";
  parameter Real ACHWes(final unit="1/h")=7
    "Design air change per hour west";
  Controls.DemandResponse.Client client(nSam=48,
    nHis=10,                                     predictionModel=Buildings.Controls.Predictors.Types.PredictionModel.WeatherRegression)
    annotation (Placement(transformation(extent={{-70,0},{-50,20}})));
  BaseClasses.PowerCalculation PTot(
    PCooExp=hvac.cooCoi.Q1_flow,
    PHeaExp=hvac.heaCoi.Q2_flow,
    PFanExp=hvac.fanSup.P,
    PRehExp=sum(hvac.VAVBox.terHea.Q2_flow))
    annotation (Placement(transformation(extent={{-204,-10},{-184,10}})));
  BoundaryConditions.WeatherData.Bus weaBus annotation (Placement(
        transformation(extent={{-120,20},{-100,40}}), iconTransformation(extent=
           {{-164,36},{-144,56}})));
  Controls.Sources.DayType dayType
    annotation (Placement(transformation(extent={{-120,-40},{-100,-20}})));
  Modelica.Blocks.Sources.CombiTimeTable bui90(
    tableOnFile=true,
    tableName="b90",
    smoothness=Modelica.Blocks.Types.Smoothness.ConstantSegments,
    extrapolation=Modelica.Blocks.Types.Extrapolation.Periodic,
    fileName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/Data/Controls/DemandResponse/Examples/B90_DR_Data.mos"),
    columns={2,3,4,5})
                     "LBNL building 90 data"
    annotation (Placement(transformation(extent={{-120,110},{-100,130}})));

  Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-120,80},{-100,100}})));
  Controls.OBC.CDL.Logical.Sources.Constant con1(k=true)
    annotation (Placement(transformation(extent={{-120,-70},{-100,-50}})));
  Controls.OBC.CDL.Integers.Sources.Constant conInt(k=0)
    annotation (Placement(transformation(extent={{-120,-130},{-100,-110}})));
  BaseClasses.ShedFactor sheFac
    annotation (Placement(transformation(extent={{-60,-100},{-40,-80}})));
  Controls.OBC.CDL.Continuous.MultiplyByParameter gai(k=1/10)
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Continuous.Integrator ene(u(unit="W"))
    "Integrator to compute energy from power"
    annotation (Placement(transformation(extent={{-120,-10},{-100,10}})));
  Controls.OBC.CDL.Continuous.AddParameter addPar(p=5000)
    annotation (Placement(transformation(extent={{-168,-10},{-148,10}})));
equation
  connect(weaDat.weaBus, hvac.weaBus) annotation (Line(
      points={{-40,40},{-26,40},{-26,41.4444},{-10.225,41.4444}},
      color={255,204,51},
      thickness=0.5));
  connect(weaDat.weaBus, weaBus) annotation (Line(
      points={{-40,40},{-36,40},{-36,60},{-110,60},{-110,30}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
  connect(weaBus.TDryBul, client.TOut) annotation (Line(
      points={{-110,30},{-94,30},{-94,3},{-71,3}},
      color={255,204,51},
      thickness=0.5), Text(
      string="%first",
      index=-1,
      extent={{-6,3},{-6,3}},
      horizontalAlignment=TextAlignment.Right));
  connect(dayType.y, client.typeOfDay) annotation (Line(points={{-99,-30},{-76,-30},
          {-76,18},{-71,18}}, color={0,127,0}));
  connect(con.y, client.isEventDay) annotation (Line(points={{-98,90},{-78,90},{
          -78,14},{-71,14}}, color={255,0,255}));
  connect(con1.y, client.shed) annotation (Line(points={{-98,-60},{-84,-60},{-84,
          7},{-71,7}}, color={255,0,255}));
  connect(conInt.y, hvac.uCooDemLimLev) annotation (Line(points={{-98,-120},{
          -28,-120},{-28,35.3333},{-21.5,35.3333}},
                                                color={255,127,0}));
  connect(conInt.y, hvac.uHeaDemLimLev) annotation (Line(points={{-98,-120},{
          -28,-120},{-28,24.2222},{-21.5,24.2222}},
                                                color={255,127,0}));
  connect(client.PPreNoShe[1], sheFac.PConPre) annotation (Line(points={{-49,15},
          {-40,15},{-40,-6},{-70,-6},{-70,-94},{-62,-94}}, color={0,0,127}));
  connect(sheFac.yShe, client.yShed) annotation (Line(points={{-38,-90},{-34,
          -90},{-34,-66},{-74,-66},{-74,5},{-71,5}}, color={0,0,127}));
  connect(bui90.y[4], gai.u)
    annotation (Line(points={{-99,120},{-82,120}}, color={0,0,127}));
  connect(gai.y, sheFac.PGenPre) annotation (Line(points={{-58,120},{-50,120},{
          -50,80},{-80,80},{-80,-86},{-62,-86}}, color={0,0,127}));
  connect(ene.y, client.ECon) annotation (Line(points={{-99,0},{-90,0},{-90,10},
          {-71,10}}, color={0,0,127}));
  connect(PTot.PTot, addPar.u)
    annotation (Line(points={{-182,0},{-170,0}}, color={0,0,127}));
  connect(addPar.y, ene.u)
    annotation (Line(points={{-146,0},{-122,0}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
This model consist of an HVAC system, a building envelope model and a model
for air flow through building leakage and through open doors.
</p>
<p>
The HVAC system is a variable air volume (VAV) flow system with economizer
and a heating and cooling coil in the air handler unit. There is also a
reheat coil and an air damper in each of the five zone inlet branches.
</p>
<p>
See the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC\">
Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</a>
for a description of the HVAC system,
and see the model
<a href=\"modelica://Buildings.Examples.VAVReheat.BaseClasses.Floor\">
Buildings.Examples.VAVReheat.BaseClasses.Floor</a>
for a description of the building envelope.
</p>
<p>
The control is based on ASHRAE Guideline 36, and implemented
using the sequences from the library
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.G36_PR1\">
Buildings.Controls.OBC.ASHRAE.G36_PR1</a> for
multi-zone VAV systems with economizer. The schematic diagram of the HVAC and control
sequence is shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/VAVReheat/vavControlSchematics.png\" border=\"1\"/>
</p>
<p>
A similar model but with a different control sequence can be found in
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
Note that this model, because of the frequent time sampling,
has longer computing time than
<a href=\"modelica://Buildings.Examples.VAVReheat.ASHRAE2006\">
Buildings.Examples.VAVReheat.ASHRAE2006</a>.
The reason is that the time integrator cannot make large steps
because it needs to set a time step each time the control samples
its input.
</p>
</html>", revisions="<html>
<ul>
<li>
December 20, 2021, by Michael Wetter:<br/>
Changed parameter declarations and added optimal start up.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2829\">issue #2829</a>.
</li>
<li>
October 4, 2021, by Michael Wetter:<br/>
Refactored <a href=\"modelica://Buildings.Examples.VAVReheat\">Buildings.Examples.VAVReheat</a>
and its base classes to separate building from HVAC model.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2652\">issue #2652</a>.
</li>
<li>
September 16, 2021, by Michael Wetter:<br/>
Removed assignment of parameter <code>lat</code> as this is now obtained from the weather data reader.<br/>
This is for
<a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1477\">IBPSA, #1477</a>.
</li>
<li>
September 3, 2021, by Michael Wetter:<br/>
Updated documentation.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2600\">issue #2600</a>.
</li>
<li>
August 24, 2021, by Michael Wetter:<br/>
Changed model to include the hydraulic configurations of the cooling coil,
heating coil and VAV terminal box.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2594\">issue #2594</a>.
</li>
<li>
April 30, 2021, by Michael Wetter:<br/>
Reformulated replaceable class and introduced floor areas in base class
to avoid access of components that are not in the constraining type.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2471\">issue #2471</a>.
</li>
<li>
April 16, 2021, by Michael Wetter:<br/>
Refactored model to implement the economizer dampers directly in
<code>Buildings.Examples.VAVReheat.BaseClasses.PartialHVAC</code> rather than through the
model of a mixing box. Since the version of the Guideline 36 model has no exhaust air damper,
this leads to simpler equations.
<br/> This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2454\">issue #2454</a>.
</li>
<li>
March 15, 2021, by David Blum:<br/>
Change component name <code>yOutDam</code> to <code>yExhDam</code>
and update documentation graphic to include relief damper.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2399\">#2399</a>.
</li>
<li>
July 10, 2020, by Antoine Gautier:<br/>
Changed design and control parameters for outdoor air flow.<br/>
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/2019\">#2019</a>
</li>
<li>
June 15, 2020, by Jianjun Hu:<br/>
Upgraded sequence of specifying operating mode according to G36 official release.
</li>
<li>
April 20, 2020, by Jianjun Hu:<br/>
Exported actual VAV damper position as the measured input data for terminal controller.<br/>
This is
for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/1873\">issue #1873</a>
</li>
<li>
March 20, 2020, by Jianjun Hu:<br/>
Replaced the AHU controller with reimplemented one. The new controller separates the
zone level calculation from the system level calculation and does not include
vector-valued calculations.<br/>
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1829\">#1829</a>.
</li>
<li>
March 09, 2020, by Jianjun Hu:<br/>
Replaced the block that calculates operation mode and zone temperature setpoint,
with the new one that does not include vector-valued calculations.<br/>
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/1709\">#1709</a>.
</li>
<li>
May 19, 2016, by Michael Wetter:<br/>
Changed chilled water supply temperature to <i>6&deg;C</i>.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/509\">#509</a>.
</li>
<li>
April 26, 2016, by Michael Wetter:<br/>
Changed controller for freeze protection as the old implementation closed
the outdoor air damper during summer.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/511\">#511</a>.
</li>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Set default temperature for medium to avoid conflicting
start values for alias variables of the temperature
of the building and the ambient air.
This is for
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/426\">issue 426</a>.
</li>
</ul>
</html>"),
    __Dymola_Commands(file=
          "modelica://Buildings/Resources/Scripts/Dymola/Examples/VAVReheat/Guideline36_DRDemonstration.mos"
        "Simulate and plot"),
    experiment(StopTime=172800, Tolerance=1e-06),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}})),
    Diagram(coordinateSystem(extent={{-140,-140},{140,140}})));
end Guideline36_DRDemonstration;
