within Buildings.Examples;
model HeatPumpPlant_Hydronics
  extends Modelica.Icons.Example;
  parameter Modelica.Units.SI.MassFlowRate m_priEnergyFlow_nominal
    "Nominal flowrate in primary energy loop";

  Fluid.FixedResistances.Junction jun(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=-90,
        origin={140,110})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov(redeclare package Medium =
        Media.Water, m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{-140,140},{-120,160}})));
  Fluid.FixedResistances.Junction jun1(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{90,100},{110,120}})));
  Fluid.FixedResistances.Junction jun2(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Fluid.FixedResistances.Junction jun3(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=90,
        origin={-160,110})));
  Fluid.FixedResistances.Junction jun4(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={140,40})));
  Fluid.Actuators.Valves.TwoWayLinear val(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={140,80})));
  Fluid.Actuators.Valves.TwoWayLinear val1(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={100,0})));
  Fluid.FixedResistances.Junction jun5(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={100,-40})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov1(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{60,30},{80,50}})));
  Fluid.FixedResistances.Junction jun6(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{170,30},{190,50}})));
  Fluid.Actuators.Valves.TwoWayLinear val2(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={180,0})));
  Fluid.FixedResistances.Junction jun7(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={180,-40})));
  Fluid.FixedResistances.PressureDrop
                              res(redeclare package Medium = Media.Water,
      m_flow_nominal=m_priEnergyFlow_nominal)
    annotation (Placement(transformation(extent={{80,140},{100,160}})));
  Fluid.FixedResistances.Pipe pip1(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{20,30},{40,50}})));
  Fluid.FixedResistances.Pipe pip2(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{210,30},{230,50}})));
  Fluid.FixedResistances.Pipe pip3(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-40,30},{-20,50}})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov2(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-70,40})));
  Fluid.FixedResistances.Junction jun8(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-110,40})));
  Fluid.Actuators.Valves.TwoWayLinear val3(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-110,80})));
  Fluid.Actuators.Valves.TwoWayLinear val4(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-160,0})));
  Fluid.FixedResistances.Junction jun9(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-160,-40})));
  Fluid.FixedResistances.Junction jun10(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-200,30},{-180,50}})));
  Fluid.FixedResistances.Junction jun11(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-190,-40})));
  Fluid.Actuators.Valves.TwoWayLinear val5(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-190,0})));
  Fluid.FixedResistances.Pipe pip4(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-240,30},{-220,50}})));
  Fluid.Actuators.Valves.TwoWayLinear val6(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={250,0})));
  Fluid.FixedResistances.Junction jun12(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{240,30},{260,50}})));
  Fluid.FixedResistances.Junction jun13(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={250,-40})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov3(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{280,30},{300,50}})));
  Fluid.Sources.Boundary_pT bou(redeclare package Medium = Media.Water,
                                nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={330,-40})));
  Fluid.Sources.Boundary_pT bou1(redeclare package Medium = Media.Water,
                                 nPorts=1)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={330,40})));
  Fluid.FixedResistances.Junction jun14(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-260,-40})));
  Fluid.FixedResistances.Junction jun15(redeclare package Medium = Media.Water)
    annotation (Placement(transformation(extent={{-270,30},{-250,50}})));
  Fluid.Actuators.Valves.TwoWayLinear val7(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},rotation=-90,
        origin={-260,0})));
  Fluid.Movers.Preconfigured.FlowControlled_dp mov4(redeclare package Medium =
        Media.Water)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}}, rotation=180,
        origin={-300,40})));
  Fluid.Sources.Boundary_pT bou2(redeclare package Medium = Media.Water,
                                 nPorts=1)
    annotation (Placement(transformation(extent={{-350,30},{-330,50}})));
  Fluid.Sources.Boundary_pT bou3(redeclare package Medium = Media.Water, nPorts=
       1)
    annotation (Placement(transformation(extent={{-350,-50},{-330,-30}})));
  Controls.OBC.CDL.Reals.MultiplyByParameter gai(k=-1)
    annotation (Placement(transformation(extent={{200,-100},{220,-80}})));
  Controls.OBC.CDL.Reals.AddParameter addPar(p=1)
    annotation (Placement(transformation(extent={{240,-100},{260,-80}})));
  Controls.OBC.CDL.Reals.MultiplyByParameter gai1(k=-1)
    annotation (Placement(transformation(extent={{-170,-100},{-150,-80}})));
  Controls.OBC.CDL.Reals.AddParameter addPar1(p=1)
    annotation (Placement(transformation(extent={{-130,-100},{-110,-80}})));
