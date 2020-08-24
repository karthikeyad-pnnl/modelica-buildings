within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.ClosedLoopTest.PlantModel;
model BoilerPlantValidation "Validation for boiler plant model"
  extends Modelica.Icons.Example;
  replaceable package MediumA =
      Buildings.Media.Air;
  replaceable package MediumW =
      Buildings.Media.Water "Medium model";

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal = 20000
    "Nominal heat flow rate of radiator";
  parameter Modelica.SIunits.Temperature TRadSup_nominal = 273.15+50
    "Radiator nominal supply water temperature";
  parameter Modelica.SIunits.Temperature TRadRet_nominal = 273.15+40
    "Radiator nominal return water temperature";
  parameter Modelica.SIunits.MassFlowRate mRad_flow_nominal=
    Q_flow_nominal/4200/(TRadSup_nominal-TRadRet_nominal)
    "Radiator nominal mass flow rate";

  parameter Modelica.SIunits.Temperature TBoiSup_nominal = 273.15+70
    "Boiler nominal supply water temperature";
  parameter Modelica.SIunits.Temperature TBoiRet_min = 273.15+60
    "Boiler minimum return water temperature";
  parameter Modelica.SIunits.MassFlowRate mBoi_flow_nominal=
    Q_flow_nominal/4200/(TBoiSup_nominal-TBoiRet_min)
    "Boiler nominal mass flow rate";
//------------------------------------------------------------------------------//

//----------------Radiator loop: Three-way valve: mass flow rate----------------//
  parameter Modelica.SIunits.MassFlowRate mRadVal_flow_nominal=
    Q_flow_nominal/4200/(TBoiSup_nominal-TRadRet_nominal)
    "Radiator nominal mass flow rate";

  parameter Modelica.SIunits.Volume V=6*10*3 "Room volume";
  parameter Modelica.SIunits.MassFlowRate mA_flow_nominal = V*1.2*6/3600
    "Nominal mass flow rate";
  parameter Modelica.SIunits.HeatFlowRate QRooInt_flow = 40000
    "Internal heat gains of the room";

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

//----------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//
//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//--------------------------------------------------------------------------------//

//------------------------------------------------------------------------------//
//--- Weather data -------------------------------------------------------------//
//------------------------------------------------------------------------------//

  BoilerPlant boilerPlant
    annotation (Placement(transformation(extent={{-300,50},{-280,70}})));
  CDL.Continuous.Sources.TimeTable                        timTab(
    extrapolation=Buildings.Controls.OBC.CDL.Types.Extrapolation.Periodic,
    smoothness=Buildings.Controls.OBC.CDL.Types.Smoothness.ConstantSegments,
    table=[-6,0; 8,-QRooInt_flow; 18,0],
    timeScale=3600)   "Time table for internal heat gain"
    annotation (Placement(transformation(extent={{-360,70},{-340,90}})));
  CDL.Logical.Sources.Constant con[2](k=fill(true, 2))
    annotation (Placement(transformation(extent={{-390,50},{-370,70}})));
  CDL.Continuous.Sources.Constant con1[2](k=fill(1, 2))
    annotation (Placement(transformation(extent={{-390,20},{-370,40}})));
  CDL.Continuous.Sources.Constant con2(k=0)
    annotation (Placement(transformation(extent={{-350,20},{-330,40}})));
