within Buildings.Fluid.ZoneEquipment.BaseClasses.Validation;
model SupplementalHeating
  "Validation model for supplemental heating controller"
  extends Modelica.Icons.Example;

  Buildings.Fluid.ZoneEquipment.BaseClasses.SupplementalHeating conSupHea(
    final TLocOut = 271.15)
    "Instance of controller for cycling fan and cyling coil"
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant uHeaMod(
    final k=true)
    "Heating mode signal"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse uHeaEna(
    final period=7200)
    "Heating coil enable signal from main heating controller"
    annotation (Placement(transformation(extent={{-40,-46},{-20,-26}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TZon(
    final height=3,
    final duration=21600,
    final offset=273.15 + 19,
    startTime=10800)
    "Measured zone temperature"
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant heaSetPoi(
    final k=273.15+ 21)
    "Heating setpoint temperature"
    annotation (Placement(transformation(extent={{-40,24},{-20,44}})));

  Buildings.Controls.OBC.CDL.Continuous.Sources.Ramp TOut(
    final height=-10,
    final duration=18000,
    final offset=273.15 + 0)
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

equation
  connect(heaSetPoi.y,conSupHea.THeaSet)  annotation (Line(points={{-18,34},{
          -10,34},{-10,8},{10,8}}, color={0,0,127}));
  connect(TZon.y, conSupHea.TZon)
    annotation (Line(points={{-18,70},{0,70},{0,4},{10,4}}, color={0,0,127}));
  connect(TOut.y, conSupHea.TOut) annotation (Line(points={{-18,0},{10,0}},
                          color={0,0,127}));
  connect(uHeaEna.y, conSupHea.uHeaEna) annotation (Line(points={{-18,-36},{-10,
          -36},{-10,-8},{10,-8}},color={255,0,255}));
  connect(uHeaMod.y, conSupHea.uHeaMod) annotation (Line(points={{-18,-70},{0,
          -70},{0,-4},{10,-4}},  color={255,0,255}));
  annotation(Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
    <p>
    This simulation model is used to validate 
    <a href=\"modelica://Buildings.Fluid.ZoneEquipment.BaseClasses.SupplementalHeating\">
    Buildings.Fluid.ZoneEquipment.BaseClasses.SupplementalHeating</a>. 
    </p>
    <p>
    It tests an instance of the supplemental heating controller <code>conSupHea</code>
    with time-varying input signals for the heating enable signal from main controller 
    <code>uHeaEna</code>, zone temperature <code>TZon</code> and outdoor air temperature
    <code>TOut</code>. The following observations can be made from the plot.
    <ul>
    <li>
    The main heating coil enable signal from the supplemental controller <code>yHeaEna</code>
    matches <code>uHeaEna</code> as long as <code>TOut</code> stays above the lockout
    temperature <code>TLocOut</code>. When <code>TOut &lt; TLocOut</code>, 
    <code>yHeaEna=false</code>.
    </li>
    <li>
    The supplemental heating modulation signal <code>ySupHea</code> is used to operate
    the supplemental heating coil when <code>TZon &lt; THeaSet</code>.
    </li>
    </ul>
    </p>
    </html>",revisions="<html>
      <ul>
      <li>
      April 10, 2023, by Xing Lu and Karthik Devaprasad:<br/>
      First implementation.
      </li>
      </ul>
      </html>"),
    experiment(Tolerance=1e-06),
    __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Fluid/ZoneEquipment/BaseClasses/Validation/SupplementalHeating.mos"
        "Simulate and Plot"),
    Documentation(info="<html>
    <p>
    This is a validation model for the controller 
    <a href=\"modelica://Buildings.Fluid.ZoneEquipment.BaseClasses.SupplementalHeating\">
    Buildings.Fluid.ZoneEquipment.BaseClasses.SupplementalHeating</a>. The model comprises the controller
    (<code>conSupHea</code>), which receives input signals including zone temperature (<code>Tzon</code>), 
    zone heating temperature setpoint (<code>heaSetPoi</code>), outdoor air temperatures (<code>TOut</code>), 
    heating coil enabling signal (<code>uHeaEna</code>), and heating mode signal (<code>uHeaMod</code>).
    </p>
    <p>
    Simulation results are observed as follows: 
    <ul>
    <li>
    When <code>TOut</code> is above the minimum dry bulb temperature <code>conSupHea.TLocOut</code> 
    and the system is in the heating mode (<code>uHeaMod=True</code>), the DX heating coil is prioritized 
    for heating (<code>conSupHea.yHeaEna=True</code>). 
    </li>
    <li>
    When <code>TOut</code> is below the minimum dry bulb temperature <code>conSupHea.TLocOut</code> 
    and the system is in the heating mode (<code>uHeaEna=True</code>), 
    the supplemental heating is enabled (conSupHea.ySupHea=ture</code>) to track the zone air temperature 
    setpoint <code>THeaSet</code> and the DX heating coil (<code>conSupHea.yHeaEna=False</code>) 
    is disabled.
    </li>
    </ul>
    </p>
    </html>",revisions="<html>
    <ul>
    <li>
    June 21, 2023, by Junke Wang and Karthik Devaprasad:<br/>
    First implementation.
    </li>
    </ul>
    </html>"));
end SupplementalHeating;
