within Buildings.Templates.ChilledWaterPlants;
model AirCooled "Air-cooled plants"
  extends
    Buildings.Templates.ChilledWaterPlants.Interfaces.PartialChilledWaterLoop(
    final typ=Buildings.Templates.ChilledWaterPlants.Types.Configuration.AirCooled,
    final have_eco=eco.have_eco,
    dat(eco(typ=eco.typ, have_valChiWatEcoByp=eco.have_valChiWatEcoByp)));

  Buildings.Templates.ChilledWaterPlants.Components.Economizers.None eco(
      redeclare final package MediumChiWat = MediumChiWat, final dat=dat.eco)
    "Waterside economizer" annotation (Placement(transformation(
        extent={{10,-10},{-10,10}},
        rotation=90,
        origin={-30,-150})));

equation
  connect(VSecRet_flow.port_a,eco. port_a2)
    annotation (Line(points={{158,-240},{-20,-240},{-20,-160},{-24,-160}},
                                                        color={0,127,255}));
  connect(eco.port_b2, chiSec.port_a2)
    annotation (Line(points={{-24,-140},{-20,-140},{-20,-110},{-24,-110}},
                                               color={0,127,255}));

end AirCooled;