within Buildings.Templates.AirHandlersFans.Validation;
model ZonalHVACPTHP
  "Validation model for PTHP zonal HVAC system"
  extends Buildings.Templates.AirHandlersFans.Validation.ZonalHVACBase(
    datAll(redeclare model ZonalHVAC =
      Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans.ZonalHVACPTHP,
        dat_VAV_1(
        ctl(
          has_fanOpeMod=false,
          fanTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.FanTypes.conSpeFan,
          heaCoiTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.HeaSou.heaPum,
          cooCoiTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.CooSou.eleDX,
          supHeaTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.SupHeaSou.ele,
          minFanSpe=0.1),
        fanSup(nFan=1),
        coiCoo(redeclare
            Buildings.Fluid.DXSystems.Cooling.AirSource.Data.DoubleSpeed.Lennox_SCA240H4B
            datCoi),
        coiHeaPre(wAirEnt_nominal=0.001, redeclare
            Buildings.Fluid.DXSystems.Heating.AirSource.Validation.Data.SingleSpeedHeating
            datCoi),
        coiHeaReh(wAirEnt_nominal=0.01))),
    redeclare
      Buildings.Templates.AirHandlersFans.Validation.UserProject.AirHandlersFans.ZonalHVACPTHP VAV_1);

equation
  connect(senTem.T, busAHU.TZon) annotation (Line(points={{57,30},{70,30},{70,
          60},{-20,60},{-20,10}}, color={0,0,127}), Text(
      string="%second",
      index=1,
      extent={{6,3},{6,3}},
      horizontalAlignment=TextAlignment.Left));
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
