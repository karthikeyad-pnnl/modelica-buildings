within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.ClosedLoopTest.PlantModel;
model BoilerPlantValidation "Validation for boiler plant model"
  extends Modelica.Icons.Example;
  replaceable package MediumA =
      Buildings.Media.Air;
  replaceable package MediumW =
      Buildings.Media.Water "Medium model";

  parameter Modelica.SIunits.HeatFlowRate Q_flow_nominal = 20000
    "Nominal heat flow rate of radiator";

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

  BoilerPlant boilerPlant(TRadRet_nominal=273.15 + 50)
    annotation (Placement(transformation(extent={{-300,50},{-280,70}})));
  CDL.Logical.Sources.Constant con[2](k=fill(true, 2))
    annotation (Placement(transformation(extent={{-390,50},{-370,70}})));
  CDL.Continuous.Sources.Constant con2(k=0)
    annotation (Placement(transformation(extent={{-350,20},{-330,40}})));
  CDL.Continuous.Hysteresis hys(uLow=273.15 + 60, uHigh=273.15 + 65)
    annotation (Placement(transformation(extent={{-260,54},{-240,74}})));
  CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-220,54},{-200,74}})));
  CDL.Routing.BooleanReplicator booRep(nout=2)
    annotation (Placement(transformation(extent={{-160,54},{-140,74}})));
  CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{-180,20},{-160,40}})));
  CDL.Routing.RealReplicator reaRep(nout=2)
    annotation (Placement(transformation(extent={{-150,20},{-130,40}})));
  CDL.Continuous.Sources.Constant con1(k=-Q_flow_nominal)
    annotation (Placement(transformation(extent={{-392,10},{-372,30}})));
  CDL.Continuous.Hysteresis hys1(uLow=273.15 + 21.7, uHigh=273.15 + 23.89)
    annotation (Placement(transformation(extent={{-260,20},{-240,40}})));
  CDL.Logical.Not not2
    annotation (Placement(transformation(extent={{-220,20},{-200,40}})));
  CDL.Logical.And and2
    annotation (Placement(transformation(extent={{-190,54},{-170,74}})));
equation

  connect(con.y, boilerPlant.uPumSta) annotation (Line(points={{-368,60},{-320,60},
          {-320,58},{-302,58}}, color={255,0,255}));
  connect(con2.y, boilerPlant.uBypValSig) annotation (Line(points={{-328,30},{-316,
          30},{-316,52},{-302,52}}, color={0,0,127}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-238,64},{-222,64}}, color={255,0,255}));
  connect(booRep.y, boilerPlant.uBoiSta) annotation (Line(points={{-138,64},{-130,
          64},{-130,88},{-314,88},{-314,65},{-302,65}},      color={255,0,255}));
  connect(booToRea.y, reaRep.u)
    annotation (Line(points={{-158,30},{-152,30}}, color={0,0,127}));
  connect(reaRep.y, boilerPlant.uHotIsoVal) annotation (Line(points={{-128,30},{
          -120,30},{-120,10},{-308,10},{-308,62},{-302,62}},
                                                    color={0,0,127}));
  connect(reaRep.y, boilerPlant.uPumSpe) annotation (Line(points={{-128,30},{-120,
          30},{-120,10},{-308,10},{-308,55},{-302,55}},
                                                   color={0,0,127}));
  connect(con1.y, boilerPlant.QRooInt_flowrate) annotation (Line(points={{-370,
          20},{-360,20},{-360,68},{-302,68}}, color={0,0,127}));
  connect(boilerPlant.ySupTem, hys.u) annotation (Line(points={{-278,60},{-270,60},
          {-270,64},{-262,64}}, color={0,0,127}));
  connect(boilerPlant.yZonTem, hys1.u) annotation (Line(points={{-278,64},{-272,
          64},{-272,30},{-262,30}}, color={0,0,127}));
  connect(hys1.y, not2.u)
    annotation (Line(points={{-238,30},{-222,30}}, color={255,0,255}));
  connect(not2.y, booToRea.u)
    annotation (Line(points={{-198,30},{-182,30}}, color={255,0,255}));
  connect(booRep.u, and2.y)
    annotation (Line(points={{-162,64},{-168,64}}, color={255,0,255}));
  connect(not1.y, and2.u1)
    annotation (Line(points={{-198,64},{-192,64}}, color={255,0,255}));
  connect(not2.y, and2.u2) annotation (Line(points={{-198,30},{-194,30},{-194,56},
          {-192,56}}, color={255,0,255}));
  connect(booToRea.y, boilerPlant.uRadIsoVal) annotation (Line(points={{-158,30},
          {-154,30},{-154,0},{-304,0},{-304,49},{-302,49}}, color={0,0,127}));
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
    experiment(
      StopTime=60000,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end BoilerPlantValidation;
