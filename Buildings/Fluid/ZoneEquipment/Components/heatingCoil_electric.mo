within Buildings.Fluid.ZoneEquipment.Components;
model heatingCoil_electric
  extends Buildings.Fluid.ZoneEquipment.Baseclasses.AirloopInterfaces;

  Controls.OBC.CDL.Interfaces.RealInput uHea "Heating level signal"
    annotation (Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  parameter Modelica.Units.SI.PressureDifference dp_Coil_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal
    "Heat flow rate at u=1, positive for heating";

  Buildings.Fluid.HeatExchangers.HeaterCooler_u heaCoi(
    m_flow_nominal=mAir_flow_nominal,
    dp_nominal=dp_Coil_nominal,
    Q_flow_nominal=QHeaCoi_flow_nominal,
    redeclare package Medium = MediumA)
    annotation (Placement(transformation(extent={{-8,-12},{12,10}})));
equation
  connect(TAirSup.port_b, VAir_flow.port_a)
    annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
  connect(uHea, heaCoi.u) annotation (Line(points={{0,120},{0,80},{-10,80},{-10,
          5.6}}, color={0,0,127}));
  connect(VAir_flow.port_b, heaCoi.port_a) annotation (Line(points={{-20,0},{
          -16,0},{-16,-1},{-8,-1}}, color={0,127,255}));
  connect(heaCoi.port_b, TAirCon.port_a) annotation (Line(points={{12,-1},{26,
          -1},{26,0},{40,0}}, color={0,127,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end heatingCoil_electric;
