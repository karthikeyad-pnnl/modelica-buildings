within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences;

block EnableLead_headered
 
    "Sequence to enable or disable the lead pump of plants with headered primary hot water pumps"
  parameter Integer nBoi=2
    "Total number of boiler CHW isolation valves";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiIsoVal[nBoi]
    "Hot water isolation valve status"
    annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yLea
    "Lead pump status"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));

protected
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch leaPumSta
    "Lead pump status"
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(
    final k=true)
    "Logical true"
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con1(
    final k=false)
    "Logical false"
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nBoi)
    "Check if there is any boiler enabled"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation
  connect(con.y,leaPumSta. u1)
    annotation (Line(points={{-18,40},{30,40},{30,8},{38,8}},color={255,0,255}));

  connect(con1.y,leaPumSta. u3)
    annotation (Line(points={{-18,-40},{30,-40},{30,-8},{38,-8}},
      color={255,0,255}));

  connect(leaPumSta.y, yLea)
    annotation (Line(points={{62,0},{120,0}}, color={255,0,255}));

  connect(uChiIsoVal, mulOr.u)
    annotation (Line(points={{-120,0},{-82,0},{-82,0},{-42,0}},
      color={255,0,255}));

  connect(mulOr.y, leaPumSta.u2)
    annotation (Line(points={{-18,0},{38,0}}, color={255,0,255}));

annotation (
  defaultComponentName="enaLeaChiPum",
  Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,150},{100,110}},
          lineColor={0,0,255},
          textString="%name"),
        Text(
          extent={{-94,12},{-40,-10}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiIsoVal"),
        Text(
          extent={{42,12},{96,-10}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yLeaPum")}),
  Diagram(coordinateSystem(preserveAspectRatio=false)),
  Documentation(info="<html>
<p>
Block that enable and disable leading primary hot water pump, for plants
with headered primary hot water pumps and parallel boilers, 
according to ASHRAE RP-1711 Advanced Sequences of Operation for HVAC Systems Phase II –
Central Plants and Hydronic Systems (Draft 6 on July 25, 2019), 
section 5.2.6 Primary hot water pumps, part 1 and 2.
</p>
<ol>
<li>
Primary hot water pumps shall be lead-lag.
</li>
<li>
The lead primary hot water pump shall be enabled when any boiler
CHW isolation valve <code>uChiIsoVal</code> is commanded open, shall be disabled
when boiler CHW isolation valves are commanded closed.
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
August 1, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));

end EnableLead_headered;
