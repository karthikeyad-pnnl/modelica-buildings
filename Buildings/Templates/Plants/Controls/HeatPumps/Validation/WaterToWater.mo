within Buildings.Templates.Plants.Controls.HeatPumps.Validation;
model WaterToWater
  final parameter Real capHea_nominal(
    final unit="W")=sum(ctl.capHeaHp_nominal)
    "Installed heating capacity"
    annotation (Dialog(group="Nominal condition"));
  parameter Real THeaWatSup_nominal(
    unit="K",
    displayUnit="degC")=323.15
    "Design HW supply temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real THeaWatSup_SP(
    unit="K",
    displayUnit="degC")=324.15
    "Design HW supply temperature setpoint"
    annotation (Dialog(group="Nominal condition"));
  parameter Real THeaWatRet_nominal(
    unit="K",
    displayUnit="degC")=315.15
    "Design HW return temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real VHeaWat_flow_nominal(unit="m3/s")=capHea_nominal/abs(
    THeaWatSup_nominal - THeaWatRet_nominal)/ctl.cp_default/ctl.rho_default
    "Design HW volume flow rate"
    annotation (Dialog(group="Nominal condition"));
  final parameter Real capCoo_nominal(
    final unit="W")=sum(ctl.capCooHp_nominal)
    "Installed cooling capacity"
    annotation (Dialog(group="Nominal condition"));
  parameter Real TChiWatSup_nominal(
    unit="K",
    displayUnit="degC")=280.15
    "Design CHW supply temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real TChiWatSup_SP(
    unit="K",
    displayUnit="degC")=279.15
    "Design CHW supply temperature setpoint"
    annotation (Dialog(group="Nominal condition"));
  parameter Real TChiWatRet_nominal(
    unit="K",
    displayUnit="degC")=285.15
    "Design CHW return temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real VChiWat_flow_nominal(unit="m3/s")=capHea_nominal/abs(
    TChiWatSup_nominal - TChiWatRet_nominal)/ctl.cp_default/ctl.rho_default
    "Design CHW volume flow rate"
    annotation (Dialog(group="Nominal condition"));
  Buildings.Templates.Plants.Controls.HeatPumps.WaterToWater ctl(
    have_heaWat=true,
    have_chiWat=true,
    have_valHpInlIso=true,
    have_valHpOutIso=true,
    have_pumChiWatPriDed_select=true,
    have_pumHeaWatSec_select=true,
    have_pumPriHdr=false,
    have_pumChiWatSec_select=true,
    have_senVHeaWatPri_select=true,
    have_senVChiWatPri_select=true,
    have_senTHeaWatPriRet_select=true,
    have_senTChiWatPriRet_select=true,
    have_senTHeaWatSecRet=true,
    have_senTChiWatSecRet=true,
    nHp=3,
    have_senDpHeaWatRemWir=false,
    nSenDpHeaWatRem=1,
    have_senDpChiWatRemWir=false,
    nSenDpChiWatRem=1,
    final THeaWatSup_nominal=THeaWatSup_nominal,
    THeaWatSupSet_min=298.15,
    final VHeaWatSec_flow_nominal=VHeaWat_flow_nominal,
    capHeaHp_nominal=fill(350, ctl.nHp),
    dpHeaWatRemSet_max={5E4},
    final TChiWatSup_nominal=TChiWatSup_nominal,
    TChiWatSupSet_max=288.15,
    final VChiWatSec_flow_nominal=VChiWat_flow_nominal,
    capCooHp_nominal=fill(350, ctl.nHp),
    yPumHeaWatPriSet=0.8,
    yPumChiWatPriSet=0.7,
    dpChiWatRemSet_max={5E4},
    have_inpSch=true,
    staEqu=[1/3,1/3,1/3; 2/3,2/3,2/3; 1,1,1],
    idxEquAlt={1,2,3}) "Plant controller"
    annotation (Placement(transformation(extent={{6,20},{46,88}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.TimeTable ratV_flow(
    table=[
      0, 0, 0;
      5, 0, 0;
      6, 1, 0;
      12, 0.2, 0.2;
      15, 0, 1;
      22, 0.1, 0.1;
      24, 0, 0],
    timeScale=3600)
    "Source signal for volume flow rate ratio – Index 1 for HW, 2 for CHW"
    annotation (Placement(transformation(extent={{-150,-150},{-130,-130}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-100,-50},{-80,-30}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-74,-70},{-54,-50}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1Hp_actual[ctl.nHp]
    "HP status" annotation (Placement(transformation(extent={{70,90},{90,110}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumHeaWatPri_actual1[ctl.nPumHeaWatPri]
    if ctl.have_heaWat and ctl.have_pumHeaWatPri "Primary HW pump status"
    annotation (Placement(transformation(extent={{100,70},{120,90}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumChiWatPri_actual[ctl.nPumChiWatPri]
    if ctl.have_chiWat and ctl.have_pumChiWatPri "Primary CHW pump status"
    annotation (Placement(transformation(extent={{70,50},{90,70}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumHeaWatSec_actual[ctl.nPumHeaWatSec]
    if ctl.have_heaWat and ctl.have_pumHeaWatSec "Secondary HW pump status"
    annotation (Placement(transformation(extent={{100,30},{120,50}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumChiWatSec_actual[ctl.nPumChiWatSec]
    if ctl.have_chiWat and ctl.have_pumChiWatSec "Secondary CHW pump status"
    annotation (Placement(transformation(extent={{70,10},{90,30}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai[2](
    each k=5)
    "Use fraction of flow rate as a proxy for plant reset request"
    annotation (Placement(transformation(extent={{-106,90},{-86,110}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reqResHeaWat
    "Generate HW reset request"
    annotation (Placement(transformation(extent={{-60,110},{-40,130}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reqResChiWat
    "Generate CHW reset request"
    annotation (Placement(transformation(extent={{-60,70},{-40,90}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin[1](
    amplitude=0.1 * ctl.dpHeaWatRemSet_max,
    freqHz={4 / 8000},
    each phase=3.1415926535898)
    if ctl.have_heaWat
    "Source signal used to generate measurement values"
    annotation (Placement(transformation(extent={{-150,-190},{-130,-170}})));
  Buildings.Controls.OBC.CDL.Reals.Add dpHeaWatRem[1]
    if ctl.have_heaWat
    "Differential pressure at remote location"
    annotation (Placement(transformation(extent={{-74,-110},{-54,-90}})));
  Buildings.Controls.OBC.CDL.Reals.Add dpChiWatRem[1]
    if ctl.have_chiWat
    "Differential pressure at remote location"
    annotation (Placement(transformation(extent={{-74,-150},{-54,-130}})));
  Controls.Pumps.Generic.ResetLocalDifferentialPressure resDpHeaWatLoc[1](each
      dpLocSet_max=20E4) if ctl.have_heaWat "Local HW DP reset"
    annotation (Placement(transformation(extent={{-34,-164},{-14,-144}})));
  Controls.Pumps.Generic.ResetLocalDifferentialPressure resDpChiWatLoc[1](each
      dpLocSet_max=15E4) if ctl.have_chiWat "Local CHW DP reset"
    annotation (Placement(transformation(extent={{-34,-210},{-14,-190}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin1[1](
    amplitude=0.1 * ctl.dpChiWatRemSet_max,
    freqHz={3 / 8000},
    each phase=3.1415926535898)
    "Source signal used to generate measurement values"
    annotation (Placement(transformation(extent={{-150,-230},{-130,-210}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter dpHeaWatLoc(final k=4)
    if ctl.have_heaWat
    "Differential pressure local to the plant"
    annotation (Placement(transformation(extent={{-74,-190},{-54,-170}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter dpChiWatLoc(final k=3)
    if ctl.have_chiWat
    "Differential pressure local to the plant"
    annotation (Placement(transformation(extent={{-74,-230},{-54,-210}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatSup(final k=
        THeaWatSup_nominal) "HWST"
    annotation (Placement(transformation(extent={{-170,210},{-150,230}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatSupSet(final k=60 + 273.15)
                       "HWSTS"
    annotation (Placement(transformation(extent={{-200,230},{-180,250}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant conCooTanCha(k=false)
    "Cold thermal energy storage dedicated charging mode enable signal"
    annotation (Placement(transformation(extent={{-60,190},{-40,210}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Pulse booPul(period=86400*2, shift=
       30)
    "Boolean pulse signal used to enable plant at non-zero simulation time"
    annotation (Placement(transformation(extent={{-60,150},{-40,170}})));
  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conIntOpeMod[8](k={
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Heating_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Disabled,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_1,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_2,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_3,
        Buildings.Controls.OBC.HeatPumpPlant.Types.OperationMode.Cooling_4})
    "Constant integer source for enumerating operation modes"
    annotation (Placement(transformation(extent={{10,220},{30,240}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEquOpeMod[8]
    "Identify current operation mode in array of possible operation modes"
    annotation (Placement(transformation(extent={{50,180},{70,200}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep(nout=8)
    "Integer replicator"
    annotation (Placement(transformation(extent={{10,180},{30,200}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelProCha[8](delayTime=fill(30,
        8))
    "Delay for representing operation mode change process duration"
    annotation (Placement(transformation(extent={{92,180},{112,200}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOrProCha(nin=8)
    "Identify any operation mode change completions"
    annotation (Placement(transformation(extent={{120,180},{140,200}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edgProCha
    "Edge block to change process change completion signal into pulse"
    annotation (Placement(transformation(extent={{150,180},{170,200}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preOpeMod[8]
    "Pre block for routing back operation mode status signals"
    annotation (Placement(transformation(extent={{90,140},{110,160}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preProCha
    "Pre block for routing back process change completion signal"
    annotation (Placement(transformation(extent={{180,180},{200,200}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelTChiWatRet(delayTime=14000)
    "Delay chilled water return temperature signal"
    annotation (Placement(transformation(extent={{150,-30},{130,-10}})));
  Buildings.Controls.OBC.CDL.Logical.Timer timTChiWatRet(t=18000)
    "Timer for disabling chilled water return temperature latch"
    annotation (Placement(transformation(extent={{150,-82},{130,-62}})));
  Buildings.Controls.OBC.CDL.Logical.Not notTChiWatRet
    "Not operator for disabling latch required instant"
    annotation (Placement(transformation(extent={{110,-90},{90,-70}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAndTChiWatRet(nin=3)
    "Enable latch for chilled water return temperature"
    annotation (Placement(transformation(extent={{90,-50},{70,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Latch latTChiWatRet
    "Latch for holding signal to chilled water return temperature switch"
    annotation (Placement(transformation(extent={{50,-50},{30,-30}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre2
    "Pre block for routing signal to change chilled water return temperature latch"
    annotation (Placement(transformation(extent={{30,-90},{50,-70}})));
  Buildings.Controls.OBC.CDL.Integers.OnCounter onCouInt
    "Count falling edge signal based on the reset signal"
    annotation (Placement(transformation(extent={{60,-130},{80,-110}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr(t=1)
    "Pass signal greater than a threshold"
    annotation (Placement(transformation(extent={{90,-130},{110,-110}})));
  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdg
    "Falling Edge block to change chilled water return temperature signal into pulse"
    annotation (Placement(transformation(extent={{30,-130},{50,-110}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    "Not operator for disabling the passing signal"
    annotation (Placement(transformation(extent={{130,-130},{150,-110}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelTChiWatSup(delayTime=7000)
    "Delay signal to chilled water supply temperature"
    annotation (Placement(transformation(extent={{150,-170},{130,-150}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelTHotWatRet(delayTime=7000)
    "Delay enable of hot water return temperature latch"
    annotation (Placement(transformation(extent={{50,-170},{30,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preTChiWatSup
    "Pre block for routing back chilled water supply temperature switch signal"
    annotation (Placement(transformation(extent={{80,-170},{60,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Timer timTHotWatRet(t=7000)
    "Timer to disable hot water return temperature latch"
    annotation (Placement(transformation(extent={{160,-220},{180,-200}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preTHotWatRet
    "Pre block for routing signal to change hot water return temperature latch"
    annotation (Placement(transformation(extent={{130,-220},{150,-200}})));
  Buildings.Controls.OBC.CDL.Logical.And andTHotWatRet
    "Enable latch only for fixed duration and then disable it"
    annotation (Placement(transformation(extent={{80,-210},{60,-190}})));
  Buildings.Controls.OBC.CDL.Logical.Not notTHotWatRet
    "Not operation for disabling latch"
    annotation (Placement(transformation(extent={{110,-218},{90,-198}})));
  Buildings.Controls.OBC.CDL.Logical.Latch latTChiWatSup
    "Latch for holding signal to chilled water supply temperature signal"
    annotation (Placement(transformation(extent={{110,-170},{90,-150}})));
  Buildings.Controls.OBC.CDL.Logical.Latch latTHotWatRet
    "Latch to hold switch for hot water return temperature"
    annotation (Placement(transformation(extent={{50,-210},{30,-190}})));
  Buildings.Controls.OBC.CDL.Logical.Timer timTChiWatSupSet(t=7000)
    "Timer to switch chilled water supply temperature setpoint"
    annotation (Placement(transformation(extent={{50,-250},{30,-230}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatRet2(k=273.15 + 50)
    "Measured hot water return temperature (Low)"
    annotation (Placement(transformation(extent={{-200,140},{-180,160}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatRet1(k=273.15 + 54)
    "Measured hot water return temperature (High)"
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTHotWatRet
    "Switch between two different hot water return temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-150,172},{-130,192}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSupSet1(k=273.15 + 14.5)
    "Chilled water supply temperature setpoint (High)"
    annotation (Placement(transformation(extent={{-200,100},{-180,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSupSet2(k=273.15 + 9)
    "Chilled water supply temperature setpoint (Low)"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTChiWatSupSet
    "Switch between two different chilled water supply temperature setpoints to induce mode transition"
    annotation (Placement(transformation(extent={{-150,110},{-130,130}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSup1(k=273.15 + 14)
    "Measured chilled water supply temperature (High)"
    annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSup2(k=273.15 + 9)
    "Measured chilled water supply temperature (Low)"
    annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTChiWatSup
    "Switch between two different chilled water supply temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-150,52},{-130,72}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatRet1(k=273.15 + 12)
    "Measured chilled water return temperature (High)"
    annotation (Placement(transformation(extent={{-200,-60},{-180,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatRet2(k=273.15 + 16)
    "Measured chilled water return temperature (Low)"
    annotation (Placement(transformation(extent={{-200,-100},{-180,-80}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTChiWatRet
    "Switch between two different chilled water return temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-150,-30},{-130,-10}})));
equation
  connect(ratV_flow.y[1], VHeaWat_flow.u)
    annotation (Line(points={{-128,-140},{-114,-140},{-114,-40},{-102,-40}},
                                                                      color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u)
    annotation (Line(points={{-128,-140},{-104,-140},{-104,-60},{-76,-60}},
                                                   color={0,0,127}));
  connect(ctl.y1Hp, y1Hp_actual.y1)
    annotation (Line(points={{48,82},{60,82},{60,100},{68,100}},
                                                              color={255,0,255}));
  connect(ctl.y1PumHeaWatPri, y1PumHeaWatPri_actual1.y1)
    annotation (Line(points={{48,66},{66,66},{66,80},{98,80}},color={255,0,255}));
  connect(ctl.y1PumChiWatPri, y1PumChiWatPri_actual.y1)
    annotation (Line(points={{48,64},{62,64},{62,60},{68,60}},color={255,0,255}));
  connect(ctl.y1PumHeaWatSec, y1PumHeaWatSec_actual.y1)
    annotation (Line(points={{48,60},{66,60},{66,40},{98,40}},color={255,0,255}));
  connect(ctl.y1PumChiWatSec, y1PumChiWatSec_actual.y1)
    annotation (Line(points={{48,58},{64,58},{64,20},{68,20}},
                                                            color={255,0,255}));
  connect(ratV_flow.y, gai.u)
    annotation (Line(points={{-128,-140},{-114,-140},{-114,100},{-108,100}},
                                                                        color={0,0,127}));
  connect(gai[1].y, reqResHeaWat.u)
    annotation (Line(points={{-84,100},{-70,100},{-70,120},{-62,120}},
                                                color={0,0,127}));
  connect(gai[2].y, reqResChiWat.u)
    annotation (Line(points={{-84,100},{-70,100},{-70,80},{-62,80}},
                                                                  color={0,0,127}));
  connect(reqResHeaWat.y,ctl.nReqResHeaWat)
    annotation (Line(points={{-38,120},{-26,120},{-26,66},{4,66}},
                                                                 color={255,127,0}));
  connect(reqResChiWat.y,ctl.nReqResChiWat)
    annotation (Line(points={{-38,80},{-30,80},{-30,62},{4,62}}, color={255,127,0}));
  connect(sin.y, dpHeaWatRem.u2)
    annotation (Line(points={{-128,-180},{-100,-180},{-100,-106},{-76,-106}},
                                                   color={0,0,127}));
  connect(sin1.y, dpChiWatRem.u2)
    annotation (Line(points={{-128,-220},{-92,-220},{-92,-146},{-76,-146}},
                                                     color={0,0,127}));
  connect(dpHeaWatRem[1].y, dpHeaWatLoc.u)
    annotation (Line(points={{-52,-100},{-46,-100},{-46,-160},{-86,-160},{-86,
          -180},{-76,-180}},
      color={0,0,127}));
  connect(dpChiWatRem[1].y, dpChiWatLoc.u)
    annotation (Line(points={{-52,-140},{-48,-140},{-48,-200},{-86,-200},{-86,
          -220},{-76,-220}},
      color={0,0,127}));
  connect(dpHeaWatRem.y, resDpHeaWatLoc.dpRem)
    annotation (Line(points={{-52,-100},{-46,-100},{-46,-160},{-36,-160}},
                                                                        color={0,0,127}));
  connect(dpChiWatRem.y, resDpChiWatLoc.dpRem)
    annotation (Line(points={{-52,-140},{-48,-140},{-48,-206},{-36,-206}},color={0,0,127}));
  connect(THeaWatSupSet.y, ctl.THeaWatPriSupSet) annotation (Line(points={{-178,
          240},{-20,240},{-20,58},{4,58}},    color={0,0,127}));
  connect(VHeaWat_flow.y, ctl.VHeaWatPri_flow) annotation (Line(points={{-78,-40},
          {-34,-40},{-34,54},{4,54}},color={0,0,127}));
  connect(VChiWat_flow.y, ctl.VChiWatPri_flow) annotation (Line(points={{-52,-60},
          {-30,-60},{-30,46},{4,46}},  color={0,0,127}));
  connect(THeaWatSup.y, ctl.THeaWatSecSup) annotation (Line(points={{-148,220},
          {-22,220},{-22,44},{4,44}},
                                 color={0,0,127}));
  connect(VHeaWat_flow.y, ctl.VHeaWatSec_flow) annotation (Line(points={{-78,-40},
          {-26,-40},{-26,40},{4,40}},color={0,0,127}));
  connect(VChiWat_flow.y, ctl.VChiWatSec_flow) annotation (Line(points={{-52,-60},
          {-30,-60},{-30,34},{4,34}},  color={0,0,127}));
  connect(resDpHeaWatLoc.dpLocSet, ctl.dpHeaWatLocSet) annotation (Line(points={{-12.2,
          -154},{-4,-154},{-4,30},{4,30}},           color={0,0,127}));
  connect(dpHeaWatLoc.y, ctl.dpHeaWatLoc) annotation (Line(points={{-52,-180},{
          -2,-180},{-2,28},{4,28}},
                                color={0,0,127}));
  connect(resDpChiWatLoc.dpLocSet, ctl.dpChiWatLocSet) annotation (Line(points={{-12.2,
          -200},{0,-200},{0,24},{4,24}},         color={0,0,127}));
  connect(dpChiWatLoc.y, ctl.dpChiWatLoc) annotation (Line(points={{-52,-220},{
          2,-220},{2,22},{4,22}},
                                color={0,0,127}));
  connect(ctl.dpHeaWatRemSet, dpHeaWatRem.u1) annotation (Line(points={{48,36},
          {58,36},{58,-20},{-34,-20},{-34,-84},{-86,-84},{-86,-94},{-76,-94}},
                                                          color={0,0,127}));
  connect(ctl.dpChiWatRemSet, dpChiWatRem.u1) annotation (Line(points={{48,34},
          {58,34},{58,-16},{-38,-16},{-38,-80},{-92,-80},{-92,-134},{-76,-134}},
                                                          color={0,0,127}));
  connect(ctl.dpHeaWatRemSet, resDpHeaWatLoc.dpRemSet) annotation (Line(points={{48,36},
          {58,36},{58,-12},{-42,-12},{-42,-148},{-36,-148}},         color={0,0,
          127}));
  connect(ctl.dpChiWatRemSet, resDpChiWatLoc.dpRemSet) annotation (Line(points={{48,34},
          {54,34},{54,-10},{-44,-10},{-44,-194},{-36,-194}},         color={0,0,
          127}));
  connect(ctl.u1PumChiWatSec_actual, y1PumChiWatSec_actual.y1_actual)
    annotation (Line(points={{4,70},{-6,70},{-6,128},{146,128},{146,20},{92,20}},
        color={255,0,255}));
  connect(ctl.u1Hp_actual, y1Hp_actual.y1_actual) annotation (Line(points={{4,78},{
          2,78},{2,120},{106,120},{106,100},{92,100}},  color={255,0,255}));
  connect(ctl.u1PumHeaWatPri_actual, y1PumHeaWatPri_actual1.y1_actual)
    annotation (Line(points={{4,76},{0,76},{0,122},{134,122},{134,80},{122,80}},
        color={255,0,255}));
  connect(ctl.u1PumChiWatPri_actual, y1PumChiWatPri_actual.y1_actual)
    annotation (Line(points={{4,74},{-2,74},{-2,124},{138,124},{138,60},{92,60}},
        color={255,0,255}));
  connect(ctl.u1PumHeaWatSec_actual, y1PumHeaWatSec_actual.y1_actual)
    annotation (Line(points={{4,72},{-4,72},{-4,126},{142,126},{142,40},{122,40}},
                color={255,0,255}));
  connect(conCooTanCha.y, ctl.uCooTanCha)
    annotation (Line(points={{-38,200},{-12,200},{-12,84},{4,84}},
                                                          color={255,0,255}));
  connect(booPul.y, ctl.uPlaEna) annotation (Line(points={{-38,160},{-14,160},{
          -14,80},{4,80}},
                        color={255,0,255}));
  connect(conIntOpeMod.y,intEquOpeMod. u2) annotation (Line(points={{32,230},{
          40,230},{40,182},{48,182}},
                                    color={255,127,0}));
  connect(intScaRep.y,intEquOpeMod. u1)
    annotation (Line(points={{32,190},{48,190}},
                                               color={255,127,0}));
  connect(intEquOpeMod.y,truDelProCha. u)
    annotation (Line(points={{72,190},{90,190}},
                                               color={255,0,255}));
  connect(truDelProCha.y,mulOrProCha. u[1:8]) annotation (Line(points={{114,190},
          {118,190},{118,193.062}},            color={255,0,255}));
  connect(mulOrProCha.y,edgProCha. u)
    annotation (Line(points={{142,190},{148,190}},
                                                 color={255,0,255}));
  connect(intEquOpeMod.y,preOpeMod. u) annotation (Line(points={{72,190},{80,
          190},{80,150},{88,150}},          color={255,0,255}));
  connect(ctl.yOpeMod, intScaRep.u) annotation (Line(points={{48,54},{54,54},{
          54,132},{4,132},{4,190},{8,190}},
                                       color={255,127,0}));
  connect(edgProCha.y, preProCha.u)
    annotation (Line(points={{172,190},{178,190}}, color={255,0,255}));
  connect(preProCha.y, ctl.uProCom) annotation (Line(points={{202,190},{210,190},
          {210,130},{-8,130},{-8,82},{4,82}},    color={255,0,255}));
  connect(preOpeMod[3].y,truDelTChiWatRet. u) annotation (Line(points={{112,150},
          {166,150},{166,-20},{152,-20}},
                                       color={255,0,255}));
  connect(notTChiWatRet.u,timTChiWatRet. passed)
    annotation (Line(points={{112,-80},{128,-80}},      color={255,0,255}));
  connect(latTChiWatRet.y,pre2. u) annotation (Line(points={{28,-40},{20,-40},{
          20,-80},{28,-80}},  color={255,0,255}));
  connect(latTChiWatRet.clr,timTChiWatRet. passed) annotation (Line(points={{52,-46},
          {58,-46},{58,-60},{116,-60},{116,-80},{128,-80}},   color={255,0,255}));
  connect(pre2.y,timTChiWatRet. u) annotation (Line(points={{52,-80},{66,-80},{
          66,-100},{156,-100},{156,-72},{152,-72}},
                         color={255,0,255}));
  connect(onCouInt.y,intGreEquThr. u)
    annotation (Line(points={{82,-120},{88,-120}}, color={255,127,0}));
  connect(falEdg.y,onCouInt. trigger)
    annotation (Line(points={{52,-120},{58,-120}}, color={255,0,255}));
  connect(truDelTChiWatRet.y,mulAndTChiWatRet. u[1]) annotation (Line(points={{128,-20},
          {106,-20},{106,-38},{92,-38},{92,-42.3333}},
                                                     color={255,0,255}));
  connect(notTChiWatRet.y,mulAndTChiWatRet. u[2]) annotation (Line(points={{88,-80},
          {78,-80},{78,-54},{106,-54},{106,-42},{92,-42},{92,-40}},
                                                        color={255,0,255}));
  connect(pre2.y,falEdg. u) annotation (Line(points={{52,-80},{66,-80},{66,-100},
          {20,-100},{20,-120},{28,-120}},          color={255,0,255}));
  connect(intGreEquThr.y,not2. u)
    annotation (Line(points={{112,-120},{128,-120}},
                                                   color={255,0,255}));
  connect(not2.y,mulAndTChiWatRet. u[3]) annotation (Line(points={{152,-120},{
          160,-120},{160,-40},{92,-40},{92,-37.6667}},
                                                color={255,0,255}));
  connect(preOpeMod[5].y,truDelTChiWatSup. u) annotation (Line(points={{112,150},
          {166,150},{166,-160},{152,-160}},color={255,0,255}));
  connect(notTHotWatRet.y,andTHotWatRet. u2) annotation (Line(points={{88,-208},
          {82,-208}},                        color={255,0,255}));
  connect(truDelTChiWatSup.y,latTChiWatSup. u)
    annotation (Line(points={{128,-160},{112,-160}},
                                                   color={255,0,255}));
  connect(mulAndTChiWatRet.y, latTChiWatRet.u)
    annotation (Line(points={{68,-40},{52,-40}}, color={255,0,255}));
  connect(latTChiWatSup.y, preTChiWatSup.u)
    annotation (Line(points={{88,-160},{82,-160}}, color={255,0,255}));
  connect(preTChiWatSup.y, truDelTHotWatRet.u)
    annotation (Line(points={{58,-160},{52,-160}}, color={255,0,255}));
  connect(preTHotWatRet.y, timTHotWatRet.u)
    annotation (Line(points={{152,-210},{158,-210}}, color={255,0,255}));
  connect(timTHotWatRet.passed, notTHotWatRet.u) annotation (Line(points={{182,
          -218},{186,-218},{186,-230},{116,-230},{116,-208},{112,-208}},
                                                                   color={255,0,
          255}));
  connect(truDelTHotWatRet.y, preTHotWatRet.u) annotation (Line(points={{28,-160},
          {20,-160},{20,-182},{120,-182},{120,-210},{128,-210}}, color={255,0,255}));
  connect(truDelTHotWatRet.y, andTHotWatRet.u1) annotation (Line(points={{28,-160},
          {20,-160},{20,-182},{86,-182},{86,-200},{82,-200}}, color={255,0,255}));
  connect(conCooTanCha.y, ctl.uHotTanCha) annotation (Line(points={{-38,200},{
          -12,200},{-12,84},{-2,84},{-2,86},{4,86}},
                                                  color={255,0,255}));
  connect(conCooTanCha.y, latTChiWatSup.clr) annotation (Line(points={{-38,200},
          {-12,200},{-12,-50},{12,-50},{12,-178},{116,-178},{116,-166},{112,
          -166}},
        color={255,0,255}));
  connect(timTHotWatRet.passed,timTChiWatSupSet. u) annotation (Line(points={{182,
          -218},{186,-218},{186,-240},{52,-240}},     color={255,0,255}));
  connect(andTHotWatRet.y, latTHotWatRet.u)
    annotation (Line(points={{58,-200},{52,-200}}, color={255,0,255}));
  connect(timTHotWatRet.passed, latTHotWatRet.clr) annotation (Line(points={{182,
          -218},{186,-218},{186,-230},{56,-230},{56,-206},{52,-206}}, color={255,
          0,255}));
  connect(conCooTanCha.y, onCouInt.reset) annotation (Line(points={{-38,200},{
          -12,200},{-12,-140},{70,-140},{70,-132}},             color={255,0,255}));
  connect(THeaWatRet1.y,swiTHotWatRet. u1) annotation (Line(points={{-178,190},
          {-152,190}},                       color={0,0,127}));
  connect(THeaWatRet2.y,swiTHotWatRet. u3) annotation (Line(points={{-178,150},
          {-170,150},{-170,174},{-152,174}},
                                  color={0,0,127}));
  connect(latTHotWatRet.y,swiTHotWatRet. u2) annotation (Line(points={{28,-200},
          {12,-200},{12,-240},{-158,-240},{-158,182},{-152,182}},
                                              color={255,0,255}));
  connect(swiTHotWatRet.y, ctl.THeaWatPriRet) annotation (Line(points={{-128,
          182},{-80,182},{-80,56},{4,56}},
                                       color={0,0,127}));
  connect(swiTHotWatRet.y, ctl.THeaWatSecRet) annotation (Line(points={{-128,
          182},{-80,182},{-80,42},{4,42}},
                                       color={0,0,127}));
  connect(TChiWatSupSet1.y, swiTChiWatSupSet.u1) annotation (Line(points={{-178,
          110},{-172,110},{-172,128},{-152,128}}, color={0,0,127}));
  connect(TChiWatSupSet2.y, swiTChiWatSupSet.u3) annotation (Line(points={{-178,70},
          {-168,70},{-168,112},{-152,112}},       color={0,0,127}));
  connect(timTChiWatSupSet.passed, swiTChiWatSupSet.u2) annotation (Line(points={{28,-248},
          {-160,-248},{-160,120},{-152,120}},           color={255,0,255}));
  connect(swiTChiWatSupSet.y, ctl.TChiWatPriSupSet) annotation (Line(points={{
          -128,120},{-118,120},{-118,52},{4,52}}, color={0,0,127}));
  connect(swiTChiWatSup.y, ctl.TChiWatPriSup) annotation (Line(points={{-128,62},
          {-122,62},{-122,50},{4,50}}, color={0,0,127}));
  connect(swiTChiWatSup.y, ctl.TChiWatSecSup) annotation (Line(points={{-128,62},
          {-122,62},{-122,38},{4,38}}, color={0,0,127}));
  connect(TChiWatSup1.y, swiTChiWatSup.u1) annotation (Line(points={{-178,30},{
          -166,30},{-166,70},{-152,70}}, color={0,0,127}));
  connect(TChiWatSup2.y, swiTChiWatSup.u3) annotation (Line(points={{-178,-10},
          {-164,-10},{-164,54},{-152,54}}, color={0,0,127}));
  connect(latTChiWatSup.y, swiTChiWatSup.u2) annotation (Line(points={{88,-160},
          {84,-160},{84,-144},{-8,-144},{-8,32},{-156,32},{-156,62},{-152,62}},
        color={255,0,255}));
  connect(TChiWatRet1.y, swiTChiWatRet.u1) annotation (Line(points={{-178,-50},
          {-164,-50},{-164,-12},{-152,-12}}, color={0,0,127}));
  connect(TChiWatRet2.y, swiTChiWatRet.u3) annotation (Line(points={{-178,-90},
          {-162,-90},{-162,-28},{-152,-28}}, color={0,0,127}));
  connect(latTChiWatRet.y, swiTChiWatRet.u2) annotation (Line(points={{28,-40},
          {-16,-40},{-16,28},{-156,28},{-156,-20},{-152,-20}}, color={255,0,255}));
  connect(swiTChiWatRet.y, ctl.TChiWatPriRet) annotation (Line(points={{-128,
          -20},{-40,-20},{-40,48},{4,48}}, color={0,0,127}));
  connect(swiTChiWatRet.y, ctl.TChiWatSecRet) annotation (Line(points={{-128,
          -20},{-40,-20},{-40,36},{4,36}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/HeatPumps_PNNL/Validation/WaterToWater.mos"
        "Simulate and plot"),
    experiment(
      StopTime=86400.0,
      Tolerance=1e-06),
    Icon(
      graphics={
        Ellipse(
          lineColor={75,138,73},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid,
          extent={{-100,-100},{100,100}}),
        Polygon(
          lineColor={0,0,255},
          fillColor={75,138,73},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-36,60},{64,0},{-36,-60},{-36,60}})}),
    Diagram(
      coordinateSystem(
        extent={{-220,-260},{220,260}})),
    Documentation(revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model validates
<a href=\"modelica://Buildings.Templates.Plants.HeatPumps_PNNL.WaterToWater\">
Buildings.Templates.Plants.HeatPumps_PNNL.WaterToWater</a>
in a configuration with three equally sized lead/lag alternate
heat pumps.
</p>
<p>
Simulating this model shows how the controller responds to a varying load by 
</p>
<ul>
<li>
staging or unstaging the AWHPs and associated primary pumps,
</li>
<li>
rotating lead/lag alternate equipment to ensure even wear,
</li>
<li>
resetting the supply temperature and remote differential pressure 
in both the CHW and HW loops based on the valve position,
</li>
<li>
staging the secondary pumps.
</li>
</ul>
</html>"));
end WaterToWater;
