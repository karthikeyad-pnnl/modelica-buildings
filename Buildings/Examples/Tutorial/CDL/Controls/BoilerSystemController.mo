within Buildings.Examples.Tutorial.CDL.Controls;
block BoilerSystemController
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TRoo
    "Measured room temperature"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOutAir
    "Measured outdoor air temperature"
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end BoilerSystemController;
