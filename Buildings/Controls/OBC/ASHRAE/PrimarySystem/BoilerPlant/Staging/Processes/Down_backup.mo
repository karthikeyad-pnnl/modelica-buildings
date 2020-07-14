within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes;
block Down_backup
  "Sequence for controlling devices when there is a stage-down command"

  parameter Integer nBoi = 2
    "Total number of boilers in the plant";

  parameter Integer totSta = 3
    "Total number of stages, including the stages with a WSE, if applicable";

  parameter Boolean have_WSE=true
    "True: have waterside economizer";

  parameter Boolean have_PonyBoiler=false
    "True: have pony boiler";

  parameter Boolean isParallelBoiler=true
    "True: the plant has parallel boilers";

  parameter Boolean isHeadered=true
    "True: headered condenser water pumps";

  parameter Real chiDemRedFac=0.75
    "Demand reducing factor of current operating boilers"
    annotation (Dialog(group="Disable last boiler", enable=have_PonyBoiler));

  parameter Real holChiDemTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=300
    "Maximum time to wait for the actual demand less than percentage of current load"
    annotation (Dialog(group="Disable last boiler", enable=have_PonyBoiler));

  parameter Real waiTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=30
    "Waiting time after enabling next head pressure control"
    annotation (Dialog(group="Disable last boiler", enable=have_PonyBoiler));

  parameter Real proOnTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=300
    "Enabled boiler operation time to indicate if it is proven on"
    annotation (Dialog(group="Disable last boiler", enable=have_PonyBoiler));

  parameter Real chaChiWatIsoTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")
    "Time to slowly change isolation valve, should be determined in the field"
    annotation (Dialog(group="Disable CHW isolation valve"));

  parameter Real staVec[totSta]
    "Boiler stage vector, element value like x.5 means boiler stage x plus WSE"
    annotation (Dialog(group="Disable condenser water pump"));

  parameter Real desConWatPumSpe[totSta]
    "Design condenser water pump speed setpoints, the size should be double of total stage numbers"
    annotation (Dialog(group="Disable condenser water pump"));

  parameter Real desConWatPumNum[totSta]
    "Design number of condenser water pumps that should be ON, the size should be double of total stage numbers"
    annotation (Dialog(group="Disable condenser water pump"));

  parameter Real byPasSetTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")
    "Time to reset minimum by-pass flow"
    annotation (Dialog(group="Reset CHW minimum flow setpoint"));

  parameter Modelica.SIunits.VolumeFlowRate minFloSet[nBoi]
    "Minimum hot water flow through each boiler"
    annotation (Dialog(group="Reset CHW minimum flow setpoint"));

  parameter Modelica.SIunits.VolumeFlowRate maxFloSet[nBoi]
    "Maximum hot water flow through each boiler"
    annotation (Dialog(group="Reset CHW minimum flow setpoint"));

  parameter Real aftByPasSetTim(
    final unit="s",
    final quantity="Time",
    final displayUnit="h")=60
    "Time to allow loop to stabilize after resetting minimum hot water flow setpoint"
    annotation (Dialog(group="Reset bypass"));

  parameter Real relSpeDif = 0.05
    "Relative error to the setpoint for checking if it has achieved speed setpoint"
    annotation (Dialog(tab="Advanced", group="Disable condenser water pump"));

  parameter Real relFloDif=0.05
    "Relative error to the setpoint for checking if it has achieved flow rate setpoint"
    annotation (Dialog(tab="Advanced", group="Reset bypass"));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uStaSet
    "Boiler stage setpoint index"
    annotation (Placement(transformation(extent={{-320,360},{-280,400}}),
      iconTransformation(extent={{-140,162},{-100,202}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiSet[nBoi]
    "Vector of boilers status setpoint"
    annotation (Placement(transformation(extent={{-320,300},{-280,340}}),
      iconTransformation(extent={{-140,142},{-100,182}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput yOpeParLoaRatMin(
    final min=0,
    final max=1,
    final unit="1")
    "Current stage minimum cycling operative partial load ratio"
    annotation (Placement(transformation(extent={{-320,260},{-280,300}}),
      iconTransformation(extent={{-140,110},{-100,150}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiLoa[nBoi](
    final quantity=fill("HeatFlowRate", nBoi),
    final unit=fill("W", nBoi))
    "Current boiler load"
    annotation (Placement(transformation(extent={{-320,230},{-280,270}}),
      iconTransformation(extent={{-140,90},{-100,130}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChi[nBoi]
    "Boiler status: true=ON"
    annotation (Placement(transformation(extent={{-320,200},{-280,240}}),
      iconTransformation(extent={{-140,60},{-100,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWat_flow(
    final min=0,
    final unit="m3/s",
    final quantity="VolumeFlowRate")
    "Measured hot water flow rate"
    annotation (Placement(transformation(extent={{-320,170},{-280,210}}),
      iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uChiSta
    "Current boiler stage, it would the same as boiler stage setpoint when it is not in staging process"
    annotation (Placement(transformation(extent={{-320,140},{-280,180}}),
      iconTransformation(extent={{-140,10},{-100,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiHeaCon[nBoi]
    "Boilers head pressure control status"
    annotation (Placement(transformation(extent={{-320,110},{-280,150}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uChiWatIsoVal[nBoi](
    final min=fill(0, nBoi),
    final max=fill(1, nBoi),
    final unit=fill("1", nBoi))
    "Hot water isolation valve position"
    annotation (Placement(transformation(extent={{-320,80},{-280,120}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiWatReq[nBoi]
    "Hot water requst status for each boiler"
    annotation (Placement(transformation(extent={{-320,-30},{-280,10}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uConWatReq[nBoi]
    "Condenser water requst status for each boiler"
    annotation (Placement(transformation(extent={{-320,-140},{-280,-100}}),
      iconTransformation(extent={{-140,-100},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uChiConIsoVal[nBoi]
    "Boiler condenser water isolation valve status"
    annotation (Placement(transformation(extent={{-320,-200},{-280,-160}}),
      iconTransformation(extent={{-140,-130},{-100,-90}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uWSE if have_WSE
    "Water side economizer status: true = ON, false = OFF"
    annotation (Placement(transformation(extent={{-320,-260},{-280,-220}}),
      iconTransformation(extent={{-140,-160},{-100,-120}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpeSet(
    final min=0,
    final max=1,
    final unit="1")
    "Condenser water pump speed setpoint"
    annotation (Placement(transformation(extent={{-320,-300},{-280,-260}}),
      iconTransformation(extent={{-140,-190},{-100,-150}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uConWatPumSpe(
    final min=0,
    final max=1,
    final unit="1")
    "Current condenser water pump speed"
    annotation (Placement(transformation(extent={{-320,-360},{-280,-320}}),
      iconTransformation(extent={{-140,-210},{-100,-170}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yStaPro
    "Indicate stage-down status: true=in stage-down process"
    annotation (Placement(transformation(extent={{280,330},{320,370}}),
      iconTransformation(extent={{100,170},{140,210}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiDem[nBoi](
    final quantity=fill("HeatFlowRate", nBoi),
    final unit=fill("W", nBoi))
    "Boiler demand setpoint"
    annotation (Placement(transformation(extent={{280,240},{320,280}}),
      iconTransformation(extent={{100,130},{140,170}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChi[nBoi]
    "Boiler enabling status"
    annotation (Placement(transformation(extent={{280,200},{320,240}}),
      iconTransformation(extent={{100,100},{140,140}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yReaDemLim
    "Release demand limit"
    annotation (Placement(transformation(extent={{280,160},{320,200}}),
      iconTransformation(extent={{100,60},{140,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatIsoVal[nBoi](
    final min=fill(0, nBoi),
    final max=fill(1, nBoi),
    final unit=fill("1", nBoi))
    "Boiler hot water isolation valve position"
    annotation (Placement(transformation(extent={{280,20},{320,60}}),
      iconTransformation(extent={{100,20},{140,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yTowStaDow
    "Tower stage down status: true=stage down cooling tower"
    annotation (Placement(transformation(extent={{280,-80},{320,-40}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yChiHeaCon[nBoi]
    "Boiler head pressure control enabling status"
    annotation (Placement(transformation(extent={{280,-130},{320,-90}}),
      iconTransformation(extent={{100,-50},{140,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yLeaPum
    "Lead pump status"
    annotation (Placement(transformation(extent={{280,-170},{320,-130}}),
      iconTransformation(extent={{100,-90},{140,-50}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yDesConWatPumSpe(
    final min=0,
    final max=1,
    final unit="1")
    "Condenser water pump design speed at current stage"
    annotation (Placement(transformation(extent={{280,-200},{320,-160}}),
      iconTransformation(extent={{100,-130},{140,-90}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yConWatPumNum
    "Number of operating condenser water pumps"
    annotation (Placement(transformation(extent={{280,-240},{320,-200}}),
      iconTransformation(extent={{100,-170},{140,-130}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yChiWatMinFloSet(
    final min=0,
    final unit="m3/s",
    final quantity="VolumeFlowRate")
    "Hot water minimum flow setpoint"
    annotation (Placement(transformation(extent={{280,-350},{320,-310}}),
      iconTransformation(extent={{100,-210},{140,-170}})));

protected
  Buildings.Controls.OBC.CDL.Integers.Change cha
    "Check if stage setpoint dicreases"
    annotation (Placement(transformation(extent={{-240,340},{-220,360}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.NextBoiler
    nexChi(
    final nBoi=nBoi)
    "Identify next enabling boiler"
    annotation (Placement(transformation(extent={{-40,310},{-20,330}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.DownStart
    dowSta(
    final nBoi=nBoi,
    final isParallelBoiler=isParallelBoiler,
    final chiDemRedFac=chiDemRedFac,
    final holChiDemTim=holChiDemTim,
    final minFloSet=minFloSet,
    final maxFloSet=maxFloSet,
    final aftByPasSetTim=aftByPasSetTim,
    final relFloDif=relFloDif,
    final byPasSetTim=byPasSetTim,
    final waiTim=waiTim,
    final chaChiWatIsoTim=chaChiWatIsoTim,
    final proOnTim=proOnTim)
    "Start stage-down process"
    annotation (Placement(transformation(extent={{60,220},{80,240}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.HWIsoVal
    disChiIsoVal(
    final nBoi=nBoi,
    final chaChiWatIsoTim=chaChiWatIsoTim,
    final iniValPos=1,
    final endValPos=0)
    "Disable isolation valve of the boiler being disabled"
    annotation (Placement(transformation(extent={{200,50},{220,70}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.CondenserWater.Controller
    conWatPumCon(
    final isHeadered=isHeadered,
    final have_WSE=have_WSE,
    final nBoi=nBoi,
    final totSta=totSta,
    final staVec=staVec,
    final desConWatPumSpe=desConWatPumSpe,
    final desConWatPumNum=desConWatPumNum,
    final relSpeDif=relSpeDif)
    "Enabling next condenser water pump or change pump speed"
    annotation (Placement(transformation(extent={{140,-192},{160,-172}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint
    minBoiWatFlo(
    final nBoi=nBoi,
    final isParallelBoiler=isParallelBoiler,
    final maxFloSet=maxFloSet,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet)
    "Minimum hot water flow setpoint"
    annotation (Placement(transformation(extent={{100,-330},{120,-310}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.ResetMinBypass
    minBypSet(
    final aftByPasSetTim=aftByPasSetTim, final relFloDif=relFloDif)
    "Check if minium bypass has been reset"
    annotation (Placement(transformation(extent={{100,-380},{120,-360}})));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant con(
    final k=false)
    "False constant"
    annotation (Placement(transformation(extent={{-160,190},{-140,210}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea1[nBoi]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-240,-20},{-220,0}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor curDisChi(
    final nin=nBoi)
    "Current disabling boiler"
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));

  Buildings.Controls.OBC.CDL.Continuous.LessEqualThreshold lesEquThr(
    final threshold=0.5)
    "Check if the disabled boiler has hot water request"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));

  Buildings.Controls.OBC.CDL.Logical.And and4
    "Logical and"
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi2
    "Logical switch"
    annotation (Placement(transformation(extent={{60,10},{80,30}})));

  Buildings.Controls.OBC.CDL.Logical.And and1
    "Logical and"
    annotation (Placement(transformation(extent={{140,10},{160,30}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep4(
    final nout=nBoi)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{40,70},{60,90}})));

  Buildings.Controls.OBC.CDL.Logical.Switch swi[nBoi]
    "Hot water isolvation valve position"
    annotation (Placement(transformation(extent={{140,70},{160,90}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea2[nBoi]
    "Convert boolean input to real output"
    annotation (Placement(transformation(extent={{-240,-130},{-220,-110}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor curDisChi1(
    final nin=nBoi)
    "Current disabling boiler"
    annotation (Placement(transformation(extent={{-80,-130},{-60,-110}})));

  Buildings.Controls.OBC.CDL.Continuous.LessEqualThreshold lesEquThr1(
    final threshold=0.5)
    "Check if the disabled boiler is not requiring condenser water"
    annotation (Placement(transformation(extent={{-40,-130},{-20,-110}})));

  Buildings.Controls.OBC.CDL.Logical.And3 and5
    "Logical and"
    annotation (Placement(transformation(extent={{60,-130},{80,-110}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(
    final nout=nBoi)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{60,-80},{80,-60}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch logSwi [nBoi]
    "Boilers head pressure control status"
    annotation (Placement(transformation(extent={{140,-80},{160,-60}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr  mulOr(
    final nu=nBoi)
    "Multiple or"
    annotation (Placement(transformation(extent={{-80,-200},{-60,-180}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr1(
    final nu=nBoi)
    "Multiple or"
    annotation (Placement(transformation(extent={{-80,-230},{-60,-210}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat
    "Logical latch, maintain ON signal until condition changes"
    annotation (Placement(transformation(extent={{-180,340},{-160,360}})));

  Buildings.Controls.OBC.CDL.Logical.And and2
    "Logical and"
    annotation (Placement(transformation(extent={{200,-250},{220,-230}})));

  Buildings.Controls.OBC.CDL.Logical.Edge edg1
    "Rising edge, output true at the moment when input turns from false to true"
    annotation (Placement(transformation(extent={{200,-380},{220,-360}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre
    "Break algebraic loop"
    annotation (Placement(transformation(extent={{160,-380},{180,-360}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat1
    "Maintain ON signal when condenser water pump has been disabled"
    annotation (Placement(transformation(extent={{240,-270},{260,-250}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat2
    "Maintain ON signal when boiler demand has been limited"
    annotation (Placement(transformation(extent={{120,150},{140,170}})));

  Buildings.Controls.OBC.CDL.Logical.Switch chiWatMinSet
    "Hot water minimum flow set"
    annotation (Placement(transformation(extent={{200,-340},{220,-320}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat3
    "Maintain ON signal when hot water isolation valve has been disabled"
    annotation (Placement(transformation(extent={{200,-40},{220,-20}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat4
    "Maintain ON signal when boiler head pressure control has been disabled"
    annotation (Placement(transformation(extent={{200,-140},{220,-120}})));

equation
  connect(nexChi.yEnaSmaBoi,dowSta. nexEnaChi)
    annotation (Line(points={{-18,311},{30,311},{30,226},{58,226}},
      color={255,127,0}));

  connect(dowSta.uChiHeaCon, uChiHeaCon)
    annotation (Line(points={{58,224},{-100,224},{-100,130},{-300,130}},
      color={255,0,255}));

  connect(dowSta.uChiWatIsoVal, uChiWatIsoVal)
    annotation (Line(points={{58,222},{-60,222},{-60,100},{-300,100}},
      color={0,0,127}));

  connect(nexChi.yLasDisBoi,dowSta. nexDisChi)
    annotation (Line(points={{-18,316},{20,316},{20,220},{58,220}},
      color={255,127,0}));

  connect(uChiWatReq, booToRea1.u)
    annotation (Line(points={{-300,-10},{-242,-10}}, color={255,0,255}));

  connect(booToRea1.y, curDisChi.u)
    annotation (Line(points={{-218,-10},{-82,-10}}, color={0,0,127}));

  connect(curDisChi.y, lesEquThr.u)
    annotation (Line(points={{-58,-10},{-42,-10}}, color={0,0,127}));

  connect(nexChi.yOnOff, logSwi2.u2)
    annotation (Line(points={{-18,320},{0,320},{0,20},{58,20}},
      color={255,0,255}));

  connect(and4.y, logSwi2.u1)
    annotation (Line(points={{-18,30},{40,30},{40,28},{58,28}},
      color={255,0,255}));

  connect(nexChi.yLasDisBoi, curDisChi.index)
    annotation (Line(points={{-18,316},{20,316},{20,120},{-140,120},{-140,-30},
      {-70,-30},{-70,-22}}, color={255,127,0}));

  connect(lesEquThr.y, and1.u2)
    annotation (Line(points={{-18,-10},{120,-10},{120,12},{138,12}},
      color={255,0,255}));

  connect(logSwi2.y, and1.u1)
    annotation (Line(points={{82,20},{138,20}}, color={255,0,255}));

  connect(nexChi.yLasDisBoi, disChiIsoVal.nexChaChi)
    annotation (Line(points={{-18,316},{20,316},{20,68},{198,68}},
      color={255,127,0}));

  connect(and1.y,disChiIsoVal.uUpsDevSta)
    annotation (Line(points={{162,20},{180,20},{180,55},{198,55}},
      color={255,0,255}));

  connect(nexChi.yOnOff, booRep4.u)
    annotation (Line(points={{-18,320},{0,320},{0,80},{38,80}}, color={255,0,255}));

  connect(booRep4.y, swi.u2)
    annotation (Line(points={{62,80},{138,80}}, color={255,0,255}));

  connect(uChiWatIsoVal, swi.u3)
    annotation (Line(points={{-300,100},{80,100},{80,72},{138,72}},
      color={0,0,127}));

  connect(dowSta.yChiWatIsoVal, swi.u1)
    annotation (Line(points={{82,228},{96,228},{96,88},{138,88}},
      color={0,0,127}));

  connect(swi.y, disChiIsoVal.uChiWatIsoVal)
    annotation (Line(points={{162,80},{180,80},{180,65},{198,65}},
      color={0,0,127}));

  connect(uConWatReq, booToRea2.u)
    annotation (Line(points={{-300,-120},{-242,-120}}, color={255,0,255}));

  connect(booToRea2.y, curDisChi1.u)
    annotation (Line(points={{-218,-120},{-82,-120}},color={0,0,127}));

  connect(curDisChi1.y, lesEquThr1.u)
    annotation (Line(points={{-58,-120},{-42,-120}}, color={0,0,127}));

  connect(logSwi2.y, and5.u1)
    annotation (Line(points={{82,20},{90,20},{90,-20},{10,-20},{10,-112},{58,-112}},
      color={255,0,255}));

  connect(lesEquThr1.y, and5.u3)
    annotation (Line(points={{-18,-120},{10,-120},{10,-128},{58,-128}},
      color={255,0,255}));

  connect(uChi,dowSta. uChi)
    annotation (Line(points={{-300,220},{-200,220},{-200,234},{58,234}},
      color={255,0,255}));

  connect(nexChi.yLasDisBoi, curDisChi1.index)
    annotation (Line(points={{-18,316},{20,316},{20,120},{-140,120},{-140,-140},
      {-70,-140},{-70,-132}}, color={255,127,0}));

  connect(nexChi.yOnOff, booRep1.u)
    annotation (Line(points={{-18,320},{0,320},{0,-70},{58,-70}},
      color={255,0,255}));

  connect(booRep1.y, logSwi.u2)
    annotation (Line(points={{82,-70},{138,-70}}, color={255,0,255}));

  connect(uChiHeaCon, logSwi.u3)
    annotation (Line(points={{-300,130},{-100,130},{-100,-90},{120,-90},{120,-78},
          {138,-78}},       color={255,0,255}));

  connect(dowSta.yChiHeaCon, logSwi.u1)
    annotation (Line(points={{82,232},{100,232},{100,-62},{138,-62}},
      color={255,0,255}));

  connect(and5.y, disHeaCon.uUpsDevSta)
    annotation (Line(points={{82,-120},{160,-120},{160,-92},{198,-92}},
      color={255,0,255}));

  connect(nexChi.yLasDisBoi, disHeaCon.nexChaChi)
    annotation (Line(points={{-18,316},{20,316},{20,-104},{198,-104}},
      color={255,127,0}));

  connect(logSwi.y, disHeaCon.uChiHeaCon)
    annotation (Line(points={{162,-70},{180,-70},{180,-108},{198,-108}},
      color={255,0,255}));

  connect(con.y,disNexCWP. uStaUp)
    annotation (Line(points={{-138,200},{-120,200},{-120,-158},{98,-158}},
      color={255,0,255}));

  connect(disNexCWP.yChiSta, conWatPumCon.uChiSta)
    annotation (Line(points={{122,-160},{130,-160},{130,-183},{138,-183}},
      color={255,127,0}));

  connect(mulOr1.y, conWatPumCon.uLeaConWatReq)
    annotation (Line(points={{-58,-220},{46,-220},{46,-180},{138,-180}},
      color={255,0,255}));

  connect(uChi, mulOr.u)
    annotation (Line(points={{-300,220},{-200,220},{-200,-190},{-82,-190}},
      color={255,0,255}));

  connect(uConWatReq, mulOr1.u)
    annotation (Line(points={{-300,-120},{-250,-120},{-250,-220},{-82,-220}},
      color={255,0,255}));

  connect(conWatPumCon.uWSE, uWSE)
    annotation (Line(points={{138,-186},{52,-186},{52,-240},{-300,-240}},
      color={255,0,255}));

  connect(conWatPumCon.uConWatPumSpe, uConWatPumSpe)
    annotation (Line(points={{138,-191},{64,-191},{64,-340},{-300,-340}},
      color={0,0,127}));

  connect(con.y, minBoiWatFlo.uStaUp)
    annotation (Line(points={{-138,200},{-120,200},{-120,-311},{98,-311}},
      color={255,0,255}));

  connect(nexChi.yOnOff, minBoiWatFlo.uOnOff)
    annotation (Line(points={{-18,320},{0,320},{0,-327},{98,-327}},
      color={255,0,255}));

  connect(dowSta.yChiDem, yChiDem)
    annotation (Line(points={{82,239},{179.5,239},{179.5,260},{300,260}},
      color={0,0,127}));

  connect(dowSta.yChi, yChi)
    annotation (Line(points={{82,224},{180,224},{180,220},{300,220}},
      color={255,0,255}));

  connect(disChiIsoVal.yChiWatIsoVal, yChiWatIsoVal)
    annotation (Line(points={{222,54},{260,54},{260,40},{300,40}},
      color={0,0,127}));

  connect(lat.y, minBypSet.chaPro)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},
      {-260,-366}, {98,-366}}, color={255,0,255}));

  connect(VChiWat_flow,minBypSet.VHotWat_flow)
    annotation (Line(points={{-300,190},{-170,190},{-170,-374},{98,-374}},
      color={0,0,127}));

  connect(VChiWat_flow, dowSta.VChiWat_flow)
    annotation (Line(points={{-300,190},{-170,190},{-170,232},{58,232}},
      color={0,0,127}));

  connect(uChiLoa,dowSta. uChiLoa)
    annotation (Line(points={{-300,250},{-170,250},{-170,236},{58,236}},
      color={0,0,127}));

  connect(lat.y,dowSta. uStaDow)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,240},
          {58,240}},        color={255,0,255}));

  connect(lat.y, disChiIsoVal.chaPro)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,52},
          {198,52}},       color={255,0,255}));

  connect(lat.y, and4.u2)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,22},
          {-42,22}},       color={255,0,255}));

  connect(lat.y, logSwi2.u3)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,12},
          {58,12}},       color={255,0,255}));

  connect(lat.y, disHeaCon.chaPro)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,-96},
          {198,-96}},       color={255,0,255}));

  connect(lat.y, minBoiWatFlo.uStaDow)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,-329},
          {98,-329}},         color={255,0,255}));

  connect(lat.y,disNexCWP. uStaDow)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},{-260,-162},
          {98,-162}},         color={255,0,255}));

  connect(lat.y, yStaPro)
    annotation (Line(points={{-158,350},{300,350}},color={255,0,255}));

  connect(dowSta.yOpeParLoaRatMin, yOpeParLoaRatMin)
    annotation (Line(points={{58,238},{40,238},{40,280},{-300,280}},
      color={0,0,127}));

  connect(conWatPumCon.uChiConIsoVal, uChiConIsoVal)
    annotation (Line(points={{138,-172},{-140,-172},{-140,-180},{-300,-180}},
      color={255,0,255}));

  connect(mulOr.y, conWatPumCon.uLeaChiEna)
    annotation (Line(points={{-58,-190},{40,-190},{40,-175},{138,-175}},
      color={255,0,255}));

  connect(mulOr.y, conWatPumCon.uLeaChiSta)
    annotation (Line(points={{-58,-190},{40,-190},{40,-177},{138,-177}},
      color={255,0,255}));

  connect(conWatPumCon.yDesConWatPumSpe, yDesConWatPumSpe)
    annotation (Line(points={{162,-179},{240,-179},{240,-180},{300,-180}},
      color={0,0,127}));

  connect(conWatPumCon.uConWatPumSpeSet, uConWatPumSpeSet)
    annotation (Line(points={{138,-189},{58,-189},{58,-280},{-300,-280}},
      color={0,0,127}));

  connect(uChi, minBoiWatFlo.uChi)
    annotation (Line(points={{-300,220},{-200,220},{-200,-316},{98,-316}},
      color={255,0,255}));

  connect(nexChi.yLasDisBoi, minBoiWatFlo.nexDisChi)
    annotation (Line(points={{-18,316},{20,316},{20,-321},{98,-321}},
      color={255,127,0}));

  connect(nexChi.yEnaSmaBoi, minBoiWatFlo.nexEnaChi)
    annotation (Line(points={{-18,311},{30,311},{30,-319},{98,-319}},
      color={255,127,0}));

  connect(con.y, minBoiWatFlo.uSubCha)
    annotation (Line(points={{-138,200},{-120,200},{-120,-324},{98,-324}},
      color={255,0,255}));

  connect(edg1.y, lat.clr)
    annotation (Line(points={{222,-370},{260,-370},{260,-390},{-190,-390},
      {-190,344},{-182,344}},   color={255,0,255}));

  connect(conWatPumCon.yConWatPumNum, yConWatPumNum)
    annotation (Line(points={{162,-185},{220,-185},{220,-220},{300,-220}},
      color={255,127,0}));

  connect(conWatPumCon.yLeaPum, yLeaPum)
    annotation (Line(points={{162,-173},{220,-173},{220,-150},{300,-150}},
      color={255,0,255}));

  connect(disHeaCon.yChiHeaCon, yChiHeaCon)
    annotation (Line(points={{222,-106},{260,-106},{260,-110},{300,-110}},
      color={255,0,255}));

  connect(minBypSet.yMinBypRes, pre.u)
    annotation (Line(points={{122,-370},{158,-370}}, color={255,0,255}));

  connect(pre.y, edg1.u)
    annotation (Line(points={{182,-370},{198,-370}}, color={255,0,255}));

  connect(dowSta.yReaDemLim, yReaDemLim)
    annotation (Line(points={{82,221},{92,221},{92,180},{300,180}},
      color={255,0,255}));

  connect(dowSta.yReaDemLim, lat2.u)
    annotation (Line(points={{82,221},{92,221},{92,160},{118,160}},
      color={255,0,255}));

  connect(edg1.y, lat2.clr)
    annotation (Line(points={{222,-370},{260,-370},{260,-390},{-190,-390},
      {-190,154},{118,154}}, color={255,0,255}));

  connect(lat2.y, and4.u1)
    annotation (Line(points={{142,160},{160,160},{160,140},{-80,140},{-80,30},
      {-42,30}}, color={255,0,255}));

  connect(conWatPumCon.yPumSpeChe, and2.u1)
    annotation (Line(points={{162,-191},{180,-191},{180,-240},{198,-240}},
      color={255,0,255}));

  connect(and2.y, lat1.u)
    annotation (Line(points={{222,-240},{230,-240},{230,-260},{238,-260}},
      color={255,0,255}));

  connect(edg1.y, lat1.clr)
    annotation (Line(points={{222,-370},{260,-370},{260,-390},{-190,-390},
      {-190,-266},{238,-266}}, color={255,0,255}));

  connect(lat1.y, minBoiWatFlo.uUpsDevSta)
    annotation (Line(points={{262,-260},{270,-260},{270,-290},{-40,-290},
      {-40,-313},{98,-313}}, color={255,0,255}));

  connect(lat1.y, minBypSet.uUpsDevSta)
    annotation (Line(points={{262,-260},{270,-260},{270,-290},{-40,-290},
      {-40,-362},{98,-362}}, color={255,0,255}));

  connect(dowSta.yChiWatMinFloSet, chiWatMinSet.u3)
    annotation (Line(points={{82,236},{170,236},{170,-338},{198,-338}},
      color={0,0,127}));

  connect(minBoiWatFlo.yChiWatMinFloSet, chiWatMinSet.u1)
    annotation (Line(points={{122,-320},{140,-320},{140,-322},{198,-322}},
      color={0,0,127}));

  connect(lat1.y, chiWatMinSet.u2)
    annotation (Line(points={{262,-260},{270,-260},{270,-290},{160,-290},
      {160,-330},{198,-330}}, color={255,0,255}));

  connect(chiWatMinSet.y, yChiWatMinFloSet)
    annotation (Line(points={{222,-330},{300,-330}}, color={0,0,127}));

  connect(chiWatMinSet.y, minBypSet.VMinBoiWat_setpoint)
    annotation (Line(points={{222,-330},{240,-330},{240,-350},{60,-350},
      {60,-378},{98,-378}}, color={0,0,127}));

  connect(nexChi.yOnOff, dowSta.uOnOff)
    annotation (Line(points={{-18,320},{0,320},{0,228},{58,228}},
      color={255,0,255}));

  connect(edg1.y, dowSta.clr)
    annotation (Line(points={{222,-370},{260,-370},{260,-390},{-190,-390},
      {-190,230},{58,230}}, color={255,0,255}));

  connect(disChiIsoVal.yEnaChiWatIsoVal, lat3.u)
    annotation (Line(points={{222,66},{240,66},{240,0},{180,0},{180,-30},
      {198,-30}}, color={255,0,255}));

  connect(lat3.y, and5.u2)
    annotation (Line(points={{222,-30},{240,-30},{240,-50},{40,-50},{40,-120},
      {58,-120}}, color={255,0,255}));

  connect(edg1.y, lat3.clr)
    annotation (Line(points={{222,-370},{260,-370},{260,-390},{-190,-390},
      {-190,-36},{198,-36}}, color={255,0,255}));

  connect(disHeaCon.yEnaHeaCon, lat4.u)
    annotation (Line(points={{222,-94},{240,-94},{240,-114},{180,-114},
      {180,-130},{198,-130}}, color={255,0,255}));

  connect(lat4.y, yTowStaDow)
    annotation (Line(points={{222,-130},{250,-130},{250,-60},{300,-60}},
      color={255,0,255}));

  connect(lat4.y, disNexCWP.uUpsDevSta)
    annotation (Line(points={{222,-130},{250,-130},{250,-142},{80,-142},{80,-152},
      {98,-152}}, color={255,0,255}));

  connect(lat4.y, and2.u2)
    annotation (Line(points={{222,-130},{250,-130},{250,-142},{80,-142},{80,-248},
      {198,-248}}, color={255,0,255}));

  connect(edg1.y, lat4.clr)
    annotation (Line(points={{222,-370},{260,-370},{260,-390},{-190,-390},
      {-190,-136},{198,-136}}, color={255,0,255}));

  connect(lat.y, nexChi.chaPro)
    annotation (Line(points={{-158,350},{-140,350},{-140,328},{-260,328},
      {-260,313},{-42,313}}, color={255,0,255}));

  connect(uStaSet, nexChi.uStaSet)
    annotation (Line(points={{-300,380},{-60,380},{-60,327},{-42,327}},
      color={255,127,0}));

  connect(nexChi.uBoiSet, uChiSet)
    annotation (Line(points={{-42,320},{-300,320}}, color={255,0,255}));

  connect(uStaSet, cha.u)
    annotation (Line(points={{-300,380},{-260,380},{-260,350},{-242,350}},
      color={255,127,0}));

  connect(cha.down, lat.u)
    annotation (Line(points={{-218,344},{-200,344},{-200,350},{-182,350}},
      color={255,0,255}));

  connect(uStaSet, disNexCWP.uStaSet)
    annotation (Line(points={{-300,380},{-130,380},{-130,-169},{98,-169}},
      color={255,127,0}));

  connect(uChiSta, disNexCWP.uChiSta)
    annotation (Line(points={{-300,160},{-150,160},{-150,-165},{98,-165}},
      color={255,127,0}));

annotation (
  defaultComponentName="dowProCon",
  Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-280,-400},{280,400}})),
    Icon(coordinateSystem(extent={{-100,-200},{100,200}}), graphics={
        Rectangle(
        extent={{-100,-200},{100,200}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        borderPattern=BorderPattern.Raised),
        Text(
          extent={{-120,260},{120,200}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-10,140},{10,-120}},
          lineColor={200,200,200},
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Polygon(
          points={{0,-120},{-42,-120},{0,-160},{40,-120},{0,-120}},
          lineColor={200,200,200},
          fillColor={207,207,207},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,190},{-58,178}},
          lineColor={255,127,0},
          textString="uStaSet"),
        Text(
          extent={{-96,140},{-26,126}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yOpeParLoaRatMin"),
        Text(
          extent={{-96,118},{-60,106}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiLoa"),
        Text(
          extent={{-100,88},{-70,76}},
          lineColor={255,0,255},
          textString="uChi"),
        Text(
          extent={{-98,68},{-44,54}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="VChiWat_flow"),
        Text(
          extent={{-96,6},{-44,-6}},
          lineColor={255,0,255},
          textString="uChiHeaCon"),
        Text(
          extent={{-98,-22},{-38,-34}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uChiWatIsoVal"),
        Text(
          extent={{-98,-54},{-48,-66}},
          lineColor={255,0,255},
          textString="uChiWatReq"),
        Text(
          extent={{-98,-72},{-40,-86}},
          lineColor={255,0,255},
          textString="uConWatReq"),
        Text(
          extent={{-98,-102},{-34,-116}},
          lineColor={255,0,255},
          textString="uChiConIsoVal"),
        Text(
          extent={{-102,-134},{-66,-146}},
          lineColor={255,0,255},
          textString="uWSE"),
        Text(
          extent={{-98,-182},{-24,-196}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatPumSpe"),
        Text(
          extent={{-98,-160},{-14,-178}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="uConWatPumSpeSet"),
        Text(
          extent={{60,198},{100,186}},
          lineColor={255,0,255},
          textString="yStaPro"),
        Text(
          extent={{60,158},{96,146}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiDem"),
        Text(
          extent={{72,126},{96,114}},
          lineColor={255,0,255},
          textString="yChi"),
        Text(
          extent={{36,50},{96,34}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatIsoVal"),
        Text(
          extent={{42,8},{96,-4}},
          lineColor={255,0,255},
          textString="yTowStaDow"),
        Text(
          extent={{48,-22},{96,-36}},
          lineColor={255,0,255},
          textString="yChiHeaCon"),
        Text(
          extent={{58,-62},{96,-74}},
          lineColor={255,0,255},
          textString="yLeaPum"),
        Text(
          extent={{18,-104},{98,-114}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yDesConWatPumSpe"),
        Text(
          extent={{34,-142},{96,-156}},
          lineColor={255,127,0},
          textString="yConWatPumNum"),
        Text(
          extent={{28,-180},{98,-194}},
          lineColor={0,0,127},
          pattern=LinePattern.Dash,
          textString="yChiWatMinFloSet"),
        Text(
          extent={{40,88},{96,74}},
          lineColor={255,0,255},
          textString="yReaDemLim"),
        Text(
          extent={{-100,170},{-60,158}},
          lineColor={255,0,255},
          textString="uChiSet"),
        Text(
          extent={{-100,38},{-58,26}},
          lineColor={255,127,0},
          textString="uChiSta")}),
Documentation(info="<html>
<p>
Block that controls devices when there is a stage-down command. This sequence is for
water-cooled primary-only parallel boiler plants with headered hot water pumps
and headered condenser water pumps, or air-cooled primary-only parallel boiler
plants with headered hot water pumps.
This development is based on ASHRAE RP-1711 Advanced Sequences of Operation for 
HVAC Systems Phase II – Central Plants and Hydronic Systems (Draft version, March 2020),
section 5.2.4.17, which specifies the step-by-step control of
devices during boiler staging down process.
</p>
<ol>
<li>
Identify the boiler(s) that should be enabled (and disabled, if <code>have_PonyBoiler=true</code>). 
This is implemented in block <code>nexChi</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.NextBoiler\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.NextBoiler</a>
for more decriptions.
</li>
<li>
Start the staging down process,
<ul>
<li>
For any stage change during which a smaller boiler is enabled and a larger chller
is disabled:
<ol type=\"i\">
<li>
Command operating boilers to reduce demand to 75% (<code>chiDemRedFac</code>) of 
their current load (<code>uChiLoa</code>) or a percentage equal to current stage 
minimum cycling operative partial load ratio <code>yOpeParLoaRatMin</code>, whichever is greater. 
Wait until actual demand &lt;

 80% of current load up to a maximum of 5 minutes 
(<code>holChiDemTim</code>) before proceeding.
</li>
<li>
Slowly change the minimum flow bypass setpoint to the one that includes both 
boilers are enabled. After new setpoint is achieved, wait 1 minute 
(<code>aftByPasSetTim</code>) to allow loop stabilize.
</li>
<li>
Enable head pressure control for the boiler being enabled. Wait 30 seconds (<code>waiTim</code>).
</li>
<li>
Slowly (<code>chaChiWatIsoTim</code>) open hot water isolation valve of the smaller 
boiler being enabled. The valve timing should be determind in the field.
</li>
<li>
Start the smaller boiler after its hot water isolation valve is fully open.
</li>
<li>
Wait 5 minutes (<code>proOnTim</code>) for the newly enabled boiler to prove that 
it is operating correctly, then shut off the larger boiler and release the 
demand limit.
</li>
</ol>
</li>
<li>
If staging down from any other stage, shut off the last stage boiler.
</li>
</ul>
These are implemented in block <code>dowSta</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.DownStart\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.DownStart</a>
for more decriptions.
</li>
<li>
When the controller of the boiler being shut off indicates no request for chilled
water flow (<code>uChiWatReq=false</code>), slowly (<code>chaChiWatIsoTim</code>) 
close the boiler's hot water isolation valve to avoid a sudden change in flow 
through other operating boilers.
This is implemented in block <code>disChiIsoVal</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.CHWIsoVal\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.CHWIsoVal</a>
for more decriptions.
</li>

<li>
When the controller of the boiler being shut off indicates no request for condenser
water flow (<code>uConWatReq=false</code>), disable the boiler's head pressure control 
loop.
This is implemented in block <code>disHeaCon</code>. See
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.HeadControl\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.HeadControl</a>
for more decriptions.
</li>

<li>
When the condenser water head pressure control valve is fully closed, shut off
the last lag condenser water pump or change the pump speed to that required of 
the new stage.
Block <code>disNexCWP</code> identifies boiler stage for the condenser water pump
control
(<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.EnableCWPump\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.EnableCWPump</a>)
and block <code>conWatPumCon</code> checks if the condenser water pumps have been reset
(<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.CondenserWater.Controller\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.CondenserWater.Controller</a>).
</li>

<li>
Change the hot water minimum flow setpoint to that appropriate for the new
stage.
The minimum flow setpoint is reset in block <code>minBoiWatFlo</code>
(<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.MinimumFlowBypass.Subsequences.FlowSetpoint</a>).
Block <code>minBypSet</code> checks if the new setpoint is achieved
(<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.ResetMinBypass\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Staging.Processes.Subsequences.ResetMinBypass</a>).
</li>
</ol>
</html>", revisions="<html>
<ul>
<li>
September 23, 2019, by Jianjun Hu:<br/>
First implementation.
</li>
</ul>
</html>"));
end Down_backup;
