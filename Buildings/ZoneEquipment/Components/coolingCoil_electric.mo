within Buildings.ZoneEquipment.Components;
model coolingCoil_electric
  extends Buildings.ZoneEquipment.Baseclasses.AirloopInterfaces(redeclare
      Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed cooCoi(
      dp_nominal=dpCooCoi_nominal,
      minSpeRat=minSpeRat,
      redeclare package Medium = MediumA));
  Controls.OBC.CDL.Interfaces.RealInput uCoo "Cooling level signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  Controls.OBC.CDL.Interfaces.RealInput TAmb
    "Ambient air drybulb temperature"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={-40,120})));

  Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed cooCoi(
    dp_nominal=dpCooCoi_nominal,
    minSpeRat=minSpeRat,
    redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-20,-20},{20,20}})));
  parameter Real minSpeRat "Minimum speed ratio";
  parameter Modelica.Units.SI.PressureDifference dpCooCoi_nominal
    "Pressure difference";
equation
  connect(uCoo, cooCoi.speRat) annotation (Line(points={{0,120},{0,76},{-14,76},
          {-14,16},{-22,16}}, color={0,0,127}));
  connect(TAmb, cooCoi.TConIn) annotation (Line(points={{-40,120},{-40,80},{-16,
          80},{-16,6},{-22,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end coolingCoil_electric;
