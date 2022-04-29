within Buildings.ZoneEquipment.Components;
model heatingCoil_HHW
  extends Buildings.ZoneEquipment.Baseclasses.WaterloopInterfaces(redeclare
      Buildings.Fluid.HeatExchangers.DryCoilCounterFlow
      partialFourPortInterface(
      redeclare package Medium1 = MediumW,
      redeclare package Medium2 = MediumA,
      m1_flow_nominal=mWat_flow_nominal,
      m2_flow_nominal=mAir_flow_nominal,
      dp1_nominal=dpCoiWat_nominal,
      dp2_nominal=dpCoiAir_nominal,
      UA_nominal=UA_nominal));

  Controls.OBC.CDL.Interfaces.RealInput uHea "Heating level signal" annotation (
     Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=-90,
        origin={0,120})));
  parameter Modelica.Units.SI.PressureDifference dpCoiWat_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.PressureDifference dpCoiAir_nominal
    "Pressure difference";
  parameter Modelica.Units.SI.ThermalConductance UA_nominal
    "Thermal conductance at nominal flow, used to compute heat capacity";
equation
  connect(port_a, TAirSup.port_a)
    annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
  connect(TAirRet.port_b, port_b)
    annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
  connect(TAirSup.port_b, VAir_flow.port_a)
    annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
  connect(port_a1, TWatSup.port_a)
    annotation (Line(points={{20,-100},{20,-80}}, color={0,127,255}));
  connect(TWatSup.port_b, VWat_flow.port_a)
    annotation (Line(points={{20,-60},{20,-50}}, color={0,127,255}));
  connect(port_b1, TWatRet.port_b)
    annotation (Line(points={{-20,-100},{-20,-70}}, color={0,127,255}));
  connect(VAir_flow.V_flow, POut.V_flow)
    annotation (Line(points={{-50,11},{-50,56},{18,56}}, color={0,0,127}));
  connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
          {8,60},{18,60}}, color={0,0,127}));
  connect(TAirSup.T, POut.TIn)
    annotation (Line(points={{-80,11},{-80,64},{18,64}}, color={0,0,127}));
  connect(VWat_flow.V_flow, PConsumed.V_flow) annotation (Line(points={{9,-40},{
          6,-40},{6,-64},{58,-64}}, color={0,0,127}));
  connect(TWatSup.T, PConsumed.TIn) annotation (Line(points={{9,-70},{0,-70},{0,
          -56},{58,-56}}, color={0,0,127}));
  connect(TWatRet.T, PConsumed.TOut)
    annotation (Line(points={{-9,-60},{58,-60}}, color={0,0,127}));
  connect(uHea, val.y) annotation (Line(points={{0,120},{0,80},{-32,80},{-32,
          -30}},
        color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end heatingCoil_HHW;
