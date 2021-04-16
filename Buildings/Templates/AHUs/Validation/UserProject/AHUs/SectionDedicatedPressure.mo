within Buildings.Templates.AHUs.Validation.UserProject.AHUs;
model SectionDedicatedPressure
  extends Buildings.Templates.AHUs.VAVSingleDuct(
    redeclare BaseClasses.OutdoorSection.DedicatedPressure secOut,
    final id="VAV_1",
    nZon=1,
    nGro=1);

end SectionDedicatedPressure;
