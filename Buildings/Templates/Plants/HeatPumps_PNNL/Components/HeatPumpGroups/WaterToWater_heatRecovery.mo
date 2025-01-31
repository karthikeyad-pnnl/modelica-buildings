within Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups;
model WaterToWater_heatRecovery
  "Water-to-water heat recovery heat pump group"

  extends
    Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interface.PartialHeatPumpGroup_WaterToWater_heatRecovery(
    final typ=Buildings.Templates.Components.Types.Chiller.WaterCooled);
  Buildings.Templates.Components.Chillers.Compression hp[nHp](
    redeclare each final package MediumChiWat=MediumCon,
    redeclare each final package MediumCon=MediumCon,
    each final have_switchover=true,
    each final typ=Buildings.Templates.Components.Types.Chiller.WaterCooled,
    final dat=datHp,
    each final allowFlowReversal1=allowFlowReversal,
    each final allowFlowReversal2=allowFlowReversal,
    each final energyDynamics=energyDynamics)
    "Heat pump unit"
    annotation (Placement(transformation(extent={{-10,10},{10,-10}})));
equation

  connect(ports_aChiWat, hp.port_a2)
    annotation (Line(points={{120,200},{120,6},{10,6}}, color={0,127,255}));
  connect(hp.port_b2, ports_bChiWat) annotation (Line(points={{-10,6},{-120,6},{
          -120,200}},  color={0,127,255}));
  connect(busHp, hp.bus)
    annotation (Line(points={{60,140},{60,76},{0,76},{0,-10}},
                                             color={255,204,51},thickness=0.5));
  connect(ports_aHotWat, hp.port_a1) annotation (Line(points={{-120,-200},{-120,
          -6},{-10,-6}},        color={0,127,255}));
  connect(ports_bHotWat, hp.port_b1) annotation (Line(points={{120,-200},{120,-6},
          {10,-6}},           color={0,127,255}));
  annotation (
    defaultComponentName="hp", Documentation(info="<html>
<p>
This model represents a group of heat pumps.
</p>
</html>"));
end WaterToWater_heatRecovery;
