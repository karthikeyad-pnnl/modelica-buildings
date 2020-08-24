within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.SecondaryPumps.Subsequences;
block EnableLead_dedicated
    "Sequence to enable or disable the lead pump of plants with dedicated primary hot water pumps"

  parameter Real offTimThr(
    final unit="s",
    displayUnit="s",
    final quantity="time") = 180
    "Threshold to check lead boiler off time";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPlaEna
    "Plant enabling status"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uLeaBoiSta
    "Lead boiler status"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yLea
    "Lead pump status"
    annotation (Placement(transformation(extent={{100,-20},{140,20}}),
        iconTransformation(extent={{100,-20},{140,20}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Latch leaPumSta(
    final pre_y_start=false)
    "Lead pump status"
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));

  Buildings.Controls.OBC.CDL.Logical.Not not2
    "Logical not"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Buildings.Controls.OBC.CDL.Logical.Timer tim
    "Measures boiler OFF time"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr(
    final threshold=offTimThr)
    "Check if the boiler has been OFF for more than 3 minutes"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));

  Buildings.Controls.OBC.CDL.Logical.And and2
    "Logical and"
    annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Buildings.Controls.OBC.CDL.Logical.Not not3
    "Logical not"
    annotation (Placement(transformation(extent={{-60,10},{-40,30}})));

equation
  connect(uPlaEna, leaPumSta.u)
    annotation (Line(points={{-120,50},{50,50},{50,0},{58,0}},
                                                 color={255,0,255}));

  connect(leaPumSta.y, yLea)
    annotation (Line(points={{82,0},{120,0}},   color={255,0,255}));

  connect(uLeaBoiSta, not2.u)
    annotation (Line(points={{-120,-50},{-82,-50}},
                                                color={255,0,255}));

  connect(not2.y, tim.u)
    annotation (Line(points={{-58,-50},{-42,-50}},
                                               color={255,0,255}));

  connect(tim.y, greEquThr.u)
    annotation (Line(points={{-18,-50},{-2,-50}},
                                              color={0,0,127}));

  connect(uPlaEna, not3.u) annotation (Line(points={{-120,50},{-80,50},{-80,20},
          {-62,20}}, color={255,0,255}));

  connect(not3.y, and2.u1)
    annotation (Line(points={{-38,20},{-2,20}},
      color={255,0,255}));

  connect(and2.y, leaPumSta.clr)
    annotation (Line(points={{22,20},{40,20},{40,-6},{58,-6}}, color={255,0,255}));

  connect(greEquThr.y, and2.u2) annotation (Line(points={{22,-50},{30,-50},{30,0},
          {-10,0},{-10,12},{-2,12}},  color={255,0,255}));
annotation (
  defaultComponentName="enaLeaPriPum_dedicated",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name")}),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>
Block that enable and disable leading primary hot water pump, for plants
with dedicated primary hot water pumps, according to ASHRAE RP-1711, March 2020 draft, 
section 5.3.6.3.
</p>
<p>
The lead primary hot water pump status <code>yLea</code> should be enabled when
boiler plant is enabled (<code>uPlaEna</code> = true). It should be disabled when
the lead boiler is disabled and has been proven off (<code>uLeaBoiSta</code> 
= false) for time <code>offTimThr</code>.
</p>
</html>", revisions="<html>
<ul>
<li>
July 30, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end EnableLead_dedicated;
