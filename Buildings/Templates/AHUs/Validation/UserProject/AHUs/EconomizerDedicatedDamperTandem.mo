within Buildings.Templates.AHUs.Validation.UserProject.AHUs;
model EconomizerDedicatedDamperTandem
  extends VAVSingleDuct(
    final id="VAV_1",
    redeclare  Economizers.DedicatedDamperTandem eco
      "Separate dedicated OA damper - Dampers actuated in tandem",
    redeclare replaceable record RecordEco =
        Economizers.Data.DedicatedDamperTandem);

  annotation (
    defaultComponentName="ahu");
end EconomizerDedicatedDamperTandem;