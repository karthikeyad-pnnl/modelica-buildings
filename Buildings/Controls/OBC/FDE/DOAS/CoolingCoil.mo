within Buildings.Controls.OBC.FDE.DOAS;
block CoolingCoil
  "This block commands the cooling coil."

  parameter Real cctPIk = 0.0000001
  "Cooling coil CCT PI gain value k.";

  parameter Real cctPITi = 0.000025
  "Cooling coil CCT PI time constant value Ti.";

  parameter Real SAccPIk = 0.0000001
  "Cooling coil SAT PI gain value k.";

  parameter Real SAccPITi = 0.000025
  "Cooling coil SAT PI time constant value Ti.";

  parameter Real erwDPadj(
   final unit="K",
   displayUnit="degC",
   final quantity="ThermodynamicTemperature")=5
   "Value subtracted from ERW supply air dewpoint.";

    // ---inputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealInput saT(
   final unit="K",
   displayUnit="degC",
   final quantity="ThermodynamicTemperature") "Supply air temperature sensor."
      annotation (Placement(transformation(extent={{-140,-90},{-100,-50}}),
        iconTransformation(extent={{-142,36},{-102,76}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput supCooSP(
   final unit="K",
   displayUnit="degC",
   final quantity="ThermodynamicTemperature")
    "Supply air temperature cooling set point."
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}}),
        iconTransformation(extent={{-142,8},{-102,48}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput supFanProof
    "True when supply fan is proven on."
      annotation (Placement(transformation(extent={{-142,-116},{-102,-76}}),
        iconTransformation(extent={{-142,64},{-102,104}})));

    // ---outputs---
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yCC
    "Cooling coil control signal"
      annotation (Placement(transformation(extent={{100,60},{140,100}}),
        iconTransformation(extent={{102,-20},{142,20}})));


  Buildings.Controls.OBC.CDL.Continuous.PID conPID(
    k=SAccPIk,
    Ti=SAccPITi,
    reverseActing=false)
    "PI calculation of supply air temperature and supply air cooling set point"
    annotation (Placement(transformation(extent={{-70,-50},{-50,-30}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con0(
    final k=0)
    "Real constant 0"
    annotation (Placement(transformation(extent={{-20,-62},{0,-42}})));
  Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Logical switch outputs supply air PI value when fan is proven on."
    annotation (Placement(transformation(extent={{14,-54},{34,-34}})));

equation
  connect(conPID.y, swi.u1)
    annotation (Line(points={{-48,-40},{-22,-40},{-22,-36},{12,-36}},
                                                  color={0,0,127}));
  connect(con0.y, swi.u3)
    annotation (Line(points={{2,-52},{12,-52}}, color={0,0,127}));
  connect(swi.u2, supFanProof)
    annotation (Line(points={{12,-44},{6,-44},{6,-96},{-122,-96}},
      color={255,0,255}));
  connect(swi.y, yCC) annotation (Line(points={{36,-44},{60,-44},{60,80},{120,
          80}}, color={0,0,127}));
  connect(saT, conPID.u_m) annotation (Line(points={{-120,-70},{-60,-70},{-60,
          -52}}, color={0,0,127}));
  connect(supCooSP, conPID.u_s)
    annotation (Line(points={{-120,-40},{-72,-40}}, color={0,0,127}));
  annotation (defaultComponentName="Cooling",
    Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}},
            lineColor={179,151,128},
            radius=10,
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
           Text(
            extent={{-90,180},{90,76}},
            lineColor={28,108,200},
            textStyle={TextStyle.Bold},
            textString="%name"),
        Text(
          extent={{-98,92},{-54,78}},
          lineColor={28,108,200},
          textString="supFanProof"),
        Text(
          extent={{-110,62},{-70,50}},
          lineColor={28,108,200},
          textString="saT"),
        Text(
          extent={{-98,34},{-58,22}},
          lineColor={28,108,200},
          textString="supCooSP"),
        Text(
          extent={{-108,-26},{-68,-38}},
          lineColor={28,108,200},
          textString="ccT"),
        Text(
          extent={{-100,-52},{-60,-64}},
          lineColor={28,108,200},
          textString="erwHum"),
        Text(
          extent={{-108,-78},{-68,-90}},
          lineColor={28,108,200},
          textString="erwT"),
        Text(
          extent={{-98,0},{-58,-12}},
          lineColor={28,108,200},
          textString="dehumMode"),
        Text(
          extent={{62,8},{106,-8}},
          lineColor={28,108,200},
          textString="yCC"),
        Rectangle(
          extent={{-22,68},{6,-66}},
          lineColor={28,108,200},
          fillColor={85,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-14,58},{68,56}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-16,60},{-10,54}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,-56},{80,-58}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{-4,-54},{2,-60}},
          lineColor={28,108,200},
          fillColor={0,0,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,-58},{30,-66},{30,-50},{42,-58}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{42,-58},{54,-66},{54,-50},{42,-58}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{38,-54},{46,-62}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Ellipse(
          extent={{36,-32},{48,-46}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{36,-38},{48,-48}},
          lineColor={127,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(points={{42,-48},{42,-54}}, color={127,0,0})}),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 17, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<h4>Normal Operation</h4>
<p>When the DOAS is energized 
(<code>supFanProof</code>) the cooling coil will
be commanded 
(<code>yCC</code>) to maintain the 
supply air temperature 
(<code>saT</code>) at the supply air temperature cooling set point 
(<code>supCooSP</code>). 

<h4>Dehumidification Operation</h4>
<p>When the DOAS is energized 
(<code>supFanProof</code>) and in dehumidification mode 
(<code>dehumMode</code>) the cooling coil will
be commanded 
(<code>yCC</code>) to maintain the cooling coil temperature 
(<code>ccT</code>) at an adjustable value 
(<code>erwDPadj</code>) below the energy recovery supply
dewpoint (<code>Dewpt.dpT</code>). The dewpoint value is calculated 
from the energy recovery supply relative humidity 
(<code>erwHum</code>) and temperature 
(<code>erwT</code>).</p>
</html>"));
end CoolingCoil;
