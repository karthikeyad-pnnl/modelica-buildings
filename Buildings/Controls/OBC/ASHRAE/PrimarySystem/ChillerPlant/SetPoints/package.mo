within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant;
package SetPoints

annotation (preferredView="info", Documentation(info="<html>
<p>
This package contains chilled water plant reset control sequences.
The implementation is based on section 5.2.5.2. in ASHRAE RP-1711, Draft 6 (July 25, 2019).
</p>
</html>"),
  Icon(graphics={
        Rectangle(
          lineColor={200,200,200},
          fillColor={248,248,248},
          fillPattern=FillPattern.HorizontalCylinder,
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
        Rectangle(
          lineColor={128,128,128},
          extent={{-100.0,-100.0},{100.0,100.0}},
          radius=25.0),
      Text(
        extent={{-100,100},{100,-100}},
        lineColor={0,0,0},
        textString="S")}));
end SetPoints;
