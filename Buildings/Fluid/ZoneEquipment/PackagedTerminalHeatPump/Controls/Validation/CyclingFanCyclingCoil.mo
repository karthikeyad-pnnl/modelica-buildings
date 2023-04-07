within Buildings.Fluid.ZoneEquipment.PackagedTerminalHeatPump.Controls.Validation;
model CyclingFanCyclingCoil
  "Validation model for controller with variable heating and constant speed fan"
  extends Modelica.Icons.Example;

  Buildings.Fluid.ZoneEquipment.PackagedTerminalHeatPump.Controls.CyclingFanCyclingCoil
    conVarWatConFan(
    heaCoiTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.HeaSou.heaPum,
    cooCoiTyp=Buildings.Fluid.ZoneEquipment.BaseClasses.Types.CooSou.eleDX,
    final controllerTypeHea=Buildings.Controls.OBC.CDL.Types.SimpleController.P,
    final tFanEnaDel=0,
    final tFanEna=0,
    dTHys=0.2) "Instance of controller with cycling fan and cyling coil"
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));

  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDel(delayTime=0)
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));
protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse supFanOpeMod(
    final period=900) "Supply fan operating mode signal"
    annotation (Placement(transformation(extent={{-40,-70},{-20,-50}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TZon(
    final height=10,
    final duration=36000,
    final offset=273.15 + 15) "Measured zone temperature"
    annotation (Placement(transformation(extent={{-40,50},{-20,70}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant heaSetPoi(final k=
        273.15 + 23) "Heating setpoint temperature"
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse uAva(final period=2700)
    "System availability signal"
    annotation (Placement(transformation(extent={{-40,-30},{-20,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant cooSetPoi(final k=
        273.15 + 24) "Cooling setpoint temperature"
    annotation (Placement(transformation(extent={{-40,86},{-20,106}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TSup(
    final height=6,
    final duration=3600,
    final offset=273.15 + 35) "Measured supply air temperature"
    annotation (Placement(transformation(extent={{-40,-108},{-20,-88}})));
equation
  connect(heaSetPoi.y, conVarWatConFan.THeaSet) annotation (Line(points={{-18,20},
          {-10,20},{-10,-1.76471},{8.88889,-1.76471}},
                                  color={0,0,127}));
  connect(TZon.y, conVarWatConFan.TZon)
    annotation (Line(points={{-18,60},{0,60},{0,5.29412},{8.88889,5.29412}},
                                                           color={0,0,127}));
  connect(supFanOpeMod.y, conVarWatConFan.fanOpeMod) annotation (Line(points={{-18,-60},
          {0,-60},{0,-8.82353},{8.88889,-8.82353}},      color={255,0,255}));
  connect(uAva.y, conVarWatConFan.uAva) annotation (Line(points={{-18,-20},{-10,
          -20},{-10,-5.29412},{8.88889,-5.29412}}, color={255,0,255}));
  connect(conVarWatConFan.yFan, truDel.u) annotation (Line(points={{31.2222,
          -8.82353},{40.5555,-8.82353},{40.5555,0},{48,0}}, color={255,0,255}));
  connect(truDel.y, conVarWatConFan.uFan) annotation (Line(points={{72,0},{80,0},
          {80,20},{4,20},{4,8.82353},{8.88889,8.82353}}, color={255,0,255}));
  connect(cooSetPoi.y, conVarWatConFan.TCooSet) annotation (Line(points={{-18,96},
          {-4,96},{-4,1.76471},{8.88889,1.76471}},     color={0,0,127}));
  connect(TSup.y, conVarWatConFan.TSup) annotation (Line(points={{-18,-98},{4,
          -98},{4,-11.2941},{8.88889,-11.2941}}, color={0,0,127}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
      <p>
      This simulation model is used to validate <a href=\"modelica://Buildings.Fluid.ZoneEquipment.PackagedTerminalHeatPump.Controls.CyclingFanCyclingCoil\">
      Buildings.Fluid.ZoneEquipment.PackagedTerminalHeatPump.Controls.CyclingFanCyclingCoil</a>.
      </p>
      <p align=\"center\">
      <img alt=\"image\" src=\"modelica://Buildings/Resources/Images/Fluid/ZoneEquipment/FanCoilUnit/Controls/constantFanVariableFlowrate.png\"/>
      </p>
      </html>
      ", revisions="<html>
      <ul>
      <li>
      August 03, 2022 by Karthik Devaprasad:<br/>
      First implementation.
      </li>
      </ul>
      </html>"),
    experiment(
      StopTime=86400,
      Tolerance=1e-06,
      __Dymola_Algorithm="Dassl"));
end CyclingFanCyclingCoil;