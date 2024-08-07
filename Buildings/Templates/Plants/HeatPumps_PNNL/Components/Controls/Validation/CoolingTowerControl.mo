within Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.Validation;
model CoolingTowerControl

  Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.CoolingTowerControl
    coolingTowerControl
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola//Buildings/Templates/Plants/HeatPumps_PNNL/Components/Controls/CoolingTowerControl.mos"
        "Simulate and plot"),
    experiment(
      StopTime=86400,
      Interval=1,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"),
    Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(
      coordinateSystem(
        preserveAspectRatio=false, extent={{-120,-160},{120,160}})),
    Documentation(
      info="<html>
<p>
This model validate <a href=\"modelica://Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.CoolingTowerControl\">
Buildings.Templates.Plants.HeatPumps_PNNL.Components.Controls.CoolingTowerControl</a>. 
</p>
</html>", revisions="<html>
<ul>
<li>
July 8, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end CoolingTowerControl;
