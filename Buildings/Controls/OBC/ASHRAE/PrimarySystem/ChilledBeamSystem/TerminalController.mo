within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem;
block TerminalController "Terminal controller"
  CDL.Interfaces.BooleanInput uDetOcc "Detected occupancy in zone"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  CDL.Interfaces.BooleanInput uConSen
    "Signal indicating condensation detected in zone"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  SetPoints.OperatingMode operatingMode
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  ZoneRegulation.Controller zonRegCon
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  CDL.Interfaces.RealInput TZon "Measured zone temperature"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  CDL.Interfaces.RealInput VDis_flow
    "Measured discharge air flow rate from CAV terminal"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  CDL.Interfaces.RealOutput yReh "CAV terminal reheat signal"
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  CDL.Interfaces.RealOutput yDam "CAV terminal damper position signal"
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
  CDL.Interfaces.RealOutput yChiVal
    "Chilled beam manifold control valve position signal"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
equation
  connect(uDetOcc, operatingMode.uDetOcc)
    annotation (Line(points={{-120,60},{-82,60}}, color={255,0,255}));
  connect(operatingMode.yOpeMod, zonRegCon.uOpeMod) annotation (Line(points={{
          -58,60},{-50,60},{-50,-6},{-12,-6}}, color={255,127,0}));
  connect(uConSen, zonRegCon.uConSen) annotation (Line(points={{-120,20},{-60,
          20},{-60,2},{-12,2}}, color={255,0,255}));
  connect(TZon, zonRegCon.TZon) annotation (Line(points={{-120,-20},{-40,-20},{
          -40,6},{-12,6}}, color={0,0,127}));
  connect(VDis_flow, zonRegCon.VDis_flow) annotation (Line(points={{-120,-60},{
          -30,-60},{-30,-2},{-12,-2}}, color={0,0,127}));
  connect(zonRegCon.yReh, yReh) annotation (Line(points={{12,4},{60,4},{60,40},
          {120,40}}, color={0,0,127}));
  connect(zonRegCon.yChiVal, yChiVal)
    annotation (Line(points={{12,0},{120,0}}, color={0,0,127}));
  connect(zonRegCon.yDam, yDam) annotation (Line(points={{12,-4},{60,-4},{60,
          -40},{120,-40}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end TerminalController;
