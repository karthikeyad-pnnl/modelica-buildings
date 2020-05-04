within Buildings.Controls.OBC.ASHRAE.G36_PR1.BoilerPlant.SetPoints;
model PumpSpeed
  parameter Modelica.SIunits.VolumeFlowRate priCirDesFloRatVal
    "Hot water design flow rate value for primary circuit";
  parameter Modelica.SIunits.Pressure hotWatDifPreMaxVal
    "Maximum allowed differential pressure value between hot-water supply and return sides";
  CDL.Interfaces.BooleanInput IsoValSig_a
    "Signal commanding isolation valve open"
    annotation (Placement(transformation(extent={{-140,80},{-100,120}})));
  CDL.Interfaces.BooleanInput IsoValSig_b
    "Signal commanding isolation valve open"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  CDL.Interfaces.RealInput uPriCirFloRat
    "Measured hot-water flow-rate in primary circuit"
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  CDL.Interfaces.RealInput uHotWatDifPre
    "Measured differential pressure between supply and return sides in primary circuit"
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  CDL.Interfaces.BooleanInput uPumProSig_a
    "Signal indicating lead pump is proved on"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  CDL.Interfaces.BooleanInput uPumProSig_b
    "Signal indicating lag pump is proved on"
    annotation (Placement(transformation(extent={{-140,-120},{-100,-80}})));
  CDL.Logical.Or or2
    "Checking to see if either of the isolation valves are open"
    annotation (Placement(transformation(extent={{-70,90},{-50,110}})));
  CDL.Interfaces.BooleanOutput yPumSta_a "Pump start signal for lead pump"
    annotation (Placement(transformation(extent={{100,40},{140,80}})));
  CDL.Interfaces.BooleanOutput yPumSta_b "Pump start signal for lag pump"
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  CDL.Interfaces.RealOutput yPumSpe "Pump speed signal to both pumps"
    annotation (Placement(transformation(extent={{100,-80},{140,-40}})));
  CDL.Continuous.Sources.Constant priCirDesFloRat(k=priCirDesFloRatVal)
    "Primary circuit design flow-rate"
    annotation (Placement(transformation(extent={{-52,10},{-32,30}})));
  CDL.Continuous.Division div "Hot water flow ratio calculation"
    annotation (Placement(transformation(extent={{-8,30},{12,50}})));
  CDL.Continuous.Greater gre
    "Checking to see if hot-water flow ratio exceeds staging limit to turn on lag pump"
    annotation (Placement(transformation(extent={{30,30},{50,50}})));
  CDL.Continuous.Sources.Constant pumStaLim(k=0.47)
    "Hot-water flow ratio limit for pump staging"
    annotation (Placement(transformation(extent={{-8,0},{12,20}})));
  CDL.Logical.Or or1 "Checking to see if either of the pumps are proved on"
    annotation (Placement(transformation(extent={{-68,-70},{-48,-50}})));
  CDL.Continuous.LimPID pumSpeCon(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PID,
    yMax=1,
    yMin=0,
    initType=Buildings.Controls.OBC.CDL.Types.Init.InitialOutput,
    y_start=1,
    reverseAction=false) "Pump speed controller"
    annotation (Placement(transformation(extent={{-26,-32},{-6,-12}})));
  CDL.Logical.Switch swi
    "Checking pumps are proved on to enable speed controller"
    annotation (Placement(transformation(extent={{12,-70},{32,-50}})));
  CDL.Continuous.Sources.Constant hotWatDifPreMax(k=hotWatDifPreMaxVal)
    "Maximum allowed differential pressure between supply and return in primary circuit"
    annotation (Placement(transformation(extent={{-56,-32},{-36,-12}})));
  CDL.Continuous.Sources.Constant maxPumSpeSig(k=1)
    "Maximum pump speed signal when pumps are not proved on"
    annotation (Placement(transformation(extent={{-26,-100},{-6,-80}})));
  CDL.Logical.LogicalSwitch logSwi
    "Checking lead pump is turned on before lag pump is turned on"
    annotation (Placement(transformation(extent={{68,-10},{88,10}})));
  CDL.Logical.Sources.Constant con(k=false) "Lag pump off signal"
    annotation (Placement(transformation(extent={{34,-24},{54,-4}})));
