within Buildings.Templates.Plants.Controls.HeatPumps.Validation;
model WaterToWater_enhanced
  final parameter Real capHea_nominal(
    final unit="W")=sum(ctl.capHeaHp_nominal)
    "Installed heating capacity"
    annotation (Dialog(group="Nominal condition"));
  parameter Real THeaWatSup_nominal(
    unit="K",
    displayUnit="degC")=333.15
    "Design HW supply temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real THeaWatRet_nominal(
    unit="K",
    displayUnit="degC")=325.15
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
    displayUnit="degC")=285.15
    "Design CHW supply temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real TChiWatRet_nominal(
    unit="K",
    displayUnit="degC")=287.15
    "Design CHW return temperature"
    annotation (Dialog(group="Nominal condition"));
  parameter Real VChiWat_flow_nominal(unit="m3/s")=capHea_nominal/abs(
    TChiWatSup_nominal - TChiWatRet_nominal)/ctl.cp_default/ctl.rho_default
    "Design CHW volume flow rate"
    annotation (Dialog(group="Nominal condition"));
  Buildings.Templates.Plants.Controls.HeatPumps.WaterToWater_enhanced   ctl(
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
    have_inpSch=false,
    staEqu=[1/3,1/3,1/3; 2/3,2/3,2/3; 1,1,1],
    idxEquAlt={1,2,3}) "Plant controller"
    annotation (Placement(transformation(extent={{6,10},{46,78}})));
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
    annotation (Placement(transformation(extent={{-150,-160},{-130,-140}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VHeaWat_flow(
    final k=VHeaWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter VChiWat_flow(
    final k=VChiWat_flow_nominal)
    "Scale by design flow"
    annotation (Placement(transformation(extent={{-74,-80},{-54,-60}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1Hp_actual[ctl.nHp]
    "HP status" annotation (Placement(transformation(extent={{70,80},{90,100}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumHeaWatPri_actual1[ctl.nPumHeaWatPri]
    if ctl.have_heaWat and ctl.have_pumHeaWatPri "Primary HW pump status"
    annotation (Placement(transformation(extent={{100,60},{120,80}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumChiWatPri_actual[ctl.nPumChiWatPri]
    if ctl.have_chiWat and ctl.have_pumChiWatPri "Primary CHW pump status"
    annotation (Placement(transformation(extent={{70,40},{90,60}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumHeaWatSec_actual[ctl.nPumHeaWatSec]
    if ctl.have_heaWat and ctl.have_pumHeaWatSec "Secondary HW pump status"
    annotation (Placement(transformation(extent={{100,20},{120,40}})));
  Buildings.Templates.Components.Controls.StatusEmulator y1PumChiWatSec_actual[ctl.nPumChiWatSec]
    if ctl.have_chiWat and ctl.have_pumChiWatSec "Secondary CHW pump status"
    annotation (Placement(transformation(extent={{70,0},{90,20}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter gai[2](
    each k=5)
    "Use fraction of flow rate as a proxy for plant reset request"
    annotation (Placement(transformation(extent={{-106,80},{-86,100}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reqResHeaWat
    "Generate HW reset request"
    annotation (Placement(transformation(extent={{-60,100},{-40,120}})));
  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reqResChiWat
    "Generate CHW reset request"
    annotation (Placement(transformation(extent={{-60,60},{-40,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin[1](
    amplitude=0.1 * ctl.dpHeaWatRemSet_max,
    freqHz={4 / 8000},
    each phase=3.1415926535898)
    if ctl.have_heaWat
    "Source signal used to generate measurement values"
    annotation (Placement(transformation(extent={{-150,-200},{-130,-180}})));
  Buildings.Controls.OBC.CDL.Reals.Add dpHeaWatRem[1]
    if ctl.have_heaWat
    "Differential pressure at remote location"
    annotation (Placement(transformation(extent={{-74,-120},{-54,-100}})));
  Buildings.Controls.OBC.CDL.Reals.Add dpChiWatRem[1]
    if ctl.have_chiWat
    "Differential pressure at remote location"
    annotation (Placement(transformation(extent={{-74,-160},{-54,-140}})));
  Controls.Pumps.Generic.ResetLocalDifferentialPressure resDpHeaWatLoc[1](each
      dpLocSet_max=20E4) if ctl.have_heaWat "Local HW DP reset"
    annotation (Placement(transformation(extent={{-34,-174},{-14,-154}})));
  Controls.Pumps.Generic.ResetLocalDifferentialPressure resDpChiWatLoc[1](each
      dpLocSet_max=15E4) if ctl.have_chiWat "Local CHW DP reset"
    annotation (Placement(transformation(extent={{-34,-220},{-14,-200}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin sin1[1](
    amplitude=0.1 * ctl.dpChiWatRemSet_max,
    freqHz={3 / 8000},
    each phase=3.1415926535898)
    "Source signal used to generate measurement values"
    annotation (Placement(transformation(extent={{-150,-240},{-130,-220}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter dpHeaWatLoc(final k=4)
    if ctl.have_heaWat
    "Differential pressure local to the plant"
    annotation (Placement(transformation(extent={{-74,-200},{-54,-180}})));
  Buildings.Controls.OBC.CDL.Reals.MultiplyByParameter dpChiWatLoc(final k=3)
    if ctl.have_chiWat
    "Differential pressure local to the plant"
    annotation (Placement(transformation(extent={{-74,-240},{-54,-220}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatSup(final k=273.15 +
        60)                 "HWST"
    annotation (Placement(transformation(extent={{-200,180},{-180,200}})));
  Buildings.Controls.OBC.CDL.Logical.Sources.Constant conCooTanCha(k=false)
    "Cold thermal energy storage dedicated charging mode enable signal"
    annotation (Placement(transformation(extent={{-60,140},{-40,160}})));
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
    annotation (Placement(transformation(extent={{10,210},{30,230}})));
  Buildings.Controls.OBC.CDL.Integers.Equal intEquOpeMod[8]
    "Identify current operation mode in array of possible operation modes"
    annotation (Placement(transformation(extent={{50,170},{70,190}})));
  Buildings.Controls.OBC.CDL.Routing.IntegerScalarReplicator intScaRep(nout=8)
    "Integer replicator"
    annotation (Placement(transformation(extent={{10,170},{30,190}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelProCha[8](delayTime=fill(30,
        8))
    "Delay for representing operation mode change process duration"
    annotation (Placement(transformation(extent={{92,170},{112,190}})));
  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOrProCha(nin=8)
    "Identify any operation mode change completions"
    annotation (Placement(transformation(extent={{120,170},{140,190}})));
  Buildings.Controls.OBC.CDL.Logical.Edge edgProCha
    "Edge block to change process change completion signal into pulse"
    annotation (Placement(transformation(extent={{150,170},{170,190}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preOpeMod[8]
    "Pre block for routing back operation mode status signals"
    annotation (Placement(transformation(extent={{90,130},{110,150}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preProCha
    "Pre block for routing back process change completion signal"
    annotation (Placement(transformation(extent={{180,170},{200,190}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelTChiWatRet(delayTime=14000)
    "Delay chilled water return temperature signal"
    annotation (Placement(transformation(extent={{150,-40},{130,-20}})));
  Buildings.Controls.OBC.CDL.Logical.Timer timTChiWatRet(t=18000)
    "Timer for disabling chilled water return temperature latch"
    annotation (Placement(transformation(extent={{150,-92},{130,-72}})));
  Buildings.Controls.OBC.CDL.Logical.Not notTChiWatRet
    "Not operator for disabling latch required instant"
    annotation (Placement(transformation(extent={{110,-100},{90,-80}})));
  Buildings.Controls.OBC.CDL.Logical.MultiAnd mulAndTChiWatRet(nin=3)
    "Enable latch for chilled water return temperature"
    annotation (Placement(transformation(extent={{90,-60},{70,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Latch latTChiWatRet
    "Latch for holding signal to chilled water return temperature switch"
    annotation (Placement(transformation(extent={{50,-60},{30,-40}})));
  Buildings.Controls.OBC.CDL.Logical.Pre pre2
    "Pre block for routing signal to change chilled water return temperature latch"
    annotation (Placement(transformation(extent={{30,-100},{50,-80}})));
  Buildings.Controls.OBC.CDL.Integers.OnCounter onCouInt
    "Count falling edge signal based on the reset signal"
    annotation (Placement(transformation(extent={{60,-140},{80,-120}})));
  Buildings.Controls.OBC.CDL.Integers.GreaterEqualThreshold intGreEquThr(t=1)
    "Pass signal greater than a threshold"
    annotation (Placement(transformation(extent={{90,-140},{110,-120}})));
  Buildings.Controls.OBC.CDL.Logical.FallingEdge falEdg
    "Falling Edge block to change chilled water return temperature signal into pulse"
    annotation (Placement(transformation(extent={{30,-140},{50,-120}})));
  Buildings.Controls.OBC.CDL.Logical.Not not2
    "Not operator for disabling the passing signal"
    annotation (Placement(transformation(extent={{130,-140},{150,-120}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelTChiWatSup(delayTime=7000)
    "Delay signal to chilled water supply temperature"
    annotation (Placement(transformation(extent={{150,-180},{130,-160}})));
  Buildings.Controls.OBC.CDL.Logical.TrueDelay truDelTHotWatRet(delayTime=7000)
    "Delay enable of hot water return temperature latch"
    annotation (Placement(transformation(extent={{50,-180},{30,-160}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preTChiWatSup
    "Pre block for routing back chilled water supply temperature switch signal"
    annotation (Placement(transformation(extent={{80,-180},{60,-160}})));
  Buildings.Controls.OBC.CDL.Logical.Timer timTHotWatRet(t=7000)
    "Timer to disable hot water return temperature latch"
    annotation (Placement(transformation(extent={{160,-230},{180,-210}})));
  Buildings.Controls.OBC.CDL.Logical.Pre preTHotWatRet
    "Pre block for routing signal to change hot water return temperature latch"
    annotation (Placement(transformation(extent={{130,-230},{150,-210}})));
  Buildings.Controls.OBC.CDL.Logical.And andTHotWatRet
    "Enable latch only for fixed duration and then disable it"
    annotation (Placement(transformation(extent={{80,-220},{60,-200}})));
  Buildings.Controls.OBC.CDL.Logical.Not notTHotWatRet
    "Not operation for disabling latch"
    annotation (Placement(transformation(extent={{110,-228},{90,-208}})));
  Buildings.Controls.OBC.CDL.Logical.Latch latTChiWatSup
    "Latch for holding signal to chilled water supply temperature signal"
    annotation (Placement(transformation(extent={{110,-180},{90,-160}})));
  Buildings.Controls.OBC.CDL.Logical.Latch latTHotWatRet
    "Latch to hold switch for hot water return temperature"
    annotation (Placement(transformation(extent={{50,-220},{30,-200}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatRet2(k=273.15 + 50)
    "Measured hot water return temperature (Low)"
    annotation (Placement(transformation(extent={{-200,100},{-180,120}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant THeaWatRet1(k=273.15 + 54)
    "Measured hot water return temperature (High)"
    annotation (Placement(transformation(extent={{-200,140},{-180,160}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTHotWatRet
    "Switch between two different hot water return temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-150,162},{-130,182}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSup1(k=273.15 + 14)
    "Measured chilled water supply temperature (High)"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatSup2(k=273.15 + 9)
    "Measured chilled water supply temperature (Low)"
    annotation (Placement(transformation(extent={{-200,20},{-180,40}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTChiWatSup
    "Switch between two different chilled water supply temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-150,60},{-130,80}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatRet1(k=273.15 + 12)
    "Measured chilled water return temperature (High)"
    annotation (Placement(transformation(extent={{-200,-20},{-180,0}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Constant TChiWatRet2(k=273.15 + 16)
    "Measured chilled water return temperature (Low)"
    annotation (Placement(transformation(extent={{-200,-60},{-180,-40}})));
  Buildings.Controls.OBC.CDL.Reals.Switch swiTChiWatRet
    "Switch between two different chilled water return temperatures to induce mode transition"
    annotation (Placement(transformation(extent={{-150,-28},{-130,-8}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold isDemHea(t=1E-2, h=0.5E-2)
    "Return true if heating demand"
    annotation (Placement(transformation(extent={{-100,220},{-80,240}})));
  Buildings.Controls.OBC.CDL.Reals.GreaterThreshold isDemCoo(t=1E-2, h=0.5E-2)
    "Return true if cooling demand"
    annotation (Placement(transformation(extent={{-100,180},{-80,200}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger reqPlaHeaWat
    "Generate HW plant request"
    annotation (Placement(transformation(extent={{-60,220},{-40,240}})));
  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger reqPlaChiWat
    "Generate CHW plant request"
    annotation (Placement(transformation(extent={{-60,180},{-40,200}})));
  Buildings.Controls.OBC.CDL.Reals.Sources.Sin TOut(
    amplitude=10,
    freqHz=0.5/24/3600,
    phase=-0.43633231299858,
    offset=10 + 273.15)
    "OAT"
    annotation (Placement(transformation(extent={{-200,220},{-180,240}})));
equation
  connect(ratV_flow.y[1], VHeaWat_flow.u)
    annotation (Line(points={{-128,-150},{-114,-150},{-114,-50},{-102,-50}},
                                                                      color={0,0,127}));
  connect(ratV_flow.y[2], VChiWat_flow.u)
    annotation (Line(points={{-128,-150},{-104,-150},{-104,-70},{-76,-70}},
                                                   color={0,0,127}));
  connect(ctl.y1Hp, y1Hp_actual.y1)
    annotation (Line(points={{48,72},{60,72},{60,90},{68,90}},color={255,0,255}));
  connect(ctl.y1PumHeaWatPri, y1PumHeaWatPri_actual1.y1)
    annotation (Line(points={{48,56},{66,56},{66,70},{98,70}},color={255,0,255}));
  connect(ctl.y1PumChiWatPri, y1PumChiWatPri_actual.y1)
    annotation (Line(points={{48,54},{62,54},{62,50},{68,50}},color={255,0,255}));
  connect(ctl.y1PumHeaWatSec, y1PumHeaWatSec_actual.y1)
    annotation (Line(points={{48,50},{66,50},{66,30},{98,30}},color={255,0,255}));
  connect(ctl.y1PumChiWatSec, y1PumChiWatSec_actual.y1)
    annotation (Line(points={{48,48},{64,48},{64,10},{68,10}},
                                                            color={255,0,255}));
  connect(ratV_flow.y, gai.u)
    annotation (Line(points={{-128,-150},{-114,-150},{-114,90},{-108,90}},
                                                                        color={0,0,127}));
  connect(gai[1].y, reqResHeaWat.u)
    annotation (Line(points={{-84,90},{-70,90},{-70,110},{-62,110}},
                                                color={0,0,127}));
  connect(gai[2].y, reqResChiWat.u)
    annotation (Line(points={{-84,90},{-70,90},{-70,70},{-62,70}},color={0,0,127}));
  connect(reqResHeaWat.y,ctl.nReqResHeaWat)
    annotation (Line(points={{-38,110},{-26,110},{-26,54},{4,54}},
                                                                 color={255,127,0}));
  connect(reqResChiWat.y,ctl.nReqResChiWat)
    annotation (Line(points={{-38,70},{-30,70},{-30,52},{4,52}}, color={255,127,0}));
  connect(sin.y, dpHeaWatRem.u2)
    annotation (Line(points={{-128,-190},{-100,-190},{-100,-116},{-76,-116}},
                                                   color={0,0,127}));
  connect(sin1.y, dpChiWatRem.u2)
    annotation (Line(points={{-128,-230},{-92,-230},{-92,-156},{-76,-156}},
                                                     color={0,0,127}));
  connect(dpHeaWatRem[1].y, dpHeaWatLoc.u)
    annotation (Line(points={{-52,-110},{-46,-110},{-46,-170},{-86,-170},{-86,-190},
          {-76,-190}},
      color={0,0,127}));
  connect(dpChiWatRem[1].y, dpChiWatLoc.u)
    annotation (Line(points={{-52,-150},{-48,-150},{-48,-210},{-86,-210},{-86,-230},
          {-76,-230}},
      color={0,0,127}));
  connect(dpHeaWatRem.y, resDpHeaWatLoc.dpRem)
    annotation (Line(points={{-52,-110},{-46,-110},{-46,-170},{-36,-170}},
                                                                        color={0,0,127}));
  connect(dpChiWatRem.y, resDpChiWatLoc.dpRem)
    annotation (Line(points={{-52,-150},{-48,-150},{-48,-216},{-36,-216}},color={0,0,127}));
  connect(VHeaWat_flow.y, ctl.VHeaWatPri_flow) annotation (Line(points={{-78,-50},
          {-34,-50},{-34,44},{4,44}},color={0,0,127}));
  connect(VChiWat_flow.y, ctl.VChiWatPri_flow) annotation (Line(points={{-52,-70},
          {-30,-70},{-30,36},{4,36}},  color={0,0,127}));
  connect(THeaWatSup.y, ctl.THeaWatSecSup) annotation (Line(points={{-178,190},{
          -118,190},{-118,34},{4,34}},
                                 color={0,0,127}));
  connect(VHeaWat_flow.y, ctl.VHeaWatSec_flow) annotation (Line(points={{-78,-50},
          {-26,-50},{-26,30},{4,30}},color={0,0,127}));
  connect(VChiWat_flow.y, ctl.VChiWatSec_flow) annotation (Line(points={{-52,-70},
          {-30,-70},{-30,24},{4,24}},  color={0,0,127}));
  connect(resDpHeaWatLoc.dpLocSet, ctl.dpHeaWatLocSet) annotation (Line(points={{-12.2,
          -164},{-4,-164},{-4,20},{4,20}},           color={0,0,127}));
  connect(dpHeaWatLoc.y, ctl.dpHeaWatLoc) annotation (Line(points={{-52,-190},{-2,
          -190},{-2,18},{4,18}},color={0,0,127}));
  connect(resDpChiWatLoc.dpLocSet, ctl.dpChiWatLocSet) annotation (Line(points={{-12.2,
          -210},{0,-210},{0,14},{4,14}},         color={0,0,127}));
  connect(dpChiWatLoc.y, ctl.dpChiWatLoc) annotation (Line(points={{-52,-230},{2,
          -230},{2,12},{4,12}}, color={0,0,127}));
  connect(ctl.dpHeaWatRemSet, dpHeaWatRem.u1) annotation (Line(points={{48,26},{
          58,26},{58,-30},{-34,-30},{-34,-94},{-86,-94},{-86,-104},{-76,-104}},
                                                          color={0,0,127}));
  connect(ctl.dpChiWatRemSet, dpChiWatRem.u1) annotation (Line(points={{48,24},{
          58,24},{58,-26},{-38,-26},{-38,-90},{-92,-90},{-92,-144},{-76,-144}},
                                                          color={0,0,127}));
  connect(ctl.dpHeaWatRemSet, resDpHeaWatLoc.dpRemSet) annotation (Line(points={{48,26},
          {58,26},{58,-22},{-42,-22},{-42,-158},{-36,-158}},         color={0,0,
          127}));
  connect(ctl.dpChiWatRemSet, resDpChiWatLoc.dpRemSet) annotation (Line(points={{48,24},
          {54,24},{54,-20},{-44,-20},{-44,-204},{-36,-204}},         color={0,0,
          127}));
  connect(ctl.u1PumChiWatSec_actual, y1PumChiWatSec_actual.y1_actual)
    annotation (Line(points={{4,60},{-6,60},{-6,118},{146,118},{146,10},{92,10}},
        color={255,0,255}));
  connect(ctl.u1Hp_actual, y1Hp_actual.y1_actual) annotation (Line(points={{4,68},{
          2,68},{2,110},{106,110},{106,90},{92,90}},    color={255,0,255}));
  connect(ctl.u1PumHeaWatPri_actual, y1PumHeaWatPri_actual1.y1_actual)
    annotation (Line(points={{4,66},{0,66},{0,112},{134,112},{134,70},{122,70}},
        color={255,0,255}));
  connect(ctl.u1PumChiWatPri_actual, y1PumChiWatPri_actual.y1_actual)
    annotation (Line(points={{4,64},{-2,64},{-2,114},{138,114},{138,50},{92,50}},
        color={255,0,255}));
  connect(ctl.u1PumHeaWatSec_actual, y1PumHeaWatSec_actual.y1_actual)
    annotation (Line(points={{4,62},{-4,62},{-4,116},{142,116},{142,30},{122,30}},
                color={255,0,255}));
  connect(conCooTanCha.y, ctl.uCooTanCha)
    annotation (Line(points={{-38,150},{-12,150},{-12,74},{4,74}},
                                                          color={255,0,255}));
  connect(conIntOpeMod.y,intEquOpeMod. u2) annotation (Line(points={{32,220},{40,
          220},{40,172},{48,172}},  color={255,127,0}));
  connect(intScaRep.y,intEquOpeMod. u1)
    annotation (Line(points={{32,180},{48,180}},
                                               color={255,127,0}));
  connect(intEquOpeMod.y,truDelProCha. u)
    annotation (Line(points={{72,180},{90,180}},
                                               color={255,0,255}));
  connect(truDelProCha.y,mulOrProCha. u[1:8]) annotation (Line(points={{114,180},
          {118,180},{118,183.062}},            color={255,0,255}));
  connect(mulOrProCha.y,edgProCha. u)
    annotation (Line(points={{142,180},{148,180}},
                                                 color={255,0,255}));
  connect(intEquOpeMod.y,preOpeMod. u) annotation (Line(points={{72,180},{80,180},
          {80,140},{88,140}},               color={255,0,255}));
  connect(ctl.yOpeMod, intScaRep.u) annotation (Line(points={{48,44},{54,44},{54,
          122},{0,122},{0,180},{8,180}},
                                       color={255,127,0}));
  connect(edgProCha.y, preProCha.u)
    annotation (Line(points={{172,180},{178,180}}, color={255,0,255}));
  connect(preProCha.y, ctl.uProCom) annotation (Line(points={{202,180},{210,180},
          {210,120},{-8,120},{-8,72},{4,72}},    color={255,0,255}));
  connect(preOpeMod[3].y,truDelTChiWatRet. u) annotation (Line(points={{112,140},
          {166,140},{166,-30},{152,-30}},
                                       color={255,0,255}));
  connect(notTChiWatRet.u,timTChiWatRet. passed)
    annotation (Line(points={{112,-90},{128,-90}},      color={255,0,255}));
  connect(latTChiWatRet.y,pre2. u) annotation (Line(points={{28,-50},{20,-50},{20,
          -90},{28,-90}},     color={255,0,255}));
  connect(latTChiWatRet.clr,timTChiWatRet. passed) annotation (Line(points={{52,-56},
          {58,-56},{58,-70},{116,-70},{116,-90},{128,-90}},   color={255,0,255}));
  connect(pre2.y,timTChiWatRet. u) annotation (Line(points={{52,-90},{66,-90},{66,
          -110},{156,-110},{156,-82},{152,-82}},
                         color={255,0,255}));
  connect(onCouInt.y,intGreEquThr. u)
    annotation (Line(points={{82,-130},{88,-130}}, color={255,127,0}));
  connect(falEdg.y,onCouInt. trigger)
    annotation (Line(points={{52,-130},{58,-130}}, color={255,0,255}));
  connect(truDelTChiWatRet.y,mulAndTChiWatRet. u[1]) annotation (Line(points={{128,-30},
          {106,-30},{106,-48},{92,-48},{92,-52.3333}},
                                                     color={255,0,255}));
  connect(notTChiWatRet.y,mulAndTChiWatRet. u[2]) annotation (Line(points={{88,-90},
          {78,-90},{78,-64},{106,-64},{106,-52},{92,-52},{92,-50}},
                                                        color={255,0,255}));
  connect(pre2.y,falEdg. u) annotation (Line(points={{52,-90},{66,-90},{66,-110},
          {20,-110},{20,-130},{28,-130}},          color={255,0,255}));
  connect(intGreEquThr.y,not2. u)
    annotation (Line(points={{112,-130},{128,-130}},
                                                   color={255,0,255}));
  connect(not2.y,mulAndTChiWatRet. u[3]) annotation (Line(points={{152,-130},{
          160,-130},{160,-50},{92,-50},{92,-47.6667}},
                                                color={255,0,255}));
  connect(preOpeMod[5].y,truDelTChiWatSup. u) annotation (Line(points={{112,140},
          {166,140},{166,-170},{152,-170}},color={255,0,255}));
  connect(notTHotWatRet.y,andTHotWatRet. u2) annotation (Line(points={{88,-218},
          {82,-218}},                        color={255,0,255}));
  connect(truDelTChiWatSup.y,latTChiWatSup. u)
    annotation (Line(points={{128,-170},{112,-170}},
                                                   color={255,0,255}));
  connect(mulAndTChiWatRet.y, latTChiWatRet.u)
    annotation (Line(points={{68,-50},{52,-50}}, color={255,0,255}));
  connect(latTChiWatSup.y, preTChiWatSup.u)
    annotation (Line(points={{88,-170},{82,-170}}, color={255,0,255}));
  connect(preTChiWatSup.y, truDelTHotWatRet.u)
    annotation (Line(points={{58,-170},{52,-170}}, color={255,0,255}));
  connect(preTHotWatRet.y, timTHotWatRet.u)
    annotation (Line(points={{152,-220},{158,-220}}, color={255,0,255}));
  connect(timTHotWatRet.passed, notTHotWatRet.u) annotation (Line(points={{182,-228},
          {186,-228},{186,-240},{116,-240},{116,-218},{112,-218}}, color={255,0,
          255}));
  connect(truDelTHotWatRet.y, preTHotWatRet.u) annotation (Line(points={{28,-170},
          {20,-170},{20,-192},{120,-192},{120,-220},{128,-220}}, color={255,0,255}));
  connect(truDelTHotWatRet.y, andTHotWatRet.u1) annotation (Line(points={{28,-170},
          {20,-170},{20,-192},{86,-192},{86,-210},{82,-210}}, color={255,0,255}));
  connect(conCooTanCha.y, ctl.uHotTanCha) annotation (Line(points={{-38,150},{-12,
          150},{-12,74},{-2,74},{-2,76},{4,76}},  color={255,0,255}));
  connect(conCooTanCha.y, latTChiWatSup.clr) annotation (Line(points={{-38,150},
          {-12,150},{-12,-150},{118,-150},{118,-176},{112,-176}},
        color={255,0,255}));
  connect(andTHotWatRet.y, latTHotWatRet.u)
    annotation (Line(points={{58,-210},{52,-210}}, color={255,0,255}));
  connect(timTHotWatRet.passed, latTHotWatRet.clr) annotation (Line(points={{182,
          -228},{186,-228},{186,-240},{56,-240},{56,-216},{52,-216}}, color={255,
          0,255}));
  connect(conCooTanCha.y, onCouInt.reset) annotation (Line(points={{-38,150},{-12,
          150},{-12,-150},{70,-150},{70,-142}},                 color={255,0,255}));
  connect(THeaWatRet1.y,swiTHotWatRet. u1) annotation (Line(points={{-178,150},{
          -170,150},{-170,180},{-152,180}},  color={0,0,127}));
  connect(THeaWatRet2.y,swiTHotWatRet. u3) annotation (Line(points={{-178,110},{
          -166,110},{-166,164},{-152,164}},
                                  color={0,0,127}));
  connect(latTHotWatRet.y,swiTHotWatRet. u2) annotation (Line(points={{28,-210},
          {14,-210},{14,-54},{-20,-54},{-20,14},{-160,14},{-160,172},{-152,172}},
                                              color={255,0,255}));
  connect(swiTHotWatRet.y, ctl.THeaWatPriRet) annotation (Line(points={{-128,172},
          {-80,172},{-80,46},{4,46}},  color={0,0,127}));
  connect(swiTHotWatRet.y, ctl.THeaWatSecRet) annotation (Line(points={{-128,172},
          {-80,172},{-80,32},{4,32}},  color={0,0,127}));
  connect(swiTChiWatSup.y, ctl.TChiWatPriSup) annotation (Line(points={{-128,70},
          {-122,70},{-122,40},{4,40}}, color={0,0,127}));
  connect(swiTChiWatSup.y, ctl.TChiWatSecSup) annotation (Line(points={{-128,70},
          {-122,70},{-122,28},{4,28}}, color={0,0,127}));
  connect(TChiWatSup1.y, swiTChiWatSup.u1) annotation (Line(points={{-178,70},{-166,
          70},{-166,78},{-152,78}},      color={0,0,127}));
  connect(TChiWatSup2.y, swiTChiWatSup.u3) annotation (Line(points={{-178,30},{-166,
          30},{-166,62},{-152,62}},        color={0,0,127}));
  connect(latTChiWatSup.y, swiTChiWatSup.u2) annotation (Line(points={{88,-170},
          {84,-170},{84,-154},{-8,-154},{-8,22},{-156,22},{-156,70},{-152,70}},
        color={255,0,255}));
  connect(TChiWatRet1.y, swiTChiWatRet.u1) annotation (Line(points={{-178,-10},{
          -152,-10}},                        color={0,0,127}));
  connect(TChiWatRet2.y, swiTChiWatRet.u3) annotation (Line(points={{-178,-50},{
          -166,-50},{-166,-26},{-152,-26}},  color={0,0,127}));
  connect(latTChiWatRet.y, swiTChiWatRet.u2) annotation (Line(points={{28,-50},{
          -16,-50},{-16,18},{-156,18},{-156,-18},{-152,-18}},  color={255,0,255}));
  connect(swiTChiWatRet.y, ctl.TChiWatPriRet) annotation (Line(points={{-128,-18},
          {-40,-18},{-40,38},{4,38}},      color={0,0,127}));
  connect(swiTChiWatRet.y, ctl.TChiWatSecRet) annotation (Line(points={{-128,-18},
          {-40,-18},{-40,26},{4,26}},      color={0,0,127}));
  connect(ratV_flow.y[1],isDemHea. u)
    annotation (Line(points={{-128,-150},{-114,-150},{-114,230},{-102,230}},
                                                                          color={0,0,127}));
  connect(ratV_flow.y[2],isDemCoo. u)
    annotation (Line(points={{-128,-150},{-114,-150},{-114,190},{-102,190}},
                                                                          color={0,0,127}));
  connect(isDemCoo.y,reqPlaChiWat. u)
    annotation (Line(points={{-78,190},{-62,190}},color={255,0,255}));
  connect(isDemHea.y,reqPlaHeaWat. u)
    annotation (Line(points={{-78,230},{-62,230}},color={255,0,255}));
  connect(reqPlaHeaWat.y, ctl.nReqPlaHeaWat) annotation (Line(points={{-38,230},
          {-16,230},{-16,58},{4,58}},  color={255,127,0}));
  connect(reqPlaChiWat.y, ctl.nReqPlaChiWat) annotation (Line(points={{-38,190},
          {-20,190},{-20,56},{4,56}},  color={255,127,0}));
  connect(TOut.y, ctl.TOut) annotation (Line(points={{-178,230},{-116,230},{-116,
          48},{4,48}}, color={0,0,127}));
  annotation (
    __Dymola_Commands(
      file=
        "modelica://Buildings/Resources/Scripts/Dymola/Templates/Plants/Controls/HeatPumps/Validation/WaterToWater_enhanced.mos"
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
August 15, 2024, by Junke Wang and Karthikeya Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>", info="<html>
<p>
This model validates
<a href=\"modelica://Buildings.Templates.Plants.Controls.HeatPumps.WaterToWater_enhanced\">
Buildings.Templates.Plants.Controls.HeatPumps.WaterToWater_enhanced</a>
in a configuration with three equally sized lead/lag alternate
heat pumps.
</p>
<p>
Simulating this model shows how the controller responds to a varying load by 
</p>
<ul>
<li>
staging or unstaging the WWHPs and associated primary pumps,
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
end WaterToWater_enhanced;
