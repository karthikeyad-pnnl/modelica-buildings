within Buildings.Controls.OBC.FDE.DOAS.Validation;
model SupplyFanController
  "This model simulates SupplyFanController"
 parameter Boolean is_vav = true
  "True: System has zone terminals with variable damper position. False: System has zone terminals with constant damper position.";

  parameter Real yMinDamSet(
  min = 0,
  final unit = "Pa",
  final quantity = "PressureDifference") = 125
  "Minimum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));

  parameter Real yMaxDamSet(
  min = 0,
  final unit = "Pa",
  final quantity = "PressureDifference") = 500
  "Maximum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));

  parameter Real damSet(
  min = 0,
  max = 1,
  final unit = "1") = 0.9
  "DDSP terminal damper percent open set point";

 parameter Real kDam(
   final unit= "1") = 0.5
  "Damper position setpoint PI gain value k.";

  parameter Real TiDam(
   final unit= "s") = 60
  "Damper position setpoint PI time constant value Ti.";

  parameter Real TdDam(
   final unit= "s") = 0.1 "Time constant of derivative block for conPIDDam";

  parameter CDL.Types.SimpleController controllerTypeDam=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
  "Type of controller";

  parameter Real dPDucSetCV(
  min = 0,
  final unit = "Pa",
  final quantity = "PressureDifference") = 250 "Constant volume down duct static pressure set point";

  parameter Real fanSpeMin(
   final unit= "m/s") = 0.0000001
  "Minimum Fan Speed";

  parameter Real kFanSpe(
   final unit= "1") = 0.5 "
  Fan speed set point SAT PI gain value k.";

  parameter Real TdFanSpe(
   final unit= "s") = 60 "Time constant of derivative block for conPIDFanSpe";

  parameter Real TiFanSpe(
   final unit= "s") = 0.000025
  "Fan speed set point SAT PI time constant value Ti.";

  parameter CDL.Types.SimpleController controllerTypeFanSpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";

  Buildings.Controls.OBC.FDE.DOAS.SupplyFanController SFcon(
    is_vav=is_vav,
    yMinDamSet=yMinDamSet,
    yMaxDamSet=yMaxDamSet,
    damSet=damSet,
    kDam=kDam,
    TiDam=TiDam,
    TdDam=TdDam,
    controllerTypeDam=controllerTypeDam,
    dPDucSetCV=dPDucSetCV,
    fanSpeMin=fanSpeMin,
    kFanSpe=kFanSpe,
    TdFanSpe=TdFanSpe,
    TiFanSpe=TiFanSpe,
    controllerTypeFanSpe=controllerTypeFanSpe)
    annotation (Placement(transformation(extent={{40,-6},{60,14}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(
    delayTime=10,
    delayOnInit=true)
    "Simulates delay between fan start command and status feedback."
    annotation (Placement(transformation(extent={{8,-34},{28,-14}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse
  OccGen(width=0.6, period=2*2880)
  annotation (Placement(transformation(extent={{-66,32},{-46,52}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin
  mostOpenDamGen(
    amplitude=0.5,
    freqHz=1/5670,
    offset=0.5)
    annotation (Placement(transformation(extent={{-66,-2},{-46,18}})));

  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sensorDDSP(
    amplitude=6,
    freqHz=1/6780,
    offset=200)
    annotation (Placement(transformation(extent={{-66,-38},{-46,-18}})));

equation
  connect(SFcon.yFanSup, truDel.u) annotation (Line(points={{62,9.2},{66,9.2},{66,
          -46},{0,-46},{0,-24},{6,-24}}, color={255,0,255}));

  connect(truDel.y, SFcon.uFanSupPro) annotation (Line(points={{30,-24},{34,-24},
          {34,0.4},{38,0.4}}, color={255,0,255}));

  connect(OccGen.y, SFcon.Occ) annotation (Line(points={{-44,42},{-10,42},{-10,11},
          {38,11}}, color={255,0,255}));

  connect(mostOpenDamGen.y, SFcon.uDamMaxOpe) annotation (Line(points={{-44,8},{
          -10,8},{-10,7.4},{38,7.4}}, color={0,0,127}));
  connect(sensorDDSP.y, SFcon.dPAirDucSta) annotation (Line(points={{-44,-28},{-10,
          -28},{-10,-3.2},{38,-3.2}}, color={0,0,127}));

  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={Ellipse(lineColor = {75,138,73},fillColor={255,255,255},
            fillPattern=
FillPattern.Solid,extent={{-100,-100},{100,100}}),Polygon(lineColor = {0,0,255},fillColor = {75,138,73},pattern = LinePattern.None,
            fillPattern=
FillPattern.Solid,points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(revisions="<html>
<ul>
<li>
September 11, 2020, by Henry Nickels:</br>
First implementation.</li>
</ul>
</html>", info="<html>
<p>
This example simulates
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.SupplyFanController\">
Buildings.Controls.OBC.FDE.DOAS.SupplyFanController</a>.
</p>
</html>"),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Validation/SupplyFanController.mos"
    "Simulate and plot"));
end SupplyFanController;
