within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints;
model BypassValvePosition
  parameter Real k(
    min=0,
    unit="1") = 1 "Gain of controller";
  parameter Modelica.SIunits.Time Ti(min=0) = 0.5
    "Time constant of integrator block"
    annotation (Dialog(enable=
          controllerType == CDL.Types.SimpleController.PI or
          controllerType == CDL.Types.SimpleController.PID));
  parameter Modelica.SIunits.Time Td(
    min=0) = 0.1
    "Time constant of derivative block"
    annotation (Dialog(enable=
          controllerType == CDL.Types.SimpleController.PD or
          controllerType == CDL.Types.SimpleController.PID));

  CDL.Interfaces.RealInput priCirFloRat
    "Measured hot-water flow-rate thorugh primary circuit"
    annotation (Placement(transformation(extent={{-120,0},{-80,40}})));
  CDL.Interfaces.BooleanInput uPumProSig_a
    "Input signal indicating lead pump has been proved on"
    annotation (Placement(transformation(extent={{-120,-40},{-80,0}})));
  CDL.Interfaces.RealOutput yBypValPos "Bypass valve opening position"
    annotation (Placement(transformation(extent={{80,-20},{120,20}})));
  CDL.Interfaces.RealInput boiMinFloSet
    "Calculated setpoint for minimum hot-water flow-rate through boilers"
    annotation (Placement(transformation(extent={{-120,40},{-80,80}})));
  CDL.Logical.Switch swi "Check if bypass valve should be modulated"
    annotation (Placement(transformation(extent={{34,-10},{54,10}})));
  CDL.Continuous.Sources.Constant opeVal(k=1)
    "Bypass valve fully open when pumps are off"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));
  CDL.Continuous.LimPID conPID(
    yMax=1,
    yMin=0,
    initType=Buildings.Controls.OBC.CDL.Types.Init.InitialOutput,
    y_start=1,
    reverseAction=false)
    "Bypass circuit flow-rate controller to satisfy boiler minimum flow-rate"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));
  CDL.Interfaces.BooleanInput uPumProSig_b
    "Input signal indicating lag pump has been proved on"
    annotation (Placement(transformation(extent={{-120,-80},{-80,-40}})));
  CDL.Logical.Or or2 "Check if either pump has been proved on"
    annotation (Placement(transformation(extent={{-50,-30},{-30,-10}})));
equation
  connect(opeVal.y, swi.u3) annotation (Line(points={{12,-20},{24,-20},{24,-8},{
          32,-8}}, color={0,0,127}));
  connect(swi.y, yBypValPos)
    annotation (Line(points={{56,0},{100,0}}, color={0,0,127}));
  connect(conPID.u_s, boiMinFloSet)
    annotation (Line(points={{-12,60},{-100,60}}, color={0,0,127}));
  connect(conPID.y, swi.u1)
    annotation (Line(points={{12,60},{24,60},{24,8},{32,8}}, color={0,0,127}));

  connect(conPID.u_m, priCirFloRat) annotation (Line(points={{0,48},{0,20},{
          -100,20}},             color={0,0,127}));
  connect(or2.u1, uPumProSig_a)
    annotation (Line(points={{-52,-20},{-100,-20}}, color={255,0,255}));
  connect(or2.y, swi.u2) annotation (Line(points={{-28,-20},{-20,-20},{-20,0},{
          32,0}}, color={255,0,255}));
  connect(or2.u2, uPumProSig_b) annotation (Line(points={{-52,-28},{-60,-28},{
          -60,-60},{-100,-60}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},
            {80,80}}), graphics={Rectangle(
          extent={{-80,80},{80,-80}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-70,20},{70,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="bypValCon")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-80,-80},{80,80}})),
Documentation(info="<html>
<p>
Control sequence for bypass circuit valve position <code>yBypValPos</code>
for boiler plant loop.
</p>
<h4>Boiler plant loop: Control of boiler minimum flow bypass valve</h4>
<ol>
<li>The bypass valve is enabled when either of the hot-water supply pumps is proven on
<code>uPumProSig = true</code>, and disabled otherwise.</li>
<li>When enabled, a PID control loop modulates the bypass valve to maintain
a primary circuit flow rate of <code>hotWatMinFloSet</code>, calculated by the
staging controller.
</li>
<li>
When <code>uPumProSig = false</code>, the valve is fully opened.
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
February 21, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end BypassValvePosition;
