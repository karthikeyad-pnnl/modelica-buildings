within Buildings.Controls.OBC.FDE.DOAS.Subsequences.Validation;
model SupplyFanController
  "This model simulates SupplyFanController"
 parameter Boolean is_vav = true
  "True: System has zone terminals with variable damper position. False: System has zone terminals with constant damper position.";

  parameter Real yMinDamSet(
    min=0,
    unit="Pa")=125
  "Minimum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));

  parameter Real yMaxDamSet(
    min=0,
    unit="Pa")=500
  "Maximum down duct static pressure reset value" annotation(Dialog(group = "DDSP range"));

  parameter Real damSet(
    max=1,
    min=0,
    unit="1")=0.9
  "DDSP terminal damper percent open set point";

  parameter Real dPDucSetCV(
    min=0,
    unit="Pa")=250                             "Constant volume down duct static pressure set point";

  parameter Real fanSpeMin(unit="m/s")=0.0000001
  "Minimum Fan Speed";

  parameter Real kFanSpe(unit="1")=0.5
                          "
  Fan speed set point SAT PI gain value k.";

  parameter Real TdFanSpe(unit="s")=60
                         "Time constant of derivative block for conPIDFanSpe";

  parameter Real TiFanSpe(unit="s")=0.000025
  "Fan speed set point SAT PI time constant value Ti.";

  parameter CDL.Types.SimpleController controllerTypeFanSpe=Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller";

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

  Buildings.Controls.OBC.FDE.DOAS.Subsequences.SupplyFanController SFcon
    annotation (Placement(transformation(extent={{48,0},{68,20}})));
equation

  connect(OccGen.y, SFcon.Occ) annotation (Line(points={{-44,42},{38,42},{38,18},
          {46,18}}, color={255,0,255}));
  connect(mostOpenDamGen.y, SFcon.uDamMaxOpe) annotation (Line(points={{-44,8},
          {36,8},{36,14},{46,14}}, color={0,0,127}));
  connect(truDel.y, SFcon.uFanSupPro) annotation (Line(points={{30,-24},{40,-24},
          {40,-4},{38,-4},{38,8},{46,8}}, color={255,0,255}));
  connect(sensorDDSP.y, SFcon.dPAirDucSta) annotation (Line(points={{-44,-28},{
          -2,-28},{-2,-40},{46,-40},{46,4}}, color={0,0,127}));
  connect(SFcon.yFanSup, truDel.u) annotation (Line(points={{70,16},{74,16},{74,
          -66},{6,-66},{6,-24}}, color={255,0,255}));
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
<a href=\"modelica://Buildings.Controls.OBC.FDE.DOAS.Subsequences.SupplyFanController\">
Buildings.Controls.OBC.FDE.DOAS.Subsequences.SupplyFanController</a>.
</p>
</html>"),__Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/FDE/DOAS/Subsequences/Validation/SupplyFanController.mos"
    "Simulate and plot"));
end SupplyFanController;