equation
  connect(or2.u1, IsoValSig_a)
    annotation (Line(points={{-72,100},{-120,100}}, color={255,0,255}));
  connect(or2.u2, IsoValSig_b) annotation (Line(points={{-72,92},{-86,92},{-86,
          60},{-120,60}},
                      color={255,0,255}));
  connect(or2.y, yPumSta_a) annotation (Line(points={{-48,100},{40,100},{40,60},
          {120,60}}, color={255,0,255}));
  connect(div.u1, uPriCirFloRat) annotation (Line(points={{-10,46},{-64,46},{-64,
          20},{-120,20}}, color={0,0,127}));
  connect(div.u2, priCirDesFloRat.y) annotation (Line(points={{-10,34},{-22,34},
          {-22,20},{-30,20}}, color={0,0,127}));
  connect(div.y, gre.u1)
    annotation (Line(points={{14,40},{28,40}}, color={0,0,127}));
  connect(pumStaLim.y, gre.u2) annotation (Line(points={{14,10},{20,10},{20,32},
          {28,32}}, color={0,0,127}));
  connect(or1.u1, uPumProSig_a)
    annotation (Line(points={{-70,-60},{-120,-60}}, color={255,0,255}));
  connect(or1.u2, uPumProSig_b) annotation (Line(points={{-70,-68},{-90,-68},{-90,
          -100},{-120,-100}}, color={255,0,255}));
  connect(pumSpeCon.u_m, uHotWatDifPre) annotation (Line(points={{-16,-34},{-16,
          -40},{-64,-40},{-64,-20},{-120,-20}}, color={0,0,127}));
  connect(pumSpeCon.u_s, hotWatDifPreMax.y)
    annotation (Line(points={{-28,-22},{-34,-22}}, color={0,0,127}));
  connect(pumSpeCon.y, swi.u1) annotation (Line(points={{-4,-22},{0,-22},{0,-52},
          {10,-52}}, color={0,0,127}));
  connect(or1.y, swi.u2) annotation (Line(points={{-46,-60},{10,-60}},
                      color={255,0,255}));
  connect(maxPumSpeSig.y, swi.u3) annotation (Line(points={{-4,-90},{0,-90},{0,-68},
          {10,-68}}, color={0,0,127}));
  connect(swi.y, yPumSpe)
    annotation (Line(points={{34,-60},{120,-60}}, color={0,0,127}));
  connect(gre.y, logSwi.u1) annotation (Line(points={{52,40},{60,40},{60,8},{66,
          8}}, color={255,0,255}));
  connect(logSwi.u2, yPumSta_a) annotation (Line(points={{66,0},{56,0},{56,60},{
          120,60}}, color={255,0,255}));
  connect(con.y, logSwi.u3) annotation (Line(points={{56,-14},{62,-14},{62,-8},{
          66,-8}}, color={255,0,255}));
  connect(logSwi.y, yPumSta_b)
    annotation (Line(points={{90,0},{120,0}}, color={255,0,255}));
  connect(yPumSpe, yPumSpe)
    annotation (Line(points={{120,-60},{120,-60}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -120},{100,120}}), graphics={Rectangle(
          extent={{-100,120},{100,-120}},
          lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid), Text(
          extent={{-90,48},{92,-38}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.None,
          textString="pumSpe")}),
                                Diagram(coordinateSystem(preserveAspectRatio=
            false, extent={{-100,-120},{100,120}})),
  Documentation(info="<html>
  <p>
  Control sequence for hot-water pump start <code>yPumSta</code> and pump speed
  <code>yPumSpe</code> for lead and lag pump in boiler plant loop.
  </p>
  <h4>Boiler plant loop: Control of hot-water pumps start and speed</h4>
  <ol>
  <li>
  The lead pump is enabled <code>yPumSta_a = true</code> when either of the
  boiler isolation valves are opened <code>IsoValSig = true</code>, and disabled
  otherwise.
  </li>
  <li>
  The hot-water flow ratio is calculated using the maesured primary circuit
  hot-water flow-rate <code>uPriCirFloRat</code>, and the lag pump is enabled
  <code>yPumSta_b = true</code> when the hot-water flow-ratio exceeds the limit
  <code>pumStaLim</code> and the lead pump is turned on <code>yPumSta_a = true</code>
  .
  </li>
  <li>
  When either of the pumps are proved on, a PID control loop modulates the
  pump speed to maintain the measured pressure differential between supply and
  return in the primary hot-water circuit <code>uHotWatDifPre</code> at the
  maximum allowed value <code>hotWatDifPreMaxVal</code>.
  </li>
  <li>
  When <code>uPumProSig = false</code>, the pump speed is set to the maximum
  value.
  </li>
  </ol>
  </html>", revisions="<html>
  <ul>
  <li>
  February 22, 2020, by Karthik Devaprasad:<br/>
  First implementation.
  </li>
  </ul>
  </html>"));
end PumpSpeed;
