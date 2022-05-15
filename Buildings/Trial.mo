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
      Buildings.Trial.PowerCalculation powerCalculation if has_coolingCoil and
        has_coolingCoilCCW
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
      Buildings.Trial.PowerCalculation powerCalculation1 if has_heatingCoil
         and has_heatingCoilHHW
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
  end Old;

  model heatingCoil_HHW
    extends Buildings.Trial.BaseConditioning_Water(
      redeclare Buildings.Fluid.HeatExchangers.DryCoilCounterFlow partialFourPortInterface(
        redeclare package Medium1 = MediumW,
        redeclare package Medium2 = MediumA,
        m1_flow_nominal=mWat_flow_nominal,
        m2_flow_nominal=mAir_flow_nominal,
        dp1_nominal=dpCoiWat_nominal,
        dp2_nominal=dpCoiAir_nominal,
        UA_nominal=UA_nominal));


    Controls.OBC.CDL.Interfaces.RealInput uHea "Heating level signal" annotation (
       Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    parameter Modelica.Units.SI.PressureDifference dpCoiWat_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.PressureDifference dpCoiAir_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.ThermalConductance UA_nominal
      "Thermal conductance at nominal flow, used to compute heat capacity";
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
    connect(uHea, val.y) annotation (Line(points={{0,120},{0,80},{-32,80},{-32,
            -30}},
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
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end PowerCalculation;

  model heatingCoil_electric
    extends Buildings.Trial.BaseConditioning_electric(
       redeclare Buildings.Fluid.HeatExchangers.HeaterCooler_u partialTwoPortInterface(
        redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal,
        dp_nominal=dp_Coil_nominal,
        Q_flow_nominal=QHeaCoi_flow_nominal));

    Controls.OBC.CDL.Interfaces.RealInput uHea "Heating level signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    parameter Modelica.Units.SI.PressureDifference dp_Coil_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal
      "Heat flow rate at u=1, positive for heating";
  equation
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-30,11},{-30,56},{18,56}}, color={0,0,127}));
    connect(TAirCon.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-60,11},{-60,64},{18,64}}, color={0,0,127}));
    connect(uHea, partialTwoPortInterface.u) annotation (Line(points={{0,120},{
            0,80},{-14,80},{-14,6},{-12,6}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end heatingCoil_electric;

  model coolingCoil_electric
    extends Buildings.Trial.BaseConditioning_electric(
      redeclare Buildings.Fluid.HeatExchangers.DXCoils.AirCooled.VariableSpeed partialTwoPortInterface(
        redeclare package Medium = MediumA,
        dp_nominal=dpCooCoi_nominal,
        minSpeRat=minSpeRat));
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
    parameter Real minSpeRat "Minimum speed ratio";
    parameter Modelica.Units.SI.PressureDifference dpCooCoi_nominal
      "Pressure difference";
  equation
    connect(uCoo, partialTwoPortInterface.speRat) annotation (Line(points={{0,
            120},{0,76},{-14,76},{-14,8},{-11,8}}, color={0,0,127}));
    connect(TAmb, partialTwoPortInterface.TConIn) annotation (Line(points={{-40,
            120},{-40,80},{-16,80},{-16,3},{-11,3}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end coolingCoil_electric;

  partial model BaseConditioning_electric

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases
      "Medium model for air";

    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
      redeclare package Medium = MediumA);

    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
      "Nominal mass flow rate of air";

    replaceable Fluid.Sensors.TemperatureTwoPort TAirSup(
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
    replaceable Fluid.Sensors.TemperatureTwoPort TAirCon(
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    replaceable Fluid.Sensors.VolumeFlowRate VAir_flow(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    PowerCalculation POut "Power output of heating coil"
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    replaceable Fluid.Interfaces.PartialTwoPortInterface
      partialTwoPortInterface(redeclare package Medium = MediumA)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Controls.OBC.CDL.Interfaces.RealOutput TCon
      "Measured conditioned air temperature"
      annotation (Placement(transformation(extent={{100,40},{140,80}})));
  equation
    connect(TAirCon.port_b, port_b)
      annotation (Line(points={{60,0},{100,0}}, color={0,127,255}));
    connect(TAirSup.port_b, VAir_flow.port_a)
      annotation (Line(points={{-50,0},{-40,0}}, color={0,127,255}));
    connect(VAir_flow.V_flow, POut.V_flow)
      annotation (Line(points={{-30,11},{-30,56},{18,56}}, color={0,0,127}));
    connect(TAirCon.T, POut.TOut) annotation (Line(points={{50,11},{50,40},{8,40},
            {8,60},{18,60}}, color={0,0,127}));
    connect(TAirSup.T, POut.TIn)
      annotation (Line(points={{-60,11},{-60,64},{18,64}}, color={0,0,127}));
    connect(VAir_flow.port_b, partialTwoPortInterface.port_a)
      annotation (Line(points={{-20,0},{-10,0}}, color={0,127,255}));
    connect(partialTwoPortInterface.port_b,TAirCon. port_a)
      annotation (Line(points={{10,0},{40,0}}, color={0,127,255}));
    connect(TAirCon.T, TCon)
      annotation (Line(points={{50,11},{50,60},{120,60}}, color={0,0,127}));
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-70,0}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BaseConditioning_electric;

  partial model BaseConditioning_Water

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases
      "Medium model for air";
    replaceable package MediumW = Buildings.Media.Water
      "Medium model for water";

    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
      redeclare package Medium = MediumA);

    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
      "Nominal mass flow rate of air";

    parameter Modelica.Units.SI.MassFlowRate mWat_flow_nominal
      "Nominal mass flow rate of water";

    replaceable Fluid.Sensors.TemperatureTwoPort TAirSup(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
    replaceable Fluid.Sensors.TemperatureTwoPort TAirRet(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    replaceable Fluid.Sensors.VolumeFlowRate VAir_flow(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          MediumW)
      annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          MediumW)
      annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
    replaceable Fluid.Sensors.TemperatureTwoPort TWatSup(redeclare package Medium =
          MediumW, m_flow_nominal=mWat_flow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={20,-70})));
    replaceable Fluid.Sensors.VolumeFlowRate VWat_flow(redeclare package Medium =
          MediumW, m_flow_nominal=mWat_flow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={20,-40})));
    replaceable Fluid.Sensors.TemperatureTwoPort TWatRet(redeclare package Medium =
          MediumW, m_flow_nominal=mWat_flow_nominal)
      annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=-90,
          origin={-20,-60})));
    PowerCalculation POut "Power output of heating coil"
      annotation (Placement(transformation(extent={{20,50},{40,70}})));
    PowerCalculation PConsumed "Power consumption of heating coil"
      annotation (Placement(transformation(extent={{60,-70},{80,-50}})));
    replaceable Fluid.Actuators.Valves.TwoWayLinear val(
      redeclare package Medium = MediumW,
      m_flow_nominal=mWat_flow_nominal,
      dpValve_nominal=50)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
          origin={-20,-30})));
    replaceable Fluid.Interfaces.PartialFourPortInterface
      partialFourPortInterface(
      redeclare package Medium1 = MediumW,
      redeclare package Medium2 = MediumA,
      m1_flow_nominal=mWat_flow_nominal,
      m2_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={6,-6})));
    Controls.OBC.CDL.Interfaces.RealOutput TCon
      "Measured conditioned air temperature"
      annotation (Placement(transformation(extent={{100,40},{140,80}}),
          iconTransformation(extent={{100,40},{140,80}})));
  equation
    connect(port_a, TAirSup.port_a)
      annotation (Line(points={{-100,0},{-90,0}}, color={0,127,255}));
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
    connect(VWat_flow.port_b, partialFourPortInterface.port_a1) annotation (
        Line(points={{20,-30},{20,-12},{16,-12}}, color={0,127,255}));
    connect(TAirRet.T, TCon)
      annotation (Line(points={{50,11},{50,60},{120,60}}, color={0,0,127}));
    connect(TWatRet.port_a, val.port_a)
      annotation (Line(points={{-20,-50},{-20,-40}}, color={0,127,255}));
    connect(val.port_b, partialFourPortInterface.port_b1) annotation (Line(points=
           {{-20,-20},{-20,-12},{-4,-12}}, color={0,127,255}));
    connect(VAir_flow.port_b, partialFourPortInterface.port_a2)
      annotation (Line(points={{-40,0},{-4,0}}, color={0,127,255}));
    connect(TAirRet.port_b, port_b) annotation (Line(points={{60,0},{80,0},{80,0},
            {100,0}}, color={0,127,255}));
    connect(partialFourPortInterface.port_b2, TAirRet.port_a) annotation (Line(
          points={{16,-1.77636e-15},{28,-1.77636e-15},{28,0},{40,0}}, color={0,127,
            255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end BaseConditioning_Water;

  model coolingCoil_CCW
    parameter Modelica.Units.SI.PressureDifference dpCoiAir_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.PressureDifference dpCoiWat_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.ThermalConductance UA_nominal
      "Thermal conductance at nominal flow, used to compute heat capacity";

    extends Buildings.Trial.BaseConditioning_Water(
      redeclare Buildings.Fluid.HeatExchangers.WetCoilCounterFlow partialFourPortInterface(
        redeclare package Medium1 = MediumW,
        redeclare package Medium2 = MediumA,
        m1_flow_nominal=mWat_flow_nominal,
        m2_flow_nominal=mAir_flow_nominal,
        dp1_nominal=dpCoiWat_nominal,
        dp2_nominal=dpCoiAir_nominal,
        UA_nominal=UA_nominal),
      port_a1(redeclare package Medium = MediumW),
      port_b1(redeclare package Medium = MediumW));

    Controls.OBC.CDL.Interfaces.RealInput uCoo
      "Cooling level signal" annotation (
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
    connect(uCoo, val.y) annotation (Line(points={{0,120},{0,80},{-32,80},{-32,
            -30}},
          color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end coolingCoil_CCW;

  partial model Baseclass_externalInterfaces

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
    replaceable package MediumW = Buildings.Media.Water "Medium model for water";

    Boolean has_coolingCoil
      "Does the zone equipment have a cooling coil?";

    Boolean has_coolingCoilCCW
      "Does the zone equipment have a chilled water cooling coil?";

    Boolean has_heatingCoil
      "Does the zone equipment have a heating coil?";

    Boolean has_heatingCoilHHW
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

    Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
      "Heating loop signal"
      annotation (Placement(transformation(extent={{-20,-20},{20,20}}, rotation=-90,
          origin={-40,280})));
    Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
      "Cooling loop signal" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={120,280})));
    Controls.OBC.CDL.Interfaces.RealInput uFan "Fan signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={40,280})));
    Controls.OBC.CDL.Interfaces.RealOutput TSupAir "Supply air temperature"
      annotation (Placement(transformation(extent={{220,220},{260,260}})));
    Controls.OBC.CDL.Interfaces.RealOutput VSupAir_flow "Supply air flowrate"
      annotation (Placement(transformation(extent={{220,180},{260,220}})));
    Controls.OBC.CDL.Interfaces.RealInput uOA if  has_heatingCoil
      "Outdoor air signal" annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-120,280})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -260},{220,260}}), graphics={Rectangle(
            extent={{-220,260},{220,-260}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-220,-260},{220,
              260}})));
  end Baseclass_externalInterfaces;

  model economizer
    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface(
      redeclare package Medium = MediumA);

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases
      "Medium model for air";

    parameter Boolean has_economizer;

    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
      "Nominal mass flow rate of air";

    parameter Modelica.Units.SI.MassFlowRate mAirOut_flow_nominal
      "Nominal mass flow rate of outdoor air";

    Modelica.Fluid.Interfaces.FluidPort_a port_Out(redeclare package Medium =
          MediumA)
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_Exh(redeclare package Medium =
          MediumA)
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    Fluid.Actuators.Dampers.MixingBox eco(
      redeclare package Medium = MediumA,
      mOut_flow_nominal=mAirOut_flow_nominal,
      dpDamOut_nominal=50,
      mRec_flow_nominal=mAir_flow_nominal,
      dpDamRec_nominal=50,
      mExh_flow_nominal=mAirOut_flow_nominal,
      dpDamExh_nominal=50) if                has_economizer
      annotation (Placement(transformation(extent={{-10,-8},{10,12}})));
    Controls.OBC.CDL.Interfaces.RealInput uEco "Economizer control signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    Fluid.Sensors.VolumeFlowRate VAirOut_flow(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-90,30},{-70,50}})));
    Fluid.Sensors.VolumeFlowRate VAirMix_flow(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
                                              "Mixed air flowrate"
      annotation (Placement(transformation(extent={{60,-10},{80,10}})));
    Fluid.Sensors.VolumeFlowRate VAirRet_flow(redeclare package Medium =
          MediumA, m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
    Fluid.Sensors.TemperatureTwoPort TOutSen(redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal)    "Outdoor air temperature sensor"
      annotation (Placement(transformation(extent={{-60,30},{-40,50}})));
    Fluid.Sensors.TemperatureTwoPort TRetSen(redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal)    "Return air temperature sensor"
      annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
    Fluid.Sensors.TemperatureTwoPort TMixSen(redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal)    "Mixed air temperature sensor"
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
    connect(TOutSen.port_b, eco.port_Out) annotation (Line(points={{-40,40},{
            -20,40},{-20,8},{-10,8}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end economizer;

  partial model Baseclass_components
    extends Buildings.Trial.Baseclass_externalInterfaces;

    Boolean has_economizer;
    replaceable Fluid.Interfaces.PartialTwoPortInterface comp3
      annotation (Placement(transformation(extent={{20,-50},{40,-30}})));
    Fluid.Movers.SpeedControlled_y fan(
      redeclare package Medium = MediumA)
      annotation (Placement(transformation(extent={{80,-50},{100,-30}})));
    Fluid.Sensors.VolumeFlowRate senVolFlo(
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{120,-50},{140,-30}})));
    Fluid.Sensors.TemperatureTwoPort senTem(redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal)
      annotation (Placement(transformation(extent={{160,-50},{180,-30}})));
    replaceable Fluid.Interfaces.PartialTwoPortInterface comp1
      annotation (Placement(transformation(extent={{-120,-50},{-100,-30}})));
    replaceable Fluid.Interfaces.PartialTwoPortInterface comp2
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet1(
      redeclare package Medium=MediumA) if has_economizer
      annotation (Placement(transformation(extent={{-230,-50},{-210,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust1(
      redeclare package Medium = MediumA) if has_economizer
      annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
    Controls.OBC.CDL.Interfaces.RealInput TAmb if has_coolingCoil and not has_coolingCoilCCW
      "Ambient outdoor air temperature"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          origin={-240,220})));

    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
      "Nominal mass flow rate, used for regularization near zero flow";
  equation
    connect(comp3.port_b, fan.port_a)
      annotation (Line(points={{40,-40},{80,-40}}, color={0,127,255}));
    connect(fan.port_b, senVolFlo.port_a)
      annotation (Line(points={{100,-40},{120,-40}}, color={0,127,255}));
    connect(senVolFlo.port_b, senTem.port_a)
      annotation (Line(points={{140,-40},{160,-40}}, color={0,127,255}));
    connect(senTem.port_b, port_supply)
      annotation (Line(points={{180,-40},{220,-40}}, color={0,127,255}));
    connect(port_return, comp1.port_a) annotation (Line(points={{220,40},{-140,40},
            {-140,-40},{-120,-40}}, color={0,127,255}));
    connect(uFan, fan.y) annotation (Line(points={{40,280},{40,0},{90,0},{90,
            -28}},
          color={0,0,127}));
    connect(comp1.port_b, comp2.port_a)
      annotation (Line(points={{-100,-40},{-60,-40}}, color={0,127,255}));
    connect(comp2.port_b, comp3.port_a)
      annotation (Line(points={{-40,-40},{20,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Baseclass_components;

  model FCU

    parameter Buildings.Trial.Types.heatingCoil heatingCoilType
      "Type of heating coil used in the FCU";

    parameter Buildings.Trial.Types.capacityControl capacityControlMethod
      "Type of capacity control method";

    parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal
      "Heat flow rate at u=1, positive for heating";
    parameter Modelica.Units.SI.MassFlowRate mHotWat_flow_nominal
      "Nominal mass flow rate of water";
    parameter Modelica.Units.SI.PressureDifference dpHeaCoiWat_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.PressureDifference dpHeaCoiAir_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.ThermalConductance UAHeaCoi_nominal
      "Thermal conductance at nominal flow, used to compute heat capacity";
    parameter Real minSpeRatCooCoi "Minimum speed ratio";
    parameter Modelica.Units.SI.PressureDifference dpCooCoiAir_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal
      "Nominal mass flow rate of water";
    parameter Modelica.Units.SI.ThermalConductance UACooCoi_nominal
      "Thermal conductance at nominal flow, used to compute heat capacity";
    parameter Modelica.Units.SI.PressureDifference dpCooCoiWat_nominal
      "Pressure difference";

    extends Buildings.Trial.Baseclass_components(
      redeclare Buildings.Trial.coolingCoil comp3(
        redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal,
        redeclare package MediumA = MediumA,
        redeclare package MediumW = MediumW,
        final has_coolingCoil=has_coolingCoil,
        final has_coolingCoilCCW=has_coolingCoilCCW,
        mAir_flow_nominal=mAir_flow_nominal,
        minSpeRatCooCoi=minSpeRatCooCoi,
        dpCooCoiAir_nominal=dpCooCoiAir_nominal,
        dpCooCoiWat_nominal=dpCooCoiWat_nominal,
        mChiWat_flow_nominal=mChiWat_flow_nominal,
        UACooCoi_nominal=UACooCoi_nominal),
      redeclare Buildings.Trial.heatingCoil comp2(
        redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal,
        redeclare package MediumA = MediumA,
        redeclare package MediumW = MediumW,
        final has_heatingCoil=has_heatingCoil,
        final has_heatingCoilHHW=has_heatingCoilHHW,
        mAir_flow_nominal=mAir_flow_nominal,
        QHeaCoi_flow_nominal=QHeaCoi_flow_nominal,
        mHotWat_flow_nominal=mHotWat_flow_nominal,
        dpHeaCoiWat_nominal=dpHeaCoiWat_nominal,
        dpHeaCoiAir_nominal=dpHeaCoiAir_nominal,
        UAHeaCoi_nominal=UAHeaCoi_nominal),
      redeclare Buildings.Trial.economizer comp1(
        mAirOut_flow_nominal=mAirOut_flow_nominal,
        redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal,
        redeclare package MediumA = MediumA,
        has_economizer=has_economizer,
        mAir_flow_nominal=mAir_flow_nominal),
      final has_economizer=true,
      final has_coolingCoil=true,
      final has_coolingCoilCCW=true,
      final has_heatingCoil=true,
      has_heatingCoilHHW=has_heatingCoilHHW,
      fan(per=fanPer, addPowerToMedium=fanAddPowerToMedium));

  //     parameter Boolean has_heatingCoil = true
  //       "Does the zone equipment have a heating coil?";
  //
  //     parameter Boolean has_coolingCoil = true
  //       "Does the zone equipment have a heating coil?";
  //
  //     parameter Boolean has_coolingCoilCCW = true
  //       "Does the zone equipment have a hot water heating coil?"
  //       annotation(Dialog(enable = has_coolingCoil));

    parameter Modelica.Units.SI.MassFlowRate mAirOut_flow_nominal
      "Nominal mass flow rate of outdoor air";
  protected
    Boolean has_heatingCoilHHW = heatingCoilType == Buildings.Trial.Types.heatingCoil.heatingHotWater
      "Does the zone equipment have a hot water heating coil?"
      annotation(Dialog(enable = has_heatingCoil));


    replaceable parameter Fluid.Movers.Data.Generic fanPer constrainedby
      Buildings.Fluid.Movers.Data.Generic
      "Record with performance data for supply fan"
      annotation (choicesAllMatching=true,
        Placement(transformation(extent={{52,60},{72,80}})));

    parameter Boolean fanAddPowerToMedium=true
      "Set to false to avoid any power (=heat and flow work) being added to medium (may give simpler equations)";
  equation
    connect(uHea, comp2.uHea) annotation (Line(points={{-40,280},{-40,120},{-50,
            120},{-50,-28}}, color={0,0,127}));
    connect(uCoo, comp3.uCoo) annotation (Line(points={{120,280},{120,82},{30,82},
            {30,-28}}, color={0,0,127}));
    connect(TAmb, comp3.TAmb)
      annotation (Line(points={{-240,220},{26,220},{26,-28}}, color={0,0,127}));
    connect(senTem.T, TSupAir) annotation (Line(points={{170,-29},{172,-29},{172,240},
            {240,240}}, color={0,0,127}));
    connect(senVolFlo.V_flow, VSupAir_flow)
      annotation (Line(points={{130,-29},{130,200},{240,200}}, color={0,0,127}));
    connect(port_CCW_inlet, comp3.port_a1) annotation (Line(points={{80,-260},{
            80,-70},{32,-70},{32,-50}}, color={0,127,255}));
    connect(port_CCW_outlet, comp3.port_b1) annotation (Line(points={{40,-260},
            {40,-80},{28,-80},{28,-50}}, color={0,127,255}));
    connect(port_HHW_inlet, comp2.port_a1) annotation (Line(points={{-40,-260},
            {-40,-80},{-48,-80},{-48,-50}}, color={0,127,255}));
    connect(port_HHW_outlet, comp2.port_b1) annotation (Line(points={{-80,-260},
            {-80,-80},{-52,-80},{-52,-50}}, color={0,127,255}));
    connect(port_OA_exhaust1, comp1.port_Exh) annotation (Line(points={{-220,40},{
            -150,40},{-150,-44},{-120,-44}}, color={0,127,255}));
    connect(port_OA_inlet1, comp1.port_Out) annotation (Line(points={{-220,-40},{-160,
            -40},{-160,-36},{-120,-36}}, color={0,127,255}));
    connect(uOA, comp1.uEco) annotation (Line(points={{-120,280},{-120,0},{-110,
            0},{-110,-28}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end FCU;

  model heatingCoil
    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases
      "Medium model for air";
    replaceable package MediumW = Buildings.Media.Water
      "Medium model for water";

    parameter Boolean has_heatingCoil
      "Does the zone equipment have a heating coil?";

    parameter Boolean has_heatingCoilHHW
      "Does the zone equipment have a hot water heating coil?"
      annotation(Dialog(enable = has_heatingCoil));

    replaceable heatingCoil_electric heatingCoil_electric1(
      redeclare package MediumA = MediumA,
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal,
      mAir_flow_nominal=mAir_flow_nominal,
      dp_Coil_nominal=dpHeaCoiAir_nominal,
      QHeaCoi_flow_nominal=QHeaCoi_flow_nominal) if has_heatingCoil and not has_heatingCoilHHW
      annotation (Placement(transformation(extent={{-10,40},{10,60}})));

    replaceable heatingCoil_HHW heatingCoil_HHW1(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal,
      mAir_flow_nominal=mAir_flow_nominal,
      mWat_flow_nominal=mHotWat_flow_nominal,
      dpCoiWat_nominal=dpHeaCoiWat_nominal,
      dpCoiAir_nominal=dpHeaCoiAir_nominal,
      UA_nominal=UAHeaCoi_nominal) if            has_heatingCoil and has_heatingCoilHHW
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));

    Controls.OBC.CDL.Interfaces.RealInput uHea if has_heatingCoil
      "Heating level signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));

    Fluid.FixedResistances.LosslessPipe pip(redeclare package Medium = MediumA,
        m_flow_nominal=mAir_flow_nominal) if   not has_heatingCoil
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          MediumW) if                                has_heatingCoil and
      has_heatingCoilHHW
      annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          MediumW) if                                has_heatingCoil and
      has_heatingCoilHHW
      annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
      "Nominal mass flow rate of air";
    parameter Modelica.Units.SI.HeatFlowRate QHeaCoi_flow_nominal
      "Heat flow rate at u=1, positive for heating";
    parameter Modelica.Units.SI.MassFlowRate mHotWat_flow_nominal
      "Nominal mass flow rate of water";
    parameter Modelica.Units.SI.PressureDifference dpHeaCoiWat_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.PressureDifference dpHeaCoiAir_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.ThermalConductance UAHeaCoi_nominal
      "Thermal conductance at nominal flow, used to compute heat capacity";
  equation
    connect(uHea, heatingCoil_electric1.uHea)
      annotation (Line(points={{0,120},{0,120},{0,62}}, color={0,0,127}));
    connect(uHea, heatingCoil_HHW1.uHea) annotation (Line(points={{0,120},{0,80},{
            -20,80},{-20,20},{0,20},{0,12}}, color={0,0,127}));
    connect(port_a, heatingCoil_HHW1.port_a)
      annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
    connect(heatingCoil_HHW1.port_b, port_b)
      annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
    connect(port_a, heatingCoil_electric1.port_a) annotation (Line(points={{-100,0},
            {-40,0},{-40,50},{-10,50}}, color={0,127,255}));
    connect(heatingCoil_electric1.port_b, port_b) annotation (Line(points={{10,50},
            {60,50},{60,0},{100,0}}, color={0,127,255}));
    connect(port_a, pip.port_a) annotation (Line(points={{-100,0},{-40,0},{-40,-40},
            {-10,-40}}, color={0,127,255}));
    connect(pip.port_b, port_b) annotation (Line(points={{10,-40},{60,-40},{60,0},
            {100,0}}, color={0,127,255}));
    connect(port_a1, heatingCoil_HHW1.port_a1) annotation (Line(points={{20,-100},
            {20,-20},{2,-20},{2,-10}}, color={0,127,255}));
    connect(port_b1, heatingCoil_HHW1.port_b1) annotation (Line(points={{-20,-100},
            {-20,-20},{-2,-20},{-2,-10}}, color={0,127,255}));
    annotation (defaultComponentName="heaCoi",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end heatingCoil;

  model coolingCoil

    extends Buildings.Fluid.Interfaces.PartialTwoPortInterface;

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases
      "Medium model for air";
    replaceable package MediumW = Buildings.Media.Water
      "Medium model for water";

    parameter Modelica.Units.SI.MassFlowRate mAir_flow_nominal
      "Nominal mass flow rate of air";
    parameter Real minSpeRatCooCoi "Minimum speed ratio";
    parameter Modelica.Units.SI.PressureDifference dpCooCoiAir_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.PressureDifference dpCooCoiWat_nominal
      "Pressure difference";
    parameter Modelica.Units.SI.MassFlowRate mChiWat_flow_nominal
      "Nominal mass flow rate of water";
    parameter Modelica.Units.SI.ThermalConductance UACooCoi_nominal
      "Thermal conductance at nominal flow, used to compute heat capacity";

    parameter Boolean has_coolingCoil
      "Does the zone equipment have a heating coil?";

    parameter Boolean has_coolingCoilCCW
      "Does the zone equipment have a hot water heating coil?"
      annotation(Dialog(enable = has_coolingCoil));

    replaceable Buildings.Trial.coolingCoil_electric coolingCoil_electric1(
      redeclare package MediumA = MediumA,
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal,
      mAir_flow_nominal=mAir_flow_nominal,
      minSpeRat=minSpeRatCooCoi,
      dpCooCoi_nominal=dpCooCoiAir_nominal) if has_coolingCoil and not
      has_coolingCoilCCW
      annotation (Placement(transformation(extent={{-10,40},{10,60}})));
    replaceable Buildings.Trial.coolingCoil_CCW coolingCoil_CCW1(
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal,
      mAir_flow_nominal=mAir_flow_nominal,
      mWat_flow_nominal=mChiWat_flow_nominal,
      dpCoiAir_nominal=dpCooCoiAir_nominal,
      dpCoiWat_nominal=dpCooCoiWat_nominal,
      UA_nominal=UACooCoi_nominal) if has_coolingCoil and has_coolingCoilCCW
      annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
    Controls.OBC.CDL.Interfaces.RealInput uCoo if has_coolingCoil
      "Cooling level signal"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={0,120})));
    Fluid.FixedResistances.LosslessPipe pip(
      redeclare package Medium = MediumA,
      m_flow_nominal=mAir_flow_nominal) if not has_coolingCoil
      annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_a1(redeclare package Medium =
          MediumW) if                                has_coolingCoil and has_coolingCoilCCW
      annotation (Placement(transformation(extent={{10,-110},{30,-90}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_b1(redeclare package Medium =
          MediumW) if                                has_coolingCoil and has_coolingCoilCCW
      annotation (Placement(transformation(extent={{-30,-110},{-10,-90}})));
    Controls.OBC.CDL.Interfaces.RealInput TAmb if has_coolingCoil
       and not has_coolingCoilCCW "Ambient outdoor air temperature"
      annotation (Placement(transformation(
          extent={{-20,-20},{20,20}},
          rotation=-90,
          origin={-40,120})));
  equation
    connect(pip.port_b, port_b) annotation (Line(points={{10,-40},{60,-40},{60,0},
            {100,0}}, color={0,127,255}));
    connect(TAmb, coolingCoil_electric1.TAmb) annotation (Line(points={{-40,120},{
            -40,72},{-4,72},{-4,62}}, color={0,0,127}));
    connect(uCoo, coolingCoil_electric1.uCoo)
      annotation (Line(points={{0,120},{0,62}}, color={0,0,127}));
    connect(uCoo, coolingCoil_CCW1.uCoo) annotation (Line(points={{0,120},{0,80},{
            -20,80},{-20,20},{0,20},{0,12}}, color={0,0,127}));
    connect(port_a, coolingCoil_electric1.port_a) annotation (Line(points={{-100,0},
            {-40,0},{-40,50},{-10,50}}, color={0,127,255}));
    connect(port_a, coolingCoil_CCW1.port_a)
      annotation (Line(points={{-100,0},{-10,0}}, color={0,127,255}));
    connect(port_a, pip.port_a) annotation (Line(points={{-100,0},{-40,0},{-40,-40},
            {-10,-40}}, color={0,127,255}));
    connect(coolingCoil_electric1.port_b, port_b) annotation (Line(points={{10,50},
            {60,50},{60,0},{100,0}}, color={0,127,255}));
    connect(coolingCoil_CCW1.port_b, port_b)
      annotation (Line(points={{10,0},{100,0}}, color={0,127,255}));
    connect(port_a1, coolingCoil_CCW1.port_a1) annotation (Line(points={{20,-100},
            {20,-20},{2,-20},{2,-10}}, color={0,127,255}));
    connect(port_b1, coolingCoil_CCW1.port_b1) annotation (Line(points={{-20,-100},
            {-20,-20},{-2,-20},{-2,-10}}, color={0,127,255}));
    annotation (defaultComponentName="heaCoi",
      Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}),                      Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end coolingCoil;

  block use_case

    replaceable package MediumA = Buildings.Media.Air
      constrainedby Modelica.Media.Interfaces.PartialCondensingGases "Medium model for air";
    replaceable package MediumW = Buildings.Media.Water "Medium model for water";

    Controls.OBC.CDL.Continuous.Sources.Constant con(k=0.5)
      annotation (Placement(transformation(extent={{-140,30},{-120,50}})));
    Fluid.Sources.Boundary_pT sinCoo(
      redeclare package Medium = MediumW,
      p=300000,
      T=279.15,
      nPorts=1) "Sink for cooling coil" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-50,-110})));
    Fluid.Sources.Boundary_pT souCoo(
      redeclare package Medium = MediumW,
      p(displayUnit="Pa") = 300000 + 6000,
      T=279.15,
      nPorts=1) "Source for cooling coil loop" annotation (Placement(
          transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-20,-110})));
    Fluid.Sources.Boundary_pT sinHea(
      redeclare package Medium = MediumW,
      p=300000,
      T=318.15,
      nPorts=1) "Sink for heating coil" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-110,-110})));
    Fluid.Sources.Boundary_pT souHea(
      redeclare package Medium = MediumW,
      p(displayUnit="Pa") = 300000 + 6000,
      T=333.15,
      nPorts=1) "Source for heating coil" annotation (Placement(transformation(
          extent={{-10,-10},{10,10}},
          rotation=90,
          origin={-80,-110})));
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
    Old.Thermostat thermostat
      annotation (Placement(transformation(extent={{40,-10},{60,10}})));
    Controls.OBC.CDL.Continuous.Sources.Constant con1(k=273.15 + 25)
      annotation (Placement(transformation(extent={{10,-10},{30,10}})));
    Controls.OBC.CDL.Continuous.Sources.Constant con2(k=273.15 + 23)
      annotation (Placement(transformation(extent={{10,-50},{30,-30}})));
    FCU fCU(
      heatingCoilType=Buildings.Trial.Types.heatingCoil.heatingHotWater,
      redeclare package MediumA = MediumA,
      redeclare package MediumW = MediumW,
      mAir_flow_nominal=10,
      QHeaCoi_flow_nominal=13866,
      mHotWat_flow_nominal=2*13866/(1000*10),
      dpHeaCoiWat_nominal=100,
      dpHeaCoiAir_nominal=100,
      UAHeaCoi_nominal=1000,
      minSpeRatCooCoi=1,
      dpCooCoiAir_nominal=100,
      mChiWat_flow_nominal=1,
      UACooCoi_nominal=1,
      dpCooCoiWat_nominal=100,
      redeclare Fluid.Movers.Data.Pumps.customFCUFan fanPer)
      annotation (Placement(transformation(extent={{-86,-52},{-42,0}})));
    Controls.OBC.CDL.Continuous.Sources.Constant con3(k=0.4)
      annotation (Placement(transformation(extent={{-140,0},{-120,20}})));
    Fluid.Sources.Outside out(redeclare package Medium = MediumA, nPorts=2)
      annotation (Placement(transformation(extent={{-114,-40},{-94,-20}})));
  equation
    connect(con.y, reaScaRep.u) annotation (Line(points={{-118,40},{-102,40}},
                       color={0,0,127}));
    connect(reaScaRep.y, zon.qGai_flow) annotation (Line(points={{-78,40},{-50,
            40},{-50,50},{-32,50}},
                              color={0,0,127}));
    connect(zon.TAir, thermostat.TZon) annotation (Line(points={{11,58},{32,58},
            {32,8},{38,8}}, color={0,0,127}));
    connect(con1.y, thermostat.TCooSet)
      annotation (Line(points={{32,0},{34,0},{34,2},{38,2}}, color={0,0,127}));
    connect(con2.y, thermostat.THeaSet) annotation (Line(points={{32,-40},{36,
            -40},{36,-2},{38,-2}}, color={0,0,127}));
    connect(thermostat.yCoo, fCU.uCoo) annotation (Line(points={{62,4},{80,4},{
            80,-60},{-20,-60},{-20,14},{-52,14},{-52,2}}, color={0,0,127}));
    connect(thermostat.yHea, fCU.uHea) annotation (Line(points={{62,0},{72,0},{
            72,-66},{-32,-66},{-32,8},{-68,8},{-68,2}}, color={0,0,127}));
    connect(thermostat.yFan, fCU.uFan) annotation (Line(points={{62,-4},{88,-4},
            {88,-72},{-38,-72},{-38,20},{-60,20},{-60,2}}, color={0,0,127}));
    connect(souCoo.ports[1], fCU.port_CCW_inlet) annotation (Line(points={{-20,
            -100},{-20,-80},{-56,-80},{-56,-52}}, color={0,127,255}));
    connect(sinCoo.ports[1], fCU.port_CCW_outlet) annotation (Line(points={{-50,
            -100},{-50,-84},{-60,-84},{-60,-52}}, color={0,127,255}));
    connect(souHea.ports[1], fCU.port_HHW_inlet) annotation (Line(points={{-80,
            -100},{-80,-80},{-68,-80},{-68,-52}}, color={0,127,255}));
    connect(sinHea.ports[1], fCU.port_HHW_outlet) annotation (Line(points={{
            -110,-100},{-110,-76},{-72,-76},{-72,-52}}, color={0,127,255}));
    connect(fCU.port_return, zon.ports[1]) annotation (Line(points={{-42,-22},{
            -12,-22},{-12,20.9}}, color={0,127,255}));
    connect(fCU.port_supply, zon.ports[2]) annotation (Line(points={{-42,-30},{
            -8,-30},{-8,20.9}}, color={0,127,255}));
    connect(con3.y, fCU.uOA)
      annotation (Line(points={{-118,10},{-76,10},{-76,2}}, color={0,0,127}));
    connect(building.weaBus, out.weaBus) annotation (Line(
        points={{-120,-30},{-118,-30},{-118,-29.8},{-114,-29.8}},
        color={255,204,51},
        thickness=0.5));
    connect(out.ports[1], fCU.port_OA_exhaust1) annotation (Line(points={{-94,
            -28},{-90,-28},{-90,-22},{-86,-22}}, color={0,127,255}));
    connect(out.ports[2], fCU.port_OA_inlet1) annotation (Line(points={{-94,-32},
            {-90,-32},{-90,-30},{-86,-30}}, color={0,127,255}));
    connect(fCU.TSupAir, thermostat.TSup) annotation (Line(points={{-40,-2},{0,
            -2},{0,-20},{34,-20},{34,-5},{38,-5}}, color={0,0,127}));
    connect(thermostat.yFan, thermostat.PFan) annotation (Line(points={{62,-4},
            {88,-4},{88,-72},{38,-72},{38,-8}},         color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,
              -160},{160,160}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,
              160}})),
      experiment(
        StopTime=864000,
        Interval=60,
        __Dymola_Algorithm="Dassl"));
  end use_case;

  package Types "Package with type definitions"
    extends Modelica.Icons.TypesPackage;

    type heatingCoil = enumeration(
        electric "Electric resistance heating coil",
        heatingHotWater "Hot-water heating coil")
        "Enumeration for the heating coil types" annotation (Documentation(info=
                                 "<html>
<p>
Enumeration for the type of heating coil used in the zone equipment.
The possible values are
</p>
<ol>
<li>
electric
</li>
<li>
heatingHotWater
</li>
</ol>
</html>",   revisions="<html>
<ul>
<li>
April 20, 2022 by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
    type capacityControl = enumeration(
        multispeedCyclingFanConstantWater "Multi-speed cycling fan with constant water flow rate",
        constantSpeedContinuousFanVariableWater "Constant speed continuous fan with variable water flow rate",
        variableSpeedFanConstantWater "Variable-speed fan with constant water flow rate",
        variableSpeedFanVariableWater "Variable-speed fan with variable water flow rate",
        multispeedFanCyclingSpeedConstantWater "Multi-speed fan with cycling between speeds and constant water flow",
        ASHRAE_90_1 "Fan speed control based on ASHRAE 90.1")
      "Enumeration for the capacity control types"
    annotation (Documentation(info="<html>
<p>
Enumeration for the type of capacity control used in the zone equipment.
The possible values are
</p>
<ol>
<li>
multispeedCyclingFanConstantWater
</li>
<li>
constantSpeedContinuousFanVariableWater
</li>
<li>
variableSpeedFanConstantWater
</li>
<li>
variableSpeedFanVariableWater
</li>
<li>
multispeedFanCyclingSpeedConstantWater
</li>
<li>
ASHRAE_90_1
</li>
</ol>
</html>",
    revisions="<html>
<ul>
<li>
April 20, 2022 by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
  annotation (Documentation(info="<html>
This package contains type definitions.
</html>"));
  end Types;

  model DER_mockup
    Controls.OBC.ASHRAE.G36_PR1.TerminalUnits.SetPoints.ZoneTemperatures
      TZonSet annotation (Placement(transformation(extent={{20,-20},{40,8}})));
    Controls.DemandResponse.Client client
      annotation (Placement(transformation(extent={{-60,0},{-40,20}})));
    Modelica.Blocks.Sources.CombiTimeTable combiTimeTable
      annotation (Placement(transformation(extent={{-60,-50},{-40,-30}})));
    DER_ReqdLink dER_ReqdLink
      annotation (Placement(transformation(extent={{-20,-20},{0,0}})));
  equation
    connect(client.PPreNoShe[1], dER_ReqdLink.u1) annotation (Line(points={{-39,
            15},{-30,15},{-30,-8},{-22,-8}}, color={0,0,127}));
    connect(combiTimeTable.y[1], dER_ReqdLink.u) annotation (Line(points={{-39,
            -40},{-30,-40},{-30,-12},{-22,-12}}, color={0,0,127}));
    connect(dER_ReqdLink.y, TZonSet.uCooDemLimLev) annotation (Line(points={{2,
            -10},{10,-10},{10,-12},{18,-12}}, color={255,127,0}));
    connect(dER_ReqdLink.y1, TZonSet.uHeaDemLimLev)
      annotation (Line(points={{2,-14},{18,-14}}, color={255,127,0}));
    connect(dER_ReqdLink.y2, client.yShed) annotation (Line(points={{2,-6},{10,
            -6},{10,30},{-70,30},{-70,5},{-61,5}}, color={0,0,127}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end DER_mockup;

  model DER_ReqdLink
    Controls.OBC.CDL.Interfaces.RealInput u annotation (Placement(
          transformation(extent={{-140,20},{-100,60}}), iconTransformation(
            extent={{-140,-40},{-100,0}})));
    Controls.OBC.CDL.Interfaces.RealInput u1 annotation (Placement(
          transformation(extent={{-140,-60},{-100,-20}}), iconTransformation(
            extent={{-140,0},{-100,40}})));
    Controls.OBC.CDL.Interfaces.IntegerOutput y annotation (Placement(
          transformation(extent={{100,-60},{140,-20}}), iconTransformation(
            extent={{100,-20},{140,20}})));
    Controls.OBC.CDL.Interfaces.IntegerOutput y1 annotation (Placement(
          transformation(extent={{100,-20},{140,20}}), iconTransformation(
            extent={{100,-60},{140,-20}})));
    Controls.OBC.CDL.Interfaces.RealOutput y2 annotation (Placement(
          transformation(extent={{100,20},{140,60}}), iconTransformation(extent
            ={{100,20},{140,60}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(
            extent={{-100,100},{100,-100}},
            lineColor={0,0,0},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid)}), Diagram(coordinateSystem(
            preserveAspectRatio=false)));
  end DER_ReqdLink;
end Trial;
