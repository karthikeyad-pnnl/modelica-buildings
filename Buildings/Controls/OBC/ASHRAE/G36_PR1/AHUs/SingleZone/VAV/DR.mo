within Buildings.Controls.OBC.ASHRAE.G36_PR1.AHUs.SingleZone.VAV;
block DR
  DemandResponse.Client client
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Controller conVAV
    annotation (Placement(transformation(extent={{20,24},{60,76}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end DR;
