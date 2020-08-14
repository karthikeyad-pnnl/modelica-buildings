within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps;
block Controller
    "Sequences to control hot water pumps in boiler plants"

  parameter Boolean isHeadered = true
    "Flag of headered hot water pumps design: true=headered, false=dedicated"
    annotation (Dialog(group="Plant parameters"));

  parameter Boolean primaryOnly = false
    "True: Plant is primary-only; False: Plant is primary-secondary"
    annotation (Dialog(group="Plant parameters"));

  parameter Boolean variablePrimary = false
    "True: Variable-speed primary pumps; False: Fixed-speed primary pumps"
    annotation (Dialog(group="Plant parameters"));

  parameter Boolean primarySecondaryFlowSensors=true
    "True: Flowrate sensors in primary and secondary loops; False: Flowrate sensor in decoupler"
    annotation (Dialog(tab="Pump control parameters",
      group="Flowrate-based speed regulation",
      enable= speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.flowrate));

  parameter Boolean primarySecondaryTemperatureSensors=true
    "True: Temperature sensors in primary and secondary loops; False: Temperature sensors in boiler supply and secondary loop"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable= speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Integer nPum = 2
    "Total number of hot water pumps"
    annotation (Dialog(group="Plant parameters"));

  parameter Integer nBoi = 2
    "Total number of boilers"
    annotation (Dialog(group="Plant parameters"));

  parameter Integer nSen=2
    "Total number of remote differential pressure sensors"
    annotation (Dialog(group="Plant parameters"));

  parameter Integer numIgnReq=0
    "Number of ignored requests"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable= speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Integer nPum_nominal(
    final max=nPum,
    final min=1) = nPum
    "Total number of pumps that operate at design conditions"
    annotation (Dialog(group="Plant parameters"));

  parameter Real minPumSpe(
    final unit="1",
    displayUnit="1",
    final min=0,
    final max=maxPumSpe) = 0.1
    "Minimum pump speed"
    annotation (Dialog(group="Pump parameters", enable=variablePrimary));

  parameter Real maxPumSpe(
    final unit="1",
    displayUnit="1",
    final min=minPumSpe,
    final max=1) = 1
    "Maximum pump speed"
    annotation (Dialog(group="Pump parameters", enable=variablePrimary));

  parameter Real VHotWat_flow_nominal(
    final min=1e-6,
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate") = 0.5
    "Total plant design hot water flow rate"
    annotation (Dialog(group="Plant parameters"));

  parameter Real boiDesFlo[nBoi](
    final min=1e-6,
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate") = {0.5,0.5}
    "Vector of design flowrates for all boilers in plant"
    annotation (Dialog(group="Plant parameters"));

  parameter Real maxLocDp(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference",
    final min=1e-6) = 5*6894.75
    "Maximum hot water loop local differential pressure setpoint"
    annotation (Dialog(tab="Pump control parameters", group="DP-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.localDP));

  parameter Real minLocDp(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference",
    final min=1e-6) = 5*6894.75
    "Minimum hot water loop local differential pressure setpoint"
    annotation (Dialog(tab="Pump control parameters",
      group="DP-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.localDP));

  parameter Real offTimThr(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 180
    "Threshold to check lead boiler off time"
    annotation (Dialog(tab="Pump control parameters", group="Pump staging parameters"));

  parameter Real timPer(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 600
    "Delay time period for enabling and disabling lag pumps"
    annotation (Dialog(tab="Pump control parameters", group="Pump staging parameters"));

  parameter Real staCon(
    final unit="1",
    displayUnit="1") = -0.03
    "Constant used in the staging equation"
    annotation (Dialog(tab="Pump control parameters", group="Pump staging parameters"));

  parameter Real relFloHys(
    final unit="1",
    displayUnit="1") = 0.01
    "Constant value used in hysteresis for checking relative flow rate"
    annotation (Dialog(tab="Pump control parameters", group="Pump staging parameters"));

  parameter Real delTim(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 900
    "Delay time"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real samPer(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 120
    "Sample period of component"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real triAmo(
    final unit="1",
    displayUnit="1") = -0.02
    "Trim amount"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real resAmo(
    final unit="1",
    displayUnit="1") = 0.03
    "Respond amount"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real maxRes(
    final unit="1",
    displayUnit="1") = 0.06
    "Maximum response per time interval"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real twoReqLimLow(
    final unit="K",
    displayUnit="K",
    final quantity="TemperatureDifference") = 1.2
    "Lower limit of hysteresis loop sending two requests"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real twoReqLimHig(
    final unit="K",
    displayUnit="K",
    final quantity="TemperatureDifference") = 2
    "Higher limit of hysteresis loop sending two requests"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real oneReqLimLow(
    final unit="K",
    displayUnit="K",
    final quantity="TemperatureDifference") = 0.2
    "Lower limit of hysteresis loop sending one request"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real oneReqLimHig(
    final unit="K",
    displayUnit="K",
    final quantity="TemperatureDifference") = 1
    "Higher limit of hysteresis loop sending one request"
    annotation (Dialog(tab="Pump control parameters",
      group="Temperature-based speed regulation",
      enable = speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature));

  parameter Real k(
    final unit="1",
    displayUnit="1",
    final min=0) = 1
    "Gain of controller"
    annotation (Dialog(tab="Pump control parameters", group="PID parameters"));

  parameter Real Ti(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Pump control parameters", group="PID parameters"));

  parameter Real Td(
    final unit="s",
    displayUnit="s",
    final quantity="time",
    final min=0) = 0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Pump control parameters", group="PID parameters"));

  parameter Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes
    speedControlType = Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP
    "Speed regulation method"
    annotation (Dialog(group="Plant parameters", enable=variablePrimary));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uStaUp if not primaryOnly
    "Stage up signal"
    annotation (Placement(transformation(extent={{-320,-210},{-280,-170}}),
      iconTransformation(extent={{-140,70},{-100,110}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uOnOff if not primaryOnly
    "Signal indicating stage change with simultaneous enabling and disabling of boilers"
    annotation (Placement(transformation(extent={{-320,-240},{-280,-200}}),
      iconTransformation(extent={{-140,40},{-100,80}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uHotWatPum[nPum]
    "Hot water pumps operating status"
    annotation (Placement(transformation(extent={{-320,120},{-280,160}}),
      iconTransformation(extent={{-140,220},{-100,260}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPlaEna if not isHeadered
    "Plant enabling status"
    annotation (Placement(transformation(extent={{-320,90},{-280,130}}),
      iconTransformation(extent={{-140,190},{-100,230}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uBoiSta[nBoi] if not
    primaryOnly
    "Boiler status vector"
    annotation (Placement(transformation(extent={{-320,-90},{-280,-50}}),
      iconTransformation(extent={{-140,100},{-100,140}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanInput uPumChaPro if not
    primaryOnly
    "Signal indicating start of pump change process"
    annotation (Placement(transformation(extent={{-320,-330},{-280,-290}}),
      iconTransformation(extent={{-140,10},{-100,50}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uNexEnaBoi if
       not isHeadered
    "Index of next enabled boiler"
    annotation (Placement(transformation(extent={{-320,-360},{-280,-320}}),
      iconTransformation(extent={{-140,-20},{-100,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.IntegerInput uPumLeaLag[nPum] if isHeadered
    "Hot water pump lead-lag order"
    annotation (Placement(transformation(extent={{-320,210},{-280,250}}),
      iconTransformation(extent={{-140,250},{-100,290}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uHotIsoVal[nBoi](
    final unit="1",
    displayUnit="1") if isHeadered
    "Hot water isolation valve status"
    annotation (Placement(transformation(extent={{-320,50},{-280,90}}),
      iconTransformation(extent={{-140,160},{-100,200}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput uMinPriPumSpeCon(
    final unit="1",
    displayUnit="1") if variablePrimary
    "Minimum allowed pump speed for non-condensing boilers"
    annotation (Placement(transformation(extent={{-320,-500},{-280,-460}}),
      iconTransformation(extent={{-140,-140},{-100,-100}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHotWat_local(
    final unit="Pa",
    displayUnit="Pa",
    final quantity="PressureDifference") if primaryOnly and variablePrimary
     and localDPRegulated
    "Hot water differential static pressure from local sensor"
    annotation (Placement(transformation(extent={{-320,-400},{-280,-360}}),
      iconTransformation(extent={{-140,-50},{-100,-10}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHotWat_remote[nSen](
    final unit=fill("Pa", nSen),
    final quantity=fill("PressureDifference", nSen)) if primaryOnly and
    variablePrimary and (localDPRegulated or remoteDPRegulated)
    "Hot water differential static pressure from remote sensor"
    annotation (Placement(transformation(extent={{-320,-440},{-280,-400}}),
      iconTransformation(extent={{-140,-80},{-100,-40}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput dpHotWatSet(
    final unit="Pa",
    final quantity="PressureDifference") if primaryOnly and variablePrimary
     and (localDPRegulated or remoteDPRegulated)
    "Hot water differential static pressure setpoint"
    annotation (Placement(transformation(extent={{-320,-470},{-280,-430}}),
      iconTransformation(extent={{-140,-110},{-100,-70}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWat_flow(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate")
    "Hot water flow"
    annotation (Placement(transformation(extent={{-320,-40},{-280,0}}),
      iconTransformation(extent={{-140,130},{-100,170}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWatSec_flow(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate") if not primaryOnly and variablePrimary
     and flowrateRegulated and primarySecondaryFlowSensors
    "Measured hot water flowrate through secondary loop"
    annotation (Placement(transformation(extent={{-320,-540},{-280,-500}}),
      iconTransformation(extent={{-140,-170},{-100,-130}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput VHotWatDec_flow(
    final unit="m3/s",
    displayUnit="m3/s",
    final quantity="VolumeFlowRate") if not primaryOnly and variablePrimary
     and flowrateRegulated and not primarySecondaryFlowSensors
    "Measured hot water flowrate through decoupler"
    annotation (Placement(transformation(extent={{-320,-570},{-280,-530}}),
      iconTransformation(extent={{-140,-200},{-100,-160}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatPri(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature") if not primaryOnly and
    variablePrimary and temperatureRegulated and
    primarySecondaryTemperatureSensors
    "Measured hot water temperature at primary loop supply"
    annotation (Placement(transformation(extent={{-320,-600},{-280,-560}}),
      iconTransformation(extent={{-140,-230},{-100,-190}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatSec(
    final unit="K",
    displayUnit="K",
    final quantity="ThermodynamicTemperature") if not primaryOnly and
    variablePrimary and temperatureRegulated
    "Measured hot water temperature at secondary loop supply"
    annotation (Placement(transformation(extent={{-320,-630},{-280,-590}}),
      iconTransformation(extent={{-140,-260},{-100,-220}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealInput THotWatBoiSup[nBoi](
    final unit=fill("K", nBoi),
    displayUnit=fill("K",nBoi),
    final quantity=fill("ThermodynamicTemperature",nBoi)) if not primaryOnly
     and variablePrimary and temperatureRegulated and not
    primarySecondaryTemperatureSensors
    "Measured hot water temperature at boiler supply"
    annotation (Placement(transformation(extent={{-320,-660},{-280,-620}}),
      iconTransformation(extent={{-140,-290},{-100,-250}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yHotWatPum[nPum]
    "Hot water pump status"
    annotation (Placement(transformation(extent={{280,-20},{320,20}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  Buildings.Controls.OBC.CDL.Interfaces.BooleanOutput yPumChaPro if not
    primaryOnly
    "Signal indicating completion of pump change process"
    annotation (Placement(transformation(extent={{280,50},{320,90}}),
      iconTransformation(extent={{100,120},{140,160}})));

  Buildings.Controls.OBC.CDL.Interfaces.RealOutput yPumSpe[nPum](
    final min=fill(0, nPum),
    final max=fill(1, nPum),
    final unit=fill("1", nPum)) if variablePrimary
    "Hot water pump speed"
    annotation (Placement(transformation(extent={{280,-506},{320,-466}}),
      iconTransformation(extent={{100,-160},{140,-120}})));

//protected
  parameter Boolean remoteDPRegulated = (speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP)
    "Boolean flag for pump speed control with remote differential pressure";

  parameter Boolean localDPRegulated = (speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.localDP)
    "Boolean flag for pump speed control with local differential pressure";

  parameter Boolean temperatureRegulated = (speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    "Boolean flag for pump speed control with temperature readings";

  parameter Boolean flowrateRegulated = (speedControlType == Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.flowrate)
    "Boolean flag for pump speed control with flowrate readings";

  parameter Integer pumInd[nPum]={i for i in 1:nPum}
    "Pump index, {1,2,...,n}";

  Buildings.Controls.OBC.CDL.Continuous.Max max if variablePrimary
    "Pass higher value"
    annotation (Placement(transformation(extent={{134,-496},{154,-476}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_dedicated
    enaDedLeaPum(
    final offTimThr=offTimThr) if not isHeadered
    "Enable lead pump of dedicated pumps"
    annotation (Placement(transformation(extent={{-200,100},{-180,120}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_headered
    enaHeaLeaPum(
    final nBoi=nBoi) if isHeadered
    "Enable lead pump of headered pumps"
    annotation (Placement(transformation(extent={{-200,60},{-180,80}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLag_headered
    enaLagHotPum(
    final nPum=nPum,
    final nPum_nominal=nPum_nominal,
    final timPer=timPer,
    final staCon=staCon,
    final relFloHys=relFloHys,
    final VHotWat_flow_nominal=VHotWat_flow_nominal) if primaryOnly and variablePrimary
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
    final k=k,
    final Ti=Ti,
    final Td=Td) if primaryOnly and variablePrimary and localDPRegulated
    "Hot water pump speed control with local DP sensor"
    annotation (Placement(transformation(extent={{-60,-430},{-40,-410}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_remoteDp
    pumSpeRemDp(
    final nSen=nSen,
    final nPum=nPum,
    final minPumSpe=minPumSpe,
    final maxPumSpe=maxPumSpe,
    final k=k,
    final Ti=Ti,
    final Td=Td) if primaryOnly and variablePrimary and remoteDPRegulated
    "Hot water pump speed control with remote DP sensor"
    annotation (Placement(transformation(extent={{-60,-470},{-40,-450}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch leaPumSta[nPum]
    "Lead pump status"
    annotation (Placement(transformation(extent={{120,180},{140,200}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch nexLagPumSta[nPum] if
    isHeadered
    "Next lag pump status"
    annotation (Placement(transformation(extent={{120,-40},{140,-20}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch lasLagPumSta[nPum] if
    isHeadered
    "Last lag pump status"
    annotation (Placement(transformation(extent={{120,-100},{140,-80}})));

  Buildings.Controls.OBC.CDL.Logical.Or enaPum[nPum] if isHeadered
    "Hot water pump status"
    annotation (Placement(transformation(extent={{180,-40},{200,-20}})));

  Buildings.Controls.OBC.CDL.Logical.And pumSta[nPum] if isHeadered
    "Hot water pump status"
    annotation (Placement(transformation(extent={{180,-100},{200,-80}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch addPum[nPum] if isHeadered
    "Add pump"
    annotation (Placement(transformation(extent={{240,-10},{260,10}})));

  Buildings.Controls.OBC.CDL.Logical.LogicalSwitch remPum[nPum] if isHeadered
    "Remove pump"
    annotation (Placement(transformation(extent={{220,-80},{240,-60}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_flow pumSpeFlo(
    final primarySecondarySensors=primarySecondaryFlowSensors,
    final nPum=nPum,
    final minPumSpe=minPumSpe,
    final maxPumSpe=maxPumSpe,
    final k=k,
    final Ti=Ti,
    final Td=Td,
    final VHotWat_flow_nominal=VHotWat_flow_nominal) if not primaryOnly and
    variablePrimary and flowrateRegulated
    "Pump speed control using flow sensors"
    annotation (Placement(transformation(extent={{-60,-514},{-40,-494}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_temperature
    pumSpeTem(
    final primarySecondarySensors=primarySecondaryTemperatureSensors,
    final nBoi=nBoi,
    final nPum=nPum,
    final numIgnReq=numIgnReq,
    final boiDesFlo=boiDesFlo,
    final minPumSpe=minPumSpe,
    final maxPumSpe=maxPumSpe,
    final delTim=delTim,
    final samPer=samPer,
    final triAmo=triAmo,
    final resAmo=resAmo,
    final maxRes=maxRes,
    final twoReqLimLow=twoReqLimLow,
    final twoReqLimHig=twoReqLimHig,
    final oneReqLimLow=oneReqLimLow,
    final oneReqLimHig=oneReqLimHig) if not primaryOnly and variablePrimary
     and temperatureRegulated
    "Pump speed control using temperature sensors"
    annotation (Placement(transformation(extent={{-60,-548},{-40,-528}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToReal booToRea[nBoi] if not
    isHeadered
    "Boolean to Real conversion"
    annotation (Placement(transformation(extent={{-252,-80},{-232,-60}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor extIndSig(
    final nin=nBoi) if not isHeadered "Identify status of lead boiler"
    annotation (Placement(transformation(extent={{-222,-80},{-202,-60}})));

  Buildings.Controls.OBC.CDL.Continuous.GreaterEqualThreshold greEquThr(
    final threshold=1) if not isHeadered "Check if lead boiler is turned on"
    annotation (Placement(transformation(extent={{-192,-80},{-172,-60}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(
    final k=1)
    "Constant one"
    annotation (Placement(transformation(extent={{-274,190},{-254,210}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep(
    final nout=nPum) if isHeadered
    "Replicate integer input"
    annotation (Placement(transformation(extent={{0,220},{20,240}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep(
    final nout=nPum)
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{0,100},{20,120}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep1(
    final nout=nPum) if isHeadered
    "Replicate integer input"
    annotation (Placement(transformation(extent={{0,-60},{20,-40}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep1(
    final nout=nPum) if isHeadered
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{58,18},{78,38}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep2(
    final nout=nPum) if isHeadered
    "Replicate integer input"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep2(
    final nout=nPum) if isHeadered
    "Replicate boolean input"
    annotation (Placement(transformation(extent={{58,-14},{78,6}})));

  Buildings.Controls.OBC.CDL.Routing.RealReplicator reaRep(
    final nout=nPum) if variablePrimary
    "Replicate real input"
    annotation (Placement(transformation(extent={{196,-496},{216,-476}})));

  Buildings.Controls.OBC.CDL.Conversions.IntegerToReal intToRea[nPum] if
    isHeadered
    "Convert integer to real number"
    annotation (Placement(transformation(extent={{-220,220},{-200,240}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor leaPum(
    final nin=nPum) if isHeadered
    "Lead pump index"
    annotation (Placement(transformation(extent={{-80,220},{-60,240}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt if isHeadered
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-40,220},{-20,240}})));

  Buildings.Controls.OBC.CDL.Integers.Sources.Constant pumIndCon[nPum](
    final k=pumInd)
    "Pump index array"
    annotation (Placement(transformation(extent={{-274,160},{-254,180}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu1[nPum]
    "Check lead pump"
    annotation (Placement(transformation(extent={{60,180},{80,200}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor nexLagPum(
    final nin=nPum) if isHeadered
    "Next lag pump"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt1 if isHeadered
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu2[nPum] if isHeadered
    "Check next lag pump"
    annotation (Placement(transformation(extent={{60,-40},{80,-20}})));

  Buildings.Controls.OBC.CDL.Routing.RealExtractor lasLagPum(
    final nin=nPum) if isHeadered
    "Last lag pump"
    annotation (Placement(transformation(extent={{-80,-110},{-60,-90}})));

  Buildings.Controls.OBC.CDL.Conversions.RealToInteger reaToInt2 if isHeadered
    "Convert real input to integer output"
    annotation (Placement(transformation(extent={{-40,-110},{-20,-90}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu3[nPum] if isHeadered
    "Check last lag pump"
    annotation (Placement(transformation(extent={{60,-100},{80,-80}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt[nPum] if
    isHeadered
    "Convert boolean to integer"
    annotation (Placement(transformation(extent={{-250,-130},{-230,-110}})));

  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt(
    final nin=nPum) if isHeadered
    "Sum of integer inputs"
    annotation (Placement(transformation(extent={{-200,-130},{-180,-110}})));

  Buildings.Controls.OBC.CDL.Integers.Add addInt if isHeadered
    "Integer add"
    annotation (Placement(transformation(extent={{-120,-80},{-100,-60}})));

  Buildings.Controls.OBC.CDL.Integers.Equal intEqu4[nPum] if not isHeadered
    "Check next lag pump"
    annotation (Placement(transformation(extent={{-220,-342},{-200,-322}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep3(
    final nout=nPum) if not isHeadered "Integer replicator"
    annotation (Placement(transformation(extent={{-254,-350},{-234,-330}})));

  Buildings.Controls.OBC.CDL.Logical.Or or2[nPum] if not isHeadered
    "Logical Or"
    annotation (Placement(transformation(extent={{66,-326},{86,-306}})));

  Buildings.Controls.OBC.CDL.Logical.And and2[nPum] if not isHeadered
    "Logical And"
    annotation (Placement(transformation(extent={{-34,-346},{-14,-326}})));

  Buildings.Controls.OBC.CDL.Routing.BooleanReplicator booRep3(
    final nout=nPum) if not isHeadered "Boolean replicator"
    annotation (Placement(transformation(extent={{-254,-320},{-234,-300}})));

  Buildings.Controls.OBC.CDL.Logical.And and1[nPum] if not isHeadered
    "Logical And"
    annotation (Placement(transformation(extent={{-170,-294},{-150,-274}})));

  Buildings.Controls.OBC.CDL.Logical.And and3[nPum] if not isHeadered
    "Logical And"
    annotation (Placement(transformation(extent={{-120,-298},{-100,-278}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt1[nPum] if
    isHeadered and (not primaryOnly)
    "Convert boolean to integer"
    annotation (Placement(transformation(extent={{-250,-166},{-230,-146}})));

  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt1(
    final nin=nBoi) if isHeadered and (not primaryOnly)
    "Sum of integer inputs"
    annotation (Placement(transformation(extent={{-200,-166},{-180,-146}})));

  Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger booToInt2[nPum] if
    isHeadered and (not primaryOnly)
    "Convert boolean to integer"
    annotation (Placement(transformation(extent={{-248,-250},{-228,-230}})));

  Buildings.Controls.OBC.CDL.Integers.MultiSum mulSumInt2(
    final nin=nBoi) if isHeadered and (not primaryOnly)
    "Sum of integer inputs"
    annotation (Placement(transformation(extent={{-202,-250},{-182,-230}})));

  Buildings.Controls.OBC.CDL.Logical.Or or1 if not primaryOnly
    "Logical or"
    annotation (Placement(transformation(extent={{-250,-200},{-230,-180}})));

  Buildings.Controls.OBC.CDL.Integers.Add addInt1 if isHeadered and (not primaryOnly)
    "Increase number of enabled boilers by one to initiate pump enable"
    annotation (Placement(transformation(extent={{-130,-170},{-110,-150}})));

  Buildings.Controls.OBC.CDL.Logical.IntegerSwitch intSwi if isHeadered and (not primaryOnly)
    "Integer switch"
    annotation (Placement(transformation(extent={{-96,-200},{-76,-180}})));

  Buildings.Controls.OBC.CDL.Integers.Greater intGre if isHeadered and (not
    primaryOnly)
    "Check if more boilers than pumps are enabled"
    annotation (Placement(transformation(extent={{-40,-200},{-20,-180}})));

  Buildings.Controls.OBC.CDL.Integers.Less intLes if isHeadered and (not
    primaryOnly)
    "Check if less boilers than pumps are enabled"
    annotation (Placement(transformation(extent={{-38,-250},{-18,-230}})));

  Buildings.Controls.OBC.CDL.Logical.Latch lat if not primaryOnly
    "Hold true signal when a pump needs to be enabled for stage change"
    annotation (Placement(transformation(extent={{-200,-200},{-180,-180}})));

  Buildings.Controls.OBC.CDL.Logical.Change cha[nPum] if not primaryOnly
    "Detect change in pump status"
    annotation (Placement(transformation(extent={{180,60},{200,80}})));

  Buildings.Controls.OBC.CDL.Logical.MultiOr mulOr(
    final nu=nPum) if not primaryOnly
    "Compile pump status change signals"
    annotation (Placement(transformation(extent={{210,60},{230,80}})));

  Buildings.Controls.OBC.CDL.Logical.And and4 if isHeadered and (not
    primaryOnly)
    "Initiate the pump enable process"
    annotation (Placement(transformation(extent={{0,-200},{20,-180}})));

  Buildings.Controls.OBC.CDL.Logical.And and5 if isHeadered and (not
    primaryOnly)
    "Initiate the pump disable process"
    annotation (Placement(transformation(extent={{0,-250},{20,-230}})));

  Buildings.Controls.OBC.CDL.Logical.Not not1 if isHeadered and (not
    primaryOnly)                                            "Logical not"
    annotation (Placement(transformation(extent={{50,-250},{70,-230}})));

  Buildings.Controls.OBC.CDL.Routing.IntegerReplicator intRep4(
    final nout=nPum) if not isHeadered
    "Replicate integer input"
    annotation (Placement(transformation(extent={{-4,180},{16,200}})));

  CDL.Logical.Pre                        pre2 if not primaryOnly
    "Logical pre block"
    annotation (Placement(transformation(extent={{240,60},{260,80}})));
  CDL.Logical.Or                        or3[nPum] if not isHeadered
    "Logical Or"
    annotation (Placement(transformation(extent={{172,-324},{192,-304}})));
  CDL.Logical.Sources.Constant con[nPum](k=fill(false, nPum))
    "Constant Boolean False"
    annotation (Placement(transformation(extent={{60,150},{80,170}})));
  CDL.Logical.LogicalSwitch lagPumSta[nPum] if not isHeadered "Lag pump status"
    annotation (Placement(transformation(extent={{-68,-354},{-48,-334}})));
  CDL.Routing.BooleanReplicator booRep4(nout=nPum) if not isHeadered
    "Booleqan replicator"
    annotation (Placement(transformation(extent={{-118,-338},{-98,-318}})));
equation
  connect(enaDedLeaPum.uPlaEna, uPlaEna) annotation (Line(points={{-202,115},{-240,
          115},{-240,110},{-300,110}}, color={255,0,255}));

  connect(uPumLeaLag, intToRea.u)
    annotation (Line(points={{-300,230},{-222,230}}, color={255,127,0}));

  connect(intToRea.y, leaPum.u)
    annotation (Line(points={{-198,230},{-82,230}}, color={0,0,127}));

  connect(conInt.y, leaPum.index)
    annotation (Line(points={{-252,200},{-70,200},{-70,218}}, color={255,127,0}));

  connect(leaPum.y, reaToInt.u)
    annotation (Line(points={{-58,230},{-42,230}},color={0,0,127}));

  connect(reaToInt.y, intRep.u)
    annotation (Line(points={{-18,230},{-2,230}}, color={255,127,0}));

  connect(intRep.y, intEqu1.u1)
    annotation (Line(points={{22,230},{30,230},{30,190},{58,190}}, color={255,127,0}));

  connect(pumIndCon.y, intEqu1.u2)
    annotation (Line(points={{-252,170},{40,170},{40,182},{58,182}},
      color={255,127,0}));

  connect(intEqu1.y, leaPumSta.u2)
    annotation (Line(points={{82,190},{118,190}},  color={255,0,255}));

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
    annotation (Line(points={{-252,170},{40,170},{40,-30},{58,-30}},
      color={255,127,0}));

  connect(intEqu2.y, nexLagPumSta.u2)
    annotation (Line(points={{82,-30},{118,-30}},  color={255,0,255}));

  connect(booRep1.y, nexLagPumSta.u1)
    annotation (Line(points={{80,28},{110,28},{110,-22},{118,-22}},
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
    annotation (Line(points={{-252,170},{40,170},{40,-90},{58,-90}},
      color={255,127,0}));

  connect(intEqu3.y, lasLagPumSta.u2)
    annotation (Line(points={{82,-90},{118,-90}},    color={255,0,255}));

  connect(enaLagHotPum.VHotWat_flow,VHotWat_flow)
    annotation (Line(points={{-202,4},{-266,4},{-266,-20},{-300,-20}},
      color={0,0,127}));

  connect(uHotWatPum,enaLagHotPum.uHotWatPum)
    annotation (Line(points={{-300,140},{-260,140},{-260,-3.8},{-202,-3.8}},
      color={255,0,255}));

  connect(intToRea.y, lasLagPum.u)
    annotation (Line(points={{-198,230},{-160,230},{-160,-100},{-82,-100}},
      color={0,0,127}));

  connect(booRep2.y, lasLagPumSta.u1)
    annotation (Line(points={{80,-4},{90,-4},{90,-82},{118,-82}},
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
    annotation (Line(points={{-62,-412},{-230,-412},{-230,-380},{-300,-380}},
      color={0,0,127}));

  connect(pumSpeLocDp.dpHotWat_remote,dpHotWat_remote)
    annotation (Line(points={{-62,-424},{-200,-424},{-200,-420},{-300,-420}},
      color={0,0,127}));

  connect(pumSpeLocDp.dpHotWatSet,dpHotWatSet)
    annotation (Line(points={{-62,-428},{-220,-428},{-220,-450},{-300,-450}},
      color={0,0,127}));

  connect(dpHotWat_remote,pumSpeRemDp.dpHotWat)
    annotation (Line(points={{-300,-420},{-200,-420},{-200,-460},{-62,-460}},
      color={0,0,127}));

  connect(dpHotWatSet,pumSpeRemDp.dpHotWatSet)
    annotation (Line(points={{-300,-450},{-220,-450},{-220,-468},{-62,-468}},
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

  connect(enaLagHotPum.yUp, booRep1.u)
    annotation (Line(points={{-178,4},{-120,4},{-120,28},{56,28}},  color={255,0,255}));

  connect(enaLagHotPum.yDown, booRep2.u)
    annotation (Line(points={{-178,-4},{56,-4}},
      color={255,0,255}));

  connect(booRep2.y, remPum.u2)
    annotation (Line(points={{80,-4},{90,-4},{90,-70},{218,-70}},
      color={255,0,255}));

  connect(pumSta.y, remPum.u3)
    annotation (Line(points={{202,-90},{210,-90},{210,-78},{218,-78}},
      color={255,0,255}));

  connect(leaPumSta.y, remPum.u1)
    annotation (Line(points={{142,190},{160,190},{160,-62},{218,-62}}, color={255,0,255}));

  connect(enaPum.y, addPum.u1)
    annotation (Line(points={{202,-30},{210,-30},{210,8},{238,8}}, color={255,0,255}));

  connect(booRep1.y, addPum.u2)
    annotation (Line(points={{80,28},{110,28},{110,0},{238,0}},  color={255,0,255}));

  connect(addPum.y,yHotWatPum)
    annotation (Line(points={{262,0},{300,0}}, color={255,0,255}));

  connect(addPum.y,pumSpeLocDp.uHotWatPum)
    annotation (Line(points={{262,0},{270,0},{270,-376},{-80,-376},{-80,-416},{-62,
          -416}},   color={255,0,255}));

  connect(addPum.y,pumSpeRemDp.uHotWatPum)
    annotation (Line(points={{262,0},{270,0},{270,-376},{-80,-376},{-80,-452},{-62,
          -452}},   color={255,0,255}));

  connect(remPum.y, addPum.u3)
    annotation (Line(points={{242,-70},{250,-70},{250,-20},{220,-20},{220,-8},
      {238,-8}},  color={255,0,255}));

  connect(uHotWatPum, booToInt.u)
    annotation (Line(points={{-300,140},{-260,140},{-260,-120},{-252,-120}},
      color={255,0,255}));

  connect(booToInt.y, mulSumInt.u)
    annotation (Line(points={{-228,-120},{-202,-120}}, color={255,127,0}));

  connect(addInt.y, nexLagPum.index)
    annotation (Line(points={{-98,-70},{-70,-70},{-70,-62}}, color={255,127,0}));

  connect(mulSumInt.y, addInt.u2)
    annotation (Line(points={{-178,-120},{-128,-120},{-128,-76},{-122,-76}},
      color={255,127,0}));

  connect(conInt.y, addInt.u1)
    annotation (Line(points={{-252,200},{-140,200},{-140,-64},{-122,-64}},
      color={255,127,0}));

  connect(mulSumInt.y, lasLagPum.index)
    annotation (Line(points={{-178,-120},{-70,-120},{-70,-112}}, color={255,127,0}));

  connect(uHotIsoVal, enaHeaLeaPum.uHotWatIsoVal) annotation (Line(points={{-300,70},
          {-202,70}},                              color={0,0,127}));

  connect(addPum.y,pumSpeFlo. uHotWatPum) annotation (Line(points={{262,0},{270,
          0},{270,-376},{-80,-376},{-80,-499},{-62,-499}}, color={255,0,255}));

  connect(addPum.y, pumSpeTem.uHotWatPum) annotation (Line(points={{262,0},{270,
          0},{270,-376},{-80,-376},{-80,-530},{-62,-530}},
                                     color={255,0,255}));

  connect(VHotWat_flow,pumSpeFlo. VHotWatPri_flow) annotation (Line(points={{-300,
          -20},{-266,-20},{-266,-504},{-62,-504}},      color={0,0,127}));

  connect(VHotWatSec_flow,pumSpeFlo. VHotWatSec_flow) annotation (Line(points={{-300,
          -520},{-240,-520},{-240,-509},{-62,-509}},       color={0,0,127}));

  connect(VHotWatDec_flow,pumSpeFlo. VHotWatDec_flow) annotation (Line(points={{-300,
          -550},{-240,-550},{-240,-509},{-62,-509}},       color={0,0,127}));

  connect(THotWatPri, pumSpeTem.THotWatPri) annotation (Line(points={{-300,-580},
          {-80,-580},{-80,-534},{-62,-534}}, color={0,0,127}));

  connect(THotWatSec, pumSpeTem.THotWatSec) annotation (Line(points={{-300,-610},
          {-76,-610},{-76,-538},{-62,-538}}, color={0,0,127}));

  connect(THotWatBoiSup, pumSpeTem.THotWatBoiSup) annotation (Line(points={{-300,
          -640},{-68,-640},{-68,-546},{-62,-546}}, color={0,0,127}));

  connect(uBoiSta, pumSpeTem.uBoiSta) annotation (Line(points={{-300,-70},{-270,
          -70},{-270,-542},{-62,-542}}, color={255,0,255}));

  connect(uBoiSta, booToRea.u)
    annotation (Line(points={{-300,-70},{-254,-70}}, color={255,0,255}));

  connect(booToRea.y, extIndSig.u)
    annotation (Line(points={{-230,-70},{-224,-70}}, color={0,0,127}));

  connect(conInt.y, extIndSig.index) annotation (Line(points={{-252,200},{-140,200},
          {-140,-88},{-212,-88},{-212,-82}}, color={255,127,0}));

  connect(greEquThr.u, extIndSig.y)
    annotation (Line(points={{-194,-70},{-200,-70}}, color={0,0,127}));

  connect(greEquThr.y, enaDedLeaPum.uLeaBoiSta) annotation (Line(points={{-170,-70},
          {-166,-70},{-166,-42},{-232,-42},{-232,105},{-202,105}}, color={255,0,
          255}));

  connect(reaRep.y, yPumSpe)
    annotation (Line(points={{218,-486},{300,-486}},color={0,0,127}));

  connect(uNexEnaBoi, intRep3.u)
    annotation (Line(points={{-300,-340},{-256,-340}}, color={255,127,0}));

  connect(intRep3.y, intEqu4.u2)
    annotation (Line(points={{-232,-340},{-222,-340}}, color={255,127,0}));

  connect(pumIndCon.y, intEqu4.u1) annotation (Line(points={{-252,170},{40,170},
          {40,-260},{-228,-260},{-228,-332},{-222,-332}}, color={255,127,0}));

  connect(uPumChaPro, booRep3.u)
    annotation (Line(points={{-300,-310},{-256,-310}}, color={255,0,255}));

  connect(and2.y, or2.u2)
    annotation (Line(points={{-12,-336},{12,-336},{12,-324},{64,-324}},
                                                     color={255,0,255}));

  connect(uHotWatPum, and1.u1) annotation (Line(points={{-300,140},{-260,140},{-260,
          -284},{-172,-284}}, color={255,0,255}));

  connect(uBoiSta, and1.u2) annotation (Line(points={{-300,-70},{-270,-70},{-270,
          -292},{-172,-292}}, color={255,0,255}));

  connect(and1.y, and3.u1)
    annotation (Line(points={{-148,-284},{-136,-284},{-136,-288},{-122,-288}},
                                                       color={255,0,255}));

  connect(booRep3.y, and3.u2) annotation (Line(points={{-232,-310},{-176,-310},
          {-176,-300},{-140,-300},{-140,-296},{-122,-296}},color={255,0,255}));

  connect(uBoiSta, booToInt1.u) annotation (Line(points={{-300,-70},{-270,-70},{
          -270,-156},{-252,-156}}, color={255,0,255}));

  connect(booToInt1.y, mulSumInt1.u[1:nPum]) annotation (Line(points={{-228,-156},
          {-202,-156}},                            color={255,127,0}));

  connect(booToInt2.y,mulSumInt2. u[1:nPum]) annotation (Line(points={{-226,-240},
          {-204,-240}},                            color={255,127,0}));

  connect(uHotWatPum, booToInt2.u) annotation (Line(points={{-300,140},{-260,140},
          {-260,-240},{-250,-240}}, color={255,0,255}));

  connect(or1.u1, uStaUp)
    annotation (Line(points={{-252,-190},{-300,-190}}, color={255,0,255}));

  connect(uOnOff, or1.u2) annotation (Line(points={{-300,-220},{-256,-220},{-256,
          -198},{-252,-198}}, color={255,0,255}));

  connect(conInt.y, addInt1.u1) annotation (Line(points={{-252,200},{-140,200},{
          -140,-154},{-132,-154}}, color={255,127,0}));

  connect(mulSumInt1.y, addInt1.u2) annotation (Line(points={{-178,-156},{-154,-156},
          {-154,-166},{-132,-166}}, color={255,127,0}));

  connect(addInt1.y, intSwi.u1) annotation (Line(points={{-108,-160},{-104,-160},
          {-104,-182},{-98,-182}}, color={255,127,0}));

  connect(mulSumInt1.y, intSwi.u3) annotation (Line(points={{-178,-156},{-154,-156},
          {-154,-198},{-98,-198}}, color={255,127,0}));

  connect(intSwi.y, intGre.u1)
    annotation (Line(points={{-74,-190},{-42,-190}}, color={255,127,0}));

  connect(mulSumInt2.y, intGre.u2) annotation (Line(points={{-180,-240},{-72,-240},
          {-72,-198},{-42,-198}}, color={255,127,0}));

  connect(intSwi.y, intLes.u1) annotation (Line(points={{-74,-190},{-56,-190},{-56,
          -240},{-40,-240}}, color={255,127,0}));

  connect(mulSumInt2.y, intLes.u2) annotation (Line(points={{-180,-240},{-72,-240},
          {-72,-248},{-40,-248}}, color={255,127,0}));

  connect(or1.y, lat.u)
    annotation (Line(points={{-228,-190},{-202,-190}}, color={255,0,255}));

  connect(lat.y, intSwi.u2)
    annotation (Line(points={{-178,-190},{-98,-190}}, color={255,0,255}));

  connect(addPum.y, cha.u) annotation (Line(points={{262,0},{270,0},{270,54},{166,
          54},{166,70},{178,70}}, color={255,0,255}));

  connect(cha.y, mulOr.u[1:nPum]) annotation (Line(points={{202,70},{208,70}},
                       color={255,0,255}));

  connect(intGre.y, and4.u1)
    annotation (Line(points={{-18,-190},{-2,-190}}, color={255,0,255}));

  connect(intLes.y, and5.u1)
    annotation (Line(points={{-16,-240},{-2,-240}}, color={255,0,255}));

  connect(uPumChaPro, and5.u2) annotation (Line(points={{-300,-310},{-276,-310},
          {-276,-264},{-8,-264},{-8,-248},{-2,-248}}, color={255,0,255}));

  connect(uPumChaPro, and4.u2) annotation (Line(points={{-300,-310},{-276,-310},
          {-276,-264},{-8,-264},{-8,-198},{-2,-198}}, color={255,0,255}));

  connect(and4.y, booRep1.u) annotation (Line(points={{22,-190},{26,-190},{26,
          28},{56,28}}, color={255,0,255}));

  connect(not1.u, and5.y)
    annotation (Line(points={{48,-240},{22,-240}}, color={255,0,255}));

  connect(not1.y, booRep2.u) annotation (Line(points={{72,-240},{78,-240},{78,
          -216},{50,-216},{50,-4},{56,-4}}, color={255,0,255}));

  connect(conInt.y, intRep4.u) annotation (Line(points={{-252,200},{-12,200},{-12,
          190},{-6,190}}, color={255,127,0}));
  connect(intRep4.y, intEqu1.u1)
    annotation (Line(points={{18,190},{58,190}}, color={255,127,0}));
  connect(mulOr.y, pre2.u)
    annotation (Line(points={{232,70},{238,70}}, color={255,0,255}));
  connect(pre2.y, yPumChaPro)
    annotation (Line(points={{262,70},{300,70}}, color={255,0,255}));
  connect(pre2.y, lat.clr) annotation (Line(points={{262,70},{274,70},{274,-208},
          {-210,-208},{-210,-196},{-202,-196}}, color={255,0,255}));
  connect(max.y, reaRep.u)
    annotation (Line(points={{156,-486},{194,-486}}, color={0,0,127}));
  connect(pumSpeRemDp.yHotWatPumSpe, max.u2) annotation (Line(points={{-38,-460},
          {96,-460},{96,-492},{132,-492}}, color={0,0,127}));
  connect(pumSpeLocDp.yHotWatPumSpe, max.u2) annotation (Line(points={{-38,-420},
          {96,-420},{96,-492},{132,-492}}, color={0,0,127}));
  connect(pumSpeFlo.yHotWatPumSpe, max.u2) annotation (Line(points={{-38,-504},{
          96,-504},{96,-492},{132,-492}}, color={0,0,127}));
  connect(pumSpeTem.yHotWatPumSpe, max.u2) annotation (Line(points={{-38,-538},{
          96,-538},{96,-492},{132,-492}}, color={0,0,127}));
  connect(uMinPriPumSpeCon, max.u1)
    annotation (Line(points={{-300,-480},{132,-480}}, color={0,0,127}));
  connect(or2.y, or3.u2) annotation (Line(points={{88,-316},{152,-316},{152,
          -322},{170,-322}}, color={255,0,255}));
  connect(leaPumSta.y, or3.u1) annotation (Line(points={{142,190},{160,190},{
          160,-314},{170,-314}}, color={255,0,255}));
  connect(or3.y, yHotWatPum) annotation (Line(points={{194,-314},{270,-314},{
          270,0},{300,0}}, color={255,0,255}));
  connect(or3.y, cha.u) annotation (Line(points={{194,-314},{270,-314},{270,54},
          {166,54},{166,70},{178,70}}, color={255,0,255}));
  connect(or3.y, pumSpeLocDp.uHotWatPum) annotation (Line(points={{194,-314},{
          270,-314},{270,-376},{-80,-376},{-80,-416},{-62,-416}}, color={255,0,
          255}));
  connect(or3.y, pumSpeRemDp.uHotWatPum) annotation (Line(points={{194,-314},{
          270,-314},{270,-376},{-80,-376},{-80,-452},{-62,-452}}, color={255,0,
          255}));
  connect(or3.y, pumSpeFlo.uHotWatPum) annotation (Line(points={{194,-314},{270,
          -314},{270,-376},{-80,-376},{-80,-499},{-62,-499}}, color={255,0,255}));
  connect(or3.y, pumSpeTem.uHotWatPum) annotation (Line(points={{194,-314},{270,
          -314},{270,-376},{-80,-376},{-80,-530},{-62,-530}}, color={255,0,255}));
  connect(con.y, leaPumSta.u3) annotation (Line(points={{82,160},{106,160},{106,
          182},{118,182}}, color={255,0,255}));
  connect(lagPumSta.y, and2.u2)
    annotation (Line(points={{-46,-344},{-36,-344}}, color={255,0,255}));
  connect(intEqu4.y, lagPumSta.u2) annotation (Line(points={{-198,-332},{-180,
          -332},{-180,-344},{-70,-344}}, color={255,0,255}));
  connect(and3.y, lagPumSta.u3) annotation (Line(points={{-98,-288},{-88,-288},
          {-88,-352},{-70,-352}}, color={255,0,255}));
  connect(booRep3.y, and2.u1) annotation (Line(points={{-232,-310},{-42,-310},{
          -42,-336},{-36,-336}}, color={255,0,255}));
  connect(and3.y, or2.u1) annotation (Line(points={{-98,-288},{10,-288},{10,
          -316},{64,-316}}, color={255,0,255}));
  connect(booRep4.y, lagPumSta.u1) annotation (Line(points={{-96,-328},{-82,
          -328},{-82,-336},{-70,-336}}, color={255,0,255}));
  connect(lat.y, booRep4.u) annotation (Line(points={{-178,-190},{-130,-190},{
          -130,-328},{-120,-328}}, color={255,0,255}));
    annotation (defaultComponentName="priPumCon",
  Diagram(coordinateSystem(preserveAspectRatio=false,
          extent={{-280,-660},{280,260}}), graphics={
          Rectangle(
          extent={{-276,256},{274,60}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{206,248},{270,232}},
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
          extent={{192,52},{270,36}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable next lag pump"),
          Text(
          extent={{188,-126},{266,-136}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Disable last lag pump"),
          Rectangle(
          extent={{-276,-360},{274,-654}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{220,-362},{266,-374}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Pump speed"),
          Rectangle(
          extent={{-276,-268},{274,-356}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{74,-272},{262,-286}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable/Disable lag pumps for dedicated primary pumps"),
          Rectangle(
          extent={{-276,-140},{274,-264}},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          pattern=LinePattern.None),
          Text(
          extent={{76,-142},{264,-156}},
          pattern=LinePattern.None,
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          lineColor={0,0,127},
          horizontalAlignment=TextAlignment.Right,
          textString="Enable/Disable lag pumps for headered, fixed-speed primary pumps")}),
 Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-280},{100,280}}),
       graphics={
        Rectangle(
          extent={{-100,-280},{100,280}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-100,330},{100,290}},
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
Primary hot water pump control sequence per ASHRAE RP-1711, March, 2020 draft, 
section 5.2.6. It consists of:
</p>
<ul>
<li>
Subsequences to enable lead pump, 
<ul>
<li>
for plants with dedicated pumps 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_dedicated\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_dedicated</a>.
</li>
<li>
for plants with headered pumps 
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_headered\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLead_headered</a>.
</li>
</ul>
</li>
<li>
Subsequences to stage lag pumps
<ul>
<li>
for primary-only plants with headered, variable-speed pumps
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLag_headered\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.EnableLag_headered</a>.
</li>
<li>
for other plants with headered pumps.
</li>
<li>
for plants with dedicated pumps.
</li>
</ul>
<li>
Subsequences to control pump speed,
<ul>
<li>
for primary-only plants, where the remote DP sensor(s) is not hardwired to the plant
controller, but a local DP sensor is hardwired
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_localDp\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_localDp</a>.
</li>
<li>
for primary-only plants, where the remote DP sensor(s) is hardwired to the plant controller
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_remoteDp\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primary_remoteDp</a>.
</li>
<li>
for primary-secondary plants, with flowrate sensor(s) for speed regulation
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_flow\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_flow</a>.
</li>
<li>
for primary-secondary plants, with temperature sensors for speed regulation
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_temperature\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Subsequences.Speed_primarySecondary_temperature</a>.
</li>
</ul>
</li>
</ul>
<p>
The parameter values for valid pump configurations are as follows:
<br>
  <table summary=\"allowedConfigurations\" border=\"1\">
    <thead>
      <tr>
        <th>Parameters/Pump configurations</th>
        <th>1</th>
        <th>2</th>
        <th>3</th>
        <th>4</th>
        <th>5</th>
        <th>6</th>
        <th>7</th>
        <th>8</th>
        <th>9</th>
        <th>10</th>
        <th>11</th>
        <th>12</th>
      </tr>
    </thead>
    <tbody>
      <tr>
        <td>primaryOnly</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
      </tr>
      <tr>
        <td>isHeadered</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
        <td>FALSE</td>
      </tr>
      <tr>
        <td>variablePrimary</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>TRUE</td>
        <td>FALSE</td>
      </tr>
      <tr>
        <td>speedControlType</td>
        <td>remoteDP</td>
        <td>localDP</td>
        <td>flowrate</td>
        <td>flowrate</td>
        <td>temperature</td>
        <td>temperature</td>
        <td>NA</td>
        <td>flowrate</td>
        <td>flowrate</td>
        <td>temperature</td>
        <td>temperature</td>
        <td>NA</td>
      </tr>
      <tr>
        <td>primarySecondaryFlowSensors</td>
        <td>NA</td>
        <td>NA</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>NA</td>
        <td>NA</td>
        <td>NA</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>NA</td>
        <td>NA</td>
        <td>NA</td>
      </tr>
      <tr>
        <td>primarySecondaryTemperatureSensors</td>
        <td>NA</td>
        <td>NA</td>
        <td>NA</td>
        <td>NA</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>NA</td>
        <td>NA</td>
        <td>NA</td>
        <td>TRUE</td>
        <td>FALSE</td>
        <td>NA</td>
      </tr>
    </tbody>
  </table>
</p>      
</html>",
revisions="<html>
<ul>
<li>
August 11, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
