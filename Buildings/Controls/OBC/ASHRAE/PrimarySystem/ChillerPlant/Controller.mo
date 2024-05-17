within Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant;
block Controller "Chiller plant controller"

  //// Economizer controller parameters

  parameter Real holdPeriod(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=1200
    "WSE minimum on or off time"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Enable parameters"));

  parameter Real delDis(
    final unit="s",
    final quantity="Time")=120
    "Delay disable time period"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Enable parameters"));

  parameter Modelica.SIunits.TemperatureDifference TOffsetEna=2
    "Temperature offset between the chilled water return upstream of WSE and the predicted WSE output"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Enable parameters"));

  parameter Modelica.SIunits.TemperatureDifference TOffsetDis=1
    "Temperature offset between the chilled water return upstream and downstream WSE"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Enable parameters"));

  parameter Modelica.SIunits.TemperatureDifference heaExcAppDes=2
    "Design heat exchanger approach"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Design parameters"));

  parameter Modelica.SIunits.TemperatureDifference cooTowAppDes=2
    "Design cooling tower approach"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Design parameters"));

  parameter Modelica.SIunits.Temperature TOutWetDes=288.15
    "Design outdoor air wet bulb temperature"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Design parameters"));

  parameter Modelica.SIunits.VolumeFlowRate VHeaExcDes_flow=0.015
    "Desing heat exchanger chilled water volume flow rate"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Design parameters"));

  parameter Modelica.SIunits.TemperatureDifference hysDt = 1
    "Deadband temperature used in hysteresis block"
    annotation(Evaluate=true, Dialog(tab="Advanced", group="Waterside economizer"));

  parameter Real step=0.02 "Tuning step"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Tuning"));

  parameter Real wseOnTimDec(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=3600
    "Economizer enable time needed to allow decrease of the tuning parameter"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Tuning"));

  parameter Real wseOnTimInc(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=1800
    "Economizer enable time needed to allow increase of the tuning parameter"
    annotation(Evaluate=true, Dialog(tab="Waterside economizer", group="Tuning"));

  //// Plant enable

  parameter Real schTab[4,2] = [0,1; 6*3600,1; 19*3600,1; 24*3600,1]
    "Plant enabling schedule allowing operators to lock out the plant during off-hour"
    annotation(Dialog(group="Plant enable"));

  parameter Modelica.SIunits.Temperature TChiLocOut=277.5
    "Outdoor air lockout temperature below which the chiller plant should be disabled"
    annotation(Dialog(group="Plant enable"));

  parameter Real plaThrTim(
    final unit="s",
    final quantity="Time")=15*60
      "Threshold time to check status of chiller plant"
    annotation(Dialog(group="Plant enable"));

  parameter Real reqThrTim(
    final unit="s",
    final quantity="Time")=3*60
      "Threshold time to check current chiller plant request"
    annotation(Dialog(group="Plant enable"));

  parameter Integer ignReq = 0
    "Ignorable chiller plant requests"
    annotation(Dialog(group="Plant enable"));

  parameter Real locDt = 1
    "Offset temperature for lockout chiller"
    annotation(Evaluate=true, Dialog(tab="Advanced", group="Plant enable"));

  //// Head pressure

  parameter Boolean fixSpePum = true
    "Flag indicating if the plant has fixed speed condenser water pumps"
    annotation(Dialog(group="Pumps configuration", enable=not have_WSE));

  parameter Boolean have_HeaPreConSig = false
    "Flag indicating if there is head pressure control signal from chiller controller"
    annotation(Dialog(tab="Head pressure", group="Head pressure control configuration"));

  parameter Real minTowSpe=0.1
    "Minimum cooling tower fan speed"
    annotation(Dialog(tab="Head pressure", group="Limits"));

  parameter Real minConWatPumSpe=0.1
    "Minimum condenser water pump speed"
    annotation(Dialog(enable= not ((not have_WSE) and fixSpePum), tab="Head pressure", group="Limits"));

  parameter Real minHeaPreValPos=0.1
    "Minimum head pressure control valve position"
    annotation(Dialog(enable= (not ((not have_WSE) and (not fixSpePum))), tab="Head pressure", group="Limits"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeHeaPre=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI "Type of controller"
    annotation(Dialog(tab="Head pressure", group="Loop signal", enable=not have_HeaPreConSig));

  parameter Modelica.SIunits.TemperatureDifference minChiLif=10
    "Minimum allowable lift at minimum load for chiller"
    annotation(Dialog(tab="Head pressure", group="Loop signal", enable=not have_HeaPreConSig));

  parameter Real kHeaPreCon=1
    "Gain of controller"
    annotation(Dialog(tab="Head pressure", group="Loop signal", enable=not have_HeaPreConSig));

  parameter Real TiHeaPreCon(
    final unit="s",
    final quantity="Time")=0.5
    "Time constant of integrator block"
    annotation(Dialog(tab="Head pressure", group="Loop signal", enable=not have_HeaPreConSig));

  //// Minimum flow bypass

  parameter Integer nChi=2
    "Total number of chillers"
    annotation(Dialog(group="Chillers configuration"));

  parameter Boolean have_parChi=true
    "Flag: true means that the plant has parallel chillers"
    annotation(Dialog(group="Chillers configuration"));

  parameter Real byPasSetTim(
    final unit="s",
    final quantity="Time")=300
    "Time constant for resetting minimum bypass flow"
    annotation(Dialog(tab="Minimum flow bypass", group="Time parameters"));

  parameter Real minFloSet[nChi](
    final unit=fill("m3/s",nChi),
    final quantity=fill("VolumeFlowRate",nChi),
    displayUnit=fill("m3/s",nChi)) = {0.0089,0.0089}
    "Minimum chilled water flow through each chiller"
    annotation(Dialog(tab="Minimum flow bypass", group="Flow limits"));

  parameter Real maxFloSet[nChi](
    final unit=fill("m3/s",nChi),
    final quantity=fill("VolumeFlowRate",nChi),
    displayUnit=fill("m3/s",nChi)) = {0.025,0.025}
    "Maximum chilled water flow through each chiller"
    annotation(Dialog(tab="Minimum flow bypass", group="Flow limits"));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeMinFloByp=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="Minimum flow bypass", group="Controller"));

  parameter Real kMinFloBypCon=1
    "Gain of controller"
    annotation (Dialog(tab="Minimum flow bypass", group="Controller"));

  parameter Real TiMinFloBypCon(
    final unit="s",
    final quantity="Time")=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Minimum flow bypass",
    group="Controller", enable=controllerTypeMinFloByp==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                               controllerTypeMinFloByp==Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real TdMinFloBypCon(
    final unit="s",
    final quantity="Time")=0 "Time constant of derivative block"
    annotation (Dialog(tab="Minimum flow bypass",
    group="Controller", enable=controllerTypeMinFloByp==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                               controllerTypeMinFloByp==Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  parameter Real yMaxFloBypCon=1 "Upper limit of output"
    annotation (Dialog(tab="Minimum flow bypass", group="Controller"));

  parameter Real yMinFloBypCon=0.1 "Lower limit of output"
    annotation (Dialog(tab="Minimum flow bypass", group="Controller"));

  //// Chilled water pumps

  parameter Boolean have_heaChiWatPum = true
    "Flag of headered chilled water pumps design: true=headered, false=dedicated"
    annotation (Dialog(group="Pumps configuration"));

  parameter Boolean have_LocalSensorChiWatPum = false
    "Flag of local DP sensor: true=local DP sensor hardwired to controller"
    annotation (Dialog(group="Pumps configuration"));

  parameter Integer nChiWatPum = 2
    "Total number of chilled water pumps"
    annotation (Dialog(group="Pumps configuration"));

  parameter Integer nSenChiWatPum=2
    "Total number of remote differential pressure sensors"
    annotation (Dialog(group="Pumps configuration"));

  parameter Real minChiWatPumSpe=0.1
    "Minimum pump speed"
    annotation (Dialog(tab="Chilled water pumps", group="Speed controller"));

  parameter Real maxChiWatPumSpe=1
    "Maximum pump speed"
    annotation (Dialog(tab="Chilled water pumps", group="Speed controller"));

  parameter Integer nPum_nominal(
    final max=nChiWatPum,
    final min=1)=nChiWatPum
    "Total number of pumps that operate at design conditions"
    annotation (Dialog(tab="Chilled water pumps", group="Nominal conditions"));

  parameter Real VChiWat_flow_nominal(
    final unit="m3/s",
    final quantity="VolumeFlowRate",
    final min=1e-6)=0.5
    "Total plant design chilled water flow rate"
    annotation (Dialog(tab="Chilled water pumps", group="Nominal conditions"));

  parameter Real maxLocDp(
    final unit="Pa",
    final quantity="PressureDifference")=15*6894.75
    "Maximum chilled water loop local differential pressure setpoint"
    annotation (Dialog(tab="Chilled water pumps", group="Pump speed control when there is local DP sensor", enable=have_LocalSensorChiWatPum));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController controllerTypeChiWatPum=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of controller"
    annotation (Dialog(tab="Chilled water pumps", group="Speed controller"));

  parameter Real kChiWatPum=1 "Gain of controller"
    annotation (Dialog(tab="Chilled water pumps", group="Speed controller"));

  parameter Real TiChiWatPum(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=0.5  "Time constant of integrator block"
      annotation (Dialog(tab="Chilled water pumps", group="Speed controller"));

  parameter Real TdChiWatPum(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=0.1 "Time constant of derivative block"
      annotation (Dialog(tab="Chilled water pumps", group="Speed controller",
    enable=
      controllerTypeChiWatPum == Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
      controllerTypeChiWatPum == Buildings.Controls.OBC.CDL.Types.SimpleController.PID));

  //// Chilled water plant reset

  parameter Real holTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=900
    "Time to fix plant reset value"
    annotation(Dialog(tab="Plant reset"));

  parameter Real iniSet = 0 "Initial setpoint"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real minSet = 0 "Minimum plant reset value"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real maxSet = 1 "Maximum plant reset value"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real delTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=900
    "Delay time after which trim and respond is activated"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real samplePeriod(
    final unit="s",
    final quantity="Time")=300
    "Sample period time"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Integer numIgnReq = 2
    "Number of ignored requests"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real triAmo = -0.02 "Trim amount"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real resAmo = 0.03
    "Respond amount (must be opposite in to triAmo)"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  parameter Real maxRes = 0.07
    "Maximum response per time interval (same sign as resAmo)"
    annotation (Dialog(tab="Plant Reset", group="Trim and respond parameters"));

  //// Chilled water supply

  parameter Modelica.SIunits.PressureDifference dpChiWatPumMin(
    final min=0,
    displayUnit="Pa") = 34473.8
    "Minimum chilled water pump differential static pressure, default 5 psi"
    annotation (Dialog(tab="Plant Reset", group="Chilled water supply"));

  parameter Modelica.SIunits.PressureDifference dpChiWatPumMax(
    final min=dpChiWatPumMin,
    displayUnit="Pa")
    "Maximum chilled water pump differential static pressure"
    annotation (Dialog(tab="Plant Reset", group="Chilled water supply"));

  parameter Modelica.SIunits.ThermodynamicTemperature TChiWatSupMin(
    displayUnit="K")
    "Minimum chilled water supply temperature"
    annotation (Dialog(tab="Plant Reset", group="Chilled water supply"));

  parameter Modelica.SIunits.ThermodynamicTemperature TChiWatSupMax(
    final min=TChiWatSupMin,
    displayUnit="K") = 288.706
    "Maximum chilled water supply temperature, default 60 degF"
    annotation (Dialog(tab="Plant Reset", group="Chilled water supply"));

  parameter Real halSet = 0.5
    "Half plant reset value"
    annotation (Dialog(tab="Plant Reset", group="Chilled water supply"));

  //// Staging setpoints

  parameter Boolean have_WSE=true
    "true = plant has a WSE, false = plant does not have WSE"
    annotation (Dialog(tab="General", group="Plant configuration"));

  parameter Boolean have_serChi = false
    "true = series chillers plant; false = parallel chillers plant"
    annotation (Dialog(tab="General", group="Chillers configuration"));

  parameter Boolean anyVsdCen = false
    "Plant contains at least one variable speed centrifugal chiller"
    annotation (Dialog(tab="General", group="Chillers configuration"));

  parameter Modelica.SIunits.Power chiDesCap[nChi]
    "Design chiller capacities vector"
    annotation (Dialog(tab="General", group="Chillers configuration"));

  parameter Modelica.SIunits.Power chiMinCap[nChi]
    "Chiller minimum cycling loads vector"
    annotation (Dialog(tab="General", group="Chillers configuration"));

  parameter Integer chiTyp[nChi]={
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.positiveDisplacement,
    Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Types.ChillerAndStageTypes.variableSpeedCentrifugal}
    "Chiller type. Recommended staging order: positive displacement, variable speed centrifugal, constant speed centrifugal"
    annotation (Dialog(tab="General", group="Chillers configuration"));

  parameter Integer nSta = 3
    "Number of chiller stages"
    annotation (Dialog(tab="General", group="Staging configuration"));

  parameter Integer staMat[nSta, nChi] = {{1,0},{0,1},{1,1}}
    "Staging matrix with stage as row index and chiller as column index"
    annotation (Dialog(tab="General", group="Staging configuration"));

  parameter Real avePer(
    final unit="s",
    final quantity="Time")=300
      "Time period for the capacity requirement rolling average"
    annotation (Dialog(tab="Staging", group="Hold and delay parameters"));

  parameter Real delayStaCha(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=900
      "Hold period for each stage change"
    annotation (Dialog(tab="Staging", group="Hold and delay parameters"));

  parameter Real parLoaRatDelay(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=900
      "Enable delay for operating and staging part load ratio condition"
    annotation (Dialog(tab="Staging", group="Hold and delay parameters"));

  parameter Real faiSafTruDelay(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=900
      "Enable delay for failsafe condition"
    annotation (Dialog(tab="Staging", group="Hold and delay parameters"));

  parameter Real effConTruDelay(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=900
      "Enable delay for efficiency condition"
    annotation (Dialog(tab="Staging", group="Hold and delay parameters"));

  parameter Real shortTDelay(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=600
      "Short enable delay for staging from zero to first available stage up"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Staging", group="Hold and delay parameters"));

  parameter Real longTDelay(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=1200
      "Long enable delay for staging from zero to first available stage up"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Staging", group="Hold and delay parameters"));

  parameter Real posDisMult(
    final unit = "1",
    final min = 0,
    final max = 1)=0.8
    "Positive displacement chiller type staging multiplier"
    annotation (Dialog(tab="Staging", group="Staging part load ratio parameters"));

  parameter Real conSpeCenMult(
    final unit = "1",
    final min = 0,
    final max = 1)=0.9
    "Constant speed centrifugal chiller type staging multiplier"
    annotation (Dialog(tab="Staging", group="Staging part load ratio parameters"));

  parameter Real anyOutOfScoMult(
    final unit = "1",
    final min = 0,
    final max = 1)=0.9
    "Outside of G36 recommended staging order chiller type SPLR multiplier"
    annotation(Evaluate=true, __cdl(ValueInReference=False), Dialog(tab="Staging", group="Staging part load ratio parameters"));

  parameter Real varSpeStaMin(
    final unit = "1",
    final min = 0.1,
    final max = 1)=0.45
    "Minimum stage up or down part load ratio for variable speed centrifugal stage types"
    annotation(Evaluate=true, Dialog(enable=anyVsdCen, tab="Staging", group="Staging part load ratio parameters"));

  parameter Real varSpeStaMax(
    final unit = "1",
    final min = varSpeStaMin,
    final max = 1)=0.9
    "Maximum stage up or down part load ratio for variable speed centrifugal stage types"
    annotation(Evaluate=true, Dialog(enable=anyVsdCen, tab="Staging", group="Staging part load ratio parameters"));

  parameter Modelica.SIunits.TemperatureDifference smallTDif = 1
    "Offset between the chilled water supply temperature and its setpoint for the long condition"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Staging", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference largeTDif = 2
    "Offset between the chilled water supply temperature and its setpoint for the short condition"
    annotation(Evaluate=true, Dialog(enable=have_WSE, tab="Staging", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference faiSafTDif = 1
    "Offset between the chilled water supply temperature and its setpoint for the failsafe condition"
    annotation (Dialog(tab="Staging", group="Value comparison parameters"));

  parameter Modelica.SIunits.PressureDifference dpDif=2*6895
    "Offset between the chilled water pump diferential static pressure and its setpoint"
    annotation (Dialog(tab="Staging", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference TDif = 1
    "Offset between the chilled water supply temperature and its setpoint for staging down to WSE only"
    annotation (Dialog(tab="Staging", group="Value comparison parameters"));

  parameter Modelica.SIunits.TemperatureDifference TDifHys = 1
    "Hysteresis deadband for temperature"
    annotation (Dialog(tab="Advanced", group="Staging"));

  parameter Modelica.SIunits.PressureDifference faiSafDpDif=2*6895
    "Offset between the chilled water differential pressure and its setpoint"
    annotation (Dialog(tab="Staging", group="Value comparison parameters"));

  parameter Modelica.SIunits.PressureDifference dpDifHys=0.5*6895
    "Pressure difference hysteresis deadband"
    annotation (Dialog(tab="Advanced", group="Staging"));

  parameter Real effConSigDif(
    final min=0,
    final max=1) = 0.05
    "Signal hysteresis deadband"
    annotation (Dialog(tab="Staging", group="Value comparison parameters"));


  //// Staging up and down process

  // derive from nSta and have_WSE
  parameter Integer totSta=6
    "Total number of stages, including the stages with a WSE, if applicable"
    annotation (Dialog(tab="Staging", group="Up process"));

  parameter Boolean have_PonyChiller=false
    "True: have pony chiller"
    annotation (Dialog(tab="Staging", group="Up process"));

  parameter Boolean have_heaPum=true
    "True: headered condenser water pumps"
    annotation (Dialog(tab="Staging", group="Up process: Condenser water pumps"));

  parameter Real chiDemRedFac=0.75
    "Demand reducing factor of current operating chillers"
    annotation (Dialog(tab="Staging", group="Up and down process: Limit chiller demand"));

  parameter Real holChiDemTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=300
    "Maximum time to wait for the actual demand less than percentage of current load"
    annotation (Dialog(tab="Staging", group="Up and down process: Limit chiller demand"));

  parameter Real aftByPasSetTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=60
    "Time to allow loop to stabilize after resetting minimum chilled water flow setpoint"
    annotation (Dialog(tab="Staging", group="Up and down process"));

  parameter Real staVec[totSta]={0,0.5,1,1.5,2,2.5}
    "Chiller stage vector, element value like x.5 means chiller stage x plus WSE"
    annotation (Dialog(tab="Staging", group="Up and down process: Condenser water pumps"));

  parameter Real desConWatPumSpe[totSta]={0,0.5,0.75,0.6,0.75,0.9}
    "Design condenser water pump speed setpoints, the size should be double of total stage numbers"
    annotation (Dialog(tab="Staging", group="Up and down process: Condenser water pumps"));

  parameter Real desConWatPumNum[totSta]={0,1,1,2,2,2}
    "Design number of condenser water pumps that should be ON, the size should be double of total stage numbers"
    annotation (Dialog(tab="Staging", group="Up and down process: Condenser water pumps"));

  parameter Real thrTimEnb(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=10
    "Threshold time to enable head pressure control after condenser water pump being reset"
    annotation (Dialog(tab="Staging", group="Up process: Time parameters"));

  parameter Real waiTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=30
    "Waiting time after enabling next head pressure control"
    annotation (Dialog(tab="Staging", group="Up and down process: Time parameters"));

  parameter Real chaChiWatIsoTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=300
    "Time to slowly change isolation valve, should be determined in the field"
    annotation (Dialog(tab="Staging", group="Up and down process: Time parameters"));

  parameter Real proOnTim(
    final unit="s",
    final quantity="Time",
    displayUnit="h")=300
    "Threshold time to check after newly enabled chiller being operated"
    annotation (Dialog(tab="Staging", group="Up and down process: Time parameters", enable=have_PonyChiller));

  parameter Real relSpeDif = 0.05
    "Relative error to the setpoint for checking if it has achieved speed setpoint"
    annotation (Dialog(tab="Staging", group="Up and down process: Relative error"));

  parameter Real relFloDif=0.05
    "Relative error to the setpoint for checking if it has achieved flow rate setpoint"
    annotation (Dialog(tab="Staging", group="Up and down process: Relative error"));

  //// Cooling tower

  // fixme: this parameter should be derived from the staging matrix and have_WSE value
  parameter Integer nTowCel=4
    "Total number of cooling tower cells"
    annotation (Dialog(tab="Cooling Towers", group="Configuration"));

  parameter Integer totChiSta=6
    "Total number of stages, stage zero should be counted as one stage"
    annotation (Dialog(tab="Cooling Towers", group="Configuration"));

  parameter Integer nConWatPum=2
    "Total number of condenser water pumps"
    annotation (Dialog(tab="Cooling Towers", group="Configuration"));

  parameter Boolean closeCoupledPlant=false
    "Flag to indicate if the plant is close coupled"
    annotation (Dialog(tab="Cooling Towers", group="Configuration"));

  // fixme: this should be a sum of all chiller capacities

  parameter Real desCap(
    final unit="W",
    final quantity="Power")=1e6
    "Plant design capacity"
    annotation (Dialog(tab="Cooling Towers", group="Configuration"));

  // Tower fan speed control

  parameter Real fanSpeMin=0.1 "Minimum tower fan speed"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed"));

  parameter Real fanSpeMax=1 "Maximum tower fan speed"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed"));

  // when WSE is enabled

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController intOpeCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Controller in the mode when WSE and chillers are enabled"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled",
                       enable=have_WSE));

  parameter Real kIntOpeTowFan=1 "Gain of controller"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled",
                       enable=have_WSE));

  parameter Real TiIntOpeTowFan(
    final unit="s",
    final quantity="Time")=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled",
                       enable=have_WSE and (intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                                            intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real TdIntOpeTowFan(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled",
                       enable=have_WSE and (intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                                           intOpeCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController chiWatConTowFan=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Controller in the mode when only WSE is enabled"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled", enable=have_WSE));

  parameter Real kWSETowFan=1 "Gain of controller"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled", enable=have_WSE));

  parameter Real TiWSETowFan(
    final unit="s",
    final quantity="Time")=0.5 "Time constant of integrator block"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled",
                        enable=have_WSE and (chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                                             chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real TdWSETowFan(
    final unit="s",
    final quantity="Time")=0.1 "Time constant of derivative block"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed controller with WSE enabled",
                       enable=have_WSE and (chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                                            chiWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  // Fan speed control: controlling condenser return water temperature when WSE is not enabled
  parameter Real LIFT_min[nChi](
    final unit=fill("K",nChi),
    final quantity=fill("TemperatureDifference",nChi),
    displayUnit=fill("degC",nChi))={12,12} "Minimum LIFT of each chiller"
      annotation (Evaluate=true, Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control"));

  parameter Real TConWatSup_nominal[nChi](
    final unit=fill("K",nChi),
    final quantity=fill("ThermodynamicTemperature",nChi),
    displayUnit=fill("degC",nChi))={293.15,293.15}
    "Condenser water supply temperature (condenser entering) of each chiller"
    annotation (Evaluate=true, Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control"));

  parameter Real TConWatRet_nominal[nChi](
    final unit=fill("K",nChi),
    final quantity=fill("ThermodynamicTemperature",nChi),
    displayUnit=fill("degC",nChi))={303.15,303.15}
    "Condenser water return temperature (condenser leaving) of each chiller"
    annotation (Evaluate=true, Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control"));

  // take TChiWatSupMin from plant reset and pass to tower

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController couPlaCon=
    Buildings.Controls.OBC.CDL.Types.SimpleController.PI
    "Type of coupled plant controller"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=closeCoupledPlant));

  parameter Real kCouPla=1 "Gain of controller"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=closeCoupledPlant));

  parameter Real TiCouPla(
    final unit="s",
    final quantity="Time")=0.5
    "Time constant of integrator block"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                       enable=closeCoupledPlant and (couPlaCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                                                      couPlaCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real TdCouPla(
    final unit="s",
    final quantity="Time")=0.1
    "Time constant of derivative block"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                       enable=closeCoupledPlant and (couPlaCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                                                     couPlaCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real yCouPlaMax=1 "Upper limit of output"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                       enable=closeCoupledPlant));

  parameter Real yCouPlaMin=0 "Lower limit of output"
    annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=closeCoupledPlant));

  parameter Real samplePeriodConTDiff(final unit="s", final quantity="Time")=30
     "Period of sampling condenser water supply and return temperature difference"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=not closeCoupledPlant));

  parameter Buildings.Controls.OBC.CDL.Types.SimpleController supWatCon=
     Buildings.Controls.OBC.CDL.Types.SimpleController.PI
     "Condenser supply water temperature controller for less coupled plant"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=not closeCoupledPlant));

  parameter Real kSupCon=1 "Gain of controller"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=not closeCoupledPlant));

  parameter Real TiSupCon(final unit="s", final quantity="Time")=0.5
     "Time constant of integrator block"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=not closeCoupledPlant and (supWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PI or
                                                          supWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real TdSupCon(final unit="s", final quantity="Time")=0.1
     "Time constant of derivative block"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=not closeCoupledPlant and (supWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PD or
                                                          supWatCon==Buildings.Controls.OBC.CDL.Types.SimpleController.PID)));

  parameter Real ySupConMax=1 "Upper limit of output"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                        enable=not closeCoupledPlant));

  parameter Real ySupConMin=0 "Lower limit of output"
     annotation (Dialog(tab="Cooling Towers", group="Fan speed: Return temperature control",
                          enable=not closeCoupledPlant));

  parameter Real speChe=0.005
     "Lower threshold value to check fan or pump speed"
     annotation (Dialog(tab="Cooling Towers", group="Advanced"));

  parameter Real iniPlaTim(final unit="s", final quantity="Time")=600
     "Time to hold return temperature at initial setpoint after plant being enabled"
     annotation (Dialog(tab="Cooling Towers", group="Advanced"));

  parameter Real ramTim(final unit="s", final quantity="Time")=180
     "Time to ramp return water temperature from initial value to setpoint"
     annotation (Dialog(tab="Cooling Towers", group="Advanced"));

  parameter Real cheMinFanSpe(final unit="s", final quantity="Time")=300
     "Threshold time for checking duration when tower fan equals to the minimum tower fan speed"
     annotation (Dialog(tab="Cooling Towers", group="Advanced"));

  parameter Real cheMaxTowSpe(final unit="s", final quantity="Time")=300
     "Threshold time for checking duration when any enabled chiller maximum cooling speed equals to the minimum tower fan speed"
     annotation (Dialog(tab="Cooling Towers", group="Advanced"));

  parameter Real cheTowOff(final unit="s", final quantity="Time")=60
     "Threshold time for checking duration when there is no enabled tower fan"
     annotation (Dialog(tab="Cooling Towers", group="Advanced"));

  // Tower staging

  parameter Real towCelOnSet[totChiSta]={0,2,2,4,4,4}
    "Number of condenser water pumps that should be ON, according to current chiller stage and WSE status"
    annotation(Dialog(tab="Cooling Towers", group="Tower staging"));

  parameter Real chaTowCelIsoTim(final unit="s", final quantity="Time")=300
    "Time to slowly change isolation valve"
     annotation (Dialog(tab="Cooling Towers", group="Enable isolation valve"));

  // Water level control
  parameter Real watLevMin(final min=0)=0.7
    "Minimum cooling tower water level recommended by manufacturer"
     annotation (Dialog(tab="Cooling Towers", group="Makeup water"));

  parameter Real watLevMax=1
    "Maximum cooling tower water level recommended by manufacturer"
    annotation (Dialog(tab="Cooling Towers", group="Makeup water"));


  CDL.Interfaces.BooleanInput uChiIsoVal[nChi] if have_heaChiWatPum
    "Chilled water isolation valve status"
    annotation(Placement(transformation(extent={{-840,650},{-800,690}}),
      iconTransformation(extent={{-140,180},{-100,220}})));

  CDL.Interfaces.BooleanInput uChiWatPum[nChiWatPum]
    "Chilled water pump status"
    annotation(Placement(transformation(extent={{-840,320},{-800,360}}),
      iconTransformation(extent={{-140,160},{-100,200}})));

  CDL.Interfaces.BooleanInput uChiAva[nChi]
    "Chiller availability status vector"
    annotation(Placement(transformation(extent={{-840,420},{-800,460}}),
        iconTransformation(extent={{-140,140},{-100,180}})));

  CDL.Interfaces.BooleanInput uChi[nChi]
    "Vector of chiller proven on status: true=ON"
    annotation(Placement(transformation(extent={{-840,520},{-800,560}}),
      iconTransformation(extent={{-140,220},{-100,260}})));

  CDL.Interfaces.BooleanInput uTowSta[nTowCel]
    "Vector of tower cell proven on status: true=running tower cell"
    annotation(Placement(transformation(extent={{-840,370},{-800,410}}),
      iconTransformation(extent={{-140,280},{-100,320}})));

  CDL.Interfaces.IntegerInput chiWatSupResReq
    "Number of chiller plant cooling requests"
    annotation(Placement(transformation(extent={{-840,230},{-800,270}}),
      iconTransformation(extent={{-140,110},{-100,150}})));

  CDL.Interfaces.RealInput VChiWat_flow(final quantity=
        "VolumeFlowRate", final unit="m3/s")
    "Measured chilled water volume flow rate"
    annotation(Placement(transformation(extent={{-840,-40},{-800,0}}),
    iconTransformation(extent={{-140,-80},{-100,-40}})));

  CDL.Interfaces.RealInput dpChiWat_remote[nSenChiWatPum](
    final unit=fill("Pa", nSenChiWatPum),
    final quantity=fill("PressureDifference", nSenChiWatPum))
    "Chilled water differential static pressure from remote sensor"
    annotation(Placement(transformation(extent={{-840,-170},{-800,-130}}),
      iconTransformation(extent={{-140,-150},{-100,-110}})));

  CDL.Interfaces.RealInput uChiWatIsoVal[nChi](
    final min=fill(0, nChi),
    final max=fill(1, nChi),
    final unit=fill("1", nChi))
    "Chilled water isolation valve position"
    annotation(Placement(transformation(extent={{-840,-220},{-800,-180}}),
      iconTransformation(extent={{-140,-130},{-100,-90}})));

  CDL.Interfaces.RealInput uConWatPumSpe[nConWatPum](
    final min=fill(0, nConWatPum),
    final max=fill(1, nConWatPum),
    final unit=fill("1", nConWatPum)) "Current condenser water pump speed"
    annotation(Placement(transformation(extent={{-840,-420},{-800,-380}}),
        iconTransformation(extent={{-140,-190},{-100,-150}})));

  CDL.Interfaces.RealInput TConWatSup(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") if not closeCoupledPlant
    "Condenser water supply temperature"
    annotation(Placement(transformation(extent={{-840,-280},{-800,-240}}),
      iconTransformation(extent={{-140,-238},{-100,-198}})));

  CDL.Interfaces.RealInput watLev "Measured water level" annotation (Placement(
        transformation(extent={{-840,-780},{-800,-740}}), iconTransformation(
          extent={{-140,-320},{-100,-280}})));

  CDL.Interfaces.RealInput uIsoVal[nTowCel](
    final min=fill(0, nTowCel),
    final max=fill(1, nTowCel),
    final unit=fill("1", nTowCel))
    "Vector of tower cells isolation valve position"
    annotation(Placement(transformation(extent={{-840,-700},{-800,-660}}),
      iconTransformation(extent={{-140,-300},{-100,-260}})));

  CDL.Interfaces.RealInput TChiWatRetDow(final unit="K",
      final quantity="ThermodynamicTemperature")
    "Chiller water return temperature downstream of the WSE"
    annotation(Placement(transformation(extent={{-840,0},{-800,40}}),
        iconTransformation(extent={{-140,-60},{-100,-20}})));

  CDL.Interfaces.RealInput TChiWatRet(final unit="K",
      final quantity="ThermodynamicTemperature")
    "Chiller water return temperature upstream of the WSE"
    annotation(Placement(transformation(extent={{-840,40},{-800,80}}),
        iconTransformation(extent={{-140,-20},{-100,20}})));

  CDL.Interfaces.RealInput TOutWet(final unit="K",
      final quantity="ThermodynamicTemperature")
    "Outdoor air wet bulb temperature"
    annotation(Placement(transformation(extent={{-840,110},{-800,150}}),
        iconTransformation(extent={{-140,30},{-100,70}})));

  CDL.Interfaces.RealInput dpChiWatPum(final unit="Pa",
      final quantity="PressureDifference") if not have_serChi
    "Chilled water pump differential static pressure"
    annotation(Placement(transformation(extent={{-840,-140},{-800,-100}}),
    iconTransformation(extent={{-140,-110},{-100,-70}})));

  CDL.Interfaces.RealInput uChiLoa[nChi](
    final quantity=fill("HeatFlowRate", nChi), final unit=fill("W", nChi))
    "Current chiller load"
    annotation(Placement(transformation(extent={{-840,140},{-800,180}}),
      iconTransformation(extent={{-140,60},{-100,100}})));

  CDL.Interfaces.RealInput TConWatRet(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") if not have_HeaPreConSig
    "Measured condenser water return temperature"
    annotation(Placement(transformation(extent={{-840,-80},{-800,-40}}),
      iconTransformation(extent={{-140,-218},{-100,-178}})));

  CDL.Interfaces.RealInput TChiWatSup(
    final unit="K",
    final displayUnit="degC",
    final quantity="ThermodynamicTemperature") if not have_HeaPreConSig
    "Measured chilled water supply temperature"
    annotation(Placement(transformation(extent={{-840,-110},{-800,-70}}),
      iconTransformation(extent={{-140,-40},{-100,0}})));

  CDL.Interfaces.BooleanOutput yChi[nChi]
    "Chiller enabling status"
    annotation(Placement(transformation(extent={{800,280},{840,320}}),
      iconTransformation(extent={{100,230},{140,270}})));

  CDL.Interfaces.BooleanOutput yChiWatPum[nChiWatPum] if
    have_heaChiWatPum
    "Chilled water pump status setpoint"
    annotation(Placement(transformation(extent={{800,500},{840,540}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  CDL.Interfaces.BooleanOutput yLeaCel
    "Lead tower cell status setpoint"
    annotation(Placement(transformation(extent={{800,-610},{840,-570}}),
      iconTransformation(extent={{100,110},{140,150}})));

  CDL.Interfaces.BooleanOutput yTowSta[nTowCel]
    "Vector of tower cells status setpoint"
    annotation(Placement(transformation(extent={{800,-680},{840,-640}}),
      iconTransformation(extent={{100,170},{140,210}})));

  CDL.Interfaces.BooleanOutput yMakUp
    "Makeup water valve On-Off status"
    annotation(Placement(transformation(extent={{800,-760},{840,-720}}),
      iconTransformation(extent={{100,140},{140,180}})));

  CDL.Interfaces.RealOutput yIsoVal[nTowCel](
    final min=fill(0, nTowCel),
    final max=fill(1, nTowCel),
    final unit=fill("1", nTowCel))
    "Cooling tower cells isolation valve position"
    annotation(Placement(transformation(extent={{800,-650},{840,-610}}),
      iconTransformation(extent={{100,-170},{140,-130}})));

  CDL.Interfaces.RealOutput yFanSpe[nTowCel](
    final min=fill(0, nTowCel),
    final max=fill(1, nTowCel),
    final unit=fill("1", nTowCel)) "Fan speed of each cooling tower cell"
    annotation(Placement(transformation(extent={{800,-710},{840,-670}}),
      iconTransformation(extent={{100,-80},{140,-40}})));

  CDL.Interfaces.RealOutput yValPos(
    final min=0,
    final max=1,
    final unit="1") "Chilled water minimum flow bypass valve position"
    annotation(Placement(transformation(extent={{800,-460},{840,-420}}),
      iconTransformation(extent={{100,-20},{140,20}})));

  CDL.Interfaces.RealOutput yChiPumSpe(
    final min=0,
    final max=1,
    final unit="1") "Enabled chilled water pump speed" annotation(Placement(
        transformation(extent={{800,466},{840,506}}), iconTransformation(extent={{100,-50},
            {140,-10}})));

  CDL.Interfaces.RealOutput yChiDem[nChi](final quantity=
       fill("HeatFlowRate", nChi), final unit=fill("W", nChi))
    "Chiller demand setpoint to set through BACnet or similar "
    annotation(Placement(transformation(extent={{800,380},{840,420}}),
      iconTransformation(extent={{100,-140},{140,-100}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Economizers.Controller wseSta(
    final holdPeriod=holdPeriod,
    final delDis=delDis,
    final TOffsetEna=TOffsetEna,
    final TOffsetDis=TOffsetDis,
    final heaExcAppDes=heaExcAppDes,
    final cooTowAppDes=cooTowAppDes,
    final TOutWetDes=TOutWetDes,
    final VHeaExcDes_flow=VHeaExcDes_flow,
    final hysDt=hysDt,
    final step=step,
    final wseOnTimDec=wseOnTimDec,
    final wseOnTimInc=wseOnTimInc)
    "Waterside economizer (WSE) enable/disable status"
    annotation(Placement(transformation(extent={{-580,300},{-540,340}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Generic.PlantEnable plaEna(
    final have_WSE=have_WSE,
    final schTab=schTab,
    final TChiLocOut=TChiLocOut,
    final plaThrTim=plaThrTim,
    final reqThrTim=reqThrTim,
    final ignReq=ignReq,
    final locDt=locDt)
    "Sequence to enable and disable plant"
    annotation(Placement(transformation(extent={{-560,-480},{-520,-440}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.HeadPressure.Controller
    heaPreCon[nChi](
    final fixSpePum=fill(fixSpePum, nChi),
    final have_HeaPreConSig=fill(have_HeaPreConSig, nChi),
    final have_WSE=fill(have_WSE, nChi),
    final minTowSpe=fill(minTowSpe, nChi),
    final minConWatPumSpe=fill(minConWatPumSpe, nChi),
    final minHeaPreValPos=fill(minHeaPreValPos, nChi),
    final controllerType=fill(controllerTypeHeaPre, nChi),
    final minChiLif=fill(minChiLif, nChi),
    final k=fill(kHeaPreCon, nChi),
    final Ti=fill(TiHeaPreCon, nChi)) "Head pressure controller"
    annotation (Placement(transformation(extent={{-420,180},{-380,220}})));

  MinimumFlowBypass.Controller minBypValCon(
    final nChi=nChi,
    final minFloSet=minFloSet,
    final controllerType=controllerTypeMinFloByp,
    final k=kMinFloBypCon,
    final Ti=TiMinFloBypCon,
    final Td=TdMinFloBypCon,
    final yMax=yMaxFloBypCon,
    final yMin=yMinFloBypCon)
    "Controller for chilled water minimum flow bypass valve"
    annotation (Placement(transformation(extent={{-560,-160},{-520,-120}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Pumps.ChilledWater.Controller chiWatPumCon(
    final have_heaPum=have_heaChiWatPum,
    final have_LocalSensor=have_LocalSensorChiWatPum,
    final nChi=nChi,
    final nPum=nChiWatPum,
    final nSen=nSenChiWatPum,
    final minPumSpe=minChiWatPumSpe,
    final maxPumSpe=maxChiWatPumSpe,
    final nPum_nominal=nPum_nominal,
    final VChiWat_flow_nominal=VChiWat_flow_nominal,
    final maxLocDp=maxLocDp,
    final controllerType=controllerTypeChiWatPum,
    final k=kChiWatPum,
    final Ti=TiChiWatPum,
    final Td=TdChiWatPum)
    "Sequences to control chilled water pumps in primary-only plant system"
    annotation(Placement(transformation(extent={{540,480},{600,540}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.SetPoints.ChilledWaterPlantReset chiWatPlaRes(
    final nPum=nChiWatPum,
    final holTim=holTim,
    final iniSet=iniSet,
    final minSet=minSet,
    final maxSet=maxSet,
    final delTim=delTim,
    final samplePeriod=samplePeriod,
    final numIgnReq=numIgnReq,
    final triAmo=triAmo,
    final resAmo=resAmo,
    final maxRes=maxRes)
    "Sequences to generate chilled water plant reset"
    annotation(Placement(transformation(extent={{-560,-320},{-520,-280}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.SetPoints.ChilledWaterSupply chiWatSupSet(
    final dpChiWatPumMin=dpChiWatPumMin,
    final dpChiWatPumMax=dpChiWatPumMax,
    final TChiWatSupMin=TChiWatSupMin,
    final TChiWatSupMax=TChiWatSupMax,
    final minSet=minSet,
    final maxSet=maxSet,
    final halSet=halSet)
    "Sequences to generate setpoints of chilled water supply temperature and the pump differential static pressure"
    annotation(Placement(transformation(extent={{-360,420},{-320,460}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Staging.SetPoints.SetpointController staSetCon(
    final have_WSE=have_WSE,
    final have_serChi=have_serChi,
    final anyVsdCen=anyVsdCen,
    final nChi=nChi,
    final chiDesCap=chiDesCap,
    final chiMinCap=chiMinCap,
    final chiTyp=chiTyp,
    final nSta=nSta,
    final staMat=staMat,
    final avePer=avePer,
    final delayStaCha=delayStaCha,
    final parLoaRatDelay=parLoaRatDelay,
    final faiSafTruDelay=faiSafTruDelay,
    final effConTruDelay=effConTruDelay,
    final shortTDelay=shortTDelay,
    final longTDelay=longTDelay,
    final conSpeCenMult=conSpeCenMult,
    final anyOutOfScoMult=anyOutOfScoMult,
    final varSpeStaMin=varSpeStaMin,
    final varSpeStaMax=varSpeStaMax,
    final smallTDif=smallTDif,
    final largeTDif=largeTDif,
    final faiSafTDif=faiSafTDif,
    final dpDif=dpDif,
    final TDif=TDif,
    final TDifHys=TDifHys,
    final faiSafDpDif=faiSafDpDif,
    final dpDifHys=dpDifHys,
    final effConSigDif=effConSigDif)
    "Calculates the chiller stage status setpoint signal"
    annotation(Placement(transformation(extent={{-160,-68},{-80,100}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.ChillerPlant.Towers.Controller towCon(
    final nTowCel=nTowCel,
    final totChiSta=totChiSta,
    final nConWatPum=nConWatPum,
    final closeCoupledPlant=closeCoupledPlant,
    final desCap=desCap,
    final fanSpeMin=fanSpeMin,
    final fanSpeMax=fanSpeMax,
    final intOpeCon=intOpeCon,
    final TiIntOpe=TiIntOpeTowFan,
    final TdIntOpe=TdIntOpeTowFan,
    final chiWatCon=chiWatConTowFan,
    final kWSE=kWSETowFan,
    final TiWSE=TiWSETowFan,
    final TdWSE=TdWSETowFan,
    final LIFT_min=LIFT_min,
    final TConWatSup_nominal=TConWatSup_nominal,
    final TConWatRet_nominal=TConWatRet_nominal,
    final couPlaCon=couPlaCon,
    final kCouPla=kCouPla,
    final TiCouPla=TiCouPla,
    final TdCouPla=TdCouPla,
    final yCouPlaMax=yCouPlaMax,
    final yCouPlaMin=yCouPlaMin,
    final samplePeriod=samplePeriodConTDiff,
    final supWatCon=supWatCon,
    final kSupCon=kSupCon,
    final TiSupCon=TiSupCon,
    final TdSupCon=TdSupCon,
    final ySupConMax=ySupConMax,
    final ySupConMin=ySupConMin,
    final speChe=speChe,
    final iniPlaTim=iniPlaTim,
    final ramTim=ramTim,
    final cheMinFanSpe=cheMinFanSpe,
    final cheMaxTowSpe=cheMaxTowSpe,
    final cheTowOff=cheTowOff,
    final staVec=staVec,
    final towCelOnSet=towCelOnSet,
    final chaTowCelIsoTim=chaTowCelIsoTim,
    final watLevMin=watLevMin,
    final watLevMax=watLevMax)
    "Cooling tower controller"
    annotation(Placement(transformation(extent={{-200,-720},{-120,-560}})));

  Staging.Processes.Down dowProCon(
    final nChi=nChi,
    final totSta=totSta,
    final have_WSE=have_WSE,
    final have_PonyChiller=have_PonyChiller,
    final have_parChi=have_parChi,
    final have_heaPum=have_heaPum,
    final chiDemRedFac=chiDemRedFac,
    final holChiDemTim=holChiDemTim,
    final waiTim=waiTim,
    final proOnTim=proOnTim,
    final chaChiWatIsoTim=chaChiWatIsoTim,
    final staVec=staVec,
    final desConWatPumSpe=desConWatPumSpe,
    final desConWatPumNum=desConWatPumNum,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet,
    final maxFloSet=maxFloSet,
    final aftByPasSetTim=aftByPasSetTim,
    final relSpeDif=relSpeDif,
    final relFloDif=relFloDif)
    "Staging down process controller"
    annotation(Placement(transformation(extent={{280,-300},{360,-140}})));

  Staging.Processes.Up upProCon(
    final nChi=nChi,
    final totSta=totSta,
    final have_WSE=have_WSE,
    final have_PonyChiller=have_PonyChiller,
    final have_parChi=have_parChi,
    final have_heaPum=have_heaPum,
    final chiDemRedFac=chiDemRedFac,
    final holChiDemTim=holChiDemTim,
    final byPasSetTim=byPasSetTim,
    final minFloSet=minFloSet,
    final maxFloSet=maxFloSet,
    final aftByPasSetTim=aftByPasSetTim,
    final staVec=staVec,
    final desConWatPumSpe=desConWatPumSpe,
    final desConWatPumNum=desConWatPumNum,
    final thrTimEnb=thrTimEnb,
    final waiTim=waiTim,
    final chaChiWatIsoTim=chaChiWatIsoTim,
    final proOnTim=proOnTim,
    final relSpeDif=relSpeDif,
    final relFloDif=relFloDif)
    "Staging up process controller"
    annotation(Placement(transformation(extent={{280,280},{360,440}})));

  CDL.Continuous.MultiMax mulMax(nin=nTowCel) "All input values are the same"
    annotation(Placement(transformation(extent={{-60,-560},{-40,-540}})));

  CDL.Logical.Or chaProUpDown "Either in staging up or in staging down process"
    annotation(Placement(transformation(extent={{500,-90},{520,-70}})));

  CDL.Discrete.TriggeredSampler staSam
    "Samples stage index after each staging process is finished"
    annotation(Placement(transformation(extent={{80,-30},{100,-10}})));

  CDL.Conversions.RealToInteger reaToInt1
    annotation(Placement(transformation(extent={{120,-30},{140,-10}})));

  CDL.Conversions.IntegerToReal intToRea
    annotation(Placement(transformation(extent={{40,-30},{60,-10}})));

  CDL.Logical.FallingEdge falEdg
    annotation(Placement(transformation(extent={{560,-90},{580,-70}})));

  CDL.Interfaces.IntegerOutput yNumCel
    "Total number of enabled cells"
    annotation(Placement(transformation(extent={{800,-560},{840,-520}}),
      iconTransformation(extent={{100,50},{140,90}})));

  CDL.Logical.MultiOr mulOr(nin=nChiWatPum)
    annotation(Placement(transformation(extent={{-640,-110},{-620,-90}})));

  CDL.Continuous.MultiMax conWatPumSpe(nin=nConWatPum)
    "Running condenser water pump speed"
    annotation (Placement(transformation(extent={{-560,-410},{-540,-390}})));
  CDL.Logical.Or staCooTow
    "Tower stage change status: true=stage cooling tower"
    annotation (Placement(transformation(extent={{500,-130},{520,-110}})));
  CDL.Interfaces.RealInput TOut(final unit="K", final quantity="ThermodynamicTemperature")
    "Outdoor air dr bulb temperature" annotation (Placement(transformation(
          extent={{-840,80},{-800,120}}), iconTransformation(extent={{-140,10},{
            -100,50}})));

  CDL.Interfaces.RealInput uFanSpe(
    final quantity="1",
    final min=0,
    final max=1) "Tower fan speed" annotation (Placement(transformation(extent={
            {-840,-608},{-800,-568}}), iconTransformation(extent={{-140,-270},{-100,
            -230}})));

  CDL.Interfaces.BooleanInput uChiConIsoVal[nChi]
    "Chilled condenser water isolation valve status" annotation (Placement(
        transformation(extent={{-840,620},{-800,660}}), iconTransformation(
          extent={{-140,200},{-100,240}})));

  CDL.Interfaces.BooleanInput uConWatReq[nChi]
    "Condenser water requst status for each chiller" annotation (Placement(
        transformation(extent={{-840,560},{-800,600}}), iconTransformation(
          extent={{-140,260},{-100,300}})));

  CDL.Interfaces.BooleanInput uChiWatReq[nChi]
    "Chilled water requst status for each chiller" annotation (Placement(
        transformation(extent={{-840,590},{-800,630}}), iconTransformation(
          extent={{-140,240},{-100,280}})));

  CDL.Routing.BooleanScalarReplicator booRep(nout=nChi) if have_WSE
    "Waterside economizer status"
    annotation (Placement(transformation(extent={{-480,290},{-460,310}})));

  CDL.Routing.RealScalarReplicator conWatRetTem(final nout=nChi)
    "Condenser water return temperature"
    annotation (Placement(transformation(extent={{-640,230},{-620,250}})));

  CDL.Routing.RealScalarReplicator chiWatSupTem(final nout=nChi)
    "Chilled water supply temperature"
    annotation (Placement(transformation(extent={{-580,210},{-560,230}})));

  CDL.Logical.Switch desConWatPumSpeSwi "Design condenser water pump speed"
    annotation (Placement(transformation(extent={{620,190},{640,210}})));

  CDL.Routing.RealScalarReplicator repDesConTem(final nout=nChi)
    "Replicate design condenser water temperature"
    annotation (Placement(transformation(extent={{660,190},{680,210}})));

  CDL.Interfaces.RealInput uHeaPreCon[nChi] if have_HeaPreConSig
    "Chiller head pressure control loop signal from chiller controller"
    annotation (Placement(transformation(extent={{-840,180},{-800,220}}),
        iconTransformation(extent={{-140,80},{-100,120}})));

  CDL.Interfaces.RealOutput yHeaPreConVal[nChi]
    "Head pressure control valve position" annotation (Placement(transformation(
          extent={{800,160},{840,200}}), iconTransformation(extent={{100,-110},{
            140,-70}})));
  CDL.Continuous.MultiMin mulMin(nin=nChi)
    annotation (Placement(transformation(extent={{-360,170},{-340,190}})));

  CDL.Logical.Switch chiMinFloSet "Chiller water minimum flow setpoint"
    annotation (Placement(transformation(extent={{620,140},{640,160}})));

  CDL.Logical.Latch lat
    annotation (Placement(transformation(extent={{620,340},{640,360}})));

  CDL.Routing.BooleanScalarReplicator uChiSwi(nout=nChi)
    "In chiller stage up process"
    annotation (Placement(transformation(extent={{660,340},{680,360}})));

  CDL.Logical.LogicalSwitch uChiStaPro[nChi]
    "Chiller head pressure control status"
    annotation (Placement(transformation(extent={{700,340},{720,360}})));

  CDL.Logical.Pre heaCon[nChi] "Chiller head pressure control"
    annotation (Placement(transformation(extent={{660,270},{680,290}})));

  CDL.Logical.Latch latConPumLeaSta
    "Latch to pick the condenser water pump lead status"
    annotation (Placement(transformation(extent={{580,-260},{600,-240}})));
  CDL.Logical.Latch latHeaPre[nChi]
    "Latch for picking the chiller head pressure control enabling status"
    annotation (Placement(transformation(extent={{548,270},{568,290}})));
  CDL.Logical.Pre preConPumLeaSta
    "Lead condenser water pump status from previous step"
    annotation (Placement(transformation(extent={{620,-260},{640,-240}})));
  CDL.Interfaces.BooleanOutput yLeaChiWatPum "Lead pump status setpoint"
    annotation (Placement(transformation(extent={{800,560},{840,600}}),
        iconTransformation(extent={{100,200},{140,240}})));
  Generic.EquipmentRotation.ControllerTwo equRot
    "fixme - rotates 2 pumps or groups of pumps"
    annotation (Placement(transformation(extent={{360,560},{380,580}})));
  CDL.Integers.Sources.Constant conInt1
                                      [nChiWatPum](k={1,2})
    "Fixme - 2 pumps or groups of pumps only"
    annotation (Placement(transformation(extent={{420,590},{440,610}})));
  CDL.Integers.Sources.Constant conInt2
                                      [nChiWatPum](k={2,1})
    "Fixme - 2 pumps or groups of pumps only"
    annotation (Placement(transformation(extent={{420,540},{440,560}})));
  CDL.Logical.IntegerSwitch intSwi[2]
    "fixme - two devices or groups of devices"
    annotation (Placement(transformation(extent={{480,560},{500,580}})));
  CDL.Logical.Xor xor[nTowCel]
    "Outputs true when input signals are not the same. fixme - move to inside towCon"
    annotation (Placement(transformation(extent={{-360,-760},{-340,-740}})));
  CDL.Logical.Latch lat1
    annotation (Placement(transformation(extent={{540,200},{560,220}})));
  CDL.Logical.Latch lat2
    annotation (Placement(transformation(extent={{560,150},{580,170}})));
  CDL.Logical.Pre pre2
    annotation (Placement(transformation(extent={{42,-500},{62,-480}})));
equation
  connect(staSetCon.uPla, plaEna.yPla) annotation(Line(points={{-168,72},{-480,
          72},{-480,-460},{-518,-460}},        color={255,0,255}));
  connect(TOutWet, wseSta.TOutWet) annotation(Line(points={{-820,130},{-720,130},
          {-720,336},{-584,336}},      color={0,0,127}));
  connect(TChiWatRetDow, wseSta.TChiWatRetDow) annotation(Line(points={{-820,20},
          {-690,20},{-690,320},{-584,320}},       color={0,0,127}));
  connect(VChiWat_flow, wseSta.VChiWat_flow) annotation(Line(points={{-820,-20},
          {-760,-20},{-760,312},{-584,312}}, color={0,0,127}));
  connect(chiWatSupResReq, plaEna.chiWatSupResReq) annotation(Line(points={{-820,
          250},{-680,250},{-680,-452},{-564,-452}},        color={255,127,0}));
  connect(chiWatSupSet.TChiWatSupSet, staSetCon.TChiWatSupSet) annotation(Line(
        points={{-316,428},{-260,428},{-260,48},{-168,48}},     color={0,0,127}));
  connect(TChiWatSup, staSetCon.TChiWatSup) annotation(Line(points={{-820,-90},
          {-710,-90},{-710,40},{-168,40}},       color={0,0,127}));
  connect(VChiWat_flow, minBypValCon.VChiWat_flow) annotation(Line(points={{-820,
          -20},{-760,-20},{-760,-140},{-564,-140}},    color={0,0,127}));
  connect(TChiWatRet, staSetCon.TChiWatRet) annotation(Line(points={{-820,60},{
          -740,60},{-740,-48},{-168,-48}},                             color={0,
          0,127}));
  connect(staSetCon.TWsePre, wseSta.TWsePre) annotation(Line(points={{-168,-56},
          {-280,-56},{-280,320},{-538,320}},
        color={0,0,127}));
  connect(VChiWat_flow, staSetCon.VChiWat_flow) annotation(Line(points={{-820,
          -20},{-760,-20},{-760,-64},{-168,-64}},
        color={0,0,127}));
  connect(chiWatSupResReq, chiWatPlaRes.TChiWatSupResReq) annotation(Line(
        points={{-820,250},{-680,250},{-680,-300},{-564,-300}},   color={255,
          127,0}));
  connect(chiWatPlaRes.yChiWatPlaRes, chiWatSupSet.uChiWatPlaRes) annotation (
      Line(points={{-516,-300},{-440,-300},{-440,440},{-364,440}},
                                                                color={0,0,127}));
  connect(dpChiWatPum, staSetCon.dpChiWatPum) annotation(Line(points={{-820,-120},
          {-752,-120},{-752,0},{-168,0}},           color={0,0,127}));
  connect(chiWatSupSet.dpChiWatPumSet, staSetCon.dpChiWatPumSet) annotation (
      Line(points={{-316,452},{-250,452},{-250,-8},{-168,-8}},     color={0,0,
          127}));
  connect(uChi, towCon.uChi) annotation(Line(points={{-820,540},{-700,540},{-700,
          -572},{-208,-572}},           color={255,0,255}));
  connect(wseSta.y, staSetCon.uWseSta) annotation(Line(points={{-538,330},{-500,
          330},{-500,96},{-168,96}},            color={255,0,255}));
  connect(wseSta.y, towCon.uWse) annotation(Line(points={{-538,330},{-500,330},
          {-500,-580},{-208,-580}},     color={255,0,255}));
  connect(plaEna.yPla, towCon.uPla) annotation(Line(points={{-518,-460},{-480,
          -460},{-480,-636},{-208,-636}},     color={255,0,255}));
  connect(TOutWet, staSetCon.TOutWet) annotation(Line(points={{-820,130},{-720,130},
          {-720,-20},{-168,-20}},                      color={0,0,127}));
  connect(towCon.yFanSpe, mulMax.u) annotation(Line(points={{-112,-684},{-80,-684},
          {-80,-550},{-62,-550}},       color={0,0,127}));
  connect(mulMax.y, staSetCon.uTowFanSpeMax) annotation(Line(points={{-38,-550},
          {-20,-550},{-20,-360},{-200,-360},{-200,-36},{-168,-36}},
        color={0,0,127}));
  connect(staSetCon.ySta, upProCon.uStaSet) annotation(Line(points={{-72,-24},{-40,
          -24},{-40,436},{272,436}},                      color={255,127,0}));
  connect(staSetCon.ySta, dowProCon.uStaSet) annotation(Line(points={{-72,-24},{
          -40,-24},{-40,-147.2},{272,-147.2}},            color={255,127,0}));
  connect(staSetCon.yChiSet, upProCon.uChiSet) annotation(Line(points={{-72,4},{
          -10,4},{-10,424},{272,424}},
        color={255,0,255}));
  connect(staSetCon.yChiSet, dowProCon.uChiSet) annotation(Line(points={{-72,4},
          {-10,4},{-10,-155.2},{272,-155.2}},               color={255,0,255}));
  connect(uChiLoa, upProCon.uChiLoa) annotation(Line(points={{-820,160},{-270,160},
          {-270,408},{272,408}},                             color={0,0,127}));
  connect(upProCon.yStaPro, chaProUpDown.u1) annotation(Line(points={{368,436},{
          480,436},{480,-80},{498,-80}},           color={255,0,255}));
  connect(dowProCon.yStaPro, chaProUpDown.u2) annotation(Line(points={{368,-144},
          {480,-144},{480,-88},{498,-88}},       color={255,0,255}));
  connect(uChi, dowProCon.uChi) annotation(Line(points={{-820,540},{-700,540},{-700,
          -188},{272,-188}},
        color={255,0,255}));
  connect(staSam.u, intToRea.y)
    annotation(Line(points={{78,-20},{62,-20}}, color={0,0,127}));
  connect(staSam.y, reaToInt1.u)
    annotation(Line(points={{102,-20},{118,-20}},
                                                color={0,0,127}));
  connect(staSetCon.ySta, intToRea.u) annotation(Line(points={{-72,-24},{-40,-24},
          {-40,-20},{38,-20}},               color={255,127,0}));
  connect(reaToInt1.y, dowProCon.uChiSta) annotation(Line(points={{142,-20},{160,
          -20},{160,-208},{272,-208}},   color={255,127,0}));
  connect(reaToInt1.y, staSetCon.uSta) annotation(Line(points={{142,-20},{160,-20},
          {160,-208},{-360,-208},{-360,60},{-168,60}},      color={255,127,0}));
  connect(mulMax.y, wseSta.uTowFanSpeMax) annotation(Line(points={{-38,-550},{
          -20,-550},{-20,-360},{-600,-360},{-600,304},{-584,304}},
                      color={0,0,127}));
  connect(towCon.yNumCel, yNumCel) annotation(Line(points={{-112,-572},{720,
          -572},{720,-540},{820,-540}},      color={255,127,0}));
  connect(towCon.yIsoVal, yIsoVal) annotation(Line(points={{-112,-620},{720,
          -620},{720,-630},{820,-630}},      color={0,0,127}));
  connect(towCon.yFanSpe, yFanSpe) annotation(Line(points={{-112,-684},{720,
          -684},{720,-690},{820,-690}},
                      color={0,0,127}));
  connect(towCon.yLeaCel, yLeaCel) annotation(Line(points={{-112,-596},{720,
          -596},{720,-590},{820,-590}},      color={255,0,255}));
  connect(towCon.yTowSta, yTowSta) annotation(Line(points={{-112,-660},{820,
          -660}},                            color={255,0,255}));
  connect(towCon.yMakUp, yMakUp) annotation(Line(points={{-112,-708},{720,-708},
          {720,-740},{820,-740}},        color={255,0,255}));
  connect(chaProUpDown.y, chiWatPlaRes.chaPro) annotation(Line(points={{522,-80},
          {550,-80},{550,-340},{-580,-340},{-580,-312},{-564,-312}},      color=
         {255,0,255}));
  connect(uChiWatPum, chiWatPlaRes.uChiWatPum) annotation(Line(points={{-820,
          340},{-670,340},{-670,-288},{-564,-288}},
        color={255,0,255}));
  connect(mulOr.y, minBypValCon.uChiWatPum) annotation(Line(points={{-618,-100},
          {-590,-100},{-590,-124},{-564,-124}}, color={255,0,255}));
  connect(uChiWatPum, mulOr.u) annotation(Line(points={{-820,340},{-670,340},{
          -670,-100},{-642,-100}},color={255,0,255}));
  connect(staSetCon.yOpeParLoaRatMin, dowProCon.yOpeParLoaRatMin) annotation (
      Line(points={{-72,-44},{-60,-44},{-60,-168},{272,-168}},           color=
          {0,0,127}));
  connect(uChi, upProCon.uChi) annotation(Line(points={{-820,540},{-700,540},{-700,
          400},{272,400}},color={255,0,255}));
  connect(wseSta.y, upProCon.uWSE) annotation(Line(points={{-538,330},{0,330},{0,
          340},{272,340}},color={255,0,255}));
  connect(wseSta.y, dowProCon.uWSE) annotation(Line(points={{-538,330},{-500,
          330},{-500,-276},{272,-276}},color={255,0,255}));
  connect(dowProCon.VChiWat_flow, VChiWat_flow) annotation(Line(points={{272,-196},
          {-760,-196},{-760,-20},{-820,-20}},color={0,0,127}));
  connect(uChiIsoVal, chiWatPumCon.uChiIsoVal) annotation(Line(points={{-820,670},
          {220,670},{220,504},{534,504}},color={255,0,255}));
  connect(VChiWat_flow, chiWatPumCon.VChiWat_flow) annotation(Line(points={{-820,
          -20},{-760,-20},{-760,498},{534,498}},color={0,0,127}));
  connect(dpChiWat_remote, chiWatPumCon.dpChiWat_remote) annotation(Line(
        points={{-820,-150},{-770,-150},{-770,486},{534,486}},color={0,0,127}));
  connect(upProCon.yChiDem, yChiDem) annotation(Line(points={{368,420},{594,420},
          {594,400},{820,400}},color={0,0,127}));
  connect(TChiWatSup, towCon.TChiWatSup) annotation(Line(points={{-820,-90},{
          -710,-90},{-710,-596},{-208,-596}},color={0,0,127}));
  connect(chiWatSupSet.TChiWatSupSet, towCon.TChiWatSupSet) annotation(Line(
        points={{-316,428},{-260,428},{-260,-604},{-208,-604}},color={0,0,127}));
  connect(dowProCon.uChiLoa, uChiLoa) annotation(Line(points={{272,-176},{-270,-176},
          {-270,160},{-820,160}},color={0,0,127}));
  connect(dowProCon.uChiWatIsoVal, uChiWatIsoVal) annotation(Line(points={{272,-232},
          {-650,-232},{-650,-200},{-820,-200}},color={0,0,127}));
  connect(uChiWatIsoVal, upProCon.uChiWatIsoVal) annotation(Line(points={{-820,-200},
          {-650,-200},{-650,292},{272,292}}, color={0,0,127}));
  connect(yChiWatPum, chiWatPumCon.yChiWatPum) annotation(Line(points={{820,520},
          {760,520},{760,510},{606,510}},color={255,0,
          255}));
  connect(chiWatPumCon.yPumSpe, yChiPumSpe) annotation(Line(points={{606,486},{820,
          486}},                          color={0,0,127}));
  connect(chiWatSupSet.dpChiWatPumSet, chiWatPumCon.dpChiWatSet) annotation (
      Line(points={{-316,452},{-250,452},{-250,480},{534,480}},
                                                              color={0,0,127}));
  connect(uChiAva, staSetCon.uChiAva) annotation(Line(points={{-820,440},{-660,
          440},{-660,80},{-168,80}},                   color={255,0,255}));
  connect(minBypValCon.yValPos, yValPos) annotation(Line(points={{-516,-140},{-380,
          -140},{-380,-440},{820,-440}},                            color={0,0,
          127}));
  connect(staSetCon.ySta, towCon.uChiStaSet) annotation(Line(points={{-72,-24},{
          -40,-24},{-40,-500},{-420,-500},{-420,-676},{-208,-676}},
        color={255,127,0}));
  connect(TConWatSup, towCon.TConWatSup) annotation(Line(points={{-820,-260},{
          -760,-260},{-760,-660},{-208,-660}},    color={0,0,127}));
  connect(TConWatRet, towCon.TConWatRet) annotation(Line(points={{-820,-60},{
          -780,-60},{-780,-644},{-208,-644}},    color={0,0,127}));
  connect(watLev, towCon.watLev) annotation (Line(points={{-820,-760},{-780,-760},
          {-780,-716},{-208,-716}}, color={0,0,127}));
  connect(towCon.uIsoVal, uIsoVal) annotation(Line(points={{-208,-708},{-780,
          -708},{-780,-680},{-820,-680}},    color={0,0,127}));
  connect(uChiLoa, towCon.chiLoa) annotation(Line(points={{-820,160},{-746,160},
          {-746,-564},{-208,-564}},         color={0,0,127}));
  connect(uTowSta, towCon.uTowSta) annotation (Line(points={{-820,390},{-734,
          390},{-734,-628},{-208,-628}}, color={255,0,255}));
  connect(uConWatPumSpe, conWatPumSpe.u) annotation (Line(points={{-820,-400},{
          -562,-400}},                         color={0,0,127}));
  connect(uConWatPumSpe, towCon.uConWatPumSpe) annotation (Line(points={{-820,
          -400},{-600,-400},{-600,-652},{-208,-652}}, color={0,0,127}));
  connect(conWatPumSpe.y, dowProCon.uConWatPumSpe) annotation (Line(points={{-538,
          -400},{220,-400},{220,-296},{272,-296}},      color={0,0,127}));
  connect(conWatPumSpe.y, upProCon.uConWatPumSpe) annotation (Line(points={{-538,
          -400},{-148,-400},{-148,-402},{252,-402},{252,316},{272,316}},
                                                      color={0,0,127}));
  connect(wseSta.yTunPar, staSetCon.uTunPar) annotation (Line(points={{-538,310},
          {-510,310},{-510,-28},{-168,-28}},         color={0,0,127}));
  connect(TChiWatRet, wseSta.TChiWatRet) annotation (Line(points={{-820,60},{
          -740,60},{-740,328},{-584,328}}, color={0,0,127}));
  connect(chaProUpDown.y, staSetCon.chaPro) annotation (Line(points={{522,-80},
          {550,-80},{550,-340},{-220,-340},{-220,88},{-168,88}}, color={255,0,
          255}));
  connect(reaToInt1.y, upProCon.uChiSta) annotation (Line(points={{142,-20},{160,
          -20},{160,368},{272,368}}, color={255,127,0}));
  connect(reaToInt1.y, towCon.uChiSta) annotation (Line(points={{142,-20},{160,-20},
          {160,-208},{-360,-208},{-360,-668},{-208,-668}}, color={255,127,0}));
  connect(chaProUpDown.y, falEdg.u)
    annotation (Line(points={{522,-80},{558,-80}}, color={255,0,255}));
  connect(upProCon.yTowStaUp, staCooTow.u1) annotation (Line(points={{368,388},{
          470,388},{470,-120},{498,-120}},
                                         color={255,0,255}));
  connect(dowProCon.yTowStaDow, staCooTow.u2) annotation (Line(points={{368,
          -220},{470,-220},{470,-128},{498,-128}},
                                         color={255,0,255}));
  connect(TOut, plaEna.TOut) annotation (Line(points={{-820,100},{-724,100},{-724,
          -468.4},{-564,-468.4}}, color={0,0,127}));
  connect(towCon.uFanSpe, uFanSpe)
    annotation (Line(points={{-208,-588},{-820,-588}}, color={0,0,127}));
  connect(uChiConIsoVal, dowProCon.uChiConIsoVal) annotation (Line(points={{-820,
          640},{210,640},{210,-264},{272,-264}}, color={255,0,255}));
  connect(uChiConIsoVal, upProCon.uChiConIsoVal) annotation (Line(points={{-820,
          640},{260,640},{260,380},{272,380}}, color={255,0,255}));
  connect(upProCon.uConWatReq, uConWatReq) annotation (Line(points={{272,352},{252,
          352},{252,580},{-820,580}}, color={255,0,255}));
  connect(upProCon.uChiWatReq, uChiWatReq) annotation (Line(points={{272,284},{240,
          284},{240,608},{-288,608},{-288,610},{-820,610}},
                                      color={255,0,255}));
  connect(uChiWatReq, dowProCon.uChiWatReq) annotation (Line(points={{-820,610},
          {200,610},{200,-244},{272,-244}}, color={255,0,255}));
  connect(uConWatReq, dowProCon.uConWatReq) annotation (Line(points={{-820,580},
          {190,580},{190,-252},{272,-252}}, color={255,0,255}));
  connect(VChiWat_flow, upProCon.VChiWat_flow) annotation (Line(points={{-820,-20},
          {-760,-20},{-760,390.4},{272,390.4}}, color={0,0,127}));
  connect(heaCon.y,heaPreCon.uChiHeaCon)  annotation (Line(points={{682,280},{
          700,280},{700,240},{-470,240},{-470,220},{-424,220}}, color={255,0,
          255}));
  connect(wseSta.y, booRep.u) annotation (Line(points={{-538,330},{-500,330},{
          -500,300},{-482,300}}, color={255,0,255}));
  connect(booRep.y, heaPreCon.uWSE) annotation (Line(points={{-458,300},{-450,
          300},{-450,188},{-424,188}}, color={255,0,255}));
  connect(TConWatRet, conWatRetTem.u) annotation (Line(points={{-820,-60},{-780,
          -60},{-780,240},{-642,240}}, color={0,0,127}));
  connect(conWatRetTem.y, heaPreCon.TConWatRet) annotation (Line(points={{-618,
          240},{-480,240},{-480,212},{-424,212}}, color={0,0,127}));
  connect(TChiWatSup, chiWatSupTem.u) annotation (Line(points={{-820,-90},{-710,
          -90},{-710,220},{-582,220}}, color={0,0,127}));
  connect(chiWatSupTem.y, heaPreCon.TChiWatSup) annotation (Line(points={{-558,
          220},{-490,220},{-490,204},{-424,204}}, color={0,0,127}));
  connect(falEdg.y, staSam.trigger) annotation (Line(points={{582,-80},{590,-80},
          {590,-40},{90,-40},{90,-31.8}}, color={255,0,255}));
  connect(upProCon.yDesConWatPumSpe, desConWatPumSpeSwi.u1) annotation (Line(
        points={{368,356},{592,356},{592,208},{618,208}}, color={0,0,127}));
  connect(dowProCon.yDesConWatPumSpe, desConWatPumSpeSwi.u3) annotation (Line(
        points={{368,-264},{460,-264},{460,192},{618,192}}, color={0,0,127}));
  connect(desConWatPumSpeSwi.y, repDesConTem.u)
    annotation (Line(points={{642,200},{658,200}}, color={0,0,127}));
  connect(repDesConTem.y, heaPreCon.desConWatPumSpe) annotation (Line(points={{
          682,200},{700,200},{700,234},{-432,234},{-432,196},{-424,196}}, color=
         {0,0,127}));
  connect(heaPreCon.uHeaPreCon, uHeaPreCon) annotation (Line(points={{-424,180},
          {-520,180},{-520,200},{-820,200}}, color={0,0,127}));
  connect(heaPreCon.yMaxTowSpeSet, towCon.uMaxTowSpeSet) annotation (Line(
        points={{-376,212},{-320,212},{-320,-620},{-208,-620}}, color={0,0,127}));
  connect(heaPreCon.yHeaPreConVal, yHeaPreConVal) annotation (Line(points={{-376,
          200},{-60,200},{-60,180},{820,180}},      color={0,0,127}));
  connect(heaPreCon.yConWatPumSpeSet, mulMin.u) annotation (Line(points={{-376,188},
          {-370,188},{-370,180},{-362,180}},      color={0,0,127}));
  connect(mulMin.y, dowProCon.uConWatPumSpeSet) annotation (Line(points={{-338,
          180},{-310,180},{-310,-288},{272,-288}}, color={0,0,127}));
  connect(mulMin.y, upProCon.uConWatPumSpeSet) annotation (Line(points={{-338,180},
          {-310,180},{-310,328},{272,328}},      color={0,0,127}));
  connect(upProCon.yChiWatMinFloSet, chiMinFloSet.u1) annotation (Line(points={{368,404},
          {600,404},{600,158},{618,158}},           color={0,0,127}));
  connect(dowProCon.yChiWatMinFloSet, chiMinFloSet.u3) annotation (Line(points=
          {{368,-296},{450,-296},{450,142},{618,142}}, color={0,0,127}));
  connect(chiMinFloSet.y, minBypValCon.VChiWatSet_flow) annotation (Line(points=
         {{642,150},{700,150},{700,-100},{-580,-100},{-580,-156},{-564,-156}},
        color={0,0,127}));
  connect(heaCon.y, upProCon.uChiHeaCon) annotation (Line(points={{682,280},{710,
          280},{710,132},{260,132},{260,304},{272,304}},     color={255,0,255}));
  connect(heaCon.y, dowProCon.uChiHeaCon) annotation (Line(points={{682,280},{720,
          280},{720,100},{230,100},{230,-220},{272,-220}},     color={255,0,255}));
  connect(uChiStaPro.y, yChi) annotation (Line(points={{722,350},{760,350},{760,
          300},{820,300}}, color={255,0,255}));
  connect(uChiSwi.y, uChiStaPro.u2)
    annotation (Line(points={{682,350},{698,350}}, color={255,0,255}));
  connect(lat.y, uChiSwi.u)
    annotation (Line(points={{642,350},{658,350}}, color={255,0,255}));
  connect(upProCon.yStaPro, lat.u) annotation (Line(points={{368,436},{610,436},
          {610,350},{618,350}}, color={255,0,255}));
  connect(dowProCon.yStaPro, lat.clr) annotation (Line(points={{368,-144},{610,-144},
          {610,344},{618,344}}, color={255,0,255}));
  connect(upProCon.yChi, uChiStaPro.u1) annotation (Line(points={{368,284},{530,
          284},{530,392},{690,392},{690,358},{698,358}}, color={255,0,255}));
  connect(dowProCon.yChi, uChiStaPro.u3) annotation (Line(points={{368,-172},{690,
          -172},{690,342},{698,342}}, color={255,0,255}));
  connect(staSetCon.yCapReq, towCon.reqPlaCap) annotation (Line(points={{-72,
          -64},{-68,-64},{-68,-480},{-220,-480},{-220,-612},{-208,-612}}, color=
         {0,0,127}));
  connect(latHeaPre.y, heaCon.u)
    annotation (Line(points={{570,280},{658,280}}, color={255,0,255}));
  connect(upProCon.yChiHeaCon, latHeaPre.u) annotation (Line(points={{368,324},{
          420,324},{420,280},{546,280}},  color={255,0,255}));
  connect(dowProCon.yChiHeaCon, latHeaPre.clr) annotation (Line(points={{368,
          -232},{420,-232},{420,274},{546,274}}, color={255,0,255}));
  connect(latConPumLeaSta.y, preConPumLeaSta.u)
    annotation (Line(points={{602,-250},{618,-250}}, color={255,0,255}));
  connect(dowProCon.yLeaPum, latConPumLeaSta.clr) annotation (Line(points={{368,
          -248},{380,-248},{380,-256},{578,-256}}, color={255,0,255}));
  connect(upProCon.yLeaPum, latConPumLeaSta.u) annotation (Line(points={{368,372},
          {402,372},{402,-250},{578,-250}},      color={255,0,255}));
  connect(preConPumLeaSta.y, towCon.uLeaConWatPum) annotation (Line(points={{
          642,-250},{652,-250},{652,-420},{-240,-420},{-240,-692},{-208,-692}},
        color={255,0,255}));
  connect(chiWatPumCon.yLea, yLeaChiWatPum) annotation (Line(points={{606,534},
          {760,534},{760,580},{820,580}}, color={255,0,255}));
  connect(equRot.yDevRol, intSwi.u2) annotation (Line(points={{382,564},{410,
          564},{410,570},{478,570}}, color={255,0,255}));
  connect(conInt1.y, intSwi.u1) annotation (Line(points={{442,600},{460,600},{
          460,578},{478,578}}, color={255,127,0}));
  connect(conInt2.y, intSwi.u3) annotation (Line(points={{442,550},{460,550},{
          460,562},{478,562}}, color={255,127,0}));
  connect(intSwi.y, chiWatPumCon.uPumLeaLag) annotation (Line(points={{502,570},
          {520,570},{520,540},{534,540}}, color={255,127,0}));
  connect(uChiWatPum, equRot.uDevSta) annotation (Line(points={{-820,340},{-682,
          340},{-682,564},{358,564}}, color={255,0,255}));
  connect(equRot.yDevStaSet, chiWatPumCon.uChiWatPum) annotation (Line(points={
          {382,576},{390,576},{390,528},{534,528},{534,528}}, color={255,0,255}));
  connect(chiWatPumCon.yLea, equRot.uLeaStaSet) annotation (Line(points={{606,
          534},{620,534},{620,620},{350,620},{350,576},{358,576}}, color={255,0,
          255}));
  connect(chiWatPumCon.yChiWatPum[1], equRot.uLagStaSet) annotation (Line(
        points={{606,507},{606,508},{630,508},{630,630},{340,630},{340,570},{358,
          570}},
        color={255,0,255}));
  connect(uTowSta, xor.u1) annotation (Line(points={{-820,390},{-776,390},{-776,
          -750},{-362,-750}}, color={255,0,255}));
  connect(towCon.yTowSta, xor.u2) annotation (Line(points={{-112,-660},{-100,
          -660},{-100,-780},{-374,-780},{-374,-758},{-362,-758}}, color={255,0,
          255}));
  connect(xor.y, towCon.uChaCel) annotation (Line(points={{-338,-750},{-240,
          -750},{-240,-700},{-208,-700}}, color={255,0,255}));
  connect(lat1.y, desConWatPumSpeSwi.u2) annotation (Line(points={{562,210},{
          580,210},{580,200},{618,200}}, color={255,0,255}));
  connect(lat2.y, chiMinFloSet.u2) annotation (Line(points={{582,160},{590,160},
          {590,150},{618,150}}, color={255,0,255}));
  connect(upProCon.yStaPro, lat1.u) annotation (Line(points={{368,436},{500,436},
          {500,210},{538,210}}, color={255,0,255}));
  connect(upProCon.yStaPro, lat2.u) annotation (Line(points={{368,436},{500,436},
          {500,160},{558,160}}, color={255,0,255}));
  connect(dowProCon.yStaPro, lat1.clr) annotation (Line(points={{368,-144},{380,
          -144},{380,200},{538,200},{538,204}}, color={255,0,255}));
  connect(dowProCon.yStaPro, lat2.clr) annotation (Line(points={{368,-144},{412,
          -144},{412,154},{558,154}}, color={255,0,255}));

  connect(staCooTow.y, pre2.u) annotation (Line(points={{522,-120},{530,-120},{
          530,-456},{14,-456},{14,-490},{40,-490}}, color={255,0,255}));
  connect(towCon.uTowStaCha, pre2.y) annotation (Line(points={{-208,-684},{-270,
          -684},{-270,-510},{92,-510},{92,-490},{64,-490}}, color={255,0,255}));
annotation (Dialog(tab="Cooling Towers", group="Configuration"),
                Dialog(tab="Chilled water pumps", group="Speed controller"),
                Dialog(tab="Plant Reset", group="Time parameter"),
               Evaluate=true, Dialog(tab="Advanced", group="Tuning"),
  defaultComponentName="chiPlaCon",
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-300},{100,300}}),
        graphics={
        Rectangle(
          extent={{-100,-300},{100,300}},
          lineColor={0,0,0},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Text(
          extent={{-110,344},{110,306}},
          lineColor={0,0,255},
          textString="%name"),
        Rectangle(
          extent={{-50,160},{50,-162}},
          lineColor={28,108,200},
          fillColor={210,210,210},
          fillPattern=FillPattern.Solid,
          borderPattern=BorderPattern.Raised),
        Polygon(
          points={{-50,160},{16,4},{-50,-162},{-50,160}},
          lineColor={175,175,175},
          fillColor={175,175,175},
          fillPattern=FillPattern.Solid)}),
  Diagram(coordinateSystem(extent={{-800,-840},{800,760}}),
          graphics={Text(
          extent={{-482,-574},{-398,-594}},
          lineColor={28,108,200},
          textString="might need a pre block")}),
  Documentation(info="<html>
<p>
Assemble a controller for plants with two devices or groups of devices (chillers, towers(4 cells), CW and C pumps)
</p>
<p>
Implemented configuration: parallel chillers, headered pumps
</p>
</html>",
revisions="<html>
<ul>
<li>
May 30, 2020, by Milica Grahovac:<br/>
First implementation.
</li>
</ul>
</html>"));
end Controller;