equation

  connect(timTab.y[1], boilerPlant.QRooInt_flowrate) annotation (Line(points={{
          -338,80},{-320,80},{-320,68},{-302,68}}, color={0,0,127}));
  connect(con.y, boilerPlant.uBoiSta) annotation (Line(points={{-368,60},{-320,60},
          {-320,65},{-302,65}}, color={255,0,255}));
  connect(con1.y, boilerPlant.uHotIsoVal) annotation (Line(points={{-368,30},{-360,
          30},{-360,56},{-314,56},{-314,62},{-302,62}}, color={0,0,127}));
  connect(con.y, boilerPlant.uPumSta) annotation (Line(points={{-368,60},{-320,60},
          {-320,58},{-302,58}}, color={255,0,255}));
  connect(con1.y, boilerPlant.uPumSpe) annotation (Line(points={{-368,30},{-360,
          30},{-360,55},{-302,55}}, color={0,0,127}));
  connect(con2.y, boilerPlant.uBypValSig) annotation (Line(points={{-328,30},{-316,
          30},{-316,52},{-302,52}}, color={0,0,127}));
  annotation (Documentation(info="<html>
<p>
This part of the system model adds to the model that is implemented in
<a href=\"modelica://Buildings.Examples.Tutorial.Boiler.System5\">
Buildings.Examples.Tutorial.Boiler.System5</a>
weather data, and it changes the control to PI control.
</p>
<h4>Implementation</h4>
<p>
This model was built as follows:
</p>
<ol>
<li>
<p>
First, we copied the model
<a href=\"modelica://Buildings.Examples.Tutorial.Boiler.System5\">
Buildings.Examples.Tutorial.Boiler.System5</a>
and called it
<code>Buildings.Examples.Tutorial.Boiler.System6</code>.
</p>
</li>
<li>
<p>
Next, we added the weather data as shown in the figure below.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/Boiler/System6Weather.png\" border=\"1\"/>
</p>
<p>
The weather data reader is implemented using
</p>
<pre>
  BoundaryConditions.WeatherData.ReaderTMY3 weaDat(
    filNam=\"modelica://Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos\")
    \"Weather data reader\";
</pre>
<p>
The yellow icon in the middle of the figure is an instance of
<a href=\"modelica://Buildings.BoundaryConditions.WeatherData.Bus\">
Buildings.BoundaryConditions.WeatherData.Bus</a>.
This is required to extract the dry bulb temperature from the weather data bus.
</p>
<p>
Note that we changed the instance <code>TOut</code> from
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.FixedTemperature\">
Modelica.Thermal.HeatTransfer.Sources.FixedTemperature</a>
to
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature\">
Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature</a>
in order to use the dry-bulb temperature as an input signal.
</p>
</li>
</ol>
<!-- ============================================== -->
<p>
This completes the closed loop control.
When simulating the model
for <i>2</i> days, or <i>172800</i> seconds, the
response shown below should be seen.
</p>
<p align=\"center\">
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/Boiler/System6Temperatures1.png\" border=\"1\"/>
<img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Examples/Tutorial/Boiler/System6Temperatures2.png\" border=\"1\"/>
</p>
<p>
The figure shows that the boiler temperature is regulated between
<i>70</i>&deg;C and
<i>90</i>&deg;C,
that
the boiler inlet temperature is above
<i>60</i>&deg;C,
and that the room temperature and the supply water temperature are
maintained at their set point.
</p>
</html>", revisions="<html>
<ul>
<li>
March 6, 2017, by Michael Wetter:<br/>
Added missing density to computation of air mass flow rate.<br/>
This is for <a href=\"https://github.com/lbl-srg/modelica-buildings/issues/673\">#673</a>.
</li>
<li>
July 2, 2015, by Michael Wetter:<br/>
Changed control input for <code>conPIDBoi</code> and set
<code>reverseActing=false</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/436\">#436</a>.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
March 1, 2013, by Michael Wetter:<br/>
Added nominal pressure drop for valves as
this parameter no longer has a default value.
</li>
<li>
January 27, 2012, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
    Diagram(coordinateSystem(preserveAspectRatio=false,extent={{-400,-360},{240,
            100}})),
    __Dymola_Commands(file=
     "modelica://Buildings/Resources/Scripts/Dymola/Examples/Tutorial/Boiler/System6.mos"
        "Simulate and plot"),
    experiment(Tolerance=1e-6, StopTime=172800));
end BoilerPlantValidation;
