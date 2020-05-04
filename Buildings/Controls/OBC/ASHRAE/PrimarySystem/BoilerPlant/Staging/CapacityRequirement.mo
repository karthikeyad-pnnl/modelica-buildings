within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging;
block CapacityRequirement "Heating capacity requirement"

  parameter Modelica.SIunits.Time avePer = 300
  "Time period for the rolling average";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSupSet(
    final unit="K",
    final quantity="ThermodynamicTemperature")
    "Hot water supply temperature setpoint"
    annotation (Placement(transformation(extent={{-160,50},{-120,90}}),
        iconTransformation(extent={{-140,50},{-100,90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatRet(
    final unit="K",
    final quantity="ThermodynamicTemperature") "Hot water return temperature"
    annotation (Placement(transformation(extent={{-160,-20},{-120,20}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWat_flow(
    final quantity="VolumeFlowRate",
    final unit="m3/s") "Measured hot water flow rate"
    annotation (Placement(transformation(extent={{-160,-90},{-120,-50}}),
        iconTransformation(extent={{-140,-90},{-100,-50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput y(
    final quantity="Power",
    final unit="W") "Hot water heating capacity requirement"
    annotation (Placement(transformation(extent={{120,-20},{160,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));

  CDL.Continuous.Max max
    "Block to ensure negative heating requirement calculation is not passed on downstream"
    annotation (Placement(transformation(extent={{90,-10},{110,10}})));
  CDL.Continuous.Sources.Constant con(k=0)
    annotation (Placement(transformation(extent={{60,24},{80,44}})));
protected
  constant Modelica.SIunits.Density rhoWat = 1000 "Water density";

  constant Modelica.SIunits.SpecificHeatCapacity cpWat = 4184
  "Specific heat capacity of water";

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant density(
    final k = rhoWat)
    "Water density"
    annotation (Placement(transformation(extent={{-100,-40},{-80,-20}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant speHeaCap(
    final k = cpWat)
    "Specific heat capacity of water"
    annotation (Placement(transformation(extent={{-100,-80},{-80,-60}})));

  Buildings.Controls.OBC.CDL.Continuous.Add add2(final k1=1, k2=-1)
                 "Adder"
    annotation (Placement(transformation(extent={{-100,34},{-80,54}})));

  Buildings.Controls.OBC.CDL.Continuous.MovingMean movMea(
    final delta=avePer)
    "Moving average"
    annotation (Placement(transformation(extent={{60,-16},{80,4}})));

  Buildings.Controls.OBC.CDL.Continuous.Product pro "Product"
    annotation (Placement(transformation(extent={{20,-16},{40,4}})));

  Buildings.Controls.OBC.CDL.Continuous.Product pro1 "Product"
    annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.Product pro2 "Product"
    annotation (Placement(transformation(extent={{-20,-22},{0,-2}})));

equation
  connect(THotWatRet, add2.u2) annotation (Line(points={{-140,0},{-110,0},{-110,
          38},{-102,38}},   color={0,0,127}));
  connect(add2.u1,THotWatSupSet)  annotation (Line(points={{-102,50},{-110,50},{
          -110,70},{-140,70}},  color={0,0,127}));
  connect(add2.y, pro.u1) annotation (Line(points={{-78,44},{10,44},{10,0},{18,0}},
                    color={0,0,127}));
  connect(pro.y, movMea.u)
    annotation (Line(points={{42,-6},{58,-6}},   color={0,0,127}));
  connect(speHeaCap.y, pro1.u2) annotation (Line(points={{-78,-70},{-70,-70},{-70,
          -56},{-62,-56}},       color={0,0,127}));
  connect(pro1.y, pro2.u2) annotation (Line(points={{-38,-50},{-30,-50},{-30,-18},
          {-22,-18}}, color={0,0,127}));
  connect(pro.u2, pro2.y) annotation (Line(points={{18,-12},{2,-12}},
                 color={0,0,127}));
  connect(pro1.u1, density.y) annotation (Line(points={{-62,-44},{-70,-44},{-70,
          -30},{-78,-30}}, color={0,0,127}));
  connect(VHotWat_flow, pro2.u1) annotation (Line(points={{-140,-70},{-110,-70},
          {-110,-6},{-22,-6}},   color={0,0,127}));
  connect(movMea.y, max.u2)
    annotation (Line(points={{82,-6},{88,-6}},   color={0,0,127}));
  connect(con.y, max.u1) annotation (Line(points={{82,34},{86,34},{86,6},{88,6}},
                 color={0,0,127}));
  connect(max.y, y)
    annotation (Line(points={{112,0},{140,0}}, color={0,0,127}));
  annotation (defaultComponentName = "capReq",
        Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
             graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-62,88},{60,-76}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          textString="Load")}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-120,-100},{120,100}})),
Documentation(info="<html>
<p>
Calculates heating capacity requirement based on the measured hot water return
temperature, <code>THotWatRet</code>, calculated hot water supply temperature
setpoint <code>THotWatSupSet</code>, and the measured hot water flow rate,
<code>VHotWat_flow</code>.<br/> The calculation is according to the draft dated
December 31st, 2019, section 5.3.3.5 and 5.3.3.6.
</p>
<p>
When a stage change process is in progress, as indicated by a boolean input
<code>chaPro</code>, the capacity requirement is kept constant for the longer of
<code>holPer</code> and the duration of the change process.<br/>
</p>
</html>",
revisions="<html>
<ul>
<li>
April 22, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end CapacityRequirement;
