within Buildings.Templates.AirHandlersFans.Validation;
model ZonalHVACPTHP "Validation model for PTHP zonal HVAC system"
  extends Buildings.Templates.AirHandlersFans.Validation.ZonalHVACBase(
    datAll(redeclare model ZonalHVAC =
      Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans.ZonalHVACPTHP,
    dat_VAV_1(coiCoo(redeclare
        Buildings.Fluid.DXSystems.Cooling.AirSource.Data.DoubleSpeed.Lennox_SCA240H4B
        datCoi),
        coiHeaPre(redeclare
        Buildings.Fluid.DXSystems.Heating.AirSource.Validation.Data.SingleSpeedHeating
        datCoi),
        coiHeaReh(redeclare
        Buildings.Fluid.DXSystems.Heating.AirSource.Validation.Data.SingleSpeedHeating
        datCoi))),
    redeclare
      Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans.ZonalHVACPTHP VAV_1);

  annotation (
  experiment(
      StopTime=86400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),        Documentation(info="<html>
<p>
This is a validation model for the configuration represented by
<a href=\"modelica://Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans.VAVMZCoilDXHeatingSingleSpeed\">
Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans.VAVMZCoilDXHeatingSingleSpeed</a>
</p>
</html>"));
end ZonalHVACPTHP;
