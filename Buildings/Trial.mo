within Buildings;
package Trial
  partial model Basecalss_externalInterfaces1
    Modelica.Fluid.Interfaces.FluidPort_a port_return
      annotation (Placement(transformation(extent={{210,30},{230,50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_supply
      annotation (Placement(transformation(extent={{210,-50},{230,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_CCW_outlet
      annotation (Placement(transformation(extent={{30,-230},{50,-210}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_CCW_inlet
      annotation (Placement(transformation(extent={{70,-230},{90,-210}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_HHW_outlet
      annotation (Placement(transformation(extent={{-90,-230},{-70,-210}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_HHW_inlet
      annotation (Placement(transformation(extent={{-50,-230},{-30,-210}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet
      annotation (Placement(transformation(extent={{-230,-50},{-210,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust
      annotation (Placement(transformation(extent={{-230,30},{-210,50}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -220},{220,220}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-220,-220},{220,
              220}})));
  end Basecalss_externalInterfaces1;

  partial model Baseclass_externalInterfaces2
    extends Buildings.Trial.Basecalss_externalInterfaces1;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Baseclass_externalInterfaces2;

  partial model Baseclass_componentInterfaces2
    extends Buildings.Trial.Baseclass_componentInterfaces1;
    Fluid.Actuators.Dampers.MixingBox eco
      annotation (Placement(transformation(extent={{-164,0},{-144,20}})));
    Fluid.Sensors.VolumeFlowRate senVolFlo2
      annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));
    Fluid.Sensors.TemperatureTwoPort senTem2
      annotation (Placement(transformation(extent={{-138,-50},{-118,-30}})));
  equation
    connect(senVolFlo1.port_b, eco.port_Ret) annotation (Line(points={{160,40},
            {-130,40},{-130,4},{-144,4}}, color={0,127,255}));
    connect(port_OA_inlet, senVolFlo2.port_a)
      annotation (Line(points={{-220,-40},{-200,-40}}, color={0,127,255}));
    connect(senVolFlo2.port_b, eco.port_Out) annotation (Line(points={{-180,-40},
            {-170,-40},{-170,16},{-164,16}}, color={0,127,255}));
    connect(port_OA_exhaust, eco.port_Exh) annotation (Line(points={{-220,40},{
            -180,40},{-180,4},{-164,4}}, color={0,127,255}));
    connect(eco.port_Sup, senTem2.port_a) annotation (Line(points={{-144,16},{
            -138,16},{-138,-40}}, color={0,127,255}));
    connect(senTem2.port_b, fan.port_a)
      annotation (Line(points={{-118,-40},{-110,-40}}, color={0,127,255}));
    connect(senVolFlo1.port_b, senTem2.port_a) annotation (Line(points={{160,40},
            {-130,40},{-130,-4},{-138,-4},{-138,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-220,
              -220},{220,220}})),                                  Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-220,-220},{220,
              220}})));
  end Baseclass_componentInterfaces2;

  partial model Baseclass_componentInterfaces1
    extends Buildings.Trial.Basecalss_externalInterfaces1;
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
end Trial;
