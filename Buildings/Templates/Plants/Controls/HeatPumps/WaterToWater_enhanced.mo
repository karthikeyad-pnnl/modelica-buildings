﻿within Buildings.Templates.Plants.Controls.HeatPumps;
block WaterToWater_enhanced "Controller for WWHP plant"
  parameter Boolean have_heaWat
    "Set to true for plants that provide HW"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  parameter Boolean have_chiWat
    "Set to true for plants that provide CHW"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  parameter Boolean have_valHpInlIso
    "Set to true for plants with isolation valves at heat pump inlet"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  parameter Boolean have_valHpOutIso
    "Set to true for plants with isolation valves at heat pump outlet"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  final parameter Boolean have_pumHeaWatPri=have_heaWat
    "Set to true for plants with primary HW pumps"
    annotation (Evaluate=true);

  parameter Boolean have_pumChiWatPriDed_select(start=false)=false
    "Set to true for plants with separate dedicated primary CHW pumps"
    annotation (Evaluate=true,
    Dialog(enable=have_chiWat and not have_pumPriHdr, group="Plant configuration"));

  final parameter Boolean have_pumChiWatPriDed=
    if have_chiWat and not have_pumPriHdr then have_pumChiWatPriDed_select else false
    "Set to true for plants with separate dedicated primary CHW pumps"
    annotation (Evaluate=true);

  final parameter Boolean have_pumChiWatPri=
    have_chiWat and (have_pumPriHdr or have_pumChiWatPriDed)
    "Set to true for plants with separate primary CHW pumps"
    annotation (Evaluate=true);

  parameter Boolean have_pumPriHdr
    "Set to true for headered primary pumps, false for dedicated pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  parameter Boolean have_pumHeaWatPriVar(start=true)=true
    "Set to true for variable speed primary HW pumps, false for constant speed pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration", enable=have_heaWat));

  parameter Boolean have_pumChiWatPriVar(start=true)=true
    "Set to true for variable speed primary CHW pumps, false for constant speed pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration", enable=have_chiWat and
    (have_pumPriHdr or have_pumChiWatPriDed)));

  // Only constant primary is supported for AWHP.
  final parameter Boolean have_pumPriCtlDp=false
    "Set to true for primary headered variable speed pumps using ∆p pump speed control"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  parameter Boolean have_pumHeaWatSec_select(start=false)
    "Set to true for plants with secondary HW pumps"
    annotation (Evaluate=true,
    Dialog(enable=have_heaWat,group="Plant configuration"));

  final parameter Boolean have_pumHeaWatSec=
    if have_heaWat then have_pumHeaWatSec_select else false
    "Set to true for plants with secondary HW pumps"
    annotation (Evaluate=true);

  parameter Boolean have_pumChiWatSec_select(start=false)
    "Set to true for plants with secondary CHW pumps"
    annotation (Evaluate=true,
    Dialog(enable=have_chiWat,group="Plant configuration"));

  final parameter Boolean have_pumChiWatSec=
    if have_chiWat then have_pumChiWatSec_select else false
    "Set to true for plants with secondary CHW pumps"
    annotation (Evaluate=true);

  // Only headered arrangements are supported for secondary pumps.
  final parameter Boolean have_pumSecHdr=true
    "Set to true for headered secondary pumps, false for dedicated pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  // Only ∆p controlled variable speed pumps are supported for secondary pumps.
  final parameter Boolean have_pumSecCtlDp=have_pumHeaWatSec or have_pumChiWatSec
    "Set to true for secondary headered variable speed pumps using ∆p pump speed control"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  // RFE(AntoineGautier): Add option for sidestream HRC. Always excluded for now.
  final parameter Boolean have_hrc(
    start=false)=false
    "Set to true for plants with a sidestream heat recovery chiller"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration",
    enable=have_heaWat and have_chiWat));

  parameter Boolean have_senVHeaWatPri_select(start=false)
    "Set to true for plants with primary HW flow sensor"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_heaWat and not have_hrc and have_senVHeaWatSec));

  final parameter Boolean have_senVHeaWatPri=have_heaWat and
    (if have_hrc or not have_senVHeaWatSec then true else have_senVHeaWatPri_select)
    "Set to true for plants with primary HW flow sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  // Secondary flow sensor required for secondary HW pump staging.
  final parameter Boolean have_senVHeaWatSec=have_pumHeaWatSec
    "Set to true for plants with secondary HW flow sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  parameter Boolean have_senVChiWatPri_select(start=false)
    "Set to true for plants with primary CHW flow sensor"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_chiWat and not have_hrc and have_senVChiWatSec));

  final parameter Boolean have_senVChiWatPri=have_chiWat and
    (if have_hrc or not have_senVChiWatSec then true
    else have_senVChiWatPri_select)
    "Set to true for plants with primary CHW flow sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  // Secondary flow sensor required for secondary CHW pump staging.
  final parameter Boolean have_senVChiWatSec(start=false)=have_pumChiWatSec
    "Set to true for plants with secondary CHW flow sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  parameter Boolean have_senTHeaWatPriRet_select(start=false)
    "Set to true for plants with primary HW return temperature sensor"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_heaWat and not have_hrc and have_senTHeaWatSecRet));

  final parameter Boolean have_senTHeaWatPriRet=have_heaWat and
    (if have_hrc or not have_senTHeaWatSecRet then true else have_senTHeaWatPriRet_select)
    "Set to true for plants with primary HW return temperature sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  parameter Boolean have_senTChiWatPriRet_select(start=false)
    "Set to true for plants with primary CHW return temperature sensor"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_chiWat and not have_hrc and have_senTChiWatSecRet));

  final parameter Boolean have_senTChiWatPriRet=have_chiWat and
    (if have_hrc or not have_senTChiWatSecRet then true else have_senTChiWatPriRet_select)
    "Set to true for plants with primary CHW return temperature sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  // For primary-secondary plants, SHWST sensor is required for plant staging.
  final parameter Boolean have_senTHeaWatSecSup=have_pumHeaWatSec
    "Set to true for plants with secondary HW supply temperature sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  // For primary-secondary plants, SCHWST sensor is required for plant staging.
  final parameter Boolean have_senTChiWatSecSup=have_pumChiWatSec
    "Set to true for plants with secondary CHW supply temperature sensor"
    annotation (Evaluate=true, Dialog(group="Sensors"));

  parameter Boolean have_senTHeaWatSecRet(start=false)
    "Set to true for plants with secondary HW return temperature sensor"
    annotation (Evaluate=true, Dialog(group="Sensors", enable=have_pumHeaWatSec));

  parameter Boolean have_senTChiWatSecRet(start=false)
    "Set to true for plants with secondary CHW return temperature sensor"
    annotation (Evaluate=true, Dialog(group="Sensors", enable=have_pumChiWatSec));

  parameter Integer nHp(final min=1)
    "Number of heat pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration"));

  parameter Integer nPumHeaWatPri(
    final min=if have_pumHeaWatPri then 1 else 0,
    start=0)=nHp
    "Number of primary HW pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration",
      enable=have_pumHeaWatPri));

  parameter Integer nPumChiWatPri(
    final min=if have_pumChiWatPri then 1 else 0,
    start=if have_pumChiWatPri then nHp else 0)=if have_pumChiWatPri then nHp
     else 0
    "Number of primary CHW pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration",
      enable=have_pumChiWatPri));

  parameter Integer nPumHeaWatSec(
    final min=if have_pumHeaWatSec then 1 else 0,
    start=0)=nHp
    "Number of secondary HW pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration",
      enable=have_pumHeaWatSec));

  parameter Integer nPumChiWatSec(
    final min=if have_pumChiWatSec then 1 else 0,
    start=0)=nHp
    "Number of secondary CHW pumps"
    annotation (Evaluate=true,
    Dialog(group="Plant configuration",
      enable=have_pumChiWatSec));

  parameter Boolean have_senDpHeaWatRemWir(start=true)=true
    "Set to true for remote HW differential pressure sensor(s) hardwired to plant or pump controller"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Integer nSenDpHeaWatRem(final min=if have_heaWat and have_pumHeaWatSec
         then 1 else 0, start=0)
    "Number of remote HW differential pressure sensors used for HW pump speed control"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Boolean have_senDpChiWatRemWir(start=true)=true
    "Set to true for remote CHW differential pressure sensor(s) hardwired to plant or pump controller"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Integer nSenDpChiWatRem(final min=if have_chiWat and have_pumChiWatSec
         then 1 else 0, start=0)
    "Number of remote CHW differential pressure sensors used for CHW pump speed control"
    annotation (Evaluate=true,
    Dialog(group="Sensors",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real THeaWatSup_nominal(
    final min=273.15,
    start=50 + 273.15,
    final unit="K",
    displayUnit="degC")
    "Design HW supply temperature (maximum setpoint)"
    annotation (Dialog(group="Information provided by designer",
      enable=have_heaWat));

  parameter Real THeaWatSupSet_min(
    final min=273.15,
    start=25 + 273.15,
    final unit="K",
    displayUnit="degC")
    "Minimum value to which the HW supply temperature can be reset"
    annotation (Dialog(group="Information provided by designer",
      enable=have_heaWat));

  parameter Real TOutHeaWatLck(
    final min=273.15,
    start=21 + 273.15,
    final unit="K",
    displayUnit="degC")=294.15
    "Outdoor air lockout temperature above which the HW loop is prevented from operating"
    annotation (Dialog(group="Information provided by designer",
      enable=have_heaWat));

  parameter Real capHeaHp_nominal[nHp](
    final min=fill(0, nHp),
    start=fill(1, nHp),
    final unit=fill("W", nHp))
    "Design heating capacity - Each heat pump"
    annotation (Dialog(group="Information provided by designer",
      enable=have_heaWat));

  parameter Real VHeaWatSec_flow_nominal(
    final min=0,
    start=1E-6,
    final unit="m3/s")
    "Design secondary HW volume flow rate"
    annotation (Evaluate=true,
    Dialog(group="Information provided by designer",
      enable=have_heaWat and have_pumHeaWatSec and have_pumSecCtlDp));

  parameter Real dpHeaWatRemSet_max[nSenDpHeaWatRem](
    final min=fill(0, nSenDpHeaWatRem),
    start=fill(5E4, nSenDpHeaWatRem),
    final unit=fill("Pa", nSenDpHeaWatRem))
    "Maximum HW differential pressure setpoint - Remote sensor"
    annotation (Dialog(group=
      "Information provided by testing, adjusting, and balancing contractor",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real dpHeaWatRemSet_min(
    final min=0,
    start=5*6894,
    final unit="Pa")=5*6894
    "Minimum value to which the HW differential pressure can be reset - Remote sensor"
    annotation (Dialog(group=
      "Information provided by designer",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real yPumHeaWatPriSet(
    final max=1,
    final min=0,
    start=1,
    final unit="1")
    "Primary pump speed providing design heat pump flow in heating mode"
    annotation (Dialog(group=
      "Information provided by testing, adjusting, and balancing contractor",
      enable=have_heaWat and have_pumHeaWatPriVar));

  parameter Real TChiWatSup_nominal(
    final min=273.15,
    start=7 + 273.15,
    final unit="K",
    displayUnit="degC")
    "Design CHW supply temperature (minimum setpoint)"
    annotation (Dialog(group="Information provided by designer",
      enable=have_chiWat));

  parameter Real TChiWatSupSet_max(
    final min=273.15,
    start=15 + 273.15,
    final unit="K",
    displayUnit="degC")
    "Maximum value to which the CHW supply temperature can be reset"
    annotation (Dialog(group="Information provided by designer",
      enable=have_chiWat));

  parameter Real TOutChiWatLck(
    final min=273.15,
    start=16 + 273.15,
    final unit="K",
    displayUnit="degC")=289.15
    "Outdoor air lockout temperature below which the CHW loop is prevented from operating"
    annotation (Dialog(group="Information provided by designer",
      enable=have_chiWat));

  parameter Real capCooHp_nominal[nHp](
    final min=fill(0, nHp),
    start=fill(1, nHp),
    final unit=fill("W", nHp))
    "Design cooling capacity - Each heat pump"
    annotation (Dialog(group="Information provided by designer",
      enable=have_chiWat));

  parameter Real VChiWatSec_flow_nominal(
    final min=0,
    start=1E-6,
    final unit="m3/s")
    "Design secondary CHW volume flow rate"
    annotation (Evaluate=true,
    Dialog(group="Information provided by designer",
      enable=have_chiWat and have_pumChiWatSec and have_pumSecCtlDp));

  parameter Real dpChiWatRemSet_max[nSenDpChiWatRem](
    final min=fill(0, nSenDpChiWatRem),
    start=fill(5E4, nSenDpChiWatRem),
    final unit=fill("Pa", nSenDpChiWatRem))
    "Maximum CHW differential pressure setpoint - Remote sensor"
    annotation (Dialog(group=
      "Information provided by testing, adjusting, and balancing contractor",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real dpChiWatRemSet_min(
    final min=0,
    start=5*6894,
    final unit="Pa")=5*6894
    "Minimum value to which the CHW differential pressure can be reset - Remote sensor"
    annotation (Dialog(group=
      "Information provided by designer",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real yPumChiWatPriSet(
    final max=1,
    final min=0,
    start=1,
    final unit="1")
    "Primary pump speed providing design heat pump flow in cooling mode"
    annotation (Dialog(group=
      "Information provided by testing, adjusting, and balancing contractor",
      enable=have_chiWat and have_pumChiWatPriVar));

  parameter Real cp_default(
    final min=0,
    final unit="J/(kg.K)")=4184
    "Default specific heat capacity used to compute required capacity"
    annotation (Evaluate=true,
    Dialog(group="Information provided by designer"));

  parameter Real rho_default(
    final min=0,
    final unit="kg/m3")=996
    "Default density used to compute required capacity"
    annotation (Evaluate=true,
    Dialog(group="Information provided by designer"));

  parameter Boolean have_inpSch=false
    "Set to true to provide schedule via software input point"
    annotation (Dialog(group="Plant enable"),
    Evaluate=true);
  parameter Real schHea[:, 2](start=[0,1; 24*3600,1])=[0,1; 24*3600,1]
    "Heating mode enable schedule"
    annotation (Dialog(enable=not have_inpSch,group="Plant enable"));

  parameter Real schCoo[:, 2](start=[0,1; 24*3600,1])=[0,1; 24*3600,1]
    "Cooling mode enable schedule"
    annotation (Dialog(enable=not have_inpSch,group="Plant enable"));

  parameter Integer nReqIgnHeaWat(final min=0)=0
    "Number of ignored HW plant requests"
    annotation (Dialog(tab="Advanced",group="Plant enable"));

  parameter Integer nReqIgnChiWat(final min=0)=0
    "Number of ignored CHW plant requests"
    annotation (Dialog(tab="Advanced",group="Plant enable"));

  parameter Real dTOutLck(
    final min=0,
    final unit="K")=0.5
    "Hysteresis for outdoor air lockout temperature"
    annotation (Dialog(tab="Advanced",group="Plant enable"));

  parameter Real dtRunEna(
    final min=0,
    final unit="s")=15*60
    "Minimum runtime of enable and disable states"
    annotation (Dialog(tab="Advanced",group="Plant enable"));

  parameter Real dtReqDis(
    final min=0,
    final unit="s")=3*60
    "Runtime with low number of request before disabling"
    annotation (Dialog(tab="Advanced",group="Plant enable"));

  parameter Real staEqu[:, nHp](
    each final max=1,
    each final min=0,
    each final unit="1")
    "Staging matrix – Equipment required for each stage"
    annotation (Dialog(group="Equipment staging and rotation"));

  final parameter Integer nSta(
    final min=1)=size(staEqu, 1)
    "Number of stages"
    annotation (Evaluate=true);

  final parameter Integer nEquAlt(
    final min=0)=max({sum({(if staEqu[i, j] > 0 and staEqu[i, j] < 1 then 1 else 0) for j in 1:nHp}) for i in 1:nSta})
    "Number of lead/lag alternate equipment"
    annotation (Evaluate=true);

  parameter Integer idxEquAlt[nEquAlt](
    each final min=1)
    "Indices of lead/lag alternate equipment"
    annotation (Evaluate=true,
    Dialog(group="Equipment staging and rotation"));

  parameter Real dtVal(
    final min=0,
    start=90,
    final unit="s")=90
    "Nominal valve timing"
    annotation (Dialog(tab="Advanced",group="Equipment staging and rotation",
      enable=have_valHpInlIso or have_valHpOutIso));

  parameter Real dtHp(
    final min=0,
    final unit="s")=180
    annotation (Dialog(tab="Advanced",group="Equipment staging and rotation"));

  parameter Real plrSta(
    final max=1,
    final min=0,
    start=0.9,
    final unit="1")=0.9
    "Staging part load ratio"
    annotation (Dialog(group="Equipment staging and rotation"));

  parameter Real dtRunSta(
    final min=0,
    final unit="s",
    displayUnit="min")=900
    "Minimum runtime of each stage"
    annotation (Dialog(tab="Advanced",group="Equipment staging and rotation"));

  parameter Real dtOff(
    final min=0,
    final unit="s")=900
    "Off time required before equipment is deemed available again"
    annotation (Dialog(tab="Advanced",group="Equipment staging and rotation"));

  parameter Real dtRunPumSta(
    final min=0,
    start=600,
    final unit="s")=600
    "Runtime before triggering stage command"
    annotation (Dialog(tab="Advanced",group="Pump staging",
      enable=have_pumPriHdr and have_pumPriCtlDp or have_pumSecHdr and have_pumSecCtlDp));

  parameter Real dVOffUpPumSta(
    final max=1,
    final min=0,
    start=0.03,
    final unit="1")=0.03
    "Stage up flow point offset"
    annotation (Dialog(tab="Advanced",group="Pump staging",
      enable=have_pumPriHdr and have_pumPriCtlDp or have_pumSecHdr and have_pumSecCtlDp));

  parameter Real dVOffDowPumSta(
    final max=1,
    final min=0,
    start=0.03,
    final unit="1")=dVOffUpPumSta
    "Stage down flow point offset"
    annotation (Dialog(tab="Advanced",group="Pump staging",
      enable=have_pumPriHdr and have_pumPriCtlDp or have_pumSecHdr and have_pumSecCtlDp));

  parameter Real dtHol(
    final min=0,
    final unit="s")=900
    "Minimum hold time during stage change"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec or have_chiWat and have_pumChiWatSec));

  parameter Real resDpHeaWat_max(
    final max=1,
    final min=0,
    final unit="1")=0.5
    "Upper limit of plant reset interval for HW differential pressure reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real resTHeaWatSup_min(
    final max=1,
    final min=0,
    final unit="1")=resDpHeaWat_max
    "Lower limit of plant reset interval for HW supply temperature reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real resDpChiWat_max(
    final max=1,
    final min=0,
    final unit="1")=0.5
    "Upper limit of plant reset interval for CHW differential pressure reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real resTChiWatSup_min(
    final max=1,
    final min=0,
    final unit="1")=resDpChiWat_max
    "Lower limit of plant reset interval for CHW supply temperature reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real res_init(
    final max=1,
    final min=0,
    final unit="1")=1
    "Initial reset value"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec or have_chiWat and have_pumChiWatSec));

  parameter Real res_min(
    final max=1,
    final min=0,
    final unit="1")=0
    "Minimum reset value"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec or have_chiWat and have_pumChiWatSec));

  parameter Real res_max(
    final max=1,
    final min=0,
    final unit="1")=1
    "Maximum reset value"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec or have_chiWat and have_pumChiWatSec));

  parameter Real dtDel(
    final min=100*1E-15,
    final unit="s")=900
    "Delay time before the reset begins"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec or have_chiWat and have_pumChiWatSec));

  parameter Real dtResHeaWat(
    final min=1E-3,
    final unit="s")=300
    "Reset period for HW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Integer nReqResIgnHeaWat(final min=0)=2
    "Number of ignored requests for HW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real triHeaWat(
    final max=0,
    final unit="1")=-0.02
    "Trim amount for HW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real rspHeaWat(
    final min=0,
    final unit="1")=0.03
    "Respond amount for HW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real rspHeaWat_max(
    final min=0,
    final unit="1")=0.07
    "Maximum response per reset period for HW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_heaWat and have_pumHeaWatSec));

  parameter Real dtResChiWat(
    final min=1E-3,
    final unit="s")=300
    "Reset period for CHW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Integer nReqResIgnChiWat(final min=0)=2
    "Number of ignored requests for CHW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real triChiWat(
    final max=0,
    final unit="1")=-0.02
    "Trim amount for CHW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real rspChiWat(
    final min=0,
    final unit="1")=0.03
    "Respond amount for CHW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real rspChiWat_max(
    final min=0,
    final unit="1")=0.07
    "Maximum response per reset period for CHW plant reset"
    annotation (Dialog(tab="Advanced",group="Plant reset",
      enable=have_chiWat and have_pumChiWatSec));

  parameter Real yPumHeaWatSec_min(
    final max=1,
    final min=0,
    start=0.1,
    final unit="1")=0.1
    "Minimum pump speed"
    annotation (Dialog(tab="Advanced",group="Secondary HW pumps",
      enable=have_pumHeaWatSec));

  parameter Real kPumHeaWatSec(
    final min=100*Buildings.Controls.OBC.CDL.Constants.eps,
    start=1)=1
    "Gain of controller"
    annotation (Dialog(tab="Advanced",group="Secondary HW pumps",
      enable=have_pumHeaWatSec));

  parameter Real TiPumHeaWatSec(
    final min=100*Buildings.Controls.OBC.CDL.Constants.eps,
    start=60,
    final unit="s")=60
    "Time constant of integrator block"
    annotation (Dialog(tab="Advanced",group="Secondary HW pumps",
      enable=have_pumHeaWatSec));

  parameter Real yPumChiWatSec_min(
    final max=1,
    final min=0,
    start=0.1,
    final unit="1")=0.1
    "Minimum pump speed"
    annotation (Dialog(tab="Advanced",group="Secondary CHW pumps",
      enable=have_pumChiWatSec));

  parameter Real kPumChiWatSec(
    final min=100*Buildings.Controls.OBC.CDL.Constants.eps,
    start=1)=1
    "Gain of controller"
    annotation (Dialog(tab="Advanced",group="Secondary CHW pumps",
      enable=have_pumChiWatSec));

  parameter Real TiPumChiWatSec(
    final min=100*Buildings.Controls.OBC.CDL.Constants.eps,
    start=60,
    final unit="s")=60
    "Time constant of integrator block"
    annotation (Dialog(tab="Advanced",group="Secondary CHW pumps",
      enable=have_pumChiWatSec));

  Buildings.Controls.OBC.CDL.Logical.Sources.Constant u1AvaHp[nHp](each k=true)
    "Heat pump available signal – Block does not handle faulted equipment yet"
    annotation (Placement(transformation(extent={{-200,210},{-180,230}}),
        iconTransformation(extent={{-240,220},{-200,260}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHotTanCha if have_heaWat
    "Hot thermal energy storage dedicated charging mode enable signal"
    annotation (Placement(transformation(extent={{-300,360},{-260,400}}),
        iconTransformation(extent={{-240,300},{-200,340}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uCooTanCha if have_chiWat
    "Cold thermal energy storage dedicated charging mode enable signal"
    annotation (Placement(transformation(extent={{-300,340},{-260,380}}),
        iconTransformation(extent={{-240,280},{-200,320}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nReqResHeaWat
    if have_heaWat
    "Sum of HW reset requests of all heating loads served"
    annotation (Placement(transformation(extent={{-300,-360},{-260,-320}}),
      iconTransformation(extent={{-240,80},{-200,120}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nReqResChiWat
    if have_chiWat
    "Sum of CHW reset requests of all heating loads served"
    annotation (Placement(transformation(extent={{-300,-380},{-260,-340}}),
      iconTransformation(extent={{-240,60},{-200,100}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1PumHeaWatPri_actual[nPumHeaWatPri]
    if have_heaWat and have_pumHeaWatPri
    "Primary HW pump status"
    annotation (Placement(transformation(extent={{-300,180},{-260,220}}),
      iconTransformation(extent={{-240,200},{-200,240}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1PumChiWatPri_actual[nPumChiWatPri]
    if have_chiWat and have_pumChiWatPri
    "Primary CHW pump status"
    annotation (Placement(transformation(extent={{-300,160},{-260,200}}),
      iconTransformation(extent={{-240,180},{-200,220}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1PumHeaWatSec_actual[nPumHeaWatSec]
    if have_heaWat and have_pumHeaWatSec
    "Secondary HW pump status"
    annotation (Placement(transformation(extent={{-300,140},{-260,180}}),
      iconTransformation(extent={{-240,160},{-200,200}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1PumChiWatSec_actual[nPumChiWatSec]
    if have_chiWat and have_pumChiWatSec
    "Secondary CHW pump status"
    annotation (Placement(transformation(extent={{-300,120},{-260,160}}),
      iconTransformation(extent={{-240,140},{-200,180}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaWatPriRet(
    final unit="K",
    displayUnit="degC") if have_heaWat and have_senTHeaWatPriRet
    "Primary HW return temperature"
    annotation (Placement(transformation(extent={{-300,40},{-260,80}}),
      iconTransformation(extent={{-240,0},{-200,40}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHeaWatPri_flow(
    final unit="m3/s") if have_heaWat and have_senVHeaWatPri
    "Primary HW volume flow rate"
    annotation (Placement(transformation(extent={{-300,20},{-260,60}}),
      iconTransformation(extent={{-240,-20},{-200,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHeaWatLoc(
    final unit="Pa")
    if have_heaWat and not have_senDpHeaWatRemWir
    "Local HW differential pressure"
    annotation (Placement(transformation(extent={{-300,-260},{-260,-220}}),
      iconTransformation(extent={{-240,-280},{-200,-240}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHeaWatLocSet[nSenDpHeaWatRem](
    each final unit="Pa")
    if have_heaWat and not have_senDpHeaWatRemWir
    "Local HW differential pressure setpoint output from each of the remote loops"
    annotation (Placement(transformation(extent={{-300,-240},{-260,-200}}),
      iconTransformation(extent={{-240,-260},{-200,-220}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHeaWatRem[nSenDpHeaWatRem](
    each final unit="Pa")
    if have_heaWat and have_senDpHeaWatRemWir
    "Remote HW differential pressure"
    annotation (Placement(transformation(extent={{-300,-220},{-260,-180}}),
      iconTransformation(extent={{-240,-240},{-200,-200}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatLoc(
    final unit="Pa")
    if have_chiWat and not have_senDpChiWatRemWir
    "Local CHW differential pressure"
    annotation (Placement(transformation(extent={{-300,-320},{-260,-280}}),
      iconTransformation(extent={{-240,-340},{-200,-300}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatLocSet[nSenDpChiWatRem](
    each final unit="Pa")
    if have_chiWat and not have_senDpChiWatRemWir
    "Local CHW differential pressure setpoint output from each of the remote loops"
    annotation (Placement(transformation(extent={{-300,-300},{-260,-260}}),
      iconTransformation(extent={{-240,-320},{-200,-280}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpChiWatRem[nSenDpChiWatRem](
    each final unit="Pa")
    if have_chiWat and have_senDpChiWatRemWir
    "Remote CHW differential pressure"
    annotation (Placement(transformation(extent={{-300,-280},{-260,-240}}),
      iconTransformation(extent={{-240,-300},{-200,-260}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1ValHeaWatHpInlIso[nHp]
    if have_heaWat and have_valHpInlIso
    "Heat pump inlet HW inlet isolation valve command" annotation (Placement(
        transformation(extent={{260,300},{300,340}}), iconTransformation(extent={{200,200},
            {240,240}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1ValHeaWatHpOutIso[nHp]
    if have_heaWat and have_valHpOutIso
    "Heat pump outlet HW isolation valve command" annotation (Placement(
        transformation(extent={{260,280},{300,320}}), iconTransformation(extent={{200,180},
            {240,220}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1ValChiWatHpInlIso[nHp]
    if have_chiWat and have_valHpInlIso
    "Heat pump inlet CHW isolation valve command" annotation (Placement(
        transformation(extent={{260,260},{300,300}}), iconTransformation(extent={{200,160},
            {240,200}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1ValChiWatHpOutIso[nHp]
    if have_chiWat and have_valHpOutIso
    "Heat pump outlet CHW isolation valve command" annotation (Placement(
        transformation(extent={{260,240},{300,280}}), iconTransformation(extent={{200,140},
            {240,180}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1PumHeaWatPri[nPumHeaWatPri]
    if have_pumHeaWatPri
    "Primary HW pump start command"
    annotation (Placement(transformation(extent={{260,180},{300,220}}),
      iconTransformation(extent={{200,100},{240,140}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1PumChiWatPri[nPumChiWatPri]
    if have_pumChiWatPri and have_chiWat
    "Primary CHW pump start command"
    annotation (Placement(transformation(extent={{260,160},{300,200}}),
      iconTransformation(extent={{200,80},{240,120}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1PumHeaWatSec[nPumHeaWatSec]
    if have_pumHeaWatSec
    "Secondary HW pump start command"
    annotation (Placement(transformation(extent={{260,140},{300,180}}),
      iconTransformation(extent={{200,40},{240,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1PumChiWatSec[nPumChiWatSec]
    if have_pumChiWatSec and have_chiWat
    "Secondary CHW pump start command"
    annotation (Placement(transformation(extent={{260,120},{300,160}}),
      iconTransformation(extent={{200,20},{240,60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1Hp[nHp]
    "Heat pump enable command"
    annotation (Placement(transformation(extent={{260,360},{300,400}}),
      iconTransformation(extent={{200,260},{240,300}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput y1HeaHp[nHp]
    if have_heaWat and have_chiWat
    "Heat pump heating/cooling mode command: true=heating, false=cooling"
    annotation (Placement(transformation(extent={{260,340},{300,380}}),
      iconTransformation(extent={{200,240},{240,280}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput dpHeaWatRemSet[nSenDpHeaWatRem](
    each final min=0,
    each final unit="Pa") if have_heaWat
    "HW differential pressure setpoint"
    annotation (Placement(transformation(extent={{260,-80},{300,-40}}),
      iconTransformation(extent={{200,-200},{240,-160}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput dpChiWatRemSet[nSenDpChiWatRem](
    each final min=0,
    each final unit="Pa") if have_chiWat
    "CHW differential pressure setpoint"
    annotation (Placement(transformation(extent={{260,-100},{300,-60}}),
      iconTransformation(extent={{200,-220},{240,-180}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumHeaWatPriHdr(
    final unit="1")
    if have_heaWat and have_pumHeaWatPriVar and have_pumPriHdr
    "Primary headered HW pump speed command"
    annotation (Placement(transformation(extent={{260,80},{300,120}}),
      iconTransformation(extent={{200,-60},{240,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumChiWatPriHdr(
    final unit="1") if have_chiWat and have_pumChiWatPri and
    have_pumChiWatPriVar and have_pumPriHdr
    "Primary headered CHW pump speed command"
    annotation (Placement(transformation(extent={{260,60},{300,100}}),
      iconTransformation(extent={{200,-80},{240,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumHeaWatSec(
    final unit="1")
    if have_heaWat and have_pumHeaWatSec
    "Primary HW pump speed command"
    annotation (Placement(transformation(extent={{260,-20},{300,20}}),
      iconTransformation(extent={{200,-140},{240,-100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumChiWatSec(
    final unit="1")
    if have_chiWat and have_pumChiWatSec
    "Primary CHW pump speed command"
    annotation (Placement(transformation(extent={{260,-40},{300,0}}),
      iconTransformation(extent={{200,-160},{240,-120}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TChiWatSupSet(
    final unit="K",
    displayUnit="degC") if have_chiWat
    "CHW supply temperature setpoint"
    annotation (Placement(transformation(extent={{260,-200},{300,-160}}),
      iconTransformation(extent={{200,-300},{240,-260}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput THeaWatSupSet(
    final unit="K",
    displayUnit="degC") if have_heaWat
    "HW supply temperature setpoint"
    annotation (Placement(transformation(extent={{260,-180},{300,-140}}),
      iconTransformation(extent={{200,-280},{240,-240}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatPriRet(
    final unit="K",
    displayUnit="degC") if have_chiWat and have_senTChiWatPriRet
    "Primary CHW return temperature"
    annotation (Placement(transformation(extent={{-300,-40},{-260,0}}),
      iconTransformation(extent={{-240,-80},{-200,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWatPri_flow(
    final unit="m3/s") if have_chiWat and have_senVChiWatPri
    "Primary CHW volume flow rate"
    annotation (Placement(transformation(extent={{-300,-60},{-260,-20}}),
      iconTransformation(extent={{-240,-100},{-200,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1Hp_actual[nHp]
    "Heat pump status"
    annotation (Placement(transformation(extent={{-300,300},{-260,340}}),
      iconTransformation(extent={{-240,220},{-200,260}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumHeaWatPriDed[nPumHeaWatPri](
    each final unit="1")
    if have_heaWat and have_pumHeaWatPriVar and not have_pumPriHdr
    "Primary dedicated HW pump speed command"
    annotation (Placement(transformation(extent={{260,40},{300,80}}),
      iconTransformation(extent={{200,-100},{240,-60}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumChiWatPriDed[nPumChiWatPri](
    each final unit="1")
    if have_chiWat and have_pumChiWatPriDed and have_pumChiWatPriVar
    "Primary dedicated CHW pump speed command"
    annotation (Placement(transformation(extent={{260,20},{300,60}}),
      iconTransformation(extent={{200,-120},{240,-80}})));

  Buildings.Templates.Plants.Controls.Utilities.StageIndex idxSta(
    final nSta=nSta,
    final dtRun=dtRunSta)
    if have_heaWat "Compute stage index"
    annotation (Placement(transformation(extent={{-10,350},{10,370}})));

  Buildings.Templates.Plants.Controls.StagingRotation.StageAvailability avaSta(final staEqu=staEqu)
    if have_heaWat
    "Evaluate stage availability"
    annotation (Placement(transformation(extent={{-110,320},{-90,340}})));

  Buildings.Templates.Plants.Controls.StagingRotation.EquipmentEnable enaEqu(final staEqu=staEqu)
    if have_heaWat "Compute enable command for equipment"
    annotation (Placement(transformation(extent={{40,350},{60,370}})));

  Buildings.Templates.Plants.Controls.StagingRotation.EventSequencing seqEve[nHp](
    each final have_heaWat=have_heaWat,
    each final have_chiWat=have_chiWat,
    each final have_valInlIso=have_valHpInlIso,
    each final have_valOutIso=have_valHpOutIso,
    each final have_pumHeaWatPri=have_pumHeaWatPri,
    each final have_pumChiWatPri=have_pumChiWatPri,
    each final have_pumHeaWatSec=have_pumHeaWatSec,
    each final have_pumChiWatSec=have_pumChiWatSec,
    each final dtVal=dtVal,
    each final dtOff=dtHp) "Event sequencing"
    annotation (Placement(transformation(extent={{140,284},{160,312}})));

  Buildings.Templates.Plants.Controls.StagingRotation.StageChangeCommand chaStaHea(
    final have_inpPlrSta=false,
    final plrSta=plrSta,
    final staEqu=staEqu,
    final capEqu=capHeaHp_nominal,
    final dtRun=dtRunSta,
    final cp_default=cp_default,
    final rho_default=rho_default) if have_heaWat
    "Generate heating stage transition command"
    annotation (Placement(transformation(extent={{-40,308},{-20,332}})));

  Buildings.Templates.Plants.Controls.StagingRotation.SortRuntime sorRunTimHea(idxEquAlt=idxEquAlt, nin=
        nHp) if have_heaWat
    "Sort lead/lag alternate equipment by staging runtime – Heating mode"
    annotation (Placement(transformation(extent={{-40,280},{-20,300}})));

  Buildings.Templates.Plants.Controls.StagingRotation.EquipmentAvailability avaEquHeaCoo[nHp](
    each final have_heaWat=have_heaWat,
    each final have_chiWat=have_chiWat,
    each final dtOff=dtOff)
    "Evaluate equipment availability in heating or cooling mode"
    annotation (Placement(transformation(extent={{-152,210},{-132,230}})));

  Buildings.Controls.OBC.CDL.Logical.Pre y1HeaPre[nHp]
    if have_heaWat and have_chiWat
    "Left-limit of command signal to break algebraic loop"
    annotation (Placement(transformation(extent={{230,350},{210,370}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.StagingHeadered staPumHeaWatPri(
    final is_pri=true,
    final have_valInlIso=have_valHpInlIso,
    final have_valOutIso=have_valHpOutIso,
    final nEqu=nHp,
    final nPum=nPumHeaWatPri,
    final is_hdr=have_pumPriHdr,
    final is_ctlDp=have_pumPriCtlDp,
    final dtRun=dtRunPumSta,
    final dVOffUp=dVOffUpPumSta,
    final dVOffDow=dVOffDowPumSta) if have_pumHeaWatPri
    "Primary HW pump staging"
    annotation (Placement(transformation(extent={{140,190},{160,210}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.StagingHeadered staPumChiWatPri(
    final is_pri=true,
    final have_valInlIso=have_valHpInlIso,
    final have_valOutIso=have_valHpOutIso,
    final nEqu=nHp,
    final nPum=nPumChiWatPri,
    final is_hdr=have_pumPriHdr,
    final is_ctlDp=have_pumPriCtlDp,
    final dtRun=dtRunPumSta,
    final dVOffUp=dVOffUpPumSta,
    final dVOffDow=dVOffDowPumSta) if have_pumChiWatPri and have_chiWat
    "Primary CHW pump staging"
    annotation (Placement(transformation(extent={{190,170},{210,190}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.StagingHeadered staPumChiWatSec(
    final is_pri=false,
    final nEqu=nHp,
    final nPum=nPumChiWatSec,
    final is_hdr=have_pumSecHdr,
    final is_ctlDp=have_pumSecCtlDp,
    final V_flow_nominal=VChiWatSec_flow_nominal,
    final dtRun=dtRunPumSta,
    final dVOffUp=dVOffUpPumSta,
    final dVOffDow=dVOffDowPumSta) if have_pumChiWatSec and have_chiWat
    "Secondary CHW pump staging"
    annotation (Placement(transformation(extent={{190,130},{210,150}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.StagingHeadered staPumHeaWatSec(
    final is_pri=false,
    final nEqu=nHp,
    final nPum=nPumHeaWatSec,
    final is_hdr=have_pumSecHdr,
    final is_ctlDp=have_pumSecCtlDp,
    final V_flow_nominal=VHeaWatSec_flow_nominal,
    final dtRun=dtRunPumSta,
    final dVOffUp=dVOffUpPumSta,
    final dVOffDow=dVOffDowPumSta) if have_pumHeaWatSec
    "Secondary HW pump staging"
    annotation (Placement(transformation(extent={{140,150},{160,170}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaWatSecRet(
    final unit="K",
    displayUnit="degC") if have_heaWat and have_senTHeaWatSecRet
    "Secondary HW return temperature"
    annotation (Placement(transformation(extent={{-300,-100},{-260,-60}}),
      iconTransformation(extent={{-240,-140},{-200,-100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHeaWatSec_flow(
    final unit="m3/s") if have_heaWat and have_senVHeaWatSec
    "Secondary HW volume flow rate"
    annotation (Placement(transformation(extent={{-300,-120},{-260,-80}}),
      iconTransformation(extent={{-240,-160},{-200,-120}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSecRet(
    final unit="K",
    displayUnit="degC") if have_chiWat and have_senTChiWatSecRet
    "Secondary CHW return temperature"
    annotation (Placement(transformation(extent={{-300,-160},{-260,-120}}),
      iconTransformation(extent={{-240,-200},{-200,-160}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VChiWatSec_flow(
    final unit="m3/s") if have_chiWat and have_senVChiWatSec
    "Secondary CHW volume flow rate"
    annotation (Placement(transformation(extent={{-300,-180},{-260,-140}}),
      iconTransformation(extent={{-240,-220},{-200,-180}})));

  Buildings.Templates.Plants.Controls.Utilities.PlaceholderReal THeaWatRet(
    have_inp=have_heaWat and have_senTHeaWatPriRet,
    have_inpPh=true) if have_heaWat
    "Select HW return temperature sensor"
    annotation (Placement(transformation(extent={{-230,30},{-210,50}})));

  Buildings.Templates.Plants.Controls.Utilities.PlaceholderReal VHeaWat_flow(have_inp=have_heaWat and
        have_senVHeaWatPri, have_inpPh=true) if have_heaWat
    "Select HW flow sensor"
    annotation (Placement(transformation(extent={{-200,10},{-180,30}})));

  Buildings.Templates.Plants.Controls.Utilities.PlaceholderReal TChiWatRet(have_inp=have_chiWat and
        have_senTChiWatPriRet, have_inpPh=true) if have_chiWat
    "Select CHW return temperature sensor"
    annotation (Placement(transformation(extent={{-230,-30},{-210,-10}})));

  Buildings.Templates.Plants.Controls.Utilities.PlaceholderReal VChiWat_flow(have_inp=have_chiWat and
        have_senVChiWatPri, have_inpPh=true) if have_chiWat
    "Select CHW flow sensor"
    annotation (Placement(transformation(extent={{-200,-50},{-180,-30}})));

  Buildings.Controls.OBC.CDL.Logical.Pre y1HpPre[nHp]
    "Left-limit of command signal to break algebraic loop"
    annotation (Placement(transformation(extent={{200,370},{180,390}})));

  Buildings.Templates.Plants.Controls.StagingRotation.StageCompletion comSta(nin=nHp) if have_heaWat
    "Check successful completion of stage change"
    annotation (Placement(transformation(extent={{-40,250},{-20,270}})));

  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resHeaWat(
    final TSup_nominal=THeaWatSup_nominal,
    final TSupSetLim=THeaWatSupSet_min,
    final dpSet_max=dpHeaWatRemSet_max,
    final dpSet_min=dpHeaWatRemSet_min,
    final dtDel=dtDel,
    final dtHol=dtHol,
    final dtRes=dtResHeaWat,
    final nReqResIgn=nReqResIgnHeaWat,
    final nSenDpRem=nSenDpHeaWatRem,
    final resDp_max=resDpHeaWat_max,
    final resTSup_min=resTHeaWatSup_min,
    final res_init=res_init,
    final res_max=res_max,
    final res_min=res_min,
    final rsp=rspHeaWat,
    final rsp_max=rspHeaWat_max,
    final tri=triHeaWat) if have_heaWat "HW plant reset"
    annotation (Placement(transformation(extent={{90,230},{110,250}})));

  Buildings.Templates.Plants.Controls.Setpoints.PlantReset resChiWat(
    final TSup_nominal=TChiWatSup_nominal,
    final TSupSetLim=TChiWatSupSet_max,
    final dpSet_max=dpChiWatRemSet_max,
    final dpSet_min=dpChiWatRemSet_min,
    final dtDel=dtDel,
    final dtHol=dtHol,
    final dtRes=dtResChiWat,
    final nReqResIgn=nReqResIgnChiWat,
    final nSenDpRem=nSenDpChiWatRem,
    final resDp_max=resDpChiWat_max,
    final resTSup_min=resTChiWatSup_min,
    final res_init=res_init,
    final res_max=res_max,
    final res_min=res_min,
    final rsp=rspChiWat,
    final rsp_max=rspChiWat_max,
    final tri=triChiWat) if have_chiWat "CHW plant reset"
    annotation (Placement(transformation(extent={{90,-50},{110,-30}})));

  Buildings.Templates.Plants.Controls.Pumps.Primary.VariableSpeedNoDpControl ctlPumPri(
    final have_heaWat=have_heaWat,
    final have_chiWat=have_chiWat,
    final have_pumChiWatPriDed=have_pumChiWatPriDed,
    final have_pumPriHdr=have_pumPriHdr,
    final nEqu=nHp,
    final nPumHeaWatPri=nPumHeaWatPri,
    final nPumChiWatPri=nPumChiWatPri,
    final yPumHeaWatPriSet=yPumHeaWatPriSet,
    final yPumChiWatPriSet=yPumChiWatPriSet) "Primary pump speed control"
    annotation (Placement(transformation(extent={{190,70},{210,90}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.ControlDifferentialPressure ctlPumHeaWatSec(
    final have_senDpRemWir=have_senDpHeaWatRemWir,
    nPum=nPumHeaWatSec,
    final nSenDpRem=nSenDpHeaWatRem,
    final y_min=yPumHeaWatSec_min,
    final k=kPumHeaWatSec,
    final Ti=TiPumHeaWatSec) if have_pumHeaWatSec
    "Secondary HW pump speed control"
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));

  Buildings.Templates.Plants.Controls.Pumps.Generic.ControlDifferentialPressure ctlPumChiWatSec(
    final have_senDpRemWir=have_senDpChiWatRemWir,
    final nPum=nPumChiWatSec,
    final nSenDpRem=nSenDpChiWatRem,
    final y_min=yPumChiWatSec_min,
    final k=kPumChiWatSec,
    final Ti=TiPumChiWatSec) if have_chiWat and have_pumChiWatSec
    "Secondary CHW pump speed control"
    annotation (Placement(transformation(extent={{190,-30},{210,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput TSupSet[nHp](
    each final unit="K",
    each final quantity="ThermodynamicTemperature",
    each displayUnit="degC")
    "Active HP supply temperature setpoint"
    annotation (Placement(transformation(extent={{260,-140},{300,-100}}),
        iconTransformation(extent={{200,-260},{240,-220}})));

  Buildings.Controls.OBC.CDL.Reals.Switch swiTSupSet[nHp]
    if have_heaWat and have_chiWat
    "Select supply temperature setpoint based on operating mode"
    annotation (Placement(transformation(extent={{190,-130},{210,-110}})));

  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator repTChiWatSupSet(
    final nout=nHp)
    if have_chiWat
    "Replicate CHWST setpoint"
    annotation (Placement(transformation(extent={{150,-150},{170,-130}})));

  Buildings.Controls.OBC.CDL.Routing.RealScalarReplicator repTHeaWatSupSet(
    final nout=nHp)
    if have_heaWat
    "Replicate HWST setpoint"
    annotation (Placement(transformation(extent={{150,-110},{170,-90}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatPriSup(
    final unit="K",
    displayUnit="degC")
    if have_chiWat "Primary CHW return temperature"
    annotation (Placement(transformation(extent={{-300,0},{-260,40}}),
      iconTransformation(extent={{-240,-60},{-200,-20}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaWatSecSup(
    final unit="K",
    displayUnit="degC")
    if have_chiWat and have_senTHeaWatSecSup
    "Secondary HW supply temperature"
    annotation (Placement(transformation(extent={{-300,-80},{-260,-40}}),
      iconTransformation(extent={{-240,-120},{-200,-80}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TChiWatSecSup(
    final unit="K",
    displayUnit="degC")
    if have_chiWat and have_senTChiWatSecSup
    "Secondary CHW supply temperature"
    annotation (Placement(transformation(extent={{-300,-140},{-260,-100}}),
      iconTransformation(extent={{-240,-180},{-200,-140}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractSignal pasTHeaWatSupSet(
    final nin=nHp,
    final nout=nHp)
    if have_heaWat and not have_chiWat
    "Direct pass through for HWST setpoint"
    annotation (Placement(transformation(extent={{220,-110},{240,-90}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractSignal pasTChiWatSupSet(
    final nin=nHp,
    final nout=nHp)
    if have_chiWat and not have_heaWat
    "Direct pass through for CHWST setpoint"
    annotation (Placement(transformation(extent={{220,-150},{240,-130}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeControl opeModCon(
      T_CHWSupSetMax=TChiWatSupSet_max)
    "Compute operation mode index signal"
    annotation (Placement(transformation(extent={{-200,340},{-180,384}})));

  Buildings.Controls.OBC.HeatPumpPlant.OperationModeProcess opeModPro
    "Enable operation mode process signal for plants and external energy sources"
    annotation (Placement(transformation(extent={{-108,352},{-92,372}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uProCom
    "Staging process completion signal" annotation (Placement(transformation(extent={{-300,320},{-260,360}}),
      iconTransformation(extent={{-240,260},{-200,300}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput yOpeMod
    "Operation mode"
    annotation (Placement(transformation(extent={{260,100},{300,140}}),
        iconTransformation(extent={{200,-20},{240,20}})));

  Buildings.Templates.Plants.Controls.Enabling.Enable PlaEna(
    final typ=Buildings.Templates.Plants.Controls.Types.Application.Heating,
    final TOutLck=TOutHeaWatLck,
    final dTOutLck=dTOutLck,
    final dtReq=dtReqDis,
    final dtRun=dtRunEna,
    final have_inpSch=have_inpSch,
    final nReqIgn=nReqIgnHeaWat,
    final sch=schHea) if have_heaWat
    "Plant mode enable"
    annotation (Placement(transformation(extent={{-198,244},{-178,264}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput u1Sch
    if have_inpSch
    "Enable via schedule"
    annotation (Placement(transformation(extent={{-300,270},{-260,310}}),
      iconTransformation(extent={{-240,300},{-200,340}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nReqPlaHeaWat
    if have_heaWat
    "Number of HW plant requests"
    annotation (Placement(transformation(extent={{-300,240},{-260,280}}),
      iconTransformation(extent={{-240,120},{-200,160}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput nReqPlaChiWat
    if have_chiWat
    "Number of CHW plant requests"
    annotation (Placement(transformation(extent={{-300,210},{-260,250}}),
      iconTransformation(extent={{-240,100},{-200,140}})));

  Buildings.Templates.Plants.Controls.StagingRotation.StageChangeCommand chaStaCoo(
    final have_inpPlrSta=false,
    final plrSta=plrSta,
    final staEqu=staEqu,
    final capEqu=capHeaHp_nominal,
    final dtRun=dtRunSta,
    final cp_default=cp_default,
    final rho_default=rho_default) if have_heaWat
    "Generate cooling stage transition command"
    annotation (Placement(transformation(extent={{-38,36},{-18,60}})));

  Buildings.Controls.OBC.CDL.Logical.Switch logSwiUp
    annotation (Placement(transformation(extent={{10,100},{30,120}})));

  Buildings.Controls.OBC.CDL.Logical.Switch logSwiDow
    annotation (Placement(transformation(extent={{10,60},{30,80}})));

  Buildings.Controls.OBC.CDL.Integers.LessThreshold intLesThr
    annotation (Placement(transformation(extent={{-110,100},{-90,120}})));

  Buildings.Controls.OBC.CDL.Integers.Add addInt
    annotation (Placement(transformation(extent={{-240,244},{-220,264}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre
    annotation (Placement(transformation(extent={{68,266},{88,286}})));

  Buildings.Controls.OBC.CDL.Logical.Pre pre1
    annotation (Placement(transformation(extent={{84,-10},{104,10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput TOut(
    final unit="K",
    final quantity="ThermodynamicTemperature",
    displayUnit="degC")
    "Outdoor air temperature"
    annotation (Placement(transformation(extent={{-300,60},{-260,100}}),
      iconTransformation(extent={{-240,20},{-200,60}})));

equation
  connect(avaSta.y1, idxSta.u1AvaSta) annotation (Line(points={{-88,330},{-56,
          330},{-56,354},{-12,354}}, color={255,0,255}));
  connect(idxSta.y, enaEqu.uSta)
    annotation (Line(points={{12,360},{38,360}}, color={255,127,0}));
  connect(seqEve.y1, y1Hp) annotation (Line(points={{162,310},{238,310},{238,
          380},{280,380}}, color={255,0,255}));
  connect(seqEve.y1Hea, y1HeaHp) annotation (Line(points={{162,308},{240,308},{
          240,360},{280,360}}, color={255,0,255}));
  connect(seqEve.y1ValHeaWatOutIso, y1ValHeaWatHpOutIso) annotation (Line(
        points={{162,298},{240,298},{240,300},{280,300}}, color={255,0,255}));
  connect(seqEve.y1ValHeaWatInlIso, y1ValHeaWatHpInlIso) annotation (Line(
        points={{162,300},{242,300},{242,320},{280,320}}, color={255,0,255}));
  connect(seqEve.y1ValChiWatInlIso, y1ValChiWatHpInlIso) annotation (Line(
        points={{162,296},{238,296},{238,280},{280,280}}, color={255,0,255}));
  connect(seqEve.y1ValChiWatOutIso, y1ValChiWatHpOutIso) annotation (Line(
        points={{162,294},{236,294},{236,260},{280,260}}, color={255,0,255}));
  connect(idxSta.y, chaStaHea.uSta) annotation (Line(points={{12,360},{20,360},
          {20,340},{-46,340},{-46,330},{-42,330}}, color={255,127,0}));
  connect(avaSta.y1, chaStaHea.u1AvaSta) annotation (Line(points={{-88,330},{-56,
          330},{-56,326},{-42,326}}, color={255,0,255}));
  connect(sorRunTimHea.yIdx, enaEqu.uIdxAltSor) annotation (Line(points={{-18,
          284},{32,284},{32,366},{38,366}}, color={255,127,0}));
  connect(enaEqu.y1, seqEve.u1Hea) annotation (Line(points={{62,360},{80,360},{
          80,310},{138,310}}, color={255,0,255}));
  connect(y1HeaHp, y1HeaPre.u)
    annotation (Line(points={{280,360},{232,360}},color={255,0,255}));
  connect(y1HeaPre.y, avaEquHeaCoo.u1Hea)
    annotation (Line(points={{208,360},{160,360},{160,378},{-156,378},{-156,214},{-154,214}},
      color={255,0,255}));
  connect(avaEquHeaCoo.y1Hea, avaSta.u1Ava) annotation (Line(points={{-130,226},
          {-120,226},{-120,330},{-112,330}}, color={255,0,255}));
  connect(avaEquHeaCoo.y1Hea, enaEqu.u1Ava) annotation (Line(points={{-130,226},
          {36,226},{36,354},{38,354}}, color={255,0,255}));
  connect(avaEquHeaCoo.y1Hea, sorRunTimHea.u1Ava)
    annotation (Line(points={{-130,226},{-120,226},{-120,284},{-42,284}},color={255,0,255}));
  connect(staPumChiWatPri.y1, y1PumChiWatPri)
    annotation (Line(points={{212,180},{280,180}},color={255,0,255}));
  connect(staPumChiWatPri.y1_actual, seqEve.u1PumChiWatPri_actual) annotation (
      Line(points={{212,186},{220,186},{220,262},{122,262},{122,296},{138,296}},
        color={255,0,255}));
  connect(seqEve.y1PumChiWatPri, staPumChiWatPri.u1Pum) annotation (Line(points=
         {{162,288},{178,288},{178,178},{188,178}}, color={255,0,255}));
  connect(u1PumChiWatPri_actual, staPumChiWatPri.u1Pum_actual)
    annotation (Line(points={{-280,180},{170,180},{170,176},{188,176}},color={255,0,255}));
  connect(u1PumHeaWatPri_actual, staPumHeaWatPri.u1Pum_actual)
    annotation (Line(points={{-280,200},{128,200},{128,196},{138,196}},color={255,0,255}));
  connect(staPumHeaWatPri.y1_actual, seqEve.u1PumHeaWatPri_actual) annotation (
      Line(points={{162,206},{164,206},{164,260},{120,260},{120,298},{138,298}},
        color={255,0,255}));
  connect(staPumHeaWatSec.y1, y1PumHeaWatSec)
    annotation (Line(points={{162,160},{280,160}},color={255,0,255}));
  connect(staPumChiWatSec.y1, y1PumChiWatSec)
    annotation (Line(points={{212,140},{280,140}},color={255,0,255}));
  connect(u1PumHeaWatSec_actual, staPumHeaWatSec.u1Pum_actual)
    annotation (Line(points={{-280,160},{120,160},{120,156},{138,156}},color={255,0,255}));
  connect(u1PumChiWatSec_actual, staPumChiWatSec.u1Pum_actual)
    annotation (Line(points={{-280,140},{180,140},{180,136},{188,136}},color={255,0,255}));
  connect(staPumHeaWatPri.y1, y1PumHeaWatPri)
    annotation (Line(points={{162,200},{216,200},{216,200},{280,200}},color={255,0,255}));
  connect(staPumChiWatSec.y1_actual, seqEve.u1PumChiWatSec_actual) annotation (
      Line(points={{212,146},{222,146},{222,266},{126,266},{126,290},{138,290}},
        color={255,0,255}));
  connect(seqEve.y1PumHeaWatPri, staPumHeaWatPri.u1Pum) annotation (Line(points=
         {{162,290},{162,220},{130,220},{130,198},{138,198}}, color={255,0,255}));
  connect(staPumHeaWatSec.y1_actual, seqEve.u1PumHeaWatSec_actual) annotation (
      Line(points={{162,166},{166,166},{166,264},{124,264},{124,292},{138,292}},
        color={255,0,255}));
  connect(VHeaWatSec_flow, staPumHeaWatSec.V_flow)
    annotation (Line(points={{-280,-100},{-156,-100},{-156,152},{138,152}},color={0,0,127}));
  connect(VChiWatSec_flow, staPumChiWatSec.V_flow)
    annotation (Line(points={{-280,-160},{-154,-160},{-154,132},{188,132}},color={0,0,127}));
  connect(THeaWatPriRet, THeaWatRet.u)
    annotation (Line(points={{-280,60},{-240,60},{-240,40},{-232,40}},
                                                  color={0,0,127}));
  connect(THeaWatRet.y, chaStaHea.TRet) annotation (Line(points={{-208,40},{-168,
          40},{-168,306},{-50,306},{-50,314},{-42,314}}, color={0,0,127}));
  connect(THeaWatSecRet, THeaWatRet.uPh) annotation (Line(points={{-280,-80},{-240,
          -80},{-240,34},{-232,34}}, color={0,0,127}));
  connect(VHeaWatPri_flow, VHeaWat_flow.u)
    annotation (Line(points={{-280,40},{-244,40},{-244,20},{-202,20}},
                                                  color={0,0,127}));
  connect(VHeaWat_flow.y, chaStaHea.V_flow) annotation (Line(points={{-178,20},
          {-166,20},{-166,304},{-48,304},{-48,312},{-42,312}}, color={0,0,127}));
  connect(VHeaWatSec_flow, VHeaWat_flow.uPh) annotation (Line(points={{-280,-100},
          {-206,-100},{-206,14},{-202,14}}, color={0,0,127}));
  connect(TChiWatPriRet, TChiWatRet.u)
    annotation (Line(points={{-280,-20},{-232,-20}},color={0,0,127}));
  connect(TChiWatSecRet, TChiWatRet.uPh) annotation (Line(points={{-280,-140},{-238,
          -140},{-238,-26},{-232,-26}},      color={0,0,127}));
  connect(VChiWatPri_flow, VChiWat_flow.u)
    annotation (Line(points={{-280,-40},{-202,-40}},color={0,0,127}));
  connect(VChiWatSec_flow, VChiWat_flow.uPh) annotation (Line(points={{-280,-160},
          {-204,-160},{-204,-46},{-202,-46}}, color={0,0,127}));
  connect(seqEve.y1ValHeaWatInlIso, staPumHeaWatPri.u1ValInlIso) annotation (
      Line(points={{162,300},{170,300},{170,216},{134,216},{134,204},{138,204}},
        color={255,0,255}));
  connect(seqEve.y1ValHeaWatOutIso, staPumHeaWatPri.u1ValOutIso) annotation (
      Line(points={{162,298},{168,298},{168,218},{132,218},{132,202},{138,202}},
        color={255,0,255}));
  connect(seqEve.y1ValChiWatInlIso, staPumChiWatPri.u1ValInlIso) annotation (
      Line(points={{162,296},{182,296},{182,184},{188,184}}, color={255,0,255}));
  connect(seqEve.y1ValChiWatOutIso, staPumChiWatPri.u1ValOutIso) annotation (
      Line(points={{162,294},{180,294},{180,182},{188,182}}, color={255,0,255}));
  connect(u1Hp_actual, sorRunTimHea.u1Run)
    annotation (Line(points={{-280,320},{-130,320},{-130,296},{-42,296}},
                                                                       color={255,0,255}));
  connect(y1Hp, y1HpPre.u)
    annotation (Line(points={{280,380},{202,380}},color={255,0,255}));
  connect(y1HpPre.y, avaEquHeaCoo.u1)
    annotation (Line(points={{178,380},{-158,380},{-158,226},{-154,226}},color={255,0,255}));
  connect(idxSta.y, comSta.uSta) annotation (Line(points={{12,360},{20,360},{20,
          248},{-46,248},{-46,264},{-42,264}}, color={255,127,0}));
  connect(u1Hp_actual, comSta.u1_actual) annotation (Line(points={{-280,320},{-130,
          320},{-130,256},{-42,256}}, color={255,0,255}));
  connect(y1HpPre.y, comSta.u1) annotation (Line(points={{178,380},{-60,380},{-60,
          260},{-42,260}}, color={255,0,255}));
  connect(comSta.y1, chaStaHea.u1StaPro) annotation (Line(points={{-18,254},{-10,
          254},{-10,306},{-44,306},{-44,322},{-42,322}}, color={255,0,255}));
  connect(resHeaWat.dpSet, dpHeaWatRemSet)
    annotation (Line(points={{112,246},{242,246},{242,-60},{280,-60}},color={0,0,127}));
  connect(resChiWat.dpSet, dpChiWatRemSet)
    annotation (Line(points={{112,-34},{238,-34},{238,-80},{280,-80}},color={0,0,127}));
  connect(nReqResHeaWat,resHeaWat.nReqRes)
    annotation (Line(points={{-280,-340},{76,-340},{76,246},{88,246}},color={255,127,0}));
  connect(nReqResChiWat,resChiWat.nReqRes)
    annotation (Line(points={{-280,-360},{80,-360},{80,-34},{88,-34}},color={255,127,0}));
  connect(comSta.y1, resHeaWat.u1StaPro) annotation (Line(points={{-18,254},{-10,
          254},{-10,234},{88,234}}, color={255,0,255}));
  connect(resHeaWat.TSupSet, chaStaHea.TSupSet) annotation (Line(points={{112,
          234},{118,234},{118,220},{-52,220},{-52,316},{-42,316}}, color={0,0,
          127}));
  connect(ctlPumPri.yPumHeaWatPriHdr, yPumHeaWatPriHdr)
    annotation (Line(points={{212,86},{222,86},{222,100},{280,100}},color={0,0,127}));
  connect(ctlPumPri.yPumChiWatPriHdr, yPumChiWatPriHdr)
    annotation (Line(points={{212,82},{220,82},{220,80},{280,80}},color={0,0,127}));
  connect(ctlPumPri.yPumHeaWatPriDed, yPumHeaWatPriDed)
    annotation (Line(points={{212,78},{220,78},{220,60},{280,60},{280,60}},color={0,0,127}));
  connect(ctlPumPri.yPumChiWatPriDed, yPumChiWatPriDed)
    annotation (Line(points={{212,74},{216,74},{216,40},{280,40}},color={0,0,127}));
  connect(staPumHeaWatPri.y1, ctlPumPri.u1PumHeaWatPri)
    annotation (Line(points={{162,200},{172,200},{172,86},{188,86}},color={255,0,255}));
  connect(staPumChiWatPri.y1, ctlPumPri.u1PumChiWatPri)
    annotation (Line(points={{212,180},{220,180},{220,100},{184,100},{184,80},{188,
          80}},
      color={255,0,255}));
  connect(seqEve.y1Hea, ctlPumPri.u1Hea) annotation (Line(points={{162,308},{
          174,308},{174,74},{188,74}}, color={255,0,255}));
  connect(ctlPumHeaWatSec.y, yPumHeaWatSec)
    annotation (Line(points={{161.8,0},{280,0}},                  color={0,0,127}));
  connect(ctlPumChiWatSec.y, yPumChiWatSec)
    annotation (Line(points={{211.8,-20},{280,-20}},                color={0,0,127}));
  connect(u1PumHeaWatSec_actual, ctlPumHeaWatSec.y1_actual)
    annotation (Line(points={{-280,160},{120,160},{120,8},{138,8}},  color={255,0,255}));
  connect(u1PumChiWatSec_actual, ctlPumChiWatSec.y1_actual)
    annotation (Line(points={{-280,140},{180,140},{180,-12},{188,-12}},
                                                                   color={255,0,255}));
  connect(resChiWat.dpSet, ctlPumChiWatSec.dpRemSet)
    annotation (Line(points={{112,-34},{178,-34},{178,-16},{188,-16}},
                                                                  color={0,0,127}));
  connect(dpHeaWatRem, ctlPumHeaWatSec.dpRem)
    annotation (Line(points={{-280,-200},{130,-200},{130,0},{138,0}},  color={0,0,127}));
  connect(resHeaWat.dpSet, ctlPumHeaWatSec.dpRemSet)
    annotation (Line(points={{112,246},{122,246},{122,4},{138,4}},  color={0,0,127}));
  connect(dpHeaWatLoc, ctlPumHeaWatSec.dpLoc)
    annotation (Line(points={{-280,-240},{134,-240},{134,-8},{138,-8}},color={0,0,127}));
  connect(dpHeaWatLocSet, ctlPumHeaWatSec.dpLocSet)
    annotation (Line(points={{-280,-220},{132,-220},{132,-4},{138,-4}},color={0,0,127}));
  connect(dpChiWatRem, ctlPumChiWatSec.dpRem)
    annotation (Line(points={{-280,-260},{180,-260},{180,-20},{188,-20}},
                                                                     color={0,0,127}));
  connect(dpChiWatLocSet, ctlPumChiWatSec.dpLocSet)
    annotation (Line(points={{-280,-280},{182,-280},{182,-24},{188,-24}},
                                                                       color={0,0,127}));
  connect(dpChiWatLoc, ctlPumChiWatSec.dpLoc)
    annotation (Line(points={{-280,-300},{184,-300},{184,-28},{188,-28}},
                                                                       color={0,0,127}));
  connect(u1AvaHp.y, avaEquHeaCoo.u1Ava) annotation (Line(points={{-178,220},{
          -154,220}},                       color={255,0,255}));
  connect(repTChiWatSupSet.y, swiTSupSet.u3) annotation (Line(points={{172,-140},
          {178,-140},{178,-128},{188,-128}}, color={0,0,127}));
  connect(repTHeaWatSupSet.y, swiTSupSet.u1) annotation (Line(points={{172,-100},
          {178,-100},{178,-112},{188,-112}}, color={0,0,127}));
  connect(resChiWat.TSupSet, repTChiWatSupSet.u) annotation (Line(points={{112,-46},
          {116,-46},{116,-140},{148,-140}}, color={0,0,127}));
  connect(resHeaWat.TSupSet, repTHeaWatSupSet.u) annotation (Line(points={{112,234},
          {118,234},{118,-100},{148,-100}}, color={0,0,127}));
  connect(seqEve.y1Hea, swiTSupSet.u2) annotation (Line(points={{162,308},{176,
          308},{176,-120},{188,-120}}, color={255,0,255}));
  connect(swiTSupSet.y, TSupSet) annotation (Line(points={{212,-120},{242,-120},
          {242,-120},{280,-120}}, color={0,0,127}));
  connect(pasTChiWatSupSet.y, TSupSet) annotation (Line(points={{242,-140},{250,
          -140},{250,-120},{280,-120}}, color={0,0,127}));
  connect(pasTHeaWatSupSet.y, TSupSet) annotation (Line(points={{242,-100},{250,
          -100},{250,-120},{280,-120}}, color={0,0,127}));
  connect(repTChiWatSupSet.y, pasTChiWatSupSet.u)
    annotation (Line(points={{172,-140},{218,-140}}, color={0,0,127}));
  connect(repTHeaWatSupSet.y, pasTHeaWatSupSet.u)
    annotation (Line(points={{172,-100},{218,-100}}, color={0,0,127}));
  connect(resChiWat.TSupSet, TChiWatSupSet) annotation (Line(points={{112,-46},
          {116,-46},{116,-180},{280,-180}}, color={0,0,127}));
  connect(resHeaWat.TSupSet, THeaWatSupSet) annotation (Line(points={{112,234},
          {118,234},{118,-160},{280,-160}}, color={0,0,127}));
  connect(opeModCon.yOpeMod, opeModPro.uOpeMod)
    annotation (Line(points={{-178,362},{-110,362}}, color={255,127,0}));
  connect(opeModPro.yHru, idxSta.u1Lea)
    annotation (Line(points={{-90,366},{-12,366}}, color={255,0,255}));
  connect(opeModPro.yHru, staPumHeaWatSec.u1Pla) annotation (Line(points={{-90,
          366},{-80,366},{-80,168},{138,168}}, color={255,0,255}));
  connect(uHotTanCha, opeModCon.uHotTanCha) annotation (Line(points={{-280,380},
          {-240,380},{-240,378},{-202,378}}, color={255,0,255}));
  connect(uCooTanCha, opeModCon.uCooTanCha) annotation (Line(points={{-280,360},
          {-240,360},{-240,374},{-202,374}}, color={255,0,255}));
  connect(uProCom, opeModCon.uProCom) annotation (Line(points={{-280,340},{-230,
          340},{-230,382},{-202,382}}, color={255,0,255}));
  connect(THeaWatPriRet, opeModCon.THeaRet) annotation (Line(points={{-280,60},
          {-240,60},{-240,108},{-216,108},{-216,362},{-202,362}}, color={0,0,
          127}));
  connect(VHeaWatPri_flow, opeModCon.VWatHot_flow) annotation (Line(points={{
          -280,40},{-244,40},{-244,104},{-216,104},{-216,358},{-202,358}},
        color={0,0,127}));
  connect(TChiWatPriSup, opeModCon.TChiSup) annotation (Line(points={{-280,20},
          {-236,20},{-236,240},{-212,240},{-212,354},{-202,354}}, color={0,0,
          127}));
  connect(TChiWatPriRet, opeModCon.TChiRet) annotation (Line(points={{-280,-20},
          {-240,-20},{-240,220},{-206,220},{-206,346},{-202,346}}, color={0,0,
          127}));
  connect(VChiWatPri_flow, opeModCon.VWatChi_flow) annotation (Line(points={{
          -280,-40},{-240,-40},{-240,220},{-204,220},{-204,342},{-202,342}},
        color={0,0,127}));
  connect(opeModCon.yOpeMod, yOpeMod) annotation (Line(points={{-178,362},{-124,
          362},{-124,128},{230,128},{230,120},{280,120}}, color={255,127,0}));
  connect(opeModPro.yHru, staPumChiWatSec.u1Pla) annotation (Line(points={{-90,
          366},{-80,366},{-80,148},{188,148}}, color={255,0,255}));
  connect(comSta.y1, resChiWat.u1StaPro) annotation (Line(points={{-18,254},{60,
          254},{60,-46},{88,-46}}, color={255,0,255}));
  connect(u1Sch,PlaEna. u1Sch)
    annotation (Line(points={{-280,290},{-280,288},{-202,288},{-202,258},{-200,
          258}},                                     color={255,0,255}));
  connect(chaStaCoo.y1Up, logSwiUp.u3) annotation (Line(points={{-16,52},{-4,52},
          {-4,102},{8,102}}, color={255,0,255}));
  connect(chaStaCoo.y1Dow, logSwiDow.u3) annotation (Line(points={{-16,44},{2,
          44},{2,62},{8,62}}, color={255,0,255}));
  connect(chaStaHea.y1Up, logSwiUp.u1) annotation (Line(points={{-18,324},{6,
          324},{6,118},{8,118}}, color={255,0,255}));
  connect(chaStaHea.y1Dow, logSwiDow.u1) annotation (Line(points={{-18,316},{2,
          316},{2,78},{8,78}}, color={255,0,255}));
  connect(PlaEna.y1, opeModCon.uPlaEna) annotation (Line(points={{-176,254},{
          -172,254},{-172,300},{-224,300},{-224,370},{-202,370}},
                                            color={255,0,255}));
  connect(enaEqu.y1, seqEve.u1Coo) annotation (Line(points={{62,360},{80,360},{
          80,306},{138,306}}, color={255,0,255}));
  connect(opeModCon.yOpeMod, intLesThr.u) annotation (Line(points={{-178,362},{
          -124,362},{-124,110},{-112,110}}, color={255,127,0}));
  connect(intLesThr.y, logSwiUp.u2)
    annotation (Line(points={{-88,110},{8,110}}, color={255,0,255}));
  connect(intLesThr.y, logSwiDow.u2) annotation (Line(points={{-88,110},{-12,
          110},{-12,70},{8,70}}, color={255,0,255}));
  connect(logSwiUp.y, idxSta.u1Up) annotation (Line(points={{32,110},{42,110},{
          42,344},{-20,344},{-20,362},{-12,362}}, color={255,0,255}));
  connect(logSwiDow.y, idxSta.u1Dow) annotation (Line(points={{32,70},{46,70},{
          46,348},{-16,348},{-16,358},{-12,358}}, color={255,0,255}));
  connect(idxSta.y, chaStaCoo.uSta) annotation (Line(points={{12,360},{20,360},
          {20,248},{-46,248},{-46,58},{-40,58}}, color={255,127,0}));
  connect(avaSta.y1, chaStaCoo.u1AvaSta) annotation (Line(points={{-88,330},{-56,
          330},{-56,54},{-40,54}}, color={255,0,255}));
  connect(comSta.y1, chaStaCoo.u1StaPro) annotation (Line(points={{-18,254},{-10,
          254},{-10,234},{-60,234},{-60,50},{-40,50}}, color={255,0,255}));
  connect(resChiWat.TSupSet, chaStaCoo.TSupSet) annotation (Line(points={{112,
          -46},{116,-46},{116,-56},{-52,-56},{-52,44},{-40,44}}, color={0,0,127}));
  connect(TChiWatRet.y, chaStaCoo.TRet) annotation (Line(points={{-208,-20},{
          -60,-20},{-60,42},{-40,42}}, color={0,0,127}));
  connect(VChiWat_flow.y, chaStaCoo.V_flow) annotation (Line(points={{-178,-40},
          {-56,-40},{-56,40},{-40,40}}, color={0,0,127}));
  connect(resChiWat.TSupSet, opeModCon.TChiSupSet) annotation (Line(points={{
          112,-46},{116,-46},{116,-56},{-52,-56},{-52,60},{-208,60},{-208,350},
          {-202,350}}, color={0,0,127}));
  connect(resHeaWat.TSupSet, opeModCon.THeaSupSet) annotation (Line(points={{
          112,234},{118,234},{118,220},{-52,220},{-52,278},{-218,278},{-218,366},
          {-202,366}}, color={0,0,127}));
  connect(nReqPlaHeaWat, addInt.u1)
    annotation (Line(points={{-280,260},{-242,260}}, color={255,127,0}));
  connect(nReqPlaChiWat, addInt.u2) annotation (Line(points={{-280,230},{-280,
          228},{-250,228},{-250,248},{-242,248}},
                                       color={255,127,0}));
  connect(addInt.y,PlaEna. nReqPla) annotation (Line(points={{-218,254},{-200,
          254}},                                             color={255,127,0}));
  connect(opeModPro.yHru, pre.u) annotation (Line(points={{-90,366},{-80,366},{
          -80,168},{64,168},{64,256},{52,256},{52,276},{66,276}}, color={255,0,
          255}));
  connect(pre.y, resHeaWat.u1Ena)
    annotation (Line(points={{90,276},{88,276},{88,240}}, color={255,0,255}));
  connect(pre1.y, resChiWat.u1Ena) annotation (Line(points={{106,0},{104,0},{
          104,-20},{72,-20},{72,-40},{88,-40}}, color={255,0,255}));
  connect(opeModPro.yHru, pre1.u) annotation (Line(points={{-90,366},{-80,366},
          {-80,168},{82,168},{82,0}}, color={255,0,255}));
  connect(TOut, PlaEna.TOut) annotation (Line(points={{-280,80},{-202,80},{-202,
          250},{-200,250}}, color={0,0,127}));
  annotation (
    defaultComponentName="ctl",
    Icon(
      coordinateSystem(
        preserveAspectRatio=true,
        extent={{-200,-340},{200,340}}),
      graphics={
        Rectangle(
          extent={{-200,340},{200,-340}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-150,390},{150,350}},
          textString="%name",
          textColor={0,0,255})}),
    Diagram(
      coordinateSystem(
        extent={{-260,-400},{260,400}})),
    Documentation(
      info="<html>
<p>
This block implements the sequence of operation for plants with 
water-to-water heat pumps.
Most parts of the sequence of operation are similar to that 
described in ASHRAE, 2021 for chiller plants.
</p>
<p>
The supported plant configurations are enumerated in the table below.<br/>
</p>
<table summary=\"summary\" border=\"1\">
<tr><th>Configuration parameter</th><th>Options</th><th>Notes</th></tr>
<tr><td>Function</td>
<td>
Heating and cooling<br/>
Heating-only<br/>
Cooling-only
</td>
<td>
</td>
</tr>
<tr><td>Type of distribution</td>
<td>
Constant primary-variable secondary centralized
</td>
<td>
\"Centralized secondary pumps\" refers to configurations with a single 
group of secondary pumps that is typically integrated into the plant.<br/>
Distributed secondary pumps with multiple secondary loops served 
by dedicated secondary pumps are currently not supported.<br/>
Options are limited to constant primary distributions because most 
AWHPs on the market use a reverse cycle for defrosting.
This requires maximum primary flow during defrost cycles and hinders
variable primary distributions.<br/>
An option for constant primary-only distributions with ∆p-controlled
variable speed pumps will be added in a next release. 
</td>
</tr>
<tr><td>Type of primary pump arrangement</td>
<td>
Dedicated<br/>
Headered
</td>
<td>It is assumed that the HW and the CHW loops have the 
same type of primary pump arrangement, as specified by this parameter.
</td>
</tr>
<tr><td>Separate dedicated primary CHW pumps</td>
<td>
False<br/>
True
</td>
<td>This option is only available for heating and cooling plants 
with dedicated primary pumps.
If this option is not selected, each AWHP uses
a common dedicated primary pump for HW and CHW. 
Otherwise, each AWHP relies on a separate dedicated HW pump 
and a separate dedicated CHW pump.
</td>
</tr>
<tr><td>Type of primary HW pumps</td>
<td>
Variable speed<br/>
Constant speed
</td>
<td>
For constant primary-variable secondary distributions, the variable
speed primary pumps are commanded at fixed speeds, determined during the
Testing, Adjusting and Balancing phase to provide design AWHP flow in 
heating and cooling modes.
The same intent is achieved with constant speed primary pumps through the 
use of balancing valves.
</td>
</tr>
<tr><td>Type of primary CHW pumps</td>
<td>
Variable speed<br/>
Constant speed
</td>
<td>See the note above on primary HW pumps.</td>
</tr>
</table>
<h4>Details</h4>
<p>
A staging matrix <code>staEqu</code> is required as a parameter. 
See the documentation of 
<a href=\"modelica://Buildings.Templates.Plants.Controls.StagingRotation.EquipmentEnable\">
Buildings.Templates.Plants.Controls.StagingRotation.EquipmentEnable</a>
for the associated definition and requirements.
</p>
<p>
Depending on the plant configuration, the term \"primary HW pumps\"
(and the corresponding variables containing <code>*pumHeaWatPri*</code>)
refers either to primary HW pumps for plants with separate primary
HW and CHW pumps (either headered or dedicated)
or to dedicated primary pumps for plants with common primary pumps
serving both the HW and CHW loops.
</p>
<p>
At its current stage of development, this controller contains no
logic for handling faulted equipment.
It is therefore assumed that any equipment is available at all times.
</p>
<h4>References</h4>
<ul>
<li id=\"ASHRAE2021\">
ASHRAE, 2021. Guideline 36-2021, High-Performance Sequences of Operation
for HVAC Systems. Atlanta, GA.
</li>
</ul>
</html>", revisions="<html>
<ul>
<li>
March 29, 2024, by Antoine Gautier:<br/>
First implementation.
</li>
</ul>
</html>"));
end WaterToWater_enhanced;
