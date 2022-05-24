within Buildings.Fluid.ZoneEquipment.Components;
model coolingCoil_electric
  extends Buildings.Fluid.ZoneEquipment.Baseclasses.AirloopInterfaces;

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
    annotation (Placement(transformation(extent={{-12,0},{28,40}})));
  parameter Real minSpeRat "Minimum speed ratio";
  parameter Modelica.Units.SI.PressureDifference dpCooCoi_nominal
    "Pressure difference";
equation
  connect(uCoo, cooCoi.speRat) annotation (Line(points={{0,120},{0,76},{-14,76},
          {-14,36}},          color={0,0,127}));
  connect(TAmb, cooCoi.TConIn) annotation (Line(points={{-40,120},{-40,80},{-16,
          80},{-16,26},{-14,26}},
                                color={0,0,127}));
  connect(VAir_flow.port_b, cooCoi.port_a) annotation (Line(points={{-20,0},{-16,
          0},{-16,20},{-12,20}}, color={0,127,255}));
  connect(cooCoi.port_b, TAirCon.port_a) annotation (Line(points={{28,20},{34,20},
          {34,0},{40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end coolingCoil_electric;
