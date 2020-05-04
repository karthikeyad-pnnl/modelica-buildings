within Buildings.Examples.Tutorial.CDL.Controls.Validation;
model BoilerController "Validation model for boiler on/off controller"
    extends Modelica.Icons.Example;

  Buildings.Examples.Tutorial.CDL.Controls.BoilerController conBoiOn
    annotation (Placement(transformation(extent={{-30,-10},{-10,10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Sine sin(
    amplitude=40,
    freqHz=1/720,
    offset=273.15 + 80)
    annotation (Placement(transformation(extent={{-80,-26},{-60,-6}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(k=true)
    annotation (Placement(transformation(extent={{-80,30},{-60,50}})));
  Buildings.Examples.Tutorial.CDL.Controls.BoilerController conBoiOff
    annotation (Placement(transformation(extent={{18,-8},{38,12}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1
    annotation (Placement(transformation(extent={{-24,30},{-4,50}})));
equation
  connect(sin.y, conBoiOn.u) annotation (Line(points={{-58,-16},{-44,-16},{-44,
          -4},{-32,-4}}, color={0,0,127}));
  connect(con.y, conBoiOn.boiStaSig) annotation (Line(points={{-58,40},{-46,40},
          {-46,4},{-32,4}}, color={255,0,255}));
  connect(not1.y, conBoiOff.boiStaSig)
    annotation (Line(points={{-2,40},{8,40},{8,6},{16,6}}, color={255,0,255}));
  connect(not1.u, conBoiOn.boiStaSig) annotation (Line(points={{-26,40},{-46,40},
          {-46,4},{-32,4}}, color={255,0,255}));
  connect(conBoiOff.u, conBoiOn.u) annotation (Line(points={{16,-2},{0,-2},{0,
          -16},{-44,-16},{-44,-4},{-32,-4}}, color={0,0,127}));
  annotation (
    Documentation(info="<html>
<p>
Validation model for the boiler return water temperature controller.
The input to the controller is a ramp signal of increasing measured return water temperature.
The validation shows that as the temperature crosses the set point, the valve opens.
</p>
</html>", revisions="<html>
<ul>
<li>
February 18, 2020, by Michael Wetter:<br/>
First implementation.
</li>
</ul>
</html>"),
__Dymola_Commands(file=
     "modelica://Buildings/Resources/Scripts/Dymola/Examples/Tutorial/CDL/Controls/Validation/RadiatorSupply.mos"
        "Simulate and plot"),
    experiment(
      StopTime=3600,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"));
end BoilerController;
