within Buildings;
package Trial
  partial model Basecalss_externalInterfaces1
    Modelica.Fluid.Interfaces.FluidPort_a port_return
      annotation (Placement(transformation(extent={{150,30},{170,50}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_supply
      annotation (Placement(transformation(extent={{150,-50},{170,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_CCW_outlet
      annotation (Placement(transformation(extent={{-80,-170},{-60,-150}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_CCW_inlet
      annotation (Placement(transformation(extent={{-40,-170},{-20,-150}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_HHW_outlet
      annotation (Placement(transformation(extent={{20,-170},{40,-150}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_HHW_inlet
      annotation (Placement(transformation(extent={{60,-170},{80,-150}})));
    Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet
      annotation (Placement(transformation(extent={{-170,-50},{-150,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust
      annotation (Placement(transformation(extent={{-170,30},{-150,50}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})));
  end Basecalss_externalInterfaces1;

  partial model Baseclass_externalInterfaces2
    extends Buildings.Trial.Basecalss_externalInterfaces1;
    Modelica.Fluid.Interfaces.FluidPort_a port_OA_inlet
      annotation (Placement(transformation(extent={{-110,-50},{-90,-30}})));
    Modelica.Fluid.Interfaces.FluidPort_b port_OA_exhaust
      annotation (Placement(transformation(extent={{-110,30},{-90,50}})));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Baseclass_externalInterfaces2;

  partial model Baseclass_componentInterfaces1
    extends Buildings.Trial.Basecalss_externalInterfaces1;
    replaceable Fluid.Interfaces.PartialTwoPortInterface coolingCoil_DX
      annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
    replaceable Fluid.Interfaces.PartialTwoPortInterface heatingCoil_electric
      annotation (Placement(transformation(extent={{40,-50},{60,-30}})));
    Fluid.Movers.FlowControlled_m_flow fan
      annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
    Fluid.FixedResistances.BaseClasses.Pipe duct(nSeg=nSeg)
      annotation (Placement(transformation(extent={{-8,-50},{12,-30}})));
    parameter Integer nSeg=10 "Number of volume segments";
    replaceable Fluid.HeatExchangers.DryCoilCounterFlow heatingCoil_HHW
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={50,0})));
    replaceable Fluid.HeatExchangers.WetCoilCounterFlow coolingCoil_CCW
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={-30,0})));
    Fluid.Actuators.Valves.TwoWayLinear val
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={-12,-80})));
    Fluid.Actuators.Valves.TwoWayLinear val1
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
          origin={70,-80})));
  equation
    connect(fan.port_b, coolingCoil_DX.port_a)
      annotation (Line(points={{-60,-40},{-40,-40}}, color={0,127,255}));
    connect(heatingCoil_electric.port_b, port_supply)
      annotation (Line(points={{60,-40},{160,-40}}, color={0,127,255}));
    connect(coolingCoil_DX.port_b,duct. port_a)
      annotation (Line(points={{-20,-40},{-8,-40}},  color={0,127,255}));
    connect(duct.port_b, heatingCoil_electric.port_a)
      annotation (Line(points={{12,-40},{40,-40}}, color={0,127,255}));
    connect(duct.port_b, heatingCoil_HHW.port_a2) annotation (Line(points={{12,-40},
            {20,-40},{20,6},{40,6}}, color={0,127,255}));
    connect(heatingCoil_HHW.port_b2, port_supply) annotation (Line(points={{60,6},{
            80,6},{80,-40},{160,-40}},  color={0,127,255}));
    connect(fan.port_b, coolingCoil_CCW.port_a2) annotation (Line(points={{-60,-40},
            {-50,-40},{-50,6},{-40,6}}, color={0,127,255}));
    connect(coolingCoil_CCW.port_b2, duct.port_a) annotation (Line(points={{-20,6},
            {-14,6},{-14,-40},{-8,-40}}, color={0,127,255}));
    connect(coolingCoil_CCW.port_b1, port_CCW_outlet) annotation (Line(points={{-40,
            -6},{-56,-6},{-56,-100},{-70,-100},{-70,-160}}, color={0,127,255}));
    connect(port_HHW_outlet, heatingCoil_HHW.port_b1)
      annotation (Line(points={{30,-160},{30,-6},{40,-6}}, color={0,127,255}));
    connect(port_HHW_inlet, val1.port_a)
      annotation (Line(points={{70,-160},{70,-90}}, color={0,127,255}));
    connect(val1.port_b, heatingCoil_HHW.port_a1)
      annotation (Line(points={{70,-70},{70,-6},{60,-6}}, color={0,127,255}));
    connect(port_CCW_inlet, val.port_a) annotation (Line(points={{-30,-160},{
            -30,-100},{-12,-100},{-12,-90}}, color={0,127,255}));
    connect(val.port_b, coolingCoil_CCW.port_a1) annotation (Line(points={{-12,
            -70},{-12,-6},{-20,-6}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
          coordinateSystem(preserveAspectRatio=false)));
  end Baseclass_componentInterfaces1;

  partial model Baseclass_componentInterfaces2
    extends Buildings.Trial.Baseclass_componentInterfaces1;
    Fluid.Actuators.Dampers.MixingBox eco
      annotation (Placement(transformation(extent={{-130,-2},{-110,18}})));
    Fluid.FixedResistances.BaseClasses.Pipe duct1(nSeg=nSeg)
      annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
          origin={0,60})));
  equation
    connect(eco.port_Sup, fan.port_a) annotation (Line(points={{-110,14},{-90,14},
            {-90,-40},{-80,-40}}, color={0,127,255}));
    connect(eco.port_Ret, port_return) annotation (Line(points={{-110,2},{-70,2},{
            -70,40},{160,40}}, color={0,127,255}));
    connect(port_OA_inlet, eco.port_Out) annotation (Line(points={{-160,-40},{-140,
            -40},{-140,14},{-130,14}}, color={0,127,255}));
    connect(port_OA_exhaust, eco.port_Exh) annotation (Line(points={{-160,40},{-134,
            40},{-134,2},{-130,2}}, color={0,127,255}));
    connect(port_return, duct1.port_a) annotation (Line(points={{160,40},{20,40},
            {20,60},{10,60}}, color={0,127,255}));
    connect(duct1.port_b, fan.port_a) annotation (Line(points={{-10,60},{-80,60},
            {-80,-40}}, color={0,127,255}));
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},
              {160,160}})),                                        Diagram(
          coordinateSystem(preserveAspectRatio=false, extent={{-160,-160},{160,160}})));
  end Baseclass_componentInterfaces2;
end Trial;
