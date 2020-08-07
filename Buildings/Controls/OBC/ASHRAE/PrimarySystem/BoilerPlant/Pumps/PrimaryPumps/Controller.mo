within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps;
block Controller
    "Sequences to control hot water pumps in primary-only plant system"

  parameter Boolean isHeadered = true
    "Flag of headered hot water pumps design: true=headered, false=dedicated";

  parameter Boolean haveLocalSensor = false
    "Flag of local DP sensor: true=local DP sensor hardwired to controller";

  parameter Integer nPum = 2
    "Total number of hot water pumps";

  parameter Integer nBoi = 2
    "Total number of boilers";

  parameter Integer nSen=2
    "Total number of remote differential pressure sensors";

  parameter Real minPumSpe(
    final unit="1",
    displayUnit="1",
    final min=0,
    final max=maxPumSpe) = 0.1
    "Minimum pump speed";

  parameter Real maxPumSpe(
    final unit="1",
    displayUnit="1",
    final min=minPumSpe,
    final max=1) = 1
    "Maximum pump speed";

  parameter Integer nPum_nominal(
    final max=nPum,
    final min=1) = nPum
    "Total number of pumps that operate at design conditions"
    annotation (Dialog(group="Nominal conditions"));

  parameter Real VChiWat_flow_nominal(
    final min=1e-6,
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate") = 0.5
    "Total plant design hot water flow rate"
    annotation (Dialog(group="Nominal conditions"));

  parameter Real maxLocDp(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference",
    final min=1e-6) = 5*6894.75
    "Maximum hot water loop local differential pressure setpoint"
    annotation (Dialog(group="Pump speed control when there is local DP sensor", enable=haveLocalSensor));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerType=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(group="Speed controller"));

  parameter Real k(
    final unit="1",
    displayUnit="1")=1
    "Gain of controller"
    annotation (Dialog(group="Speed controller"));

  parameter Real Ti(
    final unit="1",
    displayUnit="1") = 0.5
    "Time constant of integrator block"
    annotation (Dialog(group="Speed controller"));

  parameter Real Td(
    final unit="1",
    displayUnit="1") = 0.1
    "Time constant of derivative block"
    annotation (Dialog(group="Speed controller",
    enable=
      controllerType == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
      controllerType == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  final parameter Real minLocDp(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference",
    final min=1e-6) = 5*6894.75
    "Minimum hot water loop local differential pressure setpoint"
    annotation (Dialog(group="Pump speed control when there is local DP sensor", enable=haveLocalSensor));

  final parameter Integer pumInd[nPum]={i for i in 1:nPum}
    "Pump index, {1,2,...,n}";

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uPumLeaLag[nPum]
    "Hot water pump lead-lag order"
    annotation (Placement(transformation(extent={{-320,210},{-280,250}}),
      iconTransformation(extent={{-140,70},{-100,110}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHotWatPum[nPum]
    "Hot water pumps operating status"
    annotation (Placement(transformation(extent={{-320,120},{-280,160}}),
      iconTransformation(extent={{-140,50},{-100,90}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPlaEna if not isHeadered
    "Plant enabling status"
    annotation (Placement(transformation(extent={{-320,90},{-280,130}}),
      iconTransformation(extent={{-140,30},{-100,70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHotIsoVal[nBoi] if isHeadered
    "Hot water isolation valve status"
    annotation (Placement(transformation(extent={{-320,50},{-280,90}}),
      iconTransformation(extent={{-140,-30},{-100,10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWat_flow(
    final unit="m3/s")
    "Hot water flow"
    annotation (Placement(transformation(extent={{-320,-40},{-280,0}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHotWat_local(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") if haveLocalSensor
    "Hot water differential static pressure from local sensor"
    annotation (Placement(transformation(extent={{-320,-180},{-280,-140}}),
      iconTransformation(extent={{-140,-70},{-100,-30}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHotWat_remote[nSen](
    final unit=fill("Pa", nSen),
    final quantity=fill("PressureDifference", nSen))
    "Hot water differential static pressure from remote sensor"
    annotation (Placement(transformation(extent={{-320,-220},{-280,-180}}),
      iconTransformation(extent={{-140,-90},{-100,-50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHotWatSet(
    final unit="Pa",
    final quantity="PressureDifference")
    "Hot water differential static pressure setpoint"
    annotation (Placement(transformation(extent={{-320,-260},{-280,-220}}),
      iconTransformation(extent={{-140,-110},{-100,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHotWatPum[nPum]
    "Hot water pump status"
    annotation (Placement(transformation(extent={{280,-20},{320,20}}),
      iconTransformation(extent={{100,60},{140,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumSpe[nPum](
    final min=fill(0, nPum),
    final max=fill(1, nPum),
    final unit=fill("1", nPum))
    "Hot water pump speed"
    annotation (Placement(transformation(extent={{280,-220},{320,-180}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_dedicated
    enaDedLeaPum if not isHeadered
    "Enable lead pump of dedicated pumps"
    annotation (Placement(transformation(extent={{-200,100},{-180,120}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_headered
    enaHeaLeaPum(final nBoi=nBoi) if isHeadered
    "Enable lead pump of headered pumps"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLag_headered
    enaLagChiPum(
    final nPum=nPum,
    final nPum_nominal=nPum_nominal,
    final VChiWat_flow_nominal=VChiWat_flow_nominal)
    "Enable lag pump for primary-only plants using differential pressure pump speed control"
    annotation (Placement(transformation(extent={{-200,-10},{-180,10}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_localDp
    pumSpeLocDp(
    final nSen=nSen,
    final nPum=nPum,
    final minLocDp=minLocDp,
    final maxLocDp=maxLocDp,
    final minPumSpe=minPumSpe,
    final maxPumSpe=maxPumSpe,
    final controllerType=controllerType,
    final k=k,
    final Ti=Ti,
    final Td=Td) if haveLocalSensor
    "Hot water pump speed control with local DP sensor"
    annotation (Placement(transformation(extent={{-60,-210},{-40,-190}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_remoteDp
    pumSpeRemDp(
    final nSen=nSen,
    final nPum=nPum,
    final minPumSpe=minPumSpe,
    final maxPumSpe=maxPumSpe,
    final controllerType=controllerType,
    final k=k,
    final Ti=Ti,
    final Td=Td) if not haveLocalSensor
    "Hot water pump speed control with remote DP sensor"
    annotation (Placement(transformation(extent={{-60,-250},{-40,-230}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch leaPumSta[nPum]
    "Lead pump status"
    annotation (Placement(transformation(extent={{120,180},{140,200}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch nexLagPumSta[nPum]
    "Next lag pump status"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch lasLagPumSta[nPum]
    "Last lag pump status"
    annotation (Placement(transformation(extent={{120,-100},{140,-80}})));

  Buildings.Controls.OBC.CDL.Logical.Or enaPum[nPum]
    "Hot water pump status"
    annotation (Placement(transformation(extent={{180,-40},{200,-20}})));

  Buildings.Controls.OBC.CDL.Logical.And pumSta[nPum]
    "Hot water pump status"
    annotation (Placement(transformation(extent={{180,-100},{200,-80}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch addPum[nPum]
    "Add pump"
    annotation (Placement(transformation(extent={{240,-10},{260,10}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch remPum[nPum]
    "Remove pump"
    annotation (Placement(transformation(extent={{220,-80},{240,-60}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_flow hotPumSpe(
    final primarySecondarySensors=true)
    annotation (Placement(transformation(extent={{-60,-294},{-40,-274}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_temperature hotPumSpe1(
    final primarySecondarySensors=false)
    annotation (Placement(transformation(extent={{-60,-328},{-40,-308}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWatSec_flow(
    final unit="m3/s")
    "Measured hot water flowrate through secondary loop"
    annotation (Placement(transformation(extent={{-320,-320},{-280,-280}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWatDec_flow(
    final unit="m3/s")
    "Measured hot water flowrate through decoupler"
    annotation (Placement(transformation(extent={{-320,-350},{-280,-310}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatPri(
    final unit="K")
    "Measured hot water temperature at primary loop supply"
    annotation (Placement(transformation(extent={{-320,-380},{-280,-340}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSec(
    final unit="K")
    "Measured hot water temperature at secondary loop supply"
    annotation (Placement(transformation(extent={{-320,-410},{-280,-370}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatBoiSup[nBoi](
    final unit=fill("K", nBoi))
    "Measured hot water temperature at boiler supply"
    annotation (Placement(transformation(extent={{-320,-440},{-280,-400}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uBoiSta[nBoi] if not isHeadered
    "Boiler status vector"
    annotation (Placement(transformation(extent={{-320,-90},{-280,-50}}),
      iconTransformation(extent={{-140,10},{-100,50}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[nBoi]
    annotation (Placement(transformation(extent={{-252,-80},{-232,-60}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor extIndSig(
    final nin=nBoi)
    annotation (Placement(transformation(extent={{-222,-80},{-202,-60}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr(
    final threshold=1)
    annotation (Placement(transformation(extent={{-192,-80},{-172,-60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-220,190},{-200,210}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep(
    final nout=nPum)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{0,220},{20,240}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=nPum)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{0,100},{20,120}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep1(
    final nout=nPum)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(
    final nout=nPum)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep2(
    final nout=nPum)
    "Replicate integer input"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep2(
    final nout=nPum)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(
    final nout=nPum)
    "Replicate real input"
    annotation (Placement(transformation(extent={{0,-210},{20,-190}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[nPum]
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-220,220},{-200,240}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor leaPum(
    final nin=nPum)
    "Lead pump index"
    annotation (Placement(transformation(extent={{-80,220},{-60,240}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-40,220},{-20,240}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant pumIndCon[nPum](
    final k=pumInd)
    "Pump index array"
    annotation (Placement(transformation(extent={{-220,160},{-200,180}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1[nPum]
    "Check lead pump"
    annotation (Placement(transformation(extent={{60,180},{80,200}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor nexLagPum(
    final nin=nPum)
    "Next lag pump"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2[nPum]
    "Check next lag pump"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor lasLagPum(
    final nin=nPum)
    "Last lag pump"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu3[nPum]
    "Check next lag pump"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[nPum]
    "Convert boolean to integer"
    annotation (Placement(transformation(extent={{-200,-130},{-180,-110}})));

  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt(
    final nin=nPum)
    "Sum of integer inputs"
    annotation (Placement(transformation(extent={{-160,-130},{-140,-110}})));

  Buildings.Controls.OBC.CDL.Integers.Add addInt
    "Integer add"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));

  CDL.Interfaces.BooleanInput uPumChaPro if                     not isHeadered
    "Signal indicating start of pump change process" annotation (Placement(
        transformation(extent={{-320,10},{-280,50}}), iconTransformation(extent
          ={{-140,30},{-100,70}})));
equation
  connect(enaDedLeaPum.uPlaEna, uPlaEna) annotation (Line(points={{-202,115},{-240,
          115},{-240,110},{-300,110}}, color={255,0,255}));

  connect(uPumLeaLag, intToRea.u)
    annotation (Line(points={{-300,230},{-222,230}}, color={255,127,0}));

  connect(intToRea.y, leaPum.u)
    annotation (Line(points={{-198,230},{-82,230}}, color={0,0,127}));

  connect(conInt.y, leaPum.index)
    annotation (Line(points={{-198,200},{-70,200},{-70,218}}, color={255,127,0}));

  connect(leaPum.y, reaToInt.u)
    annotation (Line(points={{-58,230},{-42,230}},color={0,0,127}));

  connect(reaToInt.y, intRep.u)
    annotation (Line(points={{-18,230},{-2,230}}, color={255,127,0}));

  connect(intRep.y, intEqu1.u1)
    annotation (Line(points={{22,230},{30,230},{30,190},{58,190}}, color={255,127,0}));

  connect(pumIndCon.y, intEqu1.u2)
    annotation (Line(points={{-198,170},{40,170},{40,182},{58,182}},
      color={255,127,0}));

  connect(intEqu1.y, leaPumSta.u2)
    annotation (Line(points={{82,190},{118,190}},  color={255,0,255}));

  connect(uHotWatPum, leaPumSta.u3)
    annotation (Line(points={{-300,140},{100,140},{100,182},{118,182}},
      color={255,0,255}));

  connect(booRep.y, leaPumSta.u1)
    annotation (Line(points={{22,110},{90,110},{90,198},{118,198}},
      color={255,0,255}));

  connect(intToRea.y, nexLagPum.u)
    annotation (Line(points={{-198,230},{-160,230},{-160,-50},{-82,-50}},
      color={0,0,127}));

  connect(nexLagPum.y, reaToInt1.u)
    annotation (Line(points={{-58,-50},{-42,-50}}, color={0,0,127}));

  connect(reaToInt1.y, intRep1.u)
    annotation (Line(points={{-18,-50},{-2,-50}}, color={255,127,0}));

  connect(intRep1.y, intEqu2.u2)
    annotation (Line(points={{22,-50},{30,-50},{30,-38},{58,-38}}, color={255,127,0}));

  connect(pumIndCon.y, intEqu2.u1)
    annotation (Line(points={{-198,170},{40,170},{40,-30},{58,-30}},
      color={255,127,0}));

  connect(intEqu2.y, nexLagPumSta.u2)
    annotation (Line(points={{82,-30},{118,-30}},  color={255,0,255}));

  connect(booRep1.y, nexLagPumSta.u1)
    annotation (Line(points={{-18,30},{110,30},{110,-22},{118,-22}},
      color={255,0,255}));

  connect(uHotWatPum, nexLagPumSta.u3)
    annotation (Line(points={{-300,140},{100,140},{100,-38},{118,-38}},
      color={255,0,255}));

  connect(lasLagPum.y, reaToInt2.u)
    annotation (Line(points={{-58,-100},{-42,-100}}, color={0,0,127}));

  connect(reaToInt2.y, intRep2.u)
    annotation (Line(points={{-18,-100},{-2,-100}}, color={255,127,0}));

  connect(intRep2.y, intEqu3.u2)
    annotation (Line(points={{22,-100},{30,-100},{30,-98},{58,-98}},
      color={255,127,0}));

  connect(pumIndCon.y, intEqu3.u1)
    annotation (Line(points={{-198,170},{40,170},{40,-90},{58,-90}},
      color={255,127,0}));

  connect(intEqu3.y, lasLagPumSta.u2)
    annotation (Line(points={{82,-90},{118,-90}},    color={255,0,255}));

  connect(enaLagChiPum.VHotWat_flow,VHotWat_flow)
    annotation (Line(points={{-202,4},{-266,4},{-266,-20},{-300,-20}},
      color={0,0,127}));

  connect(uHotWatPum,enaLagChiPum.uHotWatPum)
    annotation (Line(points={{-300,140},{-260,140},{-260,-3.8},{-202,-3.8}},
      color={255,0,255}));

  connect(intToRea.y, lasLagPum.u)
    annotation (Line(points={{-198,230},{-160,230},{-160,-100},{-82,-100}},
      color={0,0,127}));

  connect(booRep2.y, lasLagPumSta.u1)
    annotation (Line(points={{-18,-10},{90,-10},{90,-82},{118,-82}},
      color={255,0,255}));

  connect(uHotWatPum, lasLagPumSta.u3)
    annotation (Line(points={{-300,140},{100,140},{100,-98},{118,-98}},
      color={255,0,255}));

  connect(nexLagPumSta.y,enaPum. u2)
    annotation (Line(points={{142,-30},{150,-30},{150,-38},{178,-38}},
      color={255,0,255}));

  connect(leaPumSta.y,enaPum. u1)
    annotation (Line(points={{142,190},{160,190},{160,-30},{178,-30}},
      color={255,0,255}));

  connect(pumSpeLocDp.dpHotWat_local,dpHotWat_local)
    annotation (Line(points={{-62,-192},{-230,-192},{-230,-160},{-300,-160}},
      color={0,0,127}));

  connect(pumSpeLocDp.dpHotWat_remote,dpHotWat_remote)
    annotation (Line(points={{-62,-204},{-200,-204},{-200,-200},{-300,-200}},
      color={0,0,127}));

  connect(pumSpeLocDp.dpHotWatSet,dpHotWatSet)
    annotation (Line(points={{-62,-208},{-220,-208},{-220,-240},{-300,-240}},
      color={0,0,127}));

  connect(dpHotWat_remote,pumSpeRemDp.dpHotWat)
    annotation (Line(points={{-300,-200},{-200,-200},{-200,-240},{-62,-240}},
      color={0,0,127}));

  connect(dpHotWatSet,pumSpeRemDp.dpHotWatSet)
    annotation (Line(points={{-300,-240},{-220,-240},{-220,-248},{-62,-248}},
      color={0,0,127}));

  connect(pumSpeLocDp.yHotWatPumSpe, reaRep.u)
    annotation (Line(points={{-38,-200},{-2,-200}}, color={0,0,127}));

  connect(pumSpeRemDp.yHotWatPumSpe, reaRep.u)
    annotation (Line(points={{-38,-240},{-20,-240},{-20,-200},{-2,-200}},
      color={0,0,127}));

  connect(enaPum.y, pumSta.u2)
    annotation (Line(points={{202,-30},{210,-30},{210,-50},{150,-50},{150,-98},
      {178,-98}},  color={255,0,255}));

  connect(lasLagPumSta.y, pumSta.u1)
    annotation (Line(points={{142,-90},{178,-90}}, color={255,0,255}));

  connect(enaDedLeaPum.yLea, booRep.u)
    annotation (Line(points={{-178,110},{-2,110}}, color={255,0,255}));

  connect(enaHeaLeaPum.yLea, booRep.u)
    annotation (Line(points={{-178,70},{-20,70},{-20,110},{-2,110}}, color={255,0,255}));

  connect(enaLagChiPum.yUp, booRep1.u)
    annotation (Line(points={{-178,4},{-120,4},{-120,30},{-42,30}}, color={255,0,255}));

  connect(enaLagChiPum.yDown, booRep2.u)
    annotation (Line(points={{-178,-4},{-120,-4},{-120,-10},{-42,-10}},
      color={255,0,255}));

  connect(booRep2.y, remPum.u2)
    annotation (Line(points={{-18,-10},{90,-10},{90,-70},{218,-70}},
      color={255,0,255}));

  connect(pumSta.y, remPum.u3)
    annotation (Line(points={{202,-90},{210,-90},{210,-78},{218,-78}},
      color={255,0,255}));

  connect(leaPumSta.y, remPum.u1)
    annotation (Line(points={{142,190},{160,190},{160,-62},{218,-62}}, color={255,0,255}));

  connect(enaPum.y, addPum.u1)
    annotation (Line(points={{202,-30},{210,-30},{210,8},{238,8}}, color={255,0,255}));

  connect(booRep1.y, addPum.u2)
    annotation (Line(points={{-18,30},{110,30},{110,0},{238,0}}, color={255,0,255}));

  connect(addPum.y,yHotWatPum)
    annotation (Line(points={{262,0},{300,0}}, color={255,0,255}));

  connect(addPum.y,pumSpeLocDp.uHotWatPum)
    annotation (Line(points={{262,0},{270,0},{270,-180},{-80,-180},{-80,-196},
      {-62,-196}},  color={255,0,255}));

  connect(addPum.y,pumSpeRemDp.uHotWatPum)
    annotation (Line(points={{262,0},{270,0},{270,-180},{-80,-180},{-80,-232},
      {-62,-232}},  color={255,0,255}));

  connect(remPum.y, addPum.u3)
    annotation (Line(points={{242,-70},{250,-70},{250,-20},{220,-20},{220,-8},
      {238,-8}},  color={255,0,255}));

  connect(uHotWatPum, booToInt.u)
    annotation (Line(points={{-300,140},{-260,140},{-260,-120},{-202,-120}},
      color={255,0,255}));

  connect(booToInt.y, mulSumInt.u)
    annotation (Line(points={{-178,-120},{-162,-120}}, color={255,127,0}));

  connect(addInt.y, nexLagPum.index)
    annotation (Line(points={{-98,-70},{-70,-70},{-70,-62}}, color={255,127,0}));

  connect(mulSumInt.y, addInt.u2)
    annotation (Line(points={{-138,-120},{-128,-120},{-128,-76},{-122,-76}},
      color={255,127,0}));

  connect(conInt.y, addInt.u1)
    annotation (Line(points={{-198,200},{-140,200},{-140,-64},{-122,-64}},
      color={255,127,0}));

  connect(mulSumInt.y, lasLagPum.index)
    annotation (Line(points={{-138,-120},{-70,-120},{-70,-112}}, color={255,127,0}));

  connect(uHotIsoVal, enaHeaLeaPum.uHotWatIsoVal) annotation (Line(points={{-300,70},
          {-202,70}},                              color={0,0,127}));
  connect(addPum.y, hotPumSpe.uHotWatPum) annotation (Line(points={{262,0},{270,
          0},{270,-180},{-80,-180},{-80,-279},{-62,-279}}, color={255,0,255}));
  connect(addPum.y, hotPumSpe1.uHotWatPum) annotation (Line(points={{262,0},{
          270,0},{270,-180},{-80,-180},{-80,-310},{-62,-310}}, color={255,0,255}));
  connect(hotPumSpe.yHotWatPumSpe, reaRep.u) annotation (Line(points={{-38,-284},
          {-20,-284},{-20,-200},{-2,-200}}, color={0,0,127}));
  connect(hotPumSpe1.yHotWatPumSpe, reaRep.u) annotation (Line(points={{-38,
          -318},{-20,-318},{-20,-200},{-2,-200}}, color={0,0,127}));
  connect(VHotWat_flow, hotPumSpe.VHotWatPri_flow) annotation (Line(points={{
          -300,-20},{-266,-20},{-266,-284},{-62,-284}}, color={0,0,127}));
  connect(VHotWatSec_flow, hotPumSpe.VHotWatSec_flow) annotation (Line(points={
          {-300,-300},{-240,-300},{-240,-289},{-62,-289}}, color={0,0,127}));
  connect(VHotWatDec_flow, hotPumSpe.VHotWatDec_flow) annotation (Line(points={
          {-300,-330},{-240,-330},{-240,-289},{-62,-289}}, color={0,0,127}));
  connect(THotWatPri, hotPumSpe1.THotWatPri) annotation (Line(points={{-300,
          -360},{-80,-360},{-80,-314},{-62,-314}}, color={0,0,127}));
  connect(THotWatSec, hotPumSpe1.THotWatSec) annotation (Line(points={{-300,
          -390},{-76,-390},{-76,-318},{-62,-318}}, color={0,0,127}));
  connect(THotWatBoiSup, hotPumSpe1.THotWatBoiSup) annotation (Line(points={{
          -300,-420},{-68,-420},{-68,-326},{-62,-326}}, color={0,0,127}));
  connect(uBoiSta, hotPumSpe1.uBoiSta) annotation (Line(points={{-300,-70},{
          -270,-70},{-270,-322},{-62,-322}}, color={255,0,255}));
  connect(uBoiSta, booToRea.u)
    annotation (Line(points={{-300,-70},{-254,-70}}, color={255,0,255}));
  connect(booToRea.y, extIndSig.u)
    annotation (Line(points={{-230,-70},{-224,-70}}, color={0,0,127}));
  connect(conInt.y, extIndSig.index) annotation (Line(points={{-198,200},{-140,200},
          {-140,-86},{-212,-86},{-212,-82}}, color={255,127,0}));
  connect(greEquThr.u, extIndSig.y)
    annotation (Line(points={{-194,-70},{-200,-70}}, color={0,0,127}));
  connect(greEquThr.y, enaDedLeaPum.uLeaBoiSta) annotation (Line(points={{-170,-70},
          {-166,-70},{-166,-42},{-232,-42},{-232,105},{-202,105}}, color={255,0,
          255}));
  connect(reaRep.y, yPumSpe)
    annotation (Line(points={{22,-200},{300,-200}}, color={0,0,127}));
annotation (
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-460},{280,260}}), graphics={
          Rectangle(
          extent={{-276,256},{274,64}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{196,248},{270,232}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable lead pump"),
          Rectangle(
          extent={{-276,56},{274,-136}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{186,50},{270,36}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable next lag pump"),
          Text(
          extent={{166,-122},{266,-136}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          fontSize=10,
          textString="Disable last lag pump"),
          Rectangle(
          extent={{-276,-140},{274,-456}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{196,-142},{266,-154}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Pump speed")}),
 Icon(coordinateSystem(preserveAspectRatio=false, extent={{-280,-460},{280,260}}),
       graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-80,60},{82,-60}},
          lineColor={28,108,200},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Polygon(
          points={{-80,60},{-14,4},{-80,-60},{-80,60}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),
  Documentation(info="<html>
<p>
Primary hot water pump control sequence per ASHRAE RP-1711, Draft 6 (July 25, 2019), 
section 5.2.6. It consists:
</p>
<ul>
<li>
Subsequences to enable lead pump, 
<ul>
<li>
for plants with dedicated pumps 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.EnableLead_dedicated\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.EnableLead_dedicated</a>
</li>
<li>
for plants with headered pumps 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.EnableLead_headered\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.EnableLead_headered</a>
</li>
</ul>
</li>
<li>
Subsequence to stage lag pumps
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.EnableLag_primary_dP\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.EnableLag_primary_dP</a>
</li>

<li>
Subsequences to control pump speed for primary-only plants,
<ul>
<li>
where the remote DP sensor(s) is not hardwired to the plant controller, 
but a local DP sensor is hardwired
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_localDp\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_localDp</a>
</li>
<li>
where the remote DP sensor(s) is hardwired to the plant controller
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_remoteDp\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.ChilledWater.Subsequences.Speed_primary_remoteDp</a>
</li>
</ul>
</li>
</ul>
</html>",
revisions="<html>
<ul>
<li>
February 13, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
