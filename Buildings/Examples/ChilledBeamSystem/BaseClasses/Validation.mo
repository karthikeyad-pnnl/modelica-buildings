within Buildings.Examples.ChilledBeamSystem.BaseClasses;
package Validation

  block ZoneModel_simplified
    "Validation model for zone model"
    extends Modelica.Icons.Example;
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.Testbed.ZoneModel_simplified
      zoneModel_simplified
      annotation (Placement(transformation(extent={{-10,20},{10,40}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end ZoneModel_simplified;
annotation (Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100,-100},{100,100}},
          radius=25.0),
        Polygon(
          origin={8,14},
          lineColor={78,138,73},
          fillColor={78,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}));
end Validation;
