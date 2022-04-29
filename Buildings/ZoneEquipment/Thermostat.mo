within Buildings.ZoneEquipment;
block Thermostat
  Controls.OBC.CDL.Interfaces.RealInput TZon
    annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
  Controls.OBC.CDL.Interfaces.RealInput TCooSet
    annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
  Controls.OBC.CDL.Interfaces.RealInput THeaSet
    annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
  Controls.OBC.CDL.Continuous.PID conPID(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=0.1,
    Ti=1200,                             reverseActing=false)
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Controls.OBC.CDL.Interfaces.RealOutput yCoo
    annotation (Placement(transformation(extent={{100,20},{140,60}})));
  Controls.OBC.CDL.Interfaces.RealOutput yHea
    annotation (Placement(transformation(extent={{100,-20},{140,20}})));
  Controls.OBC.CDL.Interfaces.RealOutput yFan
    annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
  Controls.OBC.CDL.Continuous.PID conPID1(
    controllerType=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    k=0.05,
    Ti=1200)
    annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
  Controls.OBC.CDL.Interfaces.RealInput PFan
    annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
  Controls.OBC.CDL.Continuous.Hysteresis hys(uLow=0.02, uHigh=0.05)
    annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
  Controls.OBC.CDL.Interfaces.RealInput TSup
    annotation (Placement(transformation(extent={{-140,-70},{-100,-30}})));
  Controls.OBC.ASHRAE.FanCoilUnit.Subsequences.SupplyAirTemperature TSupAir(
      have_coolingCoil=true, have_heatingCoil=true,
    controllerTypeCooCoi=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    kCooCoi=0.05,
    TiCooCoi=1200,
    controllerTypeHeaCoi=Buildings.Controls.OBC.CDL.Types.SimpleController.PI,
    kHeaCoi=0.01,
    TiHeaCoi=1200)
    annotation (Placement(transformation(extent={{0,58},{20,82}})));

  Controls.OBC.ASHRAE.FanCoilUnit.Subsequences.FanSpeed fanSpe(
    have_coolingCoil=true,
    have_heatingCoil=true,
    deaSpe=0.1,
    heaSpeMin=0.2,
    heaSpeMax=1,
    cooSpeMin=0.3)
    annotation (Placement(transformation(extent={{0,-72},{20,-52}})));
  Controls.OBC.CDL.Integers.Sources.Constant conInt(k=1)
    annotation (Placement(transformation(extent={{-52,70},{-32,90}})));
  Controls.OBC.CDL.Continuous.Product pro
    annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
  Controls.OBC.CDL.Conversions.BooleanToReal booToRea
    annotation (Placement(transformation(extent={{30,-50},{50,-30}})));
  Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{-40,-90},{-20,-70}})));
equation
  connect(TZon, conPID.u_m) annotation (Line(points={{-120,80},{-90,80},{-90,
          40},{-70,40},{-70,48}}, color={0,0,127}));
  connect(TZon, conPID1.u_m) annotation (Line(points={{-120,80},{-90,80},{
          -90,-46},{-70,-46},{-70,-42}},
                                     color={0,0,127}));
  connect(TCooSet, conPID.u_s) annotation (Line(points={{-120,20},{-86,20},{
          -86,60},{-82,60}}, color={0,0,127}));
  connect(THeaSet, conPID1.u_s) annotation (Line(points={{-120,-20},{-86,-20},
          {-86,-30},{-82,-30}}, color={0,0,127}));
  connect(PFan, hys.u)
    annotation (Line(points={{-120,-80},{-82,-80}}, color={0,0,127}));
  connect(TSup, TSupAir.TAirSup) annotation (Line(points={{-120,-50},{-6,
          -50},{-6,68},{-2,68}}, color={0,0,127}));
  connect(conPID1.y, TSupAir.uHea) annotation (Line(points={{-58,-30},{-20,
          -30},{-20,72},{-2,72}}, color={0,0,127}));
  connect(conPID.y, TSupAir.uCoo) annotation (Line(points={{-58,60},{-14,60},
          {-14,64},{-2,64}}, color={0,0,127}));
  connect(TCooSet, TSupAir.TZonSetCoo) annotation (Line(points={{-120,20},{
          -4,20},{-4,60},{-2,60}}, color={0,0,127}));
  connect(THeaSet, TSupAir.TZonSetHea) annotation (Line(points={{-120,-20},
          {-86,-20},{-86,0},{-24,0},{-24,76},{-2,76}}, color={0,0,127}));
  connect(TSupAir.yCooCoi, yCoo) annotation (Line(points={{22,64},{40,64},{
          40,40},{120,40}}, color={0,0,127}));
  connect(TSupAir.yHeaCoi, yHea) annotation (Line(points={{22,76},{50,76},{
          50,0},{120,0}}, color={0,0,127}));
  connect(conPID1.y, fanSpe.uHea) annotation (Line(points={{-58,-30},{-20,
          -30},{-20,-64},{-2,-64}}, color={0,0,127}));
  connect(conPID.y, fanSpe.uCoo) annotation (Line(points={{-58,60},{-14,60},
          {-14,-68},{-2,-68}}, color={0,0,127}));
  connect(conInt.y, fanSpe.opeMod) annotation (Line(points={{-30,80},{-28,
          80},{-28,-54},{-2,-54}}, color={255,127,0}));
  connect(fanSpe.yFanSpe, pro.u2) annotation (Line(points={{22,-64},{40,-64},
          {40,-66},{58,-66}}, color={0,0,127}));
  connect(fanSpe.yFan, booToRea.u) annotation (Line(points={{22,-60},{26,
          -60},{26,-40},{28,-40}}, color={255,0,255}));
  connect(booToRea.y, pro.u1) annotation (Line(points={{52,-40},{54,-40},{
          54,-54},{58,-54}}, color={0,0,127}));
  connect(pro.y, yFan) annotation (Line(points={{82,-60},{90,-60},{90,-40},
          {120,-40}}, color={0,0,127}));
  connect(hys.y, pre.u)
    annotation (Line(points={{-58,-80},{-42,-80}}, color={255,0,255}));
  connect(pre.y, fanSpe.uFanPro) annotation (Line(points={{-18,-80},{-10,
          -80},{-10,-58},{-2,-58}}, color={255,0,255}));
  connect(pre.y, TSupAir.uFan) annotation (Line(points={{-18,-80},{-10,-80},
          {-10,80},{-2,80}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)));
end Thermostat;