equation
  connect(jun1.port_2, jun.port_3)
    annotation (Line(points={{110,110},{130,110}},
                                               color={0,127,255}));
  connect(jun2.port_2, jun1.port_1)
    annotation (Line(points={{-100,110},{90,110}},
                                                color={0,127,255}));
  connect(jun3.port_3, jun2.port_1)
    annotation (Line(points={{-150,110},{-120,110}},
                                                 color={0,127,255}));
  connect(jun3.port_2, mov.port_a) annotation (Line(points={{-160,120},{-160,150},
          {-140,150}},        color={0,127,255}));
  connect(jun4.port_3, val.port_b)
    annotation (Line(points={{140,50},{140,70}},color={0,127,255}));
  connect(val.port_a, jun.port_2)
    annotation (Line(points={{140,90},{140,100}},color={0,127,255}));
  connect(val1.port_a, jun1.port_3)
    annotation (Line(points={{100,10},{100,100}},
                                                color={0,127,255}));
  connect(jun5.port_3, val1.port_b)
    annotation (Line(points={{100,-30},{100,-10}},
                                              color={0,127,255}));
  connect(mov1.port_b, jun4.port_2)
    annotation (Line(points={{80,40},{130,40}},color={0,127,255}));
  connect(jun4.port_1, jun6.port_1)
    annotation (Line(points={{150,40},{170,40}},color={0,127,255}));
  connect(val2.port_a, jun6.port_3)
    annotation (Line(points={{180,10},{180,30}},          color={0,127,255}));
  connect(jun5.port_1, jun7.port_2)
    annotation (Line(points={{110,-40},{170,-40}},color={0,127,255}));
  connect(jun7.port_3, val2.port_b)
    annotation (Line(points={{180,-30},{180,-10}},
                                                color={0,127,255}));
  connect(mov.port_b,res. port_a)
    annotation (Line(points={{-120,150},{80,150}}, color={0,127,255}));
  connect(res.port_b, jun.port_1)
    annotation (Line(points={{100,150},{140,150},{140,120}},
                                                          color={0,127,255}));
  connect(pip1.port_b, mov1.port_a)
    annotation (Line(points={{40,40},{60,40}}, color={0,127,255}));
  connect(jun5.port_2, pip1.port_a) annotation (Line(points={{90,-40},{10,-40},{
          10,40},{20,40}},    color={0,127,255}));
  connect(jun6.port_2, pip2.port_a)
    annotation (Line(points={{190,40},{210,40}}, color={0,127,255}));
  connect(mov2.port_a, pip3.port_a)
    annotation (Line(points={{-60,40},{-40,40}},   color={0,127,255}));
  connect(jun8.port_1, mov2.port_b)
    annotation (Line(points={{-100,40},{-80,40}},  color={0,127,255}));
  connect(jun8.port_3, val3.port_b)
    annotation (Line(points={{-110,50},{-110,70}},  color={0,127,255}));
  connect(val3.port_a, jun2.port_3)
    annotation (Line(points={{-110,90},{-110,100}},  color={0,127,255}));
  connect(val4.port_a, jun3.port_1)
    annotation (Line(points={{-160,10},{-160,100}}, color={0,127,255}));
  connect(jun9.port_3, val4.port_b)
    annotation (Line(points={{-160,-30},{-160,-10}},
                                                  color={0,127,255}));
  connect(jun9.port_1, pip3.port_b) annotation (Line(points={{-150,-40},{-10,-40},
          {-10,40},{-20,40}}, color={0,127,255}));
  connect(jun10.port_2, jun8.port_2)
    annotation (Line(points={{-180,40},{-120,40}}, color={0,127,255}));
  connect(jun11.port_1, jun9.port_2)
    annotation (Line(points={{-180,-40},{-170,-40}}, color={0,127,255}));
  connect(val5.port_a, jun10.port_3)
    annotation (Line(points={{-190,10},{-190,30}}, color={0,127,255}));
  connect(val5.port_b, jun11.port_3)
    annotation (Line(points={{-190,-10},{-190,-30}},
                                                  color={0,127,255}));
  connect(pip4.port_b, jun10.port_1)
    annotation (Line(points={{-220,40},{-200,40}}, color={0,127,255}));
  connect(pip2.port_b, jun12.port_1)
    annotation (Line(points={{230,40},{240,40}}, color={0,127,255}));
  connect(jun12.port_3, val6.port_a)
    annotation (Line(points={{250,30},{250,10}}, color={0,127,255}));
  connect(jun7.port_1, jun13.port_2)
    annotation (Line(points={{190,-40},{240,-40}}, color={0,127,255}));
  connect(jun13.port_3, val6.port_b)
    annotation (Line(points={{250,-30},{250,-10}},
                                                color={0,127,255}));
  connect(jun12.port_2, mov3.port_a)
    annotation (Line(points={{260,40},{280,40}}, color={0,127,255}));
  connect(jun13.port_1, bou.ports[1])
    annotation (Line(points={{260,-40},{320,-40}}, color={0,127,255}));
  connect(mov3.port_b, bou1.ports[1])
    annotation (Line(points={{300,40},{320,40}}, color={0,127,255}));
  connect(jun14.port_1, jun11.port_2)
    annotation (Line(points={{-250,-40},{-200,-40}}, color={0,127,255}));
  connect(jun15.port_2, pip4.port_a)
    annotation (Line(points={{-250,40},{-240,40}}, color={0,127,255}));
  connect(val7.port_a, jun15.port_3)
    annotation (Line(points={{-260,10},{-260,30}}, color={0,127,255}));
  connect(val7.port_b, jun14.port_3)
    annotation (Line(points={{-260,-10},{-260,-30}}, color={0,127,255}));
  connect(mov4.port_a, jun15.port_1)
    annotation (Line(points={{-290,40},{-270,40}}, color={0,127,255}));
  connect(bou2.ports[1], mov4.port_b)
    annotation (Line(points={{-330,40},{-310,40}}, color={0,127,255}));
  connect(bou3.ports[1], jun14.port_2)
    annotation (Line(points={{-330,-40},{-270,-40}}, color={0,127,255}));
  connect(gai.u, val2.y_actual) annotation (Line(points={{198,-90},{194,-90},{194,
          -5},{187,-5}}, color={0,0,127}));
  connect(gai.y, addPar.u)
    annotation (Line(points={{222,-90},{238,-90}}, color={0,0,127}));
  connect(addPar.y, val6.y) annotation (Line(points={{262,-90},{280,-90},{280,0},
          {262,0}}, color={0,0,127}));
  connect(val.y_actual, val1.y) annotation (Line(points={{147,75},{147,60},{120,
          60},{120,0},{112,0}}, color={0,0,127}));
  connect(val3.y_actual, val4.y) annotation (Line(points={{-103,75},{-103,60},{-140,
          60},{-140,0},{-148,0}}, color={0,0,127}));
  connect(gai1.y, addPar1.u)
    annotation (Line(points={{-148,-90},{-132,-90}}, color={0,0,127}));
  connect(addPar1.y, val7.y) annotation (Line(points={{-108,-90},{-100,-90},{-100,
          -120},{-240,-120},{-240,0},{-248,0}}, color={0,0,127}));
  connect(val5.y_actual, gai1.u) annotation (Line(points={{-183,-5},{-183,-12},{
          -176,-12},{-176,-90},{-172,-90}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
            {100,100}})),                                        Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-360,-200},{360,200}})));
end HeatPumpPlant_Hydronics;
