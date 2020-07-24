within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.SetPoints;
block BypassValvePosition
  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerType=
         Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";

  parameter Real k(
    min=0) = 1
    "Gain of controller";

  parameter Real Ti(min=0) = 0.5
    "Time constant of integrator block"
    annotation (Dialog(enable=
          controllerType == CDL.Types.SimpleController.PI or
          controllerType == CDL.Types.SimpleController.PID));

  parameter Real Td(min=0) = 0.1
    "Time constant of derivative block"
    annotation (Dialog(enable=
          controllerType == CDL.Types.SimpleController.PD or
          controllerType == CDL.Types.SimpleController.PID));

  parameter Integer nPum = 2
    "Number of pumps";

  Buildings.Controls.OBC.CDL.Interfaces.RealInput priCirFloRat
    "Measured hot-water flow-rate thorugh primary circuit"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPumSta[nPum]
    "Input signals indicating pump statuses"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yBypValPos
    "Bypass valve opening position"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput boiMinFloSet
    "Calculated setpoint for minimum hot-water flow-rate through boilers"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi
    "Check if bypass valve should be modulated"
    annotation (Placement(transformation(extent={{34,-10},{54,10}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant opeVal(k=1)
    "Bypass valve fully open when pumps are off"
    annotation (Placement(transformation(extent={{-10,-30},{10,-10}})));

  Buildings.Controls.OBC.CDL.Continuous.LimPID conPID(
    controllerType=controllerType,
    k=k,
    Ti=Ti,
    Td=Td,
    yMax=1,
    yMin=0,
    xi_start=1,
    reverseAction=false,
    reset=Buildings.Controls.OBC.CDL.Types.Reset.Parameter)
    "Bypass circuit flow-rate controller to satisfy boiler minimum flow-rate"
    annotation (Placement(transformation(extent={{-10,50},{10,70}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(nu=2)
    "Block to detect if any of the pumps are proved ON"
    annotation (Placement(transformation(extent={{-70,-60},{-50,-40}})));

equation
  connect(opeVal.y, swi.u3) annotation (Line(points={{12,-20},{24,-20},{24,-8},{
          32,-8}}, color={0,0,127}));

  connect(swi.y, yBypValPos)
    annotation (Line(points={{56,0},{120,0}}, color={0,0,127}));

  connect(conPID.u_s, boiMinFloSet)
    annotation (Line(points={{-12,60},{-120,60}}, color={0,0,127}));

  connect(conPID.y, swi.u1)
    annotation (Line(points={{12,60},{24,60},{24,8},{32,8}}, color={0,0,127}));

  connect(conPID.u_m, priCirFloRat) annotation (Line(points={{0,48},{0,20},{-120,
          20}},                  color={0,0,127}));

  connect(conPID.trigger, swi.u2)
    annotation (Line(points={{-6,48},{-6,0},{32,0}}, color={255,0,255}));

  connect(mulOr.u[1:2], uPumSta) annotation (Line(points={{-72,-53.5},{-102,-53.5},
          {-102,-50},{-120,-50}}, color={255,0,255}));

  connect(mulOr.y, swi.u2) annotation (Line(points={{-48,-50},{-40,-50},{-40,0},
          {32,0}}, color={255,0,255}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}}), graphics={Rectangle(
          extent={{-100,100},{100,-100}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-70,20},{70,-20}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="bypValCon")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
Documentation(info="<html>
<p>
Control sequence for bypass circuit valve position <code>yBypValPos</code>
for boiler plant loop.
</p>
<h4>Boiler plant loop: Control of boiler minimum flow bypass valve</h4>
<ol>
<li>The bypass valve is enabled when any of the hot-water supply pumps are proven on
<code>uPumSta = true</code>, and disabled otherwise.</li>
<li>When enabled, a PID control loop modulates the bypass valve to maintain
a primary circuit flow rate of <code>hotWatMinFloSet</code>, calculated by the
plant stage controllers.
</li>
<li>
When all the pumps are not proved on<code>uPumSta = false</code>, the valve is fully opened.
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
February 21, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
    experiment(
      StartTime=-1814400,
      StopTime=1814400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end BypassValvePosition;
