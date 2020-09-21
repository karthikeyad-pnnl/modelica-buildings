within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.Validation;
model HeadControl
  "Validate sequence of enabling and disabling head pressure control loop"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl
    enaHeaCon(
    final nChi=2)
    "Enable head pressure control after condenser water pump reset"
    annotation (Placement(transformation(extent={{-40,130},{-20,150}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl
    disHeaCon(
    final nChi=2,
    final thrTimEnb=0,
    final waiTim=0,
    final heaStaCha=false)
    "Disable head pressure control of smaller chiller when the stage-up requires large chiller on and small chiller off"
    annotation (Placement(transformation(extent={{60,130},{80,150}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl
    disHeaCon1(
    final nChi=2,
    final thrTimEnb=0,
    final waiTim=0,
    final heaStaCha=false)
    "Disable head pressure control of the chiller being disabled"
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl
    enaHeaCon1(
    final nChi=2,
    final thrTimEnb=0,
    final waiTim=30,
    final heaStaCha=true)
    "Disable head pressure control of smaller chiller when the stage-up requires large chiller on and small chiller off"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

protected
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(
    final width=0.15,
    final period=120) "Boolean pulse"
    annotation (Placement(transformation(extent={{-140,110},{-120,130}})));
  Buildings.Controls.OBC.CDL.Logical.Not staUp "Stage up command"
    annotation (Placement(transformation(extent={{-100,110},{-80,130}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul1(
    final width=0.20,
    final period=120) "Boolean pulse"
    annotation (Placement(transformation(extent={{-140,150},{-120,170}})));
  Buildings.Controls.OBC.CDL.Logical.Not upStrDev
    "Upstream device reset status"
    annotation (Placement(transformation(extent={{-100,150},{-80,170}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant chiOne(
    final k=true)
    "Operating chiller one"
    annotation (Placement(transformation(extent={{-100,20},{-80,40}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant enaChi(final k=2)
    "Enabling chiller index"
    annotation (Placement(transformation(extent={{-100,50},{-80,70}})));
  Buildings.Controls.OBC.CDL.Logical.Pre heaPreConRet
    "Return value of chiller head pressure control status"
    annotation (Placement(transformation(extent={{0,90},{20,110}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant disChi(final k=2)
    "Disabling small chiller"
    annotation (Placement(transformation(extent={{0,50},{20,70}})));
  Buildings.Controls.OBC.CDL.Logical.Pre heaPreConRet1
    "Return value of chiller head pressure control status"
    annotation (Placement(transformation(extent={{100,90},{120,110}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch chiTwo "Chiller two status"
    annotation (Placement(transformation(extent={{140,70},{160,90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul2(
    final width=0.15,
    final period=120) "Boolean pulse"
    annotation (Placement(transformation(extent={{-140,-110},{-120,-90}})));
  Buildings.Controls.OBC.CDL.Logical.Not staUp1 "Stage up command"
    annotation (Placement(transformation(extent={{-100,-110},{-80,-90}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul3(
    final width=0.20,
    final period=120) "Boolean pulse"
    annotation (Placement(transformation(extent={{-140,-70},{-120,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Not upStrDev1 "Upstream device reset status"
    annotation (Placement(transformation(extent={{-100,-70},{-80,-50}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant chiOne1(final k=true)
    "Operating chiller one"
    annotation (Placement(transformation(extent={{-100,-200},{-80,-180}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant disChi1(final k=2)
    "Disabling chiller index"
    annotation (Placement(transformation(extent={{-100,-170},{-80,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Pre heaPreConRet2
    "Return value of chiller head pressure control status"
    annotation (Placement(transformation(extent={{0,-130},{20,-110}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant enaChi1(
    final k=2) "Enabling small chiller"
    annotation (Placement(transformation(extent={{60,-130},{80,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Pre heaPreConRet3
    "Return value of chiller head pressure control status"
    annotation (Placement(transformation(extent={{140,-130},{160,-110}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch chiTwo1 "Chiller two status"
    annotation (Placement(transformation(extent={{40,-160},{60,-140}})));

equation
  connect(booPul.y, staUp.u)
    annotation (Line(points={{-118,120},{-102,120}}, color={255,0,255}));
  connect(booPul1.y, upStrDev.u)
    annotation (Line(points={{-118,160},{-102,160}}, color={255,0,255}));
  connect(upStrDev.y, enaHeaCon.uUpsDevSta)
    annotation (Line(points={{-78,160},{-60,160},{-60,148},{-42,148}},
      color={255,0,255}));
  connect(staUp.y, enaHeaCon.chaPro)
    annotation (Line(points={{-78,120},{-60,120},{-60,144},{-42,144}},
      color={255,0,255}));
  connect(enaChi.y, enaHeaCon.nexChaChi)
    annotation (Line(points={{-78,60},{-56,60},{-56,136},{-42,136}},
      color={255,127,0}));
  connect(chiOne.y, enaHeaCon.uChiHeaCon[1])
    annotation (Line(points={{-78,30},{-52,30},{-52,131},{-42,131}},
      color={255,0,255}));
  connect(enaHeaCon.yChiHeaCon[2], heaPreConRet.u) annotation (Line(points={{-18,
          135},{-10,135},{-10,100},{-2,100}}, color={255,0,255}));
  connect(heaPreConRet.y, enaHeaCon.uChiHeaCon[2]) annotation (Line(points={{22,
          100},{30,100},{30,84},{-48,84},{-48,133},{-42,133}}, color={255,0,255}));
  connect(upStrDev.y, disHeaCon.uUpsDevSta)
    annotation (Line(points={{-78,160},{40,160},{40,148},{58,148}},
      color={255,0,255}));
  connect(staUp.y, disHeaCon.chaPro)
    annotation (Line(points={{-78,120},{40,120},{40,144},{58,144}},
      color={255,0,255}));
  connect(disChi.y, disHeaCon.nexChaChi)
    annotation (Line(points={{22,60},{44,60},{44,136},{58,136}},
      color={255,127,0}));
  connect(chiOne.y, disHeaCon.uChiHeaCon[1])
    annotation (Line(points={{-78,30},{48,30},{48,131},{58,131}},
      color={255,0,255}));
  connect(disHeaCon.yChiHeaCon[2], heaPreConRet1.u) annotation (Line(points={{82,
          135},{90,135},{90,100},{98,100}}, color={255,0,255}));
  connect(staUp.y, chiTwo.u2)
    annotation (Line(points={{-78,120},{-60,120},{-60,80},{138,80}},
      color={255,0,255}));
  connect(heaPreConRet1.y, chiTwo.u1) annotation (Line(points={{122,100},{130,100},
          {130,88},{138,88}}, color={255,0,255}));
  connect(chiOne.y, chiTwo.u3)
    annotation (Line(points={{-78,30},{120,30},{120,72},{138,72}},
      color={255,0,255}));
  connect(chiTwo.y, disHeaCon.uChiHeaCon[2])
    annotation (Line(points={{162,80},{170,80},{170,60},{52,60},{52,133},
      {58,133}}, color={255,0,255}));
  connect(booPul2.y, staUp1.u)
    annotation (Line(points={{-118,-100},{-102,-100}}, color={255,0,255}));
  connect(booPul3.y, upStrDev1.u)
    annotation (Line(points={{-118,-60},{-102,-60}}, color={255,0,255}));
  connect(upStrDev1.y, disHeaCon1.uUpsDevSta)
    annotation (Line(points={{-78,-60},{-60,-60},{-60,-72},{-42,-72}},
      color={255,0,255}));
  connect(staUp1.y, disHeaCon1.chaPro)
    annotation (Line(points={{-78,-100},{-60,-100},{-60,-76},{-42,-76}},
      color={255,0,255}));
  connect(disChi1.y, disHeaCon1.nexChaChi)
    annotation (Line(points={{-78,-160},{-56,-160},{-56,-84},{-42,-84}},
      color={255,127,0}));
  connect(chiOne1.y, disHeaCon1.uChiHeaCon[1])
    annotation (Line(points={{-78,-190},{-52,-190},{-52,-89},{-42,-89}},
      color={255,0,255}));
  connect(disHeaCon1.yChiHeaCon[2], heaPreConRet2.u) annotation (Line(points={{-18,
          -85},{-10,-85},{-10,-120},{-2,-120}}, color={255,0,255}));
  connect(enaHeaCon1.yChiHeaCon[2], heaPreConRet3.u) annotation (Line(points={{122,
          -85},{130,-85},{130,-120},{138,-120}}, color={255,0,255}));
  connect(staUp1.y, chiTwo1.u2)
    annotation (Line(points={{-78,-100},{-60,-100},{-60,-150},{38,-150}},
      color={255,0,255}));
  connect(heaPreConRet2.y, chiTwo1.u1) annotation (Line(points={{22,-120},{30,-120},
          {30,-142},{38,-142}}, color={255,0,255}));
  connect(chiOne1.y, chiTwo1.u3)
    annotation (Line(points={{-78,-190},{-52,-190},{-52,-158},{38,-158}},
      color={255,0,255}));
  connect(chiTwo1.y, disHeaCon1.uChiHeaCon[2])
    annotation (Line(points={{62,-150},{70,-150},{70,-170},{-48,-170},
      {-48,-87},{-42,-87}}, color={255,0,255}));
  connect(upStrDev1.y, enaHeaCon1.uUpsDevSta)
    annotation (Line(points={{-78,-60},{80,-60},{80,-72},{98,-72}},
      color={255,0,255}));
  connect(staUp1.y, enaHeaCon1.chaPro)
    annotation (Line(points={{-78,-100},{80,-100},{80,-76},{98,-76}},
      color={255,0,255}));
  connect(enaChi1.y, enaHeaCon1.nexChaChi)
    annotation (Line(points={{82,-120},{84,-120},{84,-84},{98,-84}},
      color={255,127,0}));
  connect(chiOne1.y, enaHeaCon1.uChiHeaCon[1])
    annotation (Line(points={{-78,-190},{88,-190},{88,-89},{98,-89}},
      color={255,0,255}));
  connect(heaPreConRet3.y, enaHeaCon1.uChiHeaCon[2])
    annotation (Line(points={{162,-120},{170,-120},{170,-150},{92,-150},{92,-87},
      {98,-87}}, color={255,0,255}));

annotation (
 experiment(StopTime=120, Tolerance=1e-06),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/ChillerPlant/Staging/Processes/Subsequences/Validation/HeadControl.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
September 24, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"),
Icon(coordinateSystem(extent={{-100,-100},{100,100}}),
     graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}),Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-160,-220},{180,220}}),
        graphics={
        Text(
          extent={{-138,194},{-4,174}},
          lineColor={0,0,127},
          textString="enable head pressure control of the chiler being enabled."),
        Text(
          extent={{-140,202},{-52,186}},
          lineColor={0,0,127},
          textString="after resetting condenser water pump,"),
        Text(
          extent={{44,190},{124,176}},
          lineColor={0,0,127},
          textString="disable its head pressure control."),
        Text(
          extent={{44,200},{122,186}},
          lineColor={0,0,127},
          textString="after small chiller being shut off,"),
        Text(
          extent={{-140,210},{-92,200}},
          lineColor={0,0,127},
          textString="In stage up process,"),
        Text(
          extent={{44,210},{166,200}},
          lineColor={0,0,127},
          textString="In stage up process that requires chillers on and off,"),
        Text(
          extent={{-146,-8},{-98,-18}},
          lineColor={0,0,127},
          textString="In stage down process,"),
        Text(
          extent={{-146,-16},{-58,-32}},
          lineColor={0,0,127},
          textString="after the disabling chiller being shut off,"),
        Text(
          extent={{-146,-28},{-72,-38}},
          lineColor={0,0,127},
          textString="disable its head pressure control."),
        Text(
          extent={{42,-18},{120,-32}},
          lineColor={0,0,127},
          textString="after minimum bypass being reset,"),
        Text(
          extent={{42,-8},{164,-18}},
          lineColor={0,0,127},
          textString="In stage down process that requires chillers on and off,"),
        Text(
          extent={{44,-26},{174,-44}},
          lineColor={0,0,127},
          textString="enable head pressure control of the chiler being enabled.")}));
end HeadControl;
