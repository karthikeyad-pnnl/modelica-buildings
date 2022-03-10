within Buildings;
package Trial

  package Old

    partial model Baseclass_externalInterfaces2
      extends Buildings.Trial.Baseclass_externalInterfaces;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Baseclass_externalInterfaces2;

    partial model Baseclass_componentInterfaces2

      parameter Boolean has_economizer
        "Does the zone equipment have an economizer?";

      parameter Boolean has_coolingCoil
        "Does the zone equipment have a cooling coil?";

      parameter Boolean has_coolingCoilCCW
        "Does the zone equipment have a chilled water cooling coil?";

      parameter Boolean has_heatingCoil
        "Does the zone equipment have a heating coil?";

      parameter Boolean has_heatingCoilHHW
        "Does the zone equipment have a hot water heating coil?";

      parameter Real mAir_flow_nominal
        "Nominal air flow rate";

      parameter Real mHHW_flow_nominal
        "Nominal HHW flow rate";

      parameter Real mCCW_flow_nominal
        "Nominal CCW flow rate";

      extends Buildings.Trial.Baseclass_externalInterfaces;

      Fluid.Actuators.Dampers.MixingBox eco(
        redeclare package Medium = MediumA,
        mOut_flow_nominal=mAir_flow_nominal,
        dpDamOut_nominal=50,
        mRec_flow_nominal=mAir_flow_nominal,
        dpDamRec_nominal=50,
        mExh_flow_nominal=mAir_flow_nominal,
        dpDamExh_nominal=50) if                has_economizer
        annotation (Placement(transformation(extent={{-166,0},{-146,20}})));
      Fluid.Sensors.VolumeFlowRate senVolFlo2(redeclare package Medium = MediumA,
                                              m_flow_nominal=mAir_flow_nominal) if
                                                 has_economizer
        annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));
      Fluid.Sensors.TemperatureTwoPort senTem2(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal)
        annotation (Placement(transformation(extent={{-140,-50},{-120,-30}})));
      replaceable Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed coolingCoil_DX(
          redeclare package Medium = MediumA, dp_nominal=50) if
        has_coolingCoil and not has_coolingCoilCCW
        annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
      replaceable Buildings.Fluid.HeatExchangers.HeaterCooler_u heatingCoil_electric(
          redeclare package Medium = MediumA, m_flow_nominal=mAir_flow_nominal,
        dp_nominal=50) if
        has_heatingCoil and not has_heatingCoilHHW
        annotation (Placement(transformation(extent={{-50,-50},{-30,-30}})));
      Fluid.Movers.FlowControlled_m_flow fan(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal,
        dp_nominal=1000)
        annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
      replaceable Fluid.HeatExchangers.DryCoilCounterFlow heatingCoil_HHW(
        redeclare package Medium1 = MediumW,
        redeclare package Medium2 = MediumA,
        m1_flow_nominal=mHHW_flow_nominal,
        m2_flow_nominal=mAir_flow_nominal,
        dp1_nominal=50,
        dp2_nominal=50,
        UA_nominal=1000) if
        has_heatingCoil and has_heatingCoilHHW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={-40,0})));
      replaceable Fluid.HeatExchangers.WetCoilCounterFlow coolingCoil_CCW(
        redeclare package Medium1 = MediumW,
        redeclare package Medium2 = MediumA,
        m1_flow_nominal=mCCW_flow_nominal,
        m2_flow_nominal=mAir_flow_nominal,
        dp1_nominal=50,
        dp2_nominal=50,
        UA_nominal=1000) if
        has_coolingCoil and has_coolingCoilCCW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={70,0})));
      Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium = MediumW,
        m_flow_nominal=mCCW_flow_nominal,
        dpValve_nominal=50) if                   has_coolingCoil and
        has_coolingCoilCCW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={90,-110})));
      Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium = MediumW,
        m_flow_nominal=mHHW_flow_nominal,
        dpValve_nominal=50) if                    has_heatingCoil and
        has_heatingCoilHHW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={-20,-110})));
      Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal)
        annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
      Fluid.Sensors.TemperatureTwoPort senTem1(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal)
        annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
      Fluid.Sensors.VolumeFlowRate senVolFlo(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal)
        annotation (Placement(transformation(extent={{180,-50},{200,-30}})));
      Fluid.Sensors.VolumeFlowRate senVolFlo1(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={180,40})));
      Fluid.FixedResistances.LosslessPipe pip(redeclare package Medium = MediumA,
          m_flow_nominal=mAir_flow_nominal) if   not has_economizer
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={-110,60})));
      Controls.OBC.CDL.Interfaces.RealOutput TMixAir
        annotation (Placement(transformation(extent={{220,180},{260,220}})));
      Controls.OBC.CDL.Interfaces.RealOutput THeaAir
        annotation (Placement(transformation(extent={{220,140},{260,180}})));
      Controls.OBC.CDL.Interfaces.RealOutput TDisAir
        annotation (Placement(transformation(extent={{220,100},{260,140}})));
      Controls.OBC.CDL.Interfaces.RealOutput VDisAir_nominal
        annotation (Placement(transformation(extent={{220,-180},{260,-140}})));
      Controls.OBC.CDL.Interfaces.RealOutput VRetAir_nominal
        annotation (Placement(transformation(extent={{220,-140},{260,-100}})));
      Controls.OBC.CDL.Interfaces.RealOutput VOA_nominal if has_economizer
        annotation (Placement(transformation(extent={{220,-100},{260,-60}})));
      Controls.OBC.CDL.Interfaces.RealInput uFan
        annotation (Placement(transformation(extent={{-260,160},{-220,200}})));
      Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
        annotation (Placement(transformation(extent={{-260,120},{-220,160}})));
      Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
        annotation (Placement(transformation(extent={{-260,80},{-220,120}})));
      Controls.OBC.CDL.Interfaces.RealInput uOA if has_economizer
        annotation (Placement(transformation(extent={{-260,40},{-220,80}})));
      BoundaryConditions.WeatherData.Bus weaBus if has_coolingCoil and not
        has_coolingCoilCCW                      annotation (Placement(
            transformation(extent={{-210,180},{-170,220}}), iconTransformation(
              extent={{-466,-14},{-446,6}})));
      Controls.OBC.CDL.Interfaces.RealOutput QHeaCoi if has_heatingCoil
        annotation (Placement(transformation(extent={{220,-260},{260,-220}})));
      Controls.OBC.CDL.Interfaces.RealOutput QCooCoi if has_coolingCoil
        annotation (Placement(transformation(extent={{220,-220},{260,-180}})));
      Controls.OBC.CDL.Interfaces.RealOutput PFan
        annotation (Placement(transformation(extent={{220,220},{260,260}})));
      Fluid.Sensors.VolumeFlowRate senVolFlo3(redeclare package Medium = MediumW,
          m_flow_nominal=mHHW_flow_nominal) if has_heatingCoil and
        has_heatingCoilHHW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={-40,-180})));
      Fluid.Sensors.VolumeFlowRate senVolFlo4(redeclare package Medium = MediumW,
          m_flow_nominal=mCCW_flow_nominal) if has_coolingCoil and
        has_coolingCoilCCW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={80,-180})));
      Buildings.Trial.PowerCalculation powerCalculation if
                                           has_coolingCoil and has_coolingCoilCCW
        annotation (Placement(transformation(extent={{160,-190},{180,-170}})));
      Fluid.Sensors.TemperatureTwoPort senTem3(redeclare package Medium = MediumW,
          m_flow_nominal=mCCW_flow_nominal) if has_coolingCoil and
        has_coolingCoilCCW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={80,-220})));
      Fluid.Sensors.TemperatureTwoPort senTem4(redeclare package Medium = MediumW,
          m_flow_nominal=mHHW_flow_nominal) if has_heatingCoil and
        has_heatingCoilHHW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={-40,-220})));
      Fluid.Sensors.TemperatureTwoPort senTem5(redeclare package Medium = MediumW,
          m_flow_nominal=mHHW_flow_nominal) if has_heatingCoil and
        has_heatingCoilHHW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
            origin={-80,-200})));
      Fluid.Sensors.TemperatureTwoPort senTem6(redeclare package Medium = MediumW,
          m_flow_nominal=mCCW_flow_nominal) if has_coolingCoil and
        has_coolingCoilCCW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=270,
            origin={50,-200})));
      Buildings.Trial.PowerCalculation powerCalculation1 if
                                            has_heatingCoil and
        has_heatingCoilHHW
        annotation (Placement(transformation(extent={{0,-190},{20,-170}})));
    equation
      connect(senVolFlo1.port_b, eco.port_Ret) annotation (Line(points={{170,40},{-134,
              40},{-134,4},{-146,4}}, color={0,127,255}));
      connect(port_OA_inlet, senVolFlo2.port_a)
        annotation (Line(points={{-220,-40},{-200,-40}}, color={0,127,255}));
      connect(senVolFlo2.port_b, eco.port_Out) annotation (Line(points={{-180,-40},{
              -170,-40},{-170,16},{-166,16}}, color={0,127,255}));
      connect(port_OA_exhaust, eco.port_Exh) annotation (Line(points={{-220,40},{-180,
              40},{-180,4},{-166,4}}, color={0,127,255}));
      connect(eco.port_Sup, senTem2.port_a) annotation (Line(points={{-146,16},{-140,
              16},{-140,-40}}, color={0,127,255}));
      connect(val1.port_b,heatingCoil_HHW. port_a1)
        annotation (Line(points={{-20,-100},{-20,-6},{-30,-6}},
                                                            color={0,127,255}));
      connect(val.port_b,coolingCoil_CCW. port_a1) annotation (Line(points={{90,-100},
              {90,-6},{80,-6}},        color={0,127,255}));
      connect(fan.port_b,heatingCoil_electric. port_a)
        annotation (Line(points={{-80,-40},{-50,-40}},  color={0,127,255}));
      connect(fan.port_b,heatingCoil_HHW. port_a2) annotation (Line(points={{-80,-40},
              {-70,-40},{-70,6},{-50,6}}, color={0,127,255}));
      connect(heatingCoil_HHW.port_b2,senTem. port_a) annotation (Line(points={{-30,6},
              {-10,6},{-10,-40},{0,-40}},      color={0,127,255}));
      connect(heatingCoil_electric.port_b,senTem. port_a)
        annotation (Line(points={{-30,-40},{0,-40}},   color={0,127,255}));
      connect(senTem.port_b,coolingCoil_CCW. port_a2) annotation (Line(points={{20,-40},
              {40,-40},{40,6},{60,6}}, color={0,127,255}));
      connect(senTem.port_b,coolingCoil_DX. port_a)
        annotation (Line(points={{20,-40},{60,-40}}, color={0,127,255}));
      connect(coolingCoil_CCW.port_b2,senTem1. port_a) annotation (Line(points={{80,6},{
              110,6},{110,-40},{150,-40}},     color={0,127,255}));
      connect(coolingCoil_DX.port_b,senTem1. port_a)
        annotation (Line(points={{80,-40},{150,-40}}, color={0,127,255}));
      connect(senTem1.port_b,senVolFlo. port_a)
        annotation (Line(points={{170,-40},{180,-40}}, color={0,127,255}));
      connect(senVolFlo.port_b, port_supply)
        annotation (Line(points={{200,-40},{220,-40}}, color={0,127,255}));
      connect(senVolFlo1.port_a, port_return)
        annotation (Line(points={{190,40},{220,40}}, color={0,127,255}));
      connect(senTem2.port_b, fan.port_a)
        annotation (Line(points={{-120,-40},{-100,-40}}, color={0,127,255}));
      connect(senVolFlo1.port_b, pip.port_a) annotation (Line(points={{170,40},{-94,
              40},{-94,60},{-100,60}}, color={0,127,255}));
      connect(pip.port_b, senTem2.port_a) annotation (Line(points={{-120,60},{-140,60},
              {-140,-40}}, color={0,127,255}));
      connect(senTem2.T, TMixAir) annotation (Line(points={{-130,-29},{-130,200},{240,
              200}}, color={0,0,127}));
      connect(senTem.T, THeaAir)
        annotation (Line(points={{10,-29},{10,160},{240,160}}, color={0,0,127}));
      connect(senTem1.T, TDisAir)
        annotation (Line(points={{160,-29},{160,120},{240,120}}, color={0,0,127}));
      connect(senVolFlo2.V_flow, VOA_nominal) annotation (Line(points={{-190,-29},{-190,
              -20},{-160,-20},{-160,-80},{240,-80}},   color={0,0,127}));
      connect(senVolFlo.V_flow, VDisAir_nominal) annotation (Line(points={{190,-29},
              {190,-20},{206,-20},{206,-160},{240,-160}}, color={0,0,127}));
      connect(senVolFlo1.V_flow, VRetAir_nominal) annotation (Line(points={{180,29},
              {180,20},{174,20},{174,-120},{240,-120}}, color={0,0,127}));
      connect(uFan, fan.m_flow_in) annotation (Line(points={{-240,180},{-90,180},{-90,
              -28}}, color={0,0,127}));
      connect(uOA, eco.y)
        annotation (Line(points={{-240,60},{-156,60},{-156,22}}, color={0,0,127}));
      connect(weaBus.TDryBul, coolingCoil_DX.TConIn) annotation (Line(
          points={{-190,200},{-170,200},{-170,188},{46,188},{46,-37},{59,-37}},
          color={255,204,51},
          thickness=0.5), Text(
          string="%first",
          index=-1,
          extent={{-6,3},{-6,3}},
          horizontalAlignment=TextAlignment.Right));
      connect(uCoo, coolingCoil_DX.speRat) annotation (Line(points={{-240,140},{30,140},
              {30,-32},{59,-32}}, color={0,0,127}));
      connect(uCoo, val.y) annotation (Line(points={{-240,140},{30,140},{30,-110},{78,
              -110}},color={0,0,127}));
      connect(uHea, heatingCoil_electric.u) annotation (Line(points={{-240,100},{-66,
              100},{-66,-34},{-52,-34}}, color={0,0,127}));
      connect(uHea, val1.y) annotation (Line(points={{-240,100},{-66,100},{-66,-110},
              {-32,-110}},color={0,0,127}));
      connect(heatingCoil_electric.Q_flow, QHeaCoi) annotation (Line(points={{-29,-34},
              {-4,-34},{-4,-240},{240,-240}}, color={0,0,127}));
      connect(senVolFlo3.port_b, val1.port_a) annotation (Line(points={{-40,-170},{-40,
              -140},{-20,-140},{-20,-120}}, color={0,127,255}));
      connect(senVolFlo4.port_b, val.port_a) annotation (Line(points={{80,-170},{80,
              -140},{90,-140},{90,-120}}, color={0,127,255}));
      connect(coolingCoil_DX.P,QCooCoi)  annotation (Line(points={{81,-31},{100,-31},
              {100,-200},{240,-200}}, color={0,0,127}));
      connect(port_CCW_inlet, senTem3.port_a)
        annotation (Line(points={{80,-260},{80,-230}}, color={0,127,255}));
      connect(senTem3.port_b, senVolFlo4.port_a)
        annotation (Line(points={{80,-210},{80,-190}}, color={0,127,255}));
      connect(port_HHW_inlet, senTem4.port_a)
        annotation (Line(points={{-40,-260},{-40,-230}}, color={0,127,255}));
      connect(senTem4.port_b, senVolFlo3.port_a)
        annotation (Line(points={{-40,-210},{-40,-190}}, color={0,127,255}));
      connect(port_HHW_outlet, senTem5.port_b)
        annotation (Line(points={{-80,-260},{-80,-210}}, color={0,127,255}));
      connect(senTem5.port_a, heatingCoil_HHW.port_b1) annotation (Line(points={{
              -80,-190},{-80,-140},{-60,-140},{-60,-6},{-50,-6}}, color={0,127,
              255}));
      connect(coolingCoil_CCW.port_b1, senTem6.port_a)
        annotation (Line(points={{60,-6},{50,-6},{50,-190}}, color={0,127,255}));
      connect(senTem6.port_b, port_CCW_outlet) annotation (Line(points={{50,-210},
              {50,-260},{40,-260}}, color={0,127,255}));
      connect(senVolFlo4.V_flow, powerCalculation.V_flow) annotation (Line(points=
             {{69,-180},{68,-180},{68,-194},{120,-194},{120,-184},{158,-184}},
            color={0,0,127}));
      connect(senTem3.T, powerCalculation.TIn) annotation (Line(points={{69,-220},
              {64,-220},{64,-160},{120,-160},{120,-176},{158,-176}}, color={0,0,
              127}));
      connect(senTem6.T, powerCalculation.TOut) annotation (Line(points={{61,-200},
              {64,-200},{64,-160},{120,-160},{120,-180},{158,-180}}, color={0,0,
              127}));
      connect(powerCalculation.yP, QCooCoi) annotation (Line(points={{182,-180},{
              200,-180},{200,-200},{240,-200}}, color={0,0,127}));
      connect(senVolFlo3.V_flow, powerCalculation1.V_flow) annotation (Line(
            points={{-51,-180},{-56,-180},{-56,-200},{-20,-200},{-20,-184},{-2,
              -184}}, color={0,0,127}));
      connect(senTem4.T, powerCalculation1.TIn) annotation (Line(points={{-51,
              -220},{-60,-220},{-60,-160},{-20,-160},{-20,-176},{-2,-176}}, color=
             {0,0,127}));
      connect(senTem5.T, powerCalculation1.TOut) annotation (Line(points={{-69,
              -200},{-64,-200},{-64,-156},{-16,-156},{-16,-180},{-2,-180}}, color=
             {0,0,127}));
      connect(powerCalculation1.yP, QHeaCoi) annotation (Line(points={{22,-180},{
              28,-180},{28,-240},{240,-240}}, color={0,0,127}));
      connect(fan.P, PFan) annotation (Line(points={{-79,-31},{-76,-31},{-76,240},
              {240,240}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},
                {220,260}})),                                        Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{220,260}})));
    end Baseclass_componentInterfaces2;

    partial model Baseclass_componentInterfaces1
      extends Buildings.Trial.Baseclass_externalInterfaces;
      replaceable Fluid.Interfaces.PartialTwoPortInterface coolingCoil_DX
        annotation (Placement(transformation(extent={{52,-50},{72,-30}})));
      replaceable Fluid.Interfaces.PartialTwoPortInterface heatingCoil_electric
        annotation (Placement(transformation(extent={{-62,-50},{-42,-30}})));
      Fluid.Movers.FlowControlled_m_flow fan
        annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
      replaceable Fluid.HeatExchangers.DryCoilCounterFlow heatingCoil_HHW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={-52,0})));
      replaceable Fluid.HeatExchangers.WetCoilCounterFlow coolingCoil_CCW
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={62,0})));
      Fluid.Actuators.Valves.TwoWayLinear val
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={80,-80})));
      Fluid.Actuators.Valves.TwoWayLinear val1
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
            origin={-32,-80})));
      Fluid.Sensors.TemperatureTwoPort senTem
        annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
      Fluid.Sensors.TemperatureTwoPort senTem1
        annotation (Placement(transformation(extent={{140,-50},{160,-30}})));
      Fluid.Sensors.VolumeFlowRate senVolFlo
        annotation (Placement(transformation(extent={{170,-50},{190,-30}})));
      Fluid.Sensors.VolumeFlowRate senVolFlo1
        annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
            origin={170,40})));
    equation
      connect(coolingCoil_CCW.port_b1, port_CCW_outlet) annotation (Line(points={{52,-6},
              {40,-6},{40,-220}},                             color={0,127,255}));
      connect(port_HHW_outlet, heatingCoil_HHW.port_b1)
        annotation (Line(points={{-80,-220},{-80,-120},{-72,-120},{-72,-6},{-62,-6}},
                                                             color={0,127,255}));
      connect(port_HHW_inlet, val1.port_a)
        annotation (Line(points={{-40,-220},{-40,-90},{-32,-90}},
                                                      color={0,127,255}));
      connect(val1.port_b, heatingCoil_HHW.port_a1)
        annotation (Line(points={{-32,-70},{-32,-6},{-42,-6}},
                                                            color={0,127,255}));
      connect(port_CCW_inlet, val.port_a) annotation (Line(points={{80,-220},{80,-90}},
                                               color={0,127,255}));
      connect(val.port_b, coolingCoil_CCW.port_a1) annotation (Line(points={{80,-70},
              {80,-6},{72,-6}},        color={0,127,255}));
      connect(fan.port_b, heatingCoil_electric.port_a)
        annotation (Line(points={{-90,-40},{-62,-40}},  color={0,127,255}));
      connect(fan.port_b, heatingCoil_HHW.port_a2) annotation (Line(points={{-90,-40},
              {-80,-40},{-80,6},{-62,6}}, color={0,127,255}));
      connect(heatingCoil_HHW.port_b2, senTem.port_a) annotation (Line(points={{-42,
              6},{-20,6},{-20,-40},{-10,-40}}, color={0,127,255}));
      connect(heatingCoil_electric.port_b, senTem.port_a)
        annotation (Line(points={{-42,-40},{-10,-40}}, color={0,127,255}));
      connect(senTem.port_b, coolingCoil_CCW.port_a2) annotation (Line(points={{10,-40},
              {30,-40},{30,6},{52,6}}, color={0,127,255}));
      connect(senTem.port_b, coolingCoil_DX.port_a)
        annotation (Line(points={{10,-40},{52,-40}}, color={0,127,255}));
      connect(coolingCoil_CCW.port_b2, senTem1.port_a) annotation (Line(points={{72,
              6},{100,6},{100,-40},{140,-40}}, color={0,127,255}));
      connect(coolingCoil_DX.port_b, senTem1.port_a)
        annotation (Line(points={{72,-40},{140,-40}}, color={0,127,255}));
      connect(senTem1.port_b, senVolFlo.port_a)
        annotation (Line(points={{160,-40},{170,-40}}, color={0,127,255}));
      connect(senVolFlo.port_b, port_supply)
        annotation (Line(points={{190,-40},{220,-40}}, color={0,127,255}));
      connect(senVolFlo1.port_a, port_return)
        annotation (Line(points={{180,40},{220,40}}, color={0,127,255}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Baseclass_componentInterfaces1;

    block trialComponent
      extends Buildings.Trial.Old.Baseclass_componentInterfaces2;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end trialComponent;

    block use_case

      replaceable package MediumA = Buildings.Media.Air
        constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
      replaceable package MediumW = Buildings.Media.Water "Medium model for water";

      Old.trialComponent triCom(
        has_economizer=false,
        has_coolingCoil=true,
        has_coolingCoilCCW=true,
        has_heatingCoil=true,
        has_heatingCoilHHW=true,
        mAir_flow_nominal=1,
        mHHW_flow_nominal=1,
        mCCW_flow_nominal=1)
        annotation (Placement(transformation(extent={{-84,-44},{-40,0}})));
      Controls.OBC.CDL.Continuous.Sources.Constant con(k=0.5)
        annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
      Fluid.Sources.Boundary_pT sinCoo(
        redeclare package Medium = MediumW,
        p=300000,
        T=279.15,
        nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-50,-80})));
      Fluid.Sources.Boundary_pT souCoo(
        redeclare package Medium = MediumW,
        p(displayUnit="Pa") = 300000 + 6000,
        T=279.15,
        nPorts=1) "Source for cooling coil loop" annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-20,-80})));
      Fluid.Sources.Boundary_pT sinHea(
        redeclare package Medium = MediumW,
        p=300000,
        T=318.15,
        nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-110,-80})));
      Fluid.Sources.Boundary_pT souHea(
        redeclare package Medium = MediumW,
        p(displayUnit="Pa") = 300000 + 6000,
        use_T_in=true,
        T=318.15,
        nPorts=1) "Source for heating coil" annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-80,-80})));
      ThermalZones.EnergyPlus.ThermalZone           zon(
        zoneName="LIVING ZONE",
        redeclare package Medium = MediumA,
        nPorts=2)
        "Thermal zone"
        annotation (Placement(transformation(extent={{-30,20},{10,60}})));
      inner ThermalZones.EnergyPlus.Building           building(
        idfName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/Data/ThermalZones/EnergyPlus/Examples/SingleFamilyHouse_TwoSpeed_ZoneAirBalance/SingleFamilyHouse_TwoSpeed_ZoneAirBalance.idf"),
        epwName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.epw"),
        weaName=Modelica.Utilities.Files.loadResource("./Buildings/Resources/weatherdata/USA_IL_Chicago-OHare.Intl.AP.725300_TMY3.mos"),
        usePrecompiledFMU=false,
        computeWetBulbTemperature=false)
        "Building model"
        annotation (Placement(transformation(extent={{-140,-40},{-120,-20}})));

      Controls.OBC.CDL.Routing.RealScalarReplicator reaScaRep(nout=3)
        annotation (Placement(transformation(extent={{-100,30},{-80,50}})));
      Thermostat thermostat
        annotation (Placement(transformation(extent={{42,-10},{62,10}})));
      Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15 + 25)
        annotation (Placement(transformation(extent={{10,-10},{30,10}})));
      Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 23)
        annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
    equation
      connect(souCoo.ports[1], triCom.port_CCW_inlet) annotation (Line(points={{-20,-70},
              {-20,-60},{-54,-60},{-54,-44}},
                                         color={0,127,255}));
      connect(sinCoo.ports[1], triCom.port_CCW_outlet) annotation (Line(points={{-50,-70},
              {-50,-64},{-58,-64},{-58,-44}}, color={0,127,255}));
      connect(souHea.ports[1], triCom.port_HHW_inlet) annotation (Line(points={{-80,-70},
              {-80,-60},{-66,-60},{-66,-44}},    color={0,127,255}));
      connect(sinHea.ports[1], triCom.port_HHW_outlet) annotation (Line(points={{-110,
              -70},{-110,-54},{-70,-54},{-70,-44}},color={0,127,255}));
      connect(triCom.port_return, zon.ports[1])
        annotation (Line(points={{-40,-18.6154},{-12,-18.6154},{-12,20.9}},
                                                           color={0,127,255}));
      connect(triCom.port_supply, zon.ports[2])
        annotation (Line(points={{-40,-25.3846},{-8,-25.3846},{-8,20.9}},
                                                             color={0,127,255}));
      connect(con.y, reaScaRep.u) annotation (Line(points={{-118,20},{-110,20},{
              -110,40},{-102,40}},
                         color={0,0,127}));
      connect(reaScaRep.y, zon.qGai_flow) annotation (Line(points={{-78,40},{-50,
              40},{-50,50},{-32,50}},
                                color={0,0,127}));
      connect(zon.TAir, thermostat.TZon) annotation (Line(points={{11,58},{32,58},
              {32,8},{40,8}}, color={0,0,127}));
      connect(con1.y, thermostat.TCooSet)
        annotation (Line(points={{32,0},{34,0},{34,2},{40,2}}, color={0,0,127}));
      connect(con2.y, thermostat.THeaSet) annotation (Line(points={{32,-40},{36,
              -40},{36,-2},{40,-2}}, color={0,0,127}));
      connect(triCom.PFan, thermostat.PFan) annotation (Line(points={{-38,
              -1.69231},{-30,-1.69231},{-30,-2},{-20,-2},{-20,16},{38,16},{38,-8},
              {40,-8}}, color={0,0,127}));
      connect(thermostat.yCoo, triCom.uCoo) annotation (Line(points={{64,4},{72,4},
              {72,18},{-92,18},{-92,-10.1538},{-86,-10.1538}}, color={0,0,127}));
      connect(thermostat.yHea, triCom.uHea) annotation (Line(points={{64,0},{72,0},
              {72,-58},{-92,-58},{-92,-13.5385},{-86,-13.5385}}, color={0,0,127}));
      connect(thermostat.yFan, triCom.uFan) annotation (Line(points={{64,-4},{76,
              -4},{76,-62},{-96,-62},{-96,-6.76923},{-86,-6.76923}}, color={0,0,
              127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
                -160},{160,160}})),                                  Diagram(
            coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
                160}})),
        experiment(StopTime=3600, __Dymola_Algorithm="Dassl"));
    end use_case;

    block Thermostat
      Controls.OBC.CDL.Interfaces.RealInput TZon
        annotation (Placement(transformation(extent={{-140,60},{-100,100}})));
      Controls.OBC.CDL.Interfaces.RealInput TCooSet
        annotation (Placement(transformation(extent={{-140,0},{-100,40}})));
      Controls.OBC.CDL.Interfaces.RealInput THeaSet
        annotation (Placement(transformation(extent={{-140,-40},{-100,0}})));
      Controls.OBC.CDL.Continuous.PID conPID(reverseActing=false)
        annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
      Controls.OBC.CDL.Interfaces.RealOutput yCoo
        annotation (Placement(transformation(extent={{100,20},{140,60}})));
      Controls.OBC.CDL.Interfaces.RealOutput yHea
        annotation (Placement(transformation(extent={{100,-20},{140,20}})));
      Controls.OBC.CDL.Interfaces.RealOutput yFan
        annotation (Placement(transformation(extent={{100,-60},{140,-20}})));
      Controls.OBC.CDL.Continuous.PID conPID1
        annotation (Placement(transformation(extent={{-80,-40},{-60,-20}})));
      Controls.OBC.CDL.Interfaces.RealInput PFan
        annotation (Placement(transformation(extent={{-140,-100},{-100,-60}})));
      Controls.OBC.CDL.Continuous.Hysteresis hys(uLow=0.02, uHigh=0.05)
        annotation (Placement(transformation(extent={{-80,-90},{-60,-70}})));
      Controls.OBC.CDL.Conversions.BooleanToReal booToRea
        annotation (Placement(transformation(extent={{-50,-90},{-30,-70}})));
      Controls.OBC.CDL.Continuous.Product pro
        annotation (Placement(transformation(extent={{40,30},{60,50}})));
      Controls.OBC.CDL.Continuous.Product pro1
        annotation (Placement(transformation(extent={{40,-10},{60,10}})));
      Controls.OBC.CDL.Continuous.Hysteresis hys1[2](uLow=0.08, uHigh=0.1)
        annotation (Placement(transformation(extent={{10,-70},{30,-50}})));
      Controls.OBC.CDL.Logical.MultiOr mulOr(nin=2)
        annotation (Placement(transformation(extent={{42,-70},{62,-50}})));
      Controls.OBC.CDL.Conversions.BooleanToReal booToRea1
        annotation (Placement(transformation(extent={{70,-70},{90,-50}})));
    equation
      connect(TZon, conPID.u_m) annotation (Line(points={{-120,80},{-90,80},{-90,
              40},{-70,40},{-70,48}}, color={0,0,127}));
      connect(TZon, conPID1.u_m) annotation (Line(points={{-120,80},{-90,80},{-90,
              -50},{-70,-50},{-70,-42}}, color={0,0,127}));
      connect(TCooSet, conPID.u_s) annotation (Line(points={{-120,20},{-86,20},{
              -86,60},{-82,60}}, color={0,0,127}));
      connect(THeaSet, conPID1.u_s) annotation (Line(points={{-120,-20},{-86,-20},
              {-86,-30},{-82,-30}}, color={0,0,127}));
      connect(PFan, hys.u)
        annotation (Line(points={{-120,-80},{-82,-80}}, color={0,0,127}));
      connect(hys.y, booToRea.u)
        annotation (Line(points={{-58,-80},{-52,-80}}, color={255,0,255}));
      connect(pro1.y, yHea)
        annotation (Line(points={{62,0},{120,0}}, color={0,0,127}));
      connect(pro.y, yCoo)
        annotation (Line(points={{62,40},{120,40}}, color={0,0,127}));
      connect(conPID.y, pro.u1) annotation (Line(points={{-58,60},{20,60},{20,46},
              {38,46}}, color={0,0,127}));
      connect(booToRea.y, pro.u2) annotation (Line(points={{-28,-80},{0,-80},{0,
              34},{38,34}}, color={0,0,127}));
      connect(conPID1.y, pro1.u2) annotation (Line(points={{-58,-30},{20,-30},{20,
              -6},{38,-6}}, color={0,0,127}));
      connect(booToRea.y, pro1.u1) annotation (Line(points={{-28,-80},{0,-80},{0,
              6},{38,6}}, color={0,0,127}));
      connect(conPID.y, hys1[1].u) annotation (Line(points={{-58,60},{-20,60},{
              -20,-60},{8,-60}}, color={0,0,127}));
      connect(conPID1.y, hys1[2].u) annotation (Line(points={{-58,-30},{-20,-30},
              {-20,-60},{8,-60}}, color={0,0,127}));
      connect(hys1.y, mulOr.u[1:2]) annotation (Line(points={{32,-60},{36,-60},{
              36,-63.5},{40,-63.5}}, color={255,0,255}));
      connect(mulOr.y, booToRea1.u)
        annotation (Line(points={{64,-60},{68,-60}}, color={255,0,255}));
      connect(booToRea1.y, yFan) annotation (Line(points={{92,-60},{98,-60},{98,
              -40},{120,-40}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)));
    end Thermostat;
  end Old;

  partial model heatingCoil_HHW
    extends Buildings.Trial.BaseConditioning_Water(
      redeclare Buildings.Fluid.HeatExchangers.DryCoilCounterFlow partialFourPortInterface);


    Controls.OBC.CDL.Interfaces.RealInput uHea "Heating level signal" annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
  equation
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
    connect(TAirRet.port_b, port_b)
      annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
    connect(port_a1, TWatSup.port_a)
      annotation (Line(points={{20,-100},{20,-80}}, color={0,127,255}));
    connect(TWatSup.port_b, VWat_flow.port_a)
      annotation (Line(points={{20,-60},{20,-50}}, color={0,127,255}));
    connect(port_b1, TWatRet.port_b)
      annotation (Line(points={{-20,-100},{-20,-70}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-50,11},{-50,56},{18,56}}, color={0,0,127}));
    connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-80,11},{-80,64},{18,64}}, color={0,0,127}));
    connect(VWat_flow.V_flow, PConsumed.V_flow) annotation (Line(points={{9,-40},{
            6,-40},{6,-64},{58,-64}}, color={0,0,127}));
    connect(TWatSup.T, PConsumed.TIn) annotation (Line(points={{9,-70},{0,-70},{0,
            -56},{58,-56}}, color={0,0,127}));
    connect(TWatRet.T, PConsumed.TOut)
      annotation (Line(points={{-9,-60},{58,-60}}, color={0,0,127}));
    connect(VAir_flow.port_b, val.port_a)
      annotation (Line(points={{-40,0},{-34,0}}, color={0,127,255}));
    connect(uHea, val.y) annotation (Line(points={{0,120},{0,80},{-24,80},{-24,12}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end heatingCoil_HHW;

  block PowerCalculation
    Controls.OBC.CDL.Interfaces.RealInput TIn
      annotation (Placement(transformation(extent={{-140,20},{-100,60}})));
    Controls.OBC.CDL.Interfaces.RealInput TOut
      annotation (Placement(transformation(extent={{-140,-20},{-100,20}})));
    Controls.OBC.CDL.Interfaces.RealInput V_flow
      annotation (Placement(transformation(extent={{-140,-60},{-100,-20}})));
    Controls.OBC.CDL.Interfaces.RealOutput yP
      annotation (Placement(transformation(extent={{100,-20},{140,20}})));
    Controls.OBC.CDL.Continuous.Add add2(k2=-1)
      annotation (Placement(transformation(extent={{-60,10},{-40,30}})));
    Controls.OBC.CDL.Continuous.Gain gai(k=1000)
      annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Controls.OBC.CDL.Continuous.Product pro
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Controls.OBC.CDL.Continuous.Abs abs
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  equation
    connect(TOut, add2.u2) annotation (Line(points={{-120,0},{-70,0},{-70,14},{
            -62,14}}, color={0,0,127}));
    connect(TIn, add2.u1) annotation (Line(points={{-120,40},{-70,40},{-70,26},
            {-62,26}}, color={0,0,127}));
    connect(V_flow, gai.u)
      annotation (Line(points={{-120,-40},{-82,-40}}, color={0,0,127}));
    connect(add2.y, pro.u1) annotation (Line(points={{-38,20},{-20,20},{-20,6},
            {-12,6}}, color={0,0,127}));
    connect(gai.y, pro.u2) annotation (Line(points={{-58,-40},{-20,-40},{-20,-6},
            {-12,-6}}, color={0,0,127}));
    connect(pro.y, abs.u)
      annotation (Line(points={{12,0},{38,0}}, color={0,0,127}));
    connect(abs.y, yP)
      annotation (Line(points={{62,0},{120,0}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PowerCalculation;

  partial model heatingCoil_electric
    extends Buildings.Trial.BaseConditioning_electric(
       redeclare Buildings.Fluid.HeatExchangers.HeaterCooler_u partialTwoPortInterface);

    Controls.OBC.CDL.Interfaces.RealInput uHea "Heating level signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
  equation
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
    connect(TAirRet.port_b, port_b)
      annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-30,11},{-30,56},{18,56}}, color={0,0,127}));
    connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-60,11},{-60,64},{18,64}}, color={0,0,127}));
    connect(VAir_flow.port_b, hea.port_a)
      annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
    connect(hea.port_b, TAirRet.port_a)
      annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
    connect(uHea, partialTwoPortInterface.u) annotation (Line(points={{0,120},{
            0,80},{-14,80},{-14,6},{-12,6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end heatingCoil_electric;

  partial model coolingCoil_electric
    extends Buildings.Trial.BaseConditioning_electric(
      redeclare Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed partialTwoPortInterface);
    Controls.OBC.CDL.Interfaces.RealInput uCoo "Cooling level signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    Controls.OBC.CDL.Interfaces.RealInput TAmb
      "Ambient air drybulb temperature" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-40,120})));
  equation
    connect(uCoo, partialTwoPortInterface.speRat) annotation (Line(points={{0,
            120},{0,76},{-14,76},{-14,8},{-11,8}}, color={0,0,127}));
    connect(TAmb, partialTwoPortInterface.TConIn) annotation (Line(points={{-40,
            120},{-40,80},{-16,80},{-16,3},{-11,3}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end coolingCoil_electric;

  partial model BaseConditioning_electric
    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

    replaceable Fluid.Sensors.TemperatureTwoPort TAirSup
      annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    replaceable Fluid.Sensors.TemperatureTwoPort TAirRet
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    replaceable Fluid.Sensors.VolumeFlowRate VAir_flow
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    PowerCalculation POut "Power output of heating coil"
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    replaceable Fluid.Interfaces.PartialTwoPortInterface
      partialTwoPortInterface
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Controls.OBC.CDL.Interfaces.RealOutput TCon
      "Measured conditioned air temperature"
      annotation (Placement(transformation(extent={{100,40},{140,80}})));
  equation
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
    connect(TAirRet.port_b, port_b)
      annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-30,11},{-30,56},{18,56}}, color={0,0,127}));
    connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-60,11},{-60,64},{18,64}}, color={0,0,127}));
    connect(VAir_flow.port_b, partialTwoPortInterface.port_a)
      annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
    connect(partialTwoPortInterface.port_b, TAirRet.port_a)
      annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
    connect(TAirRet.T, TCon)
      annotation (Line(points={{50,11},{50,60},{120,60}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BaseConditioning_electric;

  partial model BaseConditioning_Water
    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

    replaceable Fluid.Sensors.TemperatureTwoPort TAirSup
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    replaceable Fluid.Sensors.TemperatureTwoPort TAirRet
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    replaceable Fluid.Sensors.VolumeFlowRate VAir_flow
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1
      annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1
      annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
    replaceable Fluid.Sensors.TemperatureTwoPort TWatSup
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={20,-70})));
    replaceable Fluid.Sensors.VolumeFlowRate VWat_flow
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={20,-40})));
    replaceable Fluid.Sensors.TemperatureTwoPort TWatRet
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-20,-60})));
    PowerCalculation POut "Power output of heating coil"
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    PowerCalculation PConsumed "Power consumption of heating coil"
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    replaceable Fluid.Actuators.Valves.TwoWayLinear val
      annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
    replaceable Fluid.Interfaces.PartialFourPortInterface
      partialFourPortInterface
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={6,-6})));
  equation
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
    connect(TAirRet.port_b, port_b)
      annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
    connect(port_a1, TWatSup.port_a)
      annotation (Line(points={{20,-100},{20,-80}}, color={0,127,255}));
    connect(TWatSup.port_b, VWat_flow.port_a)
      annotation (Line(points={{20,-60},{20,-50}}, color={0,127,255}));
    connect(port_b1, TWatRet.port_b)
      annotation (Line(points={{-20,-100},{-20,-70}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-50,11},{-50,56},{18,56}}, color={0,0,127}));
    connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-80,11},{-80,64},{18,64}}, color={0,0,127}));
    connect(VWat_flow.V_flow, PConsumed.V_flow) annotation (Line(points={{9,-40},{
            6,-40},{6,-64},{58,-64}}, color={0,0,127}));
    connect(TWatSup.T, PConsumed.TIn) annotation (Line(points={{9,-70},{0,-70},{0,
            -56},{58,-56}}, color={0,0,127}));
    connect(TWatRet.T, PConsumed.TOut)
      annotation (Line(points={{-9,-60},{58,-60}}, color={0,0,127}));
    connect(VAir_flow.port_b, val.port_a)
      annotation (Line(points={{-40,0},{-34,0}}, color={0,127,255}));
    connect(val.port_b, partialFourPortInterface.port_a2)
      annotation (Line(points={{-14,0},{-4,0}}, color={0,127,255}));
    connect(partialFourPortInterface.port_b2, TAirRet.port_a)
      annotation (Line(points={{16,0},{40,0}}, color={0,127,255}));
    connect(VWat_flow.port_b, partialFourPortInterface.port_a1) annotation (
        Line(points={{20,-30},{20,-12},{16,-12}}, color={0,127,255}));
    connect(TWatRet.port_a, partialFourPortInterface.port_b1) annotation (Line(
          points={{-20,-50},{-20,-12},{-4,-12}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BaseConditioning_Water;

  partial model coolingCoil_CCW
    extends Buildings.Trial.BaseConditioning_Water(
      redeclare Buildings.Fluid.HeatExchangers.WetCoilCounterFlow partialFourPortInterface);

    Controls.OBC.CDL.Interfaces.RealInput uCoo "Cooling level signal" annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
  equation
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
    connect(TAirRet.port_b, port_b)
      annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-70,0},{-60,0}}, color={0,127,255}));
    connect(port_a1, TWatSup.port_a)
      annotation (Line(points={{20,-100},{20,-80}}, color={0,127,255}));
    connect(TWatSup.port_b, VWat_flow.port_a)
      annotation (Line(points={{20,-60},{20,-50}}, color={0,127,255}));
    connect(port_b1, TWatRet.port_b)
      annotation (Line(points={{-20,-100},{-20,-70}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-50,11},{-50,56},{18,56}}, color={0,0,127}));
    connect(TAirRet.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-80,11},{-80,64},{18,64}}, color={0,0,127}));
    connect(VWat_flow.V_flow, PConsumed.V_flow) annotation (Line(points={{9,-40},{
            6,-40},{6,-64},{58,-64}}, color={0,0,127}));
    connect(TWatSup.T, PConsumed.TIn) annotation (Line(points={{9,-70},{0,-70},{0,
            -56},{58,-56}}, color={0,0,127}));
    connect(TWatRet.T, PConsumed.TOut)
      annotation (Line(points={{-9,-60},{58,-60}}, color={0,0,127}));
    connect(VAir_flow.port_b, val.port_a)
      annotation (Line(points={{-40,0},{-34,0}}, color={0,127,255}));
    connect(uCoo, val.y) annotation (Line(points={{0,120},{0,80},{-24,80},{-24,12}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end coolingCoil_CCW;

  partial model Baseclass_externalInterfaces

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
    replaceable package MediumW = Buildings.Media.Water "Medium model for water";

    parameter Boolean has_economizer
      "Does the zone equipment have an economizer?";

    parameter Boolean has_coolingCoil
      "Does the zone equipment have a cooling coil?";

    parameter Boolean has_coolingCoilCCW
      "Does the zone equipment have a chilled water cooling coil?";

    parameter Boolean has_heatingCoil
      "Does the zone equipment have a heating coil?";

    parameter Boolean has_heatingCoilHHW
      "Does the zone equipment have a hot water heating coil?";

    Modelica.Fluid.Interfaces.FluidPort_a port_return(redeclare package Medium =
          MediumA)
      "Return air port from zone"
      annotation (Placement(transformation(extent={{210,30},{230,50}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_supply(redeclare package Medium =
          MediumA)
      "Supply air port to the zone"
      annotation (Placement(transformation(extent={{210,-50},{230,-30}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_CCW_outlet(redeclare package
        Medium = MediumW) if                                 has_coolingCoil and has_coolingCoilCCW
      annotation (Placement(transformation(extent={{30,-270},{50,-250}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_CCW_inlet(redeclare package Medium =
                 MediumW) if                                has_coolingCoil and has_coolingCoilCCW
      annotation (Placement(transformation(extent={{70,-270},{90,-250}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_HHW_outlet(redeclare package
        Medium = MediumW) if                                 has_heatingCoil and has_heatingCoilHHW
      annotation (Placement(transformation(extent={{-90,-270},{-70,-250}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_HHW_inlet(redeclare package Medium =
                 MediumW) if                                has_heatingCoil and has_heatingCoilHHW
      annotation (Placement(transformation(extent={{-50,-270},{-30,-250}})));

    Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet(redeclare package Medium =
                 MediumA) if                               has_economizer
      annotation (Placement(transformation(extent={{-230,-50},{-210,-30}})));

    Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust(redeclare package
        Medium = MediumA) if                                 has_economizer
      annotation (Placement(transformation(extent={{-230,30},{-210,50}})));

    Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
      "Heating loop signal"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90,
          origin={-120,280})));
    Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
      "Cooling loop signal" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={120,280})));
    Controls.OBC.CDL.Interfaces.RealInput uFan if has_heatingCoil "Fan signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,280})));
    Controls.OBC.CDL.Interfaces.RealOutput TSupAir "Supply air temperature"
      annotation (Placement(transformation(extent={{220,220},{260,260}})));
    Controls.OBC.CDL.Interfaces.RealOutput VSupAir_flow "Supply air flowrate"
      annotation (Placement(transformation(extent={{220,180},{260,220}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -260},{220,260}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{220,
              260}})));
  end Baseclass_externalInterfaces;

  partial model economizer
    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

    Modelica.Fluid.Interfaces.FluidPort_a port_Out
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Exh
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    Fluid.Actuators.Dampers.MixingBox eco(
      redeclare package Medium = MediumA,
      mOut_flow_nominal=mAir_flow_nominal,
      dpDamOut_nominal=50,
      mRec_flow_nominal=mAir_flow_nominal,
      dpDamRec_nominal=50,
      mExh_flow_nominal=mAir_flow_nominal,
      dpDamExh_nominal=50) if                has_economizer
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
    Controls.OBC.CDL.Interfaces.RealInput uEco "Economizer control signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    Fluid.Sensors.VolumeFlowRate VAirOut_flow
      annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
    Fluid.Sensors.VolumeFlowRate VAirMix_flow "Mixed air flowrate"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Fluid.Sensors.VolumeFlowRate VAirRet_flow
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Fluid.Sensors.TemperatureTwoPort TOutSen "Outdoor air temperature sensor"
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Fluid.Sensors.TemperatureTwoPort TRetSen "Return air temperature sensor"
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Fluid.Sensors.TemperatureTwoPort TMixSen "Mixed air temperature sensor"
      annotation (Placement(transformation(extent={{30,-10},{50,10}})));
    Controls.OBC.CDL.Interfaces.RealOutput TMix
      "Measured mixed air temperature"
      annotation (Placement(transformation(extent={{100,20},{140,60}})));
    Controls.OBC.CDL.Interfaces.RealOutput VOut_flow
      "Measured outdoor air flowrate"
      annotation (Placement(transformation(extent={{100,60},{140,100}})));
  equation
    connect(port_Exh, eco.port_Exh) annotation (Line(points={{-100,-40},{-10,
            -40},{-10,-4}}, color={0,127,255}));
    connect(uEco, eco.y)
      annotation (Line(points={{0,120},{0,14}}, color={0,0,127}));
    connect(port_Out, VAirOut_flow.port_a)
      annotation (Line(points={{-100,40},{-90,40}}, color={0,127,255}));
    connect(VAirMix_flow.port_b, port_b)
      annotation (Line(points={{80,0},{100,0}}, color={0,127,255}));
    connect(port_a, VAirRet_flow.port_a)
      annotation (Line(points={{-100,0},{-80,0}}, color={0,127,255}));
    connect(VAirOut_flow.port_b, TOutSen.port_a)
      annotation (Line(points={{-70,40},{-60,40}}, color={0,127,255}));
    connect(TOutSen.port_b, eco.port_Out) annotation (Line(points={{-40,40},{
            -20,40},{-20,8},{-10,8}}, color={0,127,255}));
    connect(VAirRet_flow.port_b, TRetSen.port_a)
      annotation (Line(points={{-60,0},{-50,0}}, color={0,127,255}));
    connect(TRetSen.port_b, eco.port_Ret) annotation (Line(points={{-30,0},{-20,
            0},{-20,-20},{10,-20},{10,-4}}, color={0,127,255}));
    connect(eco.port_Sup, TMixSen.port_a) annotation (Line(points={{10,8},{20,8},
            {20,0},{30,0}}, color={0,127,255}));
    connect(TMixSen.port_b, VAirMix_flow.port_a)
      annotation (Line(points={{50,0},{60,0}}, color={0,127,255}));
    connect(TMixSen.T, TMix)
      annotation (Line(points={{40,11},{40,40},{120,40}}, color={0,0,127}));
    connect(VAirOut_flow.V_flow, VOut_flow)
      annotation (Line(points={{-80,51},{-80,80},{120,80}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end economizer;

  partial model Baseclass_components
    extends Buildings.Trial.Baseclass_externalInterfaces;
    replaceable Fluid.Interfaces.PartialTwoPortInterface heaCoi
      annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
    replaceable Fluid.Interfaces.PartialTwoPortInterface cooCoi
      annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
    Fluid.Movers.SpeedControlled_y fan
      annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
    Fluid.Sensors.VolumeFlowRate senVolFlo
      annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
    Fluid.Sensors.TemperatureTwoPort senTem
      annotation (Placement(transformation(extent={{160,-50},{180,-30}})));
  equation
    connect(heaCoi.port_b, cooCoi.port_a)
      annotation (Line(points={{-20,-40},{20,-40}}, color={0,127,255}));
    connect(cooCoi.port_b, fan.port_a)
      annotation (Line(points={{40,-40},{80,-40}}, color={0,127,255}));
    connect(fan.port_b, senVolFlo.port_a)
      annotation (Line(points={{100,-40},{120,-40}}, color={0,127,255}));
    connect(senVolFlo.port_b, senTem.port_a)
      annotation (Line(points={{140,-40},{160,-40}}, color={0,127,255}));
    connect(senTem.port_b, port_supply)
      annotation (Line(points={{180,-40},{220,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Baseclass_components;

  model Usecase
    replaceable Baseclass_components baseclass_components(
      has_economizer=true,
      has_coolingCoil=false,
      has_heatingCoil=true,
      has_heatingCoilHHW=false)
      annotation (Placement(transformation(extent={{-22,-8},{22,44}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Usecase;
end Trial;
