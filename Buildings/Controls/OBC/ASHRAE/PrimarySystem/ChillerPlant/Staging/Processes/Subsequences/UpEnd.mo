﻿within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences;
block UpEnd "Sequence for ending stage-up process"

  parameter Integer nChi "Total number of chillers";
  parameter Boolean isParallelChiller=true
    "True: the plant has parallel chillers";

  parameter Real proOnTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h") = 300
    "Threshold time to check if newly enabled chiller being operated by more than 5 minutes"
    annotation (Dialog(group="Enable next chiller"));
  parameter Real chaChiWatIsoTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")
    "Time to slowly change isolation valve, should be determined in the field"
    annotation (Dialog(group="Chilled water isolation valve"));
  parameter Real byPasSetTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")
    "Time to slowly reset minimum bypass flow"
    annotation (Dialog(group="Reset CHW minimum flow setpoint"));
  parameter Modelica.SIunits.VolumeFlowRate minFloSet[nChi]
    "Minimum chilled water flow through each chiller"
    annotation (Dialog(group="Reset CHW minimum flow setpoint"));
  parameter Modelica.SIunits.VolumeFlowRate maxFloSet[nChi]
    "Maximum chilled water flow through each chiller"
    annotation (Dialog(group="Reset CHW minimum flow setpoint"));
  parameter Real aftByPasSetTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=60
    "Time after minimum bypass flow being resetted to new setpoint"
    annotation (Dialog(group="Reset bypass"));
  parameter Real relFloDif=0.05
    "Relative error to the setpoint for checking if it has achieved flow rate setpoint"
    annotation (Dialog(tab="Advanced", group="Reset bypass"));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nexEnaChi
    "Index of next enabling chiller"
    annotation (Placement(transformation(extent={{-240,220},{-200,260}}),
      iconTransformation(extent={{-140,100},{-100,140}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp "Stage-up command"
    annotation (Placement(transformation(extent={{-240,190},{-200,230}}),
      iconTransformation(extent={{-140,80},{-100,120}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uEnaChiWatIsoVal
    "Status of chiller chilled water isolation valve control: true=enabled valve is fully open"
    annotation (Placement(transformation(extent={{-240,160},{-200,200}}),
      iconTransformation(extent={{-140,60},{-100,100}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nChi]
    "Chiller status: true=ON"
     annotation (Placement(transformation(extent={{-240,130},{-200,170}}),
       iconTransformation(extent={{-140,40},{-100,80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff
    "Indicate if the stage require one chiller to be enabled while another is disabled"
    annotation (Placement(transformation(extent={{-240,80},{-200,120}}),
      iconTransformation(extent={{-140,20},{-100,60}})));
  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nexDisChi
    "Next disabling chiller when there is any stage up that need one chiller on and another off"
    annotation (Placement(transformation(extent={{-240,50},{-200,90}}),
      iconTransformation(extent={{-140,0},{-100,40}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatReq[nChi]
    "Chilled water request status for each chiller"
    annotation (Placement(transformation(extent={{-240,0},{-200,40}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[nChi](
    final unit=fill("1", nChi),
    final min=fill(0, nChi),
    final max=fill(1, nChi)) "Chilled water isolation valve position"
    annotation (Placement(transformation(extent={{-240,-30},{-200,10}}),
      iconTransformation(extent={{-140,-40},{-100,0}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uConWatReq[nChi]
    "Condenser water request status for each chiller"
    annotation (Placement(transformation(extent={{-240,-90},{-200,-50}}),
      iconTransformation(extent={{-140,-60},{-100,-20}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiHeaCon[nChi]
    "Chillers head pressure control status"
    annotation (Placement(transformation(extent={{-240,-120},{-200,-80}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWat_flow(
    final unit="m3/s")
    "Measured chilled water flow rate"
    annotation (Placement(transformation(extent={{-240,-190},{-200,-150}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealInput VMinChiWat_setpoint(
    final unit="m3/s")
    "Minimum chiller water flow setpoint calculated from upstream process"
    annotation (Placement(transformation(extent={{-240,-220},{-200,-180}}),
      iconTransformation(extent={{-140,-120},{-100,-80}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[nChi]
    "Chiller enabling status"
    annotation (Placement(transformation(extent={{200,120},{240,160}}),
      iconTransformation(extent={{100,70},{140,110}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoVal[nChi](
    final min=fill(0, nChi),
    final max=fill(1, nChi),
    final unit=fill("1", nChi))
    "Chiller chilled water isolation valve position"
    annotation (Placement(transformation(extent={{200,40},{240,80}}),
      iconTransformation(extent={{100,30},{140,70}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiHeaCon[nChi]
    "Chiller head pressure control enabling status"
    annotation (Placement(transformation(extent={{200,-70},{240,-30}}),
      iconTransformation(extent={{100,-10},{140,30}})));
  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatMinSet(
    final unit="m3/s") "Chilled water minimum flow setpoint"
    annotation (Placement(transformation(extent={{200,-130},{240,-90}}),
      iconTransformation(extent={{100,-50},{140,-10}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yEndSta
    "Flag to indicate if the staging process is finished"
    annotation (Placement(transformation(extent={{200,-210},{240,-170}}),
      iconTransformation(extent={{100,-90},{140,-50}})));
  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput endStaTri
    "Staging end trigger"
    annotation (Placement(transformation(extent={{200,-250},{240,-210}}),
      iconTransformation(extent={{100,-110},{140,-70}})));

protected
  parameter Integer chiInd[nChi]={i for i in 1:nChi}
    "Chiller index, {1,2,...,n}";
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.EnableChiller
    enaChi(final nChi=nChi, final proOnTim=proOnTim) "Enable next chiller"
    annotation (Placement(transformation(extent={{-100,180},{-80,200}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.CHWIsoVal
    disChiIsoVal(
    final nChi=nChi,
    final chaChiWatIsoTim=chaChiWatIsoTim,
    final iniValPos=1,
    final endValPos=0)
    "Disable isolation valve of the chiller being disabled"
    annotation (Placement(transformation(extent={{60,-20},{80,0}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl
    disHeaCon(
    final nChi=nChi,
    final thrTimEnb=0,
    final waiTim=0,
    final heaStaCha=false)
    "Disable head pressure control of the chiller being disabled"
    annotation (Placement(transformation(extent={{40,-80},{60,-60}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint
    minChiWatSet(
    final nChi=nChi,
    final isParallelChiller=isParallelChiller,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet,
    final maxFloSet=maxFloSet) "Reset minimum chilled water flow setpoint"
    annotation (Placement(transformation(extent={{40,-140},{60,-120}})));
  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.ResetMinBypass
    minBypSet(
    final aftByPasSetTim=aftByPasSetTim,
    final relFloDif=relFloDif)
    "Check if minimum bypass flow has been resetted"
    annotation (Placement(transformation(extent={{40,-190},{60,-170}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[nChi]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,10},{-140,30}})));
  Buildings.Controls.OBC.CDL.Continuous.LessEqualThreshold lesEquThr(
    final threshold=0.5)
    "Check if the disabled chiller is not requiring chilled water"
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Buildings.Controls.OBC.CDL.Logical.And and4 "Logical and"
    annotation (Placement(transformation(extent={{0,30},{20,50}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con2(
    final k=true) "True constant"
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea2[nChi]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-160,-80},{-140,-60}})));
  Buildings.Controls.OBC.CDL.Continuous.LessEqualThreshold lesEquThr1(
    final threshold=0.5)
    "Check if the disabled chiller is not requiring condenser water"
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Buildings.Controls.OBC.CDL.Logical.And and5 "Logical and"
    annotation (Placement(transformation(extent={{-20,-80},{0,-60}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con3(final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-160,-160},{-140,-140}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2 "Logical not"
    annotation (Placement(transformation(extent={{-160,90},{-140,110}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor  curDisChi(final nin=nChi)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-120,10},{-100,30}})));
  Buildings.Controls.OBC.CDL.Routing.RealExtractor curDisChi1(final nin=nChi)
    "Current disabling chiller"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi3[nChi]
    "Logical switch"
    annotation (Placement(transformation(extent={{160,-60},{180,-40}})));
  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep4(final nout=nChi)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{-80,50},{-60,70}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatIso[nChi]
    "Chilled water isolation valve"
    annotation (Placement(transformation(extent={{160,50},{180,70}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi4
    "Logical switch"
    annotation (Placement(transformation(extent={{160,-170},{180,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatByp
    "Chilled water bypass flow setpoint"
    annotation (Placement(transformation(extent={{160,-120},{180,-100}})));
  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi5 "Logical switch"
    annotation (Placement(transformation(extent={{60,-240},{80,-220}})));
  Buildings.Controls.OBC.CDL.Logical.Switch chiWatByp1
    "Chilled water bypass flow setpoint"
    annotation (Placement(transformation(extent={{100,-140},{120,-120}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat1
    "Maintain ON signal when the chiller has been proven on"
    annotation (Placement(transformation(extent={{-60,130},{-40,150}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre
    "Break algebraic loop"
    annotation (Placement(transformation(extent={{120,-240},{140,-220}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edg1
    "Rising edge, output true at the moment when input turns from false to true"
    annotation (Placement(transformation(extent={{160,-240},{180,-220}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat2
    "Maintain ON signal when the chilled water isolation valve has been closed"
    annotation (Placement(transformation(extent={{120,-30},{140,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Latch lat3
    "Maintain ON signal when the chiller head pressure control has been disabled"
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));

equation
  connect(uOnOff, not2.u)
    annotation (Line(points={{-220,100},{-162,100}}, color={255,0,255}));
  connect(booToRea1.y,curDisChi. u)
    annotation (Line(points={{-138,20},{-122,20}}, color={0,0,127}));
  connect(uChiWatReq, booToRea1.u)
    annotation (Line(points={{-220,20},{-162,20}}, color={255,0,255}));
  connect(curDisChi.y, lesEquThr.u)
    annotation (Line(points={{-98,20},{-82,20}}, color={0,0,127}));
  connect(lesEquThr.y, and4.u2)
    annotation (Line(points={{-58,20},{-20,20},{-20,32},{-2,32}},
      color={255,0,255}));
  connect(nexDisChi, disChiIsoVal.nexChaChi)
    annotation (Line(points={{-220,70},{-180,70},{-180,-2},{58,-2}},
      color={255,127,0}));
  connect(uChiWatIsoVal,disChiIsoVal. uChiWatIsoVal)
    annotation (Line(points={{-220,-10},{50,-10},{50,-5},{58,-5}},
      color={0,0,127}));
  connect(and4.y,disChiIsoVal.uUpsDevSta)
    annotation (Line(points={{22,40},{30,40},{30,-15},{58,-15}}, color={255,0,255}));
  connect(con2.y,disChiIsoVal. chaPro)
    annotation (Line(points={{-58,-40},{10,-40},{10,-18},{58,-18}},
      color={255,0,255}));
  connect(uConWatReq, booToRea2.u)
    annotation (Line(points={{-220,-70},{-162,-70}}, color={255,0,255}));
  connect(booToRea2.y, curDisChi1.u)
    annotation (Line(points={{-138,-70},{-122,-70}}, color={0,0,127}));
  connect(nexDisChi, curDisChi1.index)
    annotation (Line(points={{-220,70},{-180,70},{-180,-90},{-110,-90},
      {-110,-82}}, color={255,127,0}));
  connect(curDisChi1.y,lesEquThr1. u)
    annotation (Line(points={{-98,-70},{-82,-70}}, color={0,0,127}));
  connect(lesEquThr1.y, and5.u1)
    annotation (Line(points={{-58,-70},{-22,-70}}, color={255,0,255}));
  connect(con2.y, disHeaCon.chaPro)
    annotation (Line(points={{-58,-40},{10,-40},{10,-66},{38,-66}}, color={255,0,255}));
  connect(and5.y, disHeaCon.uUpsDevSta)
    annotation (Line(points={{2,-70},{20,-70},{20,-62},{38,-62}},
      color={255,0,255}));
  connect(nexDisChi, disHeaCon.nexChaChi)
    annotation (Line(points={{-220,70},{-180,70},{-180,-90},{20,-90},{20,-74},
      {38,-74}}, color={255,127,0}));
  connect(disHeaCon.uChiHeaCon, uChiHeaCon)
    annotation (Line(points={{38,-78},{30,-78},{30,-100},{-220,-100}},
      color={255,0,255}));
  connect(nexDisChi, curDisChi.index)
    annotation (Line(points={{-220,70},{-180,70},{-180,-2},{-110,-2},{-110,8}},
      color={255,127,0}));
  connect(con3.y, minChiWatSet.uStaDow)
    annotation (Line(points={{-138,-150},{-20,-150},{-20,-139},{38,-139}},
      color={255,0,255}));
  connect(con2.y, minBypSet.chaPro)
    annotation (Line(points={{-58,-40},{10,-40},{10,-176},{38,-176}},
      color={255,0,255}));
  connect(minBypSet.VChiWat_flow, VChiWat_flow)
    annotation (Line(points={{38,-184},{-20,-184},{-20,-170},{-220,-170}},
      color={0,0,127}));
  connect(not2.y, booRep4.u)
    annotation (Line(points={{-138,100},{-130,100},{-130,60},{-82,60}},
      color={255,0,255}));
  connect(uChiHeaCon, logSwi3.u1)
    annotation (Line(points={{-220,-100},{130,-100},{130,-42},{158,-42}},
      color={255,0,255}));
  connect(disHeaCon.yChiHeaCon, logSwi3.u3)
    annotation (Line(points={{62,-76},{80,-76},{80,-58},{158,-58}},
      color={255,0,255}));
  connect(logSwi3.y, yChiHeaCon)
    annotation (Line(points={{182,-50},{220,-50}}, color={255,0,255}));
  connect(booRep4.y, logSwi3.u2)
    annotation (Line(points={{-58,60},{40,60},{40,-50},{158,-50}},
      color={255,0,255}));
  connect(booRep4.y, chiWatIso.u2)
    annotation (Line(points={{-58,60},{158,60}},  color={255,0,255}));
  connect(uChiWatIsoVal, chiWatIso.u1)
    annotation (Line(points={{-220,-10},{50,-10},{50,68},{158,68}},
      color={0,0,127}));
  connect(disChiIsoVal.yChiWatIsoVal, chiWatIso.u3)
    annotation (Line(points={{82,-16},{90,-16},{90,52},{158,52}},
      color={0,0,127}));
  connect(chiWatIso.y, yChiWatIsoVal)
    annotation (Line(points={{182,60},{220,60}}, color={0,0,127}));
  connect(not2.y, logSwi4.u2)
    annotation (Line(points={{-138,100},{-130,100},{-130,-160},{158,-160}},
      color={255,0,255}));
  connect(con2.y, logSwi4.u1)
    annotation (Line(points={{-58,-40},{10,-40},{10,-152},{158,-152}},
      color={255,0,255}));
  connect(minBypSet.yMinBypRes, logSwi4.u3)
    annotation (Line(points={{62,-180},{120,-180},{120,-168},{158,-168}},
      color={255,0,255}));
  connect(not2.y, chiWatByp.u2)
    annotation (Line(points={{-138,100},{-130,100},{-130,-110},{158,-110}},
      color={255,0,255}));
  connect(chiWatByp.y,yChiWatMinSet)
    annotation (Line(points={{182,-110},{220,-110}}, color={0,0,127}));
  connect(not2.y, logSwi5.u2)
    annotation (Line(points={{-138,100},{-130,100},{-130,-230},{58,-230}},
      color={255,0,255}));
  connect(logSwi4.y, logSwi5.u3)
    annotation (Line(points={{182,-160},{190,-160},{190,-210},{40,-210},
      {40,-238},{58,-238}}, color={255,0,255}));
  connect(logSwi5.y, yEndSta)
    annotation (Line(points={{82,-230},{100,-230},{100,-190},{220,-190}},
      color={255,0,255}));
  connect(nexEnaChi, enaChi.nexEnaChi)
    annotation (Line(points={{-220,240},{-120,240},{-120,199},{-102,199}},
      color={255,127,0}));
  connect(uStaUp, enaChi.uStaUp)
    annotation (Line(points={{-220,210},{-140,210},{-140,196},{-102,196}},
      color={255,0,255}));
  connect(uEnaChiWatIsoVal, enaChi.uEnaChiWatIsoVal)
    annotation (Line(points={{-220,180},{-160,180},{-160,192},{-102,192}},
      color={255,0,255}));
  connect(uChi, enaChi.uChi)
    annotation (Line(points={{-220,150},{-140,150},{-140,188},{-102,188}},
      color={255,0,255}));
  connect(uOnOff, enaChi.uOnOff)
    annotation (Line(points={{-220,100},{-190,100},{-190,184},{-102,184}},
      color={255,0,255}));
  connect(nexDisChi, enaChi.nexDisChi)
    annotation (Line(points={{-220,70},{-110,70},{-110,181},{-102,181}},
      color={255,127,0}));
  connect(enaChi.yChi, yChi)
    annotation (Line(points={{-78,198},{92,198},{92,140},{220,140}},
      color={255,0,255}));
  connect(uChi, minChiWatSet.uChi)
    annotation (Line(points={{-220,150},{-170,150},{-170,-126},{38,-126}},
      color={255,0,255}));
  connect(nexDisChi, minChiWatSet.nexDisChi)
    annotation (Line(points={{-220,70},{-180,70},{-180,-131},{38,-131}},
      color={255,127,0}));
  connect(uOnOff, minChiWatSet.uOnOff)
    annotation (Line(points={{-220,100},{-190,100},{-190,-137},{38,-137}},
      color={255,0,255}));
  connect(minChiWatSet.yChiWatMinFloSet, minBypSet.VMinChiWat_setpoint)
    annotation (Line(points={{62,-130},{70,-130},{70,-146},{30,-146},{30,-188},
      {38,-188}},  color={0,0,127}));
  connect(con3.y, minChiWatSet.uUpsDevSta)
    annotation (Line(points={{-138,-150},{-20,-150},{-20,-123},{38,-123}},
      color={255,0,255}));
  connect(minChiWatSet.yChiWatMinFloSet, chiWatByp1.u1)
    annotation (Line(points={{62,-130},{70,-130},{70,-122},{98,-122}},
      color={0,0,127}));
  connect(VMinChiWat_setpoint, chiWatByp1.u3)
    annotation (Line(points={{-220,-200},{80,-200},{80,-138},{98,-138}},
      color={0,0,127}));
  connect(VMinChiWat_setpoint, chiWatByp.u1)
    annotation (Line(points={{-220,-200},{140,-200},{140,-102},{158,-102}},
      color={0,0,127}));
  connect(chiWatByp1.y, chiWatByp.u3)
    annotation (Line(points={{122,-130},{150,-130},{150,-118},{158,-118}},
      color={0,0,127}));
  connect(nexEnaChi, minChiWatSet.nexEnaChi)
    annotation (Line(points={{-220,240},{-120,240},{-120,160},{-90,160},
      {-90,-129},{38,-129}}, color={255,127,0}));
  connect(enaChi.yNewChiEna, lat1.u)
    annotation (Line(points={{-78,182},{-70,182},{-70,140},{-62,140}},
      color={255,0,255}));
  connect(lat1.y, and4.u1)
    annotation (Line(points={{-38,140},{-30,140},{-30,40},{-2,40}},
      color={255,0,255}));
  connect(lat1.y, minChiWatSet.uStaUp)
    annotation (Line(points={{-38,140},{-30,140},{-30,-121},{38,-121}},
      color={255,0,255}));
  connect(lat1.y, logSwi5.u1)
    annotation (Line(points={{-38,140},{-30,140},{-30,-222},{58,-222}},
      color={255,0,255}));
  connect(logSwi5.y, pre.u)
    annotation (Line(points={{82,-230},{118,-230}}, color={255,0,255}));
  connect(pre.y, edg1.u)
    annotation (Line(points={{142,-230},{158,-230}}, color={255,0,255}));
  connect(edg1.y, endStaTri)
    annotation (Line(points={{182,-230},{220,-230}}, color={255,0,255}));
  connect(edg1.y, lat1.clr)
    annotation (Line(points={{182,-230},{190,-230},{190,-250},{-50,-250},
      {-50,120},{-68,120},{-68,134},{-62,134}}, color={255,0,255}));
  connect(disChiIsoVal.yEnaChiWatIsoVal, lat2.u)
    annotation (Line(points={{82,-4},{100,-4},{100,-20},{118,-20}},
      color={255,0,255}));
  connect(lat2.y, and5.u2)
    annotation (Line(points={{142,-20},{160,-20},{160,-34},{-40,-34},{-40,-78},
      {-22,-78}}, color={255,0,255}));
  connect(edg1.y, lat2.clr)
    annotation (Line(points={{182,-230},{190,-230},{190,-250},{-50,-250},
      {-50,-26},{118,-26}}, color={255,0,255}));
  connect(disHeaCon.yEnaHeaCon, lat3.u)
    annotation (Line(points={{62,-64},{90,-64},{90,-80},{98,-80}}, color={255,0,255}));
  connect(lat3.y, chiWatByp1.u2)
    annotation (Line(points={{122,-80},{140,-80},{140,-94},{80,-94},{80,-130},
      {98,-130}}, color={255,0,255}));
  connect(lat3.y, minChiWatSet.uSubCha)
    annotation (Line(points={{122,-80},{140,-80},{140,-94},{20,-94},{20,-134},
      {38,-134}}, color={255,0,255}));
  connect(lat3.y, minBypSet.uUpsDevSta)
    annotation (Line(points={{122,-80},{140,-80},{140,-94},{20,-94},{20,-172},
      {38,-172}}, color={255,0,255}));
  connect(edg1.y, lat3.clr)
    annotation (Line(points={{182,-230},{190,-230},{190,-250},{-50,-250},
      {-50,-86},{98,-86}}, color={255,0,255}));

annotation (
  defaultComponentName="endUp",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-200,-260},{200,260}}), graphics={
          Rectangle(
          extent={{-198,38},{198,-38}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{52,32},{194,24}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Close chilled water 
isolation valve"),
          Rectangle(
          extent={{-198,-62},{198,-98}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{76,-64},{192,-72}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Disable head
pressure control"),
          Rectangle(
          extent={{-198,-102},{198,-198}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{-182,-166},{-66,-174}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Reset minimum 
bypass setpoint"),
          Rectangle(
          extent={{-198,-202},{198,-258}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{-168,-212},{-52,-220}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="End stage-up process"),
          Rectangle(
          extent={{-198,238},{198,62}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{48,198},{190,190}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable next chiller")}),
    Icon(graphics={
        Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid),
        Text(
          extent={{-120,146},{100,108}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-40,6},{40,-6}},
          lineColor={200,200,200},
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Rectangle(
          extent={{-2,72},{2,6}},
          lineColor={200,200,200},
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,90},{-20,72},{0,72},{20,72},{0,90}},
          lineColor={200,200,200},
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-98,122},{-66,112}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="nexEnaChi"),
        Text(
          extent={{-98,104},{-76,92}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uStaUp"),
        Text(
          extent={{-98,86},{-46,72}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uEnaChiWatIsoVal"),
        Text(
          extent={{-98,62},{-84,54}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChi"),
        Text(
          extent={{-98,42},{-76,34}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uOnOff"),
        Text(
          extent={{-98,24},{-68,14}},
          lineColor={255,127,0},
          pattern=LinePattern.Dash,
          textString="nexDisChi"),
        Text(
          extent={{-98,4},{-64,-10}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiWatReq"),
        Text(
          extent={{-98,-14},{-56,-26}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiWatIsoVal"),
        Text(
          extent={{-98,-34},{-64,-48}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uConWatReq"),
        Text(
          extent={{-98,-56},{-64,-70}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="uChiHeaCon"),
        Text(
          extent={{-98,-74},{-56,-86}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VChiWat_flow"),
        Text(
          extent={{56,-22},{98,-34}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatMinSet"),
        Text(
          extent={{72,-62},{96,-74}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yEndSta"),
        Text(
          extent={{64,18},{98,4}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yChiHeaCon"),
        Text(
          extent={{56,58},{98,46}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatIsoVal"),
        Text(
          extent={{82,96},{96,88}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="yChi"),
        Text(
          extent={{-98,-90},{-30,-100}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VMinChiWat_setpoint"),
        Text(
          extent={{68,-82},{96,-96}},
          lineColor={255,0,255},
          pattern=LinePattern.Dash,
          textString="endStaTri")}),
Documentation(info="<html>
<p>
Block that controls devices at the ending step of chiller staging up process.
This development is based on ASHRAE RP-1711 Advanced Sequences of Operation for 
HVAC Systems Phase II – Central Plants and Hydronic Systems (Draft version,
March 2020), section 5.2.4.16, item 6 and 7. These sections specify the controls of 
devices at the ending step of staging up process.
</p>
<p>
For the stage-up process that does not require a smaller chiller being disabled
and a larger chiller being enabled (<code>uOnOff=false</code>),
</p>
<ul>
<li>
Start the next stage chiller (<code>nexEnaChi</code>) after the chilled water 
isolation valve is fully open (<code>uEnaChiWatIsoVal=true</code>). 
This is implemented in block <code>enaChi</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.EnableChiller\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.EnableChiller</a>
for more decriptions.
</li>
</ul>
<p>
For any stage change during which a smaller chiller is diabled and a larger chiller
is enabled (<code>uOnOff=true</code>), after starting the next stage chiller 
specified above, do following:
</p>
<ol>
<li>
Wait 5 minutes (<code>proOnTim</code>) for the newly enabled chiller to prove that 
is operating correctly, then shut off the small chiller (<code>nexDisChi</code>). 
This is implemented in block <code>enaChi</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.EnableChiller\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.EnableChiller</a>
for more decriptions.
</li>
<li>
When the controller of the smaller chiller being shut off indicates no request
for chilled water flow (<code>uChiWatReq=false</code>), slowly close the chiller's 
chilled water isolation valve to avoid a sudden change in flow through other 
operating chillers.
This is implemented in block <code>disChiIsoVal</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.CHWIsoVal\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.CHWIsoVal</a>
for more decriptions.
</li>
<li>
When the controller of the smaller chiller being shut off indicates no request for 
condenser water flow (<code>uConWatReq=false</code>), disable the chiller's head 
pressure control loop.
This is implemented in block <code>disHeaCon</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.HeadControl</a>
for more decriptions.
</li>
<li>
Change the minimum flow bypass setpoint to that appropriate for the new stage.
This is implemented in block <code>minChiWatSet</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint</a>
for more decriptions.
</li>
<li>
Block <code>minBypSet</code> will then check if the new chilled water flow setpoint
has been achieved. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.ResetMinBypass\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.Processes.Subsequences.ResetMinBypass</a>
for more decriptions.
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
September 22, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end UpEnd;
