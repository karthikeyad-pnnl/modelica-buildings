within Buildings.Templates.Plants.HeatPumps_PNNL.Components.HeatPumpGroups;
model WaterToWater
  "Water-to-water heat pump group"

  extends Buildings.Templates.Plants.HeatPumps_PNNL.Components.Interfaces.PartialHeatPumpGroup_WW(
    final typ=Buildings.Templates.Components.Types.HeatPump.AirToWater,
    final typMod=Buildings.Templates.Components.Types.HeatPumpModel.EquationFit);
  Buildings.Templates.Components.HeatPumps.WaterToWater hp[nHp](
    redeclare each final package MediumHeaWat=MediumHeaWat,
    each final is_rev=is_rev,
    final dat=datHp,
    each final allowFlowReversal=allowFlowReversal,
    each final energyDynamics=energyDynamics,
    each final have_preDroChiHeaWat=have_preDroChiHeaWat,
    each final have_preDroSou=have_preDroSou)
    "Heat pump unit"
    annotation (Placement(transformation(extent={{10,-10},{-10,10}})));
equation

  connect(ports_aChiHeaWat, hp.port_a)
    annotation (Line(points={{120,200},{120,0},{10,0}},color={0,127,255}));
  connect(hp.port_b, ports_bChiWat)
    annotation (Line(points={{-10,0},{-120,0},{-120,200}}, color={0,127,255}));
  connect(busHp, hp.bus)
    annotation (Line(points={{0,160},{0,10}},color={255,204,51},thickness=0.5));
  connect(ports_aSou, hp.port_aSou)
    annotation (Line(points={{-120,-200},{-120,-10},{-10,-10}},color={0,127,255}));
  connect(ports_bSou, hp.port_bSou)
    annotation (Line(points={{120,-200},{120,-10},{10,-10}},color={0,127,255}));
  annotation (
    defaultComponentName="hp_WW");
end WaterToWater;
