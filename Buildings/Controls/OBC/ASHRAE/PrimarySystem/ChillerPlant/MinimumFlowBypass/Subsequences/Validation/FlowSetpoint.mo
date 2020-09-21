within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.Validation;
model FlowSetpoint
  "Validation sequence of specifying minimum bypass flow setpoint"

  parameter Integer nChi=3 "Total number of chillers";

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint
    staUpMinFlo(
    final nChi=nChi,
    final byPasSetTim=1.5)
    "Minimum flow setpoint when there is stage up command"
    annotation (Placement(transformation(extent={{120,170},{140,190}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint
    onOffStaUpMinFlo(
    final nChi=nChi,
    final byPasSetTim=1.5)
    "Minimum flow setpoint when there is stage up command and the change requires one chiller off and another chiller on"
    annotation (Placement(transformation(extent={{120,-10},{140,10}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint
    staDowMinFlo(
    final nChi=nChi,
    final byPasSetTim=1.5)
    "Minimum flow setpoint when there is stage down command"
    annotation (Placement(transformation(extent={{120,-170},{140,-150}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant noOnOff(final k=false)
    "No chiller on/off during the stage change"
    annotation (Placement(transformation(extent={{-140,50},{-120,70}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse staCha(
    final width=0.25, final period=4) "Stage up command"
    annotation (Placement(transformation(extent={{-140,190},{-120,210}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse upDev(
    final width=0.3, final period=4)
    "Status of upflow device"
    annotation (Placement(transformation(extent={{-140,160},{-120,180}})));
  Buildings.Controls.OBC.CDL.Logical.Switch enaChi "Next enabling chiller"
    annotation (Placement(transformation(extent={{-40,90},{-20,110}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant noStaCha(
    final k=false) "No stage change"
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Buildings.Controls.OBC.CDL.Logical.Not not1 "Logical not"
    annotation (Placement(transformation(extent={{-100,190},{-80,210}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-100,160},{-80,180}})));
  Buildings.Controls.OBC.CDL.Logical.Switch disChi "Disabling chiller"
    annotation (Placement(transformation(extent={{-40,-130},{-20,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant haveOnOff(
    final k=true)
    "Have chiller on/off during the stage change"
    annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse enaNexChi(
    final width=0.8, final period=4)
    "Enable next chiller"
    annotation (Placement(transformation(extent={{-140,-30},{-120,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Not not3 "Logical not"
    annotation (Placement(transformation(extent={{-100,-30},{-80,-10}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con(
    final k=3) "Index of enabling chiller"
    annotation (Placement(transformation(extent={{-140,110},{-120,130}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant zer(
    final k=0) "Zero"
    annotation (Placement(transformation(extent={{-140,-190},{-120,-170}})));
  Buildings.Controls.OBC.CDL.Continuous.Sources.Constant con1(
    final k=2) "Index of disabling chiller"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{0,-190},{20,-170}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant chiSta[nChi](
    final k={true,true,false})
    "Current chiller status"
    annotation (Placement(transformation(extent={{-40,130},{-20,150}})));

equation
  connect(noOnOff.y, staUpMinFlo.uOnOff)
    annotation (Line(points={{-118,60},{76,60},{76,173},{118,173}},
      color={255,0,255}));
  connect(noStaCha.y, staUpMinFlo.uStaDow)
    annotation (Line(points={{-118,20},{92,20},{92,171},{118,171}},
      color={255,0,255}));
  connect(staCha.y, not1.u)
    annotation (Line(points={{-118,200},{-102,200}}, color={255,0,255}));
  connect(upDev.y, not2.u)
    annotation (Line(points={{-118,170},{-102,170}}, color={255,0,255}));
  connect(not1.y,enaChi. u2)
    annotation (Line(points={{-78,200},{-60,200},{-60,100},{-42,100}},
      color={255,0,255}));
  connect(not1.y, staUpMinFlo.uStaUp)
    annotation (Line(points={{-78,200},{68,200},{68,189},{118,189}},
      color={255,0,255}));
  connect(not2.y, staUpMinFlo.uUpsDevSta)
    annotation (Line(points={{-78,170},{72,170},{72,187},{118,187}},
      color={255,0,255}));
  connect(not1.y, disChi.u2)
    annotation (Line(points={{-78,200},{-60,200},{-60,-120},{-42,-120}},
      color={255,0,255}));
  connect(noOnOff.y, staDowMinFlo.uOnOff)
    annotation (Line(points={{-118,60},{76,60},{76,-167},{118,-167}},
      color={255,0,255}));
  connect(noStaCha.y, staDowMinFlo.uStaUp)
    annotation (Line(points={{-118,20},{92,20},{92,-151},{118,-151}},
      color={255,0,255}));
  connect(not2.y, staDowMinFlo.uUpsDevSta)
    annotation (Line(points={{-78,170},{72,170},{72,-153},{118,-153}},
      color={255,0,255}));
  connect(not1.y, staDowMinFlo.uStaDow)
    annotation (Line(points={{-78,200},{68,200},{68,-169},{118,-169}},
      color={255,0,255}));
  connect(not1.y, onOffStaUpMinFlo.uStaUp)
    annotation (Line(points={{-78,200},{68,200},{68,9},{118,9}},
      color={255,0,255}));
  connect(not2.y, onOffStaUpMinFlo.uUpsDevSta)
    annotation (Line(points={{-78,170},{72,170},{72,7},{118,7}},
      color={255,0,255}));
  connect(haveOnOff.y, onOffStaUpMinFlo.uOnOff)
    annotation (Line(points={{-118,-60},{40,-60},{40,-7},{118,-7}},
      color={255,0,255}));
  connect(noStaCha.y, onOffStaUpMinFlo.uStaDow)
    annotation (Line(points={{-118,20},{0,20},{0,-9},{118,-9}},
      color={255,0,255}));
  connect(con.y, enaChi.u1)
    annotation (Line(points={{-118,120},{-100,120},{-100,108},{-42,108}},
      color={0,0,127}));
  connect(con1.y, disChi.u1)
    annotation (Line(points={{-118,-100},{-100,-100},{-100,-112},{-42,-112}},
      color={0,0,127}));
  connect(zer.y, enaChi.u3)
    annotation (Line(points={{-118,-180},{-64,-180},{-64,92},{-42,92}},
      color={0,0,127}));
  connect(zer.y, disChi.u3)
    annotation (Line(points={{-118,-180},{-64,-180},{-64,-128},{-42,-128}},
      color={0,0,127}));
  connect(enaChi.y, reaToInt.u)
    annotation (Line(points={{-18,100},{-2,100}}, color={0,0,127}));
  connect(disChi.y, reaToInt1.u)
    annotation (Line(points={{-18,-120},{-2,-120}}, color={0,0,127}));
  connect(zer.y, reaToInt2.u)
    annotation (Line(points={{-118,-180},{-60,-180},{-60,-180},{-2,-180}},
      color={0,0,127}));
  connect(chiSta.y, staUpMinFlo.uChi)
    annotation (Line(points={{-18,140},{80,140},{80,184},{118,184}},
      color={255,0,255}));
  connect(chiSta.y, onOffStaUpMinFlo.uChi)
    annotation (Line(points={{-18,140},{80,140},{80,4},{118,4}},
      color={255,0,255}));
  connect(chiSta.y, staDowMinFlo.uChi)
    annotation (Line(points={{-18,140},{80,140},{80,-156},{118,-156}},
      color={255,0,255}));
  connect(reaToInt.y, staUpMinFlo.nexEnaChi)
    annotation (Line(points={{22,100},{88,100},{88,181},{118,181}},
      color={255,127,0}));
  connect(reaToInt2.y, staUpMinFlo.nexDisChi)
    annotation (Line(points={{22,-180},{84,-180},{84,179},{118,179}},
      color={255,127,0}));
  connect(reaToInt2.y, staDowMinFlo.nexEnaChi)
    annotation (Line(points={{22,-180},{84,-180},{84,-159},{118,-159}},
      color={255,127,0}));
  connect(reaToInt1.y, staDowMinFlo.nexDisChi)
    annotation (Line(points={{22,-120},{88,-120},{88,-161},{118,-161}},
      color={255,127,0}));
  connect(reaToInt.y, onOffStaUpMinFlo.nexEnaChi)
    annotation (Line(points={{22,100},{88,100},{88,1},{118,1}},
      color={255,127,0}));
  connect(reaToInt1.y, onOffStaUpMinFlo.nexDisChi)
    annotation (Line(points={{22,-120},{88,-120},{88,-1},{118,-1}},
      color={255,127,0}));
  connect(enaNexChi.y, not3.u)
    annotation (Line(points={{-118,-20},{-102,-20}}, color={255,0,255}));
  connect(noOnOff.y, staUpMinFlo.uSubCha) annotation (Line(points={{-118,60},{
          76,60},{76,176},{118,176}}, color={255,0,255}));
  connect(noOnOff.y, staDowMinFlo.uSubCha) annotation (Line(points={{-118,60},{
          76,60},{76,-164},{118,-164}}, color={255,0,255}));
  connect(not3.y, onOffStaUpMinFlo.uSubCha) annotation (Line(points={{-78,-20},
          {20,-20},{20,-4},{118,-4}}, color={255,0,255}));

annotation (
 experiment(StopTime=4.0, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/MinimumFlowBypass/Subsequences/Validation/FlowSetpoint.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
March 28, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{160,
            220}})));
end FlowSetpoint;
