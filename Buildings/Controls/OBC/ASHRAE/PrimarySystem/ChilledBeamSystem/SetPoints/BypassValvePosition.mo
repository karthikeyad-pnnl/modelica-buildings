within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChilledBeamSystem.SetPoints;
block BypassValvePosition
  "Block with sequences for calculating bypass valve position"

  parameter Integer nPum = 2
    "Number of pumps in the chilled water loop";

  parameter Real minPumSpe(
    final unit = "1",
    displayUnit = "1") = 0.1
    "Minimum pump speed";

  parameter Real dPumSpe(
    final unit = "1",
    displayUnit = "1") = 0.01
    "Value added to minimum pump speed to get upper hysteresis limit"
    annotation(Dialog(tab="Advanced"));

  parameter Real dPChiWatMax(
    final unit = "Pa",
    displayUnit = "Pa",
    final quantity = "PressureDifference") = 50000
    "Maximum allowed differential pressure in the chilled water loop";

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPumSta[nPum]
    "Pump proven On signal"
    annotation (Placement(transformation(extent={{-140,30},{-100,70}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  CDL.Interfaces.RealOutput yBypValPos "Bypass valve position" annotation (
      Placement(transformation(extent={{100,-20},{140,20}}), iconTransformation(
          extent={{-336,-18},{-296,22}})));
  CDL.Interfaces.RealInput uPumSpe "Pump speed" annotation (Placement(
        transformation(extent={{-140,-20},{-100,20}}), iconTransformation(
          extent={{-354,-72},{-314,-32}})));

  CDL.Logical.Switch swi
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  CDL.Continuous.Hysteresis hys(uLow=minPumSpe + dPumSpe, uHigh=minPumSpe + 2*
        dPumSpe) "Check if pump speed is at minimum"
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  CDL.Logical.And and2 "Logical And"
    annotation (Placement(transformation(extent={{-20,-10},{0,10}})));
  CDL.Logical.Switch swi1 "Real switch"
    annotation (Placement(transformation(extent={{20,40},{40,60}})));
  CDL.Continuous.Sources.Constant con(k=0) "Constant real source"
    annotation (Placement(transformation(extent={{-20,60},{0,80}})));
  CDL.Continuous.Sources.Constant con1(k=1) "Constant real source"
    annotation (Placement(transformation(extent={{-20,20},{0,40}})));
  CDL.Interfaces.RealInput dpChiWatLoo(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference")
    "Chilled water loop differential static pressure" annotation (Placement(
        transformation(extent={{-140,-70},{-100,-30}}), iconTransformation(
          extent={{-140,-20},{-100,20}})));
  CDL.Continuous.PID conPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=k,
    Ti=Ti,
    reverseActing=false)
    annotation (Placement(transformation(extent={{20,-60},{40,-40}})));
  parameter Real k=1 "Gain of controller";
  parameter Real Ti=0.5 "Time constant of integrator block";
  CDL.Continuous.AddParameter addPar(p=-dPChiWatMax, k=1)
    "Find error in meaured differential pressure from maximum allowed value"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  CDL.Continuous.AddParameter addPar1(p=0, k=1/dPChiWatMax)
    "Normalize differential pressure error"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
protected
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nZon)
    "Multi Or"
    annotation (Placement(transformation(extent={{-80,40},{-60,60}})));

equation
  connect(uPumSta, mulOr.u[1:nZon]) annotation (Line(points={{-120,50},{-82,50}},
                             color={255,0,255}));
  connect(uPumSpe, hys.u)
    annotation (Line(points={{-120,0},{-92,0}}, color={0,0,127}));
  connect(hys.y, not1.u)
    annotation (Line(points={{-68,0},{-62,0}}, color={255,0,255}));
  connect(not1.y, and2.u2) annotation (Line(points={{-38,0},{-34,0},{-34,-8},{-22,
          -8}}, color={255,0,255}));
  connect(swi.y, yBypValPos)
    annotation (Line(points={{82,0},{120,0}}, color={0,0,127}));
  connect(mulOr.y, and2.u1) annotation (Line(points={{-58,50},{-30,50},{-30,0},{
          -22,0}}, color={255,0,255}));
  connect(mulOr.y, swi1.u2)
    annotation (Line(points={{-58,50},{18,50}}, color={255,0,255}));
  connect(con1.y, swi1.u3) annotation (Line(points={{2,30},{6,30},{6,42},{18,42}},
        color={0,0,127}));
  connect(con.y, swi1.u1) annotation (Line(points={{2,70},{10,70},{10,58},{18,58}},
        color={0,0,127}));
  connect(swi1.y, swi.u3) annotation (Line(points={{42,50},{54,50},{54,-8},{58,-8}},
        color={0,0,127}));
  connect(and2.y, swi.u2)
    annotation (Line(points={{2,0},{58,0}}, color={255,0,255}));
  connect(conPID.y, swi.u1) annotation (Line(points={{42,-50},{48,-50},{48,8},{
          58,8}}, color={0,0,127}));
  connect(con.y, conPID.u_s) annotation (Line(points={{2,70},{10,70},{10,-50},{
          18,-50}}, color={0,0,127}));
  connect(dpChiWatLoo, addPar.u)
    annotation (Line(points={{-120,-50},{-82,-50}}, color={0,0,127}));
  connect(addPar.y, addPar1.u)
    annotation (Line(points={{-58,-50},{-42,-50}}, color={0,0,127}));
  connect(addPar1.y, conPID.u_m) annotation (Line(points={{-18,-50},{-10,-50},{
          -10,-72},{30,-72},{30,-62}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {120,100}}), graphics={
            Text(
              extent={{-100,150},{100,110}},
              lineColor={0,0,255},
              textString="%name"),
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-50,20},{50,-20}},
              lineColor={28,108,200},
              fillColor={255,255,255},
              fillPattern=FillPattern.None,
          textString="sysOpeMod")}),                             Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}})),
        Documentation(info="<html>
        <p>
        Sequences for calculating system operating mode in chilled beam systems.
        </p>
        <p>
        The block determines the system operating mode setpoint <code>yOpeMod</code>
        as well as the enable signals for the chilled beam system <code>yChiBeaEna</code>
        and the DOAS <code>yDoasEna</code>. To do this, it uses the detected 
        occupancy signal from the zones <code>uDetOcc</code> and the expected 
        occupancy schedule <code>schTab</code>.
        </p>
        <p>
        The operating mode setpoint and the enable signals based on the inputs 
        are as follows:
        <br>
        <table summary=\"allowedConfigurations\" border=\"1\">
          <thead>
            <tr>
              <th>Detected occupancy</th>
              <th>Expected occupancy schedule</th>
              <th>System operating mode</th>
              <th>Chilled beam system enable status</th>
              <th>DOAS enable status</th>
            </tr>
          </thead>
          <tbody>
            <tr>
              <td>Occupied</td>
              <td>-</td>
              <td>1</td>
              <td>True</td>
              <td>True</td>
            </tr>
            <tr>
              <td>Unoccupied</td>
              <td>Unoccupied</td>
              <td>2</td>
              <td>True</td>
              <td>False</td>
            </tr>
            <tr>
              <td>Unoccupied</td>
              <td>Occupied</td>
              <td>3</td>
              <td>True</td>
              <td>True</td>
            </tr>
          </tbody>
        </table>
        </p>
        </html>"));
end BypassValvePosition;
