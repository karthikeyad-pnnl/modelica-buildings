within Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Validation;
model Controller
    "Validate boiler water pump control sequence"

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon(
    isHeadered=true,
    primaryOnly=true,
    variablePrimary=true,
    nPum=2,
    nBoi=2,
    nSen=2,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=5*6894.75,
    minLocDp=5*6894.75,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    k=1,
    Ti=10,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.remoteDP)
    annotation (Placement(transformation(extent={{-170,372},{-150,428}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon1(
    isHeadered=true,
    primaryOnly=true,
    variablePrimary=true,
    nPum=2,
    nBoi=2,
    nSen=2,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.localDP)
    annotation (Placement(transformation(extent={{190,362},{210,418}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon2(
    isHeadered=true,
    primaryOnly=false,
    variablePrimary=true,
    nPum=2,
    nBoi=2,
    nSen=2,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.flowrate)
    annotation (Placement(transformation(extent={{-170,222},{-150,278}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon3(
    isHeadered=true,
    primaryOnly=false,
    variablePrimary=true,
    primarySecondaryFlowSensors=false,
    nPum=2,
    nBoi=2,
    nSen=2,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.flowrate)
    annotation (Placement(transformation(extent={{190,202},{210,258}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon4(
    isHeadered=true,
    primaryOnly=false,
    variablePrimary=true,
    primarySecondaryTemperatureSensors=true,
    nPum=2,
    nBoi=2,
    nSen=2,
    numIgnReq=0,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    delTim=900,
    samPer=120,
    triAmo=-0.02,
    resAmo=0.03,
    maxRes=0.06,
    twoReqLimLow=1.2,
    twoReqLimHig=2,
    oneReqLimLow=0.2,
    oneReqLimHig=1,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    annotation (Placement(transformation(extent={{-170,62},{-150,118}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon5(
    isHeadered=true,
    primaryOnly=false,
    variablePrimary=true,
    primarySecondaryTemperatureSensors=false,
    nPum=2,
    nBoi=2,
    nSen=2,
    numIgnReq=0,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    delTim=900,
    samPer=120,
    triAmo=-0.02,
    resAmo=0.03,
    maxRes=0.06,
    twoReqLimLow=1.2,
    twoReqLimHig=2,
    oneReqLimLow=0.2,
    oneReqLimHig=1,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    annotation (Placement(transformation(extent={{190,42},{210,98}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon6(
    isHeadered=true,
    primaryOnly=false,
    variablePrimary=false,
    primarySecondaryTemperatureSensors=false,
    nPum=2,
    nBoi=2,
    nSen=2,
    numIgnReq=0,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    delTim=900,
    samPer=120,
    triAmo=-0.02,
    resAmo=0.03,
    maxRes=0.06,
    twoReqLimLow=1.2,
    twoReqLimHig=2,
    oneReqLimLow=0.2,
    oneReqLimHig=1,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    annotation (Placement(transformation(extent={{-180,-118},{-160,-62}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon7(
    isHeadered=false,
    primaryOnly=false,
    variablePrimary=true,
    nPum=2,
    nBoi=2,
    nSen=2,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.flowrate)
    annotation (Placement(transformation(extent={{210,-138},{230,-82}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon8(
    isHeadered=false,
    primaryOnly=false,
    variablePrimary=true,
    primarySecondaryFlowSensors=false,
    nPum=2,
    nBoi=2,
    nSen=2,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.flowrate)
    annotation (Placement(transformation(extent={{-180,-298},{-160,-242}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon9(
    isHeadered=false,
    primaryOnly=false,
    variablePrimary=true,
    primarySecondaryTemperatureSensors=true,
    nPum=2,
    nBoi=2,
    nSen=2,
    numIgnReq=0,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    delTim=900,
    samPer=120,
    triAmo=-0.02,
    resAmo=0.03,
    maxRes=0.06,
    twoReqLimLow=1.2,
    twoReqLimHig=2,
    oneReqLimLow=0.2,
    oneReqLimHig=1,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    annotation (Placement(transformation(extent={{210,-308},{230,-252}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon10(
    isHeadered=false,
    primaryOnly=false,
    variablePrimary=true,
    primarySecondaryTemperatureSensors=false,
    nPum=2,
    nBoi=2,
    nSen=2,
    numIgnReq=0,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    delTim=900,
    samPer=120,
    triAmo=-0.02,
    resAmo=0.03,
    maxRes=0.06,
    twoReqLimLow=1.2,
    twoReqLimHig=2,
    oneReqLimLow=0.2,
    oneReqLimHig=1,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    annotation (Placement(transformation(extent={{-170,-458},{-150,-402}})));

  Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller
    priPumCon11(
    isHeadered=false,
    primaryOnly=false,
    variablePrimary=false,
    primarySecondaryTemperatureSensors=false,
    nPum=2,
    nBoi=2,
    nSen=2,
    numIgnReq=0,
    nPum_nominal=2,
    minPumSpe=0.1,
    maxPumSpe=1,
    VHotWat_flow_nominal=0.5,
    boiDesFlo={0.5,0.5},
    maxLocDp=10,
    minLocDp=5,
    offTimThr=180,
    timPer=600,
    staCon=-0.03,
    relFloHys=0.01,
    delTim=900,
    samPer=120,
    triAmo=-0.02,
    resAmo=0.03,
    maxRes=0.06,
    twoReqLimLow=1.2,
    twoReqLimHig=2,
    oneReqLimLow=0.2,
    oneReqLimHig=1,
    k=1,
    Ti=0.5,
    Td=0.1,
    speedControlType=Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Types.PrimaryPumpSpeedControlTypes.temperature)
    annotation (Placement(transformation(extent={{190,-488},{210,-432}})));

  CDL.Integers.Sources.Constant conInt[2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{-220,440},{-200,460}})));
  CDL.Logical.Pre pre1[2]
    annotation (Placement(transformation(extent={{-130,390},{-110,410}})));
  CDL.Continuous.Sources.Constant con2(k=0.25)
    annotation (Placement(transformation(extent={{-310,340},{-290,360}})));
  CDL.Continuous.Sources.Sine sin[2](
    amplitude=0.5,
    freqHz=1/900,
    offset=1)
    annotation (Placement(transformation(extent={{-220,360},{-200,380}})));
  CDL.Continuous.Sources.Sine sin1(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{-270,390},{-250,410}})));

  CDL.Integers.Sources.Constant conInt1
                                      [2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{140,430},{160,450}})));
  CDL.Logical.Pre pre2[2]
    annotation (Placement(transformation(extent={{230,380},{250,400}})));
  CDL.Continuous.Sources.Constant con5(k=0.25)
    annotation (Placement(transformation(extent={{48,328},{68,348}})));
  CDL.Continuous.Sources.Sine sin2
                                 [2](
    amplitude=0.5,
    freqHz=1/900,
    offset=1)
    annotation (Placement(transformation(extent={{146,348},{166,368}})));
  CDL.Continuous.Sources.Sine sin3(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{78,348},{98,368}})));
  CDL.Continuous.Sources.Sine sin4(
    amplitude=5,
    freqHz=1/450,
    offset=7.5)
    annotation (Placement(transformation(extent={{158,308},{178,328}})));

  CDL.Integers.Sources.Constant conInt2
                                      [2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{-220,290},{-200,310}})));
  CDL.Logical.Pre pre3[2]
    annotation (Placement(transformation(extent={{-140,240},{-120,260}})));
  CDL.Continuous.Sources.Constant con8(k=0.25)
    annotation (Placement(transformation(extent={{-310,190},{-290,210}})));
  CDL.Continuous.Sources.Sine sin5(
    amplitude=0.1,
    freqHz=1/900,
    offset=0.25)
    annotation (Placement(transformation(extent={{-214,208},{-194,228}})));
  CDL.Continuous.Sources.Sine sin6(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{-280,210},{-260,230}})));
  CDL.Logical.TrueFalseHold truFalHol(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-130,280},{-110,300}})));
  CDL.Logical.Sources.Pulse booPul1(period=1800, startTime=15)
    annotation (Placement(transformation(extent={{-280,170},{-260,190}})));
  CDL.Logical.Sources.Constant con9(k=true)
    annotation (Placement(transformation(extent={{-250,210},{-230,230}})));

  CDL.Integers.Sources.Constant conInt3
                                      [2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{140,270},{160,290}})));
  CDL.Logical.Pre pre4[2]
    annotation (Placement(transformation(extent={{220,220},{240,240}})));
  CDL.Continuous.Sources.Constant con12(k=0.25)
    annotation (Placement(transformation(extent={{50,170},{70,190}})));
  CDL.Continuous.Sources.Sine sin7(
    amplitude=0.1,
    freqHz=1/900,
    offset=0)
    annotation (Placement(transformation(extent={{140,188},{160,208}})));
  CDL.Continuous.Sources.Sine sin8(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0)
    annotation (Placement(transformation(extent={{80,190},{100,210}})));
  CDL.Logical.TrueFalseHold truFalHol1(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{230,260},{250,280}})));
  CDL.Logical.Sources.Pulse booPul3(period=1800, startTime=15)
    annotation (Placement(transformation(extent={{80,150},{100,170}})));
  CDL.Logical.Sources.Constant con13(k=true)
    annotation (Placement(transformation(extent={{110,190},{130,210}})));

  CDL.Integers.Sources.Constant conInt4
                                      [2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{-220,130},{-200,150}})));
  CDL.Logical.Pre pre5[2]
    annotation (Placement(transformation(extent={{-140,80},{-120,100}})));
  CDL.Continuous.Sources.Constant con16(k=0.25)
    annotation (Placement(transformation(extent={{-310,30},{-290,50}})));
  CDL.Continuous.Sources.Sine sin9(
    amplitude=1.5,
    freqHz=1/3600,
    phase=3.1415926535898,
    offset=1)
    annotation (Placement(transformation(extent={{-214,48},{-194,68}})));
  CDL.Continuous.Sources.Sine sin10(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{-280,50},{-260,70}})));
  CDL.Logical.TrueFalseHold truFalHol2(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-130,120},{-110,140}})));
  CDL.Logical.Sources.Pulse booPul5(period=1800, startTime=15)
    annotation (Placement(transformation(extent={{-280,10},{-260,30}})));
  CDL.Logical.Sources.Constant con17(k=true)
    annotation (Placement(transformation(extent={{-250,50},{-230,70}})));
  CDL.Continuous.Sources.Constant con18(k=1)
    annotation (Placement(transformation(extent={{-310,-10},{-290,10}})));

  CDL.Integers.Sources.Constant conInt5
                                      [2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{140,110},{160,130}})));
  CDL.Logical.Pre pre6[2]
    annotation (Placement(transformation(extent={{220,60},{240,80}})));
  CDL.Continuous.Sources.Constant con21(k=0.25)
    annotation (Placement(transformation(extent={{50,10},{70,30}})));
  CDL.Continuous.Sources.Sine sin11[2](
    amplitude=fill(1.5, 2),
    freqHz=fill(1/3600, 2),
    phase=fill(3.14, 2),
    offset=fill(1, 2),
    startTime=fill(0, 2))
    annotation (Placement(transformation(extent={{146,28},{166,48}})));
  CDL.Continuous.Sources.Sine sin12(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{80,30},{100,50}})));
  CDL.Logical.TrueFalseHold truFalHol3(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{230,100},{250,120}})));
  CDL.Logical.Sources.Pulse booPul7(period=1800, startTime=15)
    annotation (Placement(transformation(extent={{80,-10},{100,10}})));
  CDL.Logical.Sources.Constant con22(k=true)
    annotation (Placement(transformation(extent={{110,30},{130,50}})));
  CDL.Continuous.Sources.Constant con23(k=1)
    annotation (Placement(transformation(extent={{50,-30},{70,-10}})));

  CDL.Integers.Sources.Constant conInt6
                                      [2](k={2,1}) "Pump rotation"
    annotation (Placement(transformation(extent={{-230,-50},{-210,-30}})));
  CDL.Logical.Pre pre7[2]
    annotation (Placement(transformation(extent={{-150,-100},{-130,-80}})));
  CDL.Continuous.Sources.Sine sin14(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{-290,-130},{-270,-110}})));
  CDL.Logical.TrueFalseHold truFalHol4(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-140,-60},{-120,-40}})));
  CDL.Logical.Sources.Pulse booPul9(period=1800, startTime=15)
    annotation (Placement(transformation(extent={{-290,-170},{-270,-150}})));
  CDL.Logical.Sources.Constant con27(k=true)
    annotation (Placement(transformation(extent={{-260,-130},{-240,-110}})));

  CDL.Integers.Sources.Constant conInt7(k=2) "Pump rotation"
    annotation (Placement(transformation(extent={{130,-150},{150,-130}})));
  CDL.Logical.Pre pre8[2]
    annotation (Placement(transformation(extent={{240,-120},{260,-100}})));
  CDL.Continuous.Sources.Constant con29(k=0.25)
    annotation (Placement(transformation(extent={{70,-170},{90,-150}})));
  CDL.Continuous.Sources.Sine sin13(
    amplitude=0.5,
    freqHz=1/900,
    offset=0.25)
    annotation (Placement(transformation(extent={{166,-152},{186,-132}})));
  CDL.Continuous.Sources.Sine sin15(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{100,-150},{120,-130}})));
  CDL.Logical.TrueFalseHold truFalHol5(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{250,-80},{270,-60}})));
  CDL.Logical.Sources.Pulse booPul11(period=1800, startTime=10)
    annotation (Placement(transformation(extent={{100,-190},{120,-170}})));

  CDL.Integers.Sources.Constant conInt8(k=2) "Pump rotation"
    annotation (Placement(transformation(extent={{-260,-310},{-240,-290}})));
  CDL.Logical.Pre pre9[2]
    annotation (Placement(transformation(extent={{-150,-280},{-130,-260}})));
  CDL.Continuous.Sources.Constant con32(k=0.25)
    annotation (Placement(transformation(extent={{-320,-330},{-300,-310}})));
  CDL.Continuous.Sources.Sine sin16(
    amplitude=0.5,
    freqHz=1/900,
    offset=0)
    annotation (Placement(transformation(extent={{-230,-312},{-210,-292}})));
  CDL.Continuous.Sources.Sine sin17(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{-290,-310},{-270,-290}})));
  CDL.Logical.TrueFalseHold truFalHol6(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-140,-240},{-120,-220}})));
  CDL.Logical.Sources.Pulse booPul13(period=1800, startTime=10)
    annotation (Placement(transformation(extent={{-290,-350},{-270,-330}})));

  CDL.Integers.Sources.Constant conInt9(k=2) "Pump rotation"
    annotation (Placement(transformation(extent={{130,-320},{150,-300}})));
  CDL.Logical.Pre pre10
                      [2]
    annotation (Placement(transformation(extent={{240,-290},{260,-270}})));
  CDL.Continuous.Sources.Constant con35(k=0.25)
    annotation (Placement(transformation(extent={{70,-340},{90,-320}})));
  CDL.Continuous.Sources.Sine sin18(
    amplitude=1.5,
    freqHz=1/3600,
    phase(displayUnit="deg") = 3.1415926535898,
    offset=0.25)
    annotation (Placement(transformation(extent={{166,-322},{186,-302}})));
  CDL.Continuous.Sources.Sine sin19(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{100,-320},{120,-300}})));
  CDL.Logical.TrueFalseHold truFalHol7(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{250,-250},{270,-230}})));
  CDL.Logical.Sources.Pulse booPul15(period=1800, startTime=10)
    annotation (Placement(transformation(extent={{100,-360},{120,-340}})));
  CDL.Continuous.Sources.Constant con37(k=0.25)
    annotation (Placement(transformation(extent={{70,-380},{90,-360}})));

  CDL.Integers.Sources.Constant conInt10(k=2) "Pump rotation"
    annotation (Placement(transformation(extent={{-250,-470},{-230,-450}})));
  CDL.Logical.Pre pre11
                      [2]
    annotation (Placement(transformation(extent={{-140,-440},{-120,-420}})));
  CDL.Continuous.Sources.Constant con39(k=0.25)
    annotation (Placement(transformation(extent={{-310,-490},{-290,-470}})));
  CDL.Continuous.Sources.Sine sin20[2](
    amplitude=fill(1.5, 2),
    freqHz=fill(1/3600, 2),
    phase=fill(3.14, 2),
    offset=fill(1, 2),
    startTime=fill(0, 2))
    annotation (Placement(transformation(extent={{-214,-472},{-194,-452}})));
  CDL.Continuous.Sources.Sine sin21(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{-280,-470},{-260,-450}})));
  CDL.Logical.TrueFalseHold truFalHol8(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-130,-400},{-110,-380}})));
  CDL.Logical.Sources.Pulse booPul17(period=1800, startTime=10)
    annotation (Placement(transformation(extent={{-280,-510},{-260,-490}})));
  CDL.Continuous.Sources.Constant con41(k=1)
    annotation (Placement(transformation(extent={{-310,-530},{-290,-510}})));

  CDL.Integers.Sources.Constant conInt11(k=2) "Pump rotation"
    annotation (Placement(transformation(extent={{120,-500},{140,-480}})));
  CDL.Logical.Pre pre12
                      [2]
    annotation (Placement(transformation(extent={{220,-470},{240,-450}})));
  CDL.Continuous.Sources.Sine sin22(
    amplitude=0.1,
    freqHz=1/3600,
    offset=0.25)
    annotation (Placement(transformation(extent={{80,-500},{100,-480}})));
  CDL.Logical.TrueFalseHold truFalHol9(trueHoldDuration=10, falseHoldDuration=0)
    annotation (Placement(transformation(extent={{230,-430},{250,-410}})));
  CDL.Logical.Sources.Pulse booPul19(period=1800, startTime=10)
    annotation (Placement(transformation(extent={{80,-540},{100,-520}})));
  CDL.Logical.Change cha12
    annotation (Placement(transformation(extent={{-220,170},{-200,190}})));
  CDL.Logical.Change cha13
    annotation (Placement(transformation(extent={{140,150},{160,170}})));
  CDL.Logical.Change cha14
    annotation (Placement(transformation(extent={{-220,10},{-200,30}})));
  CDL.Logical.Change cha15
    annotation (Placement(transformation(extent={{140,-10},{160,10}})));
  CDL.Logical.Change cha16
    annotation (Placement(transformation(extent={{-230,-170},{-210,-150}})));
  CDL.Logical.Change cha17
    annotation (Placement(transformation(extent={{140,-190},{160,-170}})));
  CDL.Logical.Change cha18
    annotation (Placement(transformation(extent={{-250,-350},{-230,-330}})));
  CDL.Logical.Change cha19
    annotation (Placement(transformation(extent={{132,-360},{152,-340}})));
  CDL.Logical.Change cha20
    annotation (Placement(transformation(extent={{-250,-510},{-230,-490}})));
  CDL.Logical.Change cha21
    annotation (Placement(transformation(extent={{120,-540},{140,-520}})));
  CDL.Logical.Edge edg
    annotation (Placement(transformation(extent={{180,-360},{200,-340}})));
  CDL.Logical.Edge edg1
    annotation (Placement(transformation(extent={{180,-190},{200,-170}})));
  CDL.Logical.Edge edg2
    annotation (Placement(transformation(extent={{-210,-350},{-190,-330}})));
  CDL.Logical.Edge edg3
    annotation (Placement(transformation(extent={{-210,-510},{-190,-490}})));
  CDL.Logical.Edge edg4
    annotation (Placement(transformation(extent={{160,-540},{180,-520}})));
  CDL.Continuous.Sources.Pulse pul[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{-310,380},{-290,400}})));
  CDL.Continuous.Sources.Constant con1(k=1)
    annotation (Placement(transformation(extent={{-260,440},{-240,460}})));
  CDL.Continuous.Sources.Pulse pul1[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{40,400},{60,420}})));
  CDL.Continuous.Sources.Constant con3(k=1)
    annotation (Placement(transformation(extent={{80,380},{100,400}})));
  CDL.Continuous.Sources.Pulse pul2[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{-300,260},{-280,280}})));
  CDL.Continuous.Sources.Pulse pul3[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{60,240},{80,260}})));
  CDL.Continuous.Sources.Pulse pul4[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{-300,100},{-280,120}})));
  CDL.Continuous.Sources.Pulse pul5[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  CDL.Continuous.Sources.Pulse pul6[2](
    amplitude=fill(1, 2),
    width=fill(0.95, 2),
    period=fill(3600, 2),
    startTime=fill(10, 2))
    annotation (Placement(transformation(extent={{-280,-80},{-260,-60}})));
  CDL.Logical.TrueFalseHold truFalHol10(trueHoldDuration=3300,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{130,-110},{150,-90}})));
  CDL.Logical.Or or2
    annotation (Placement(transformation(extent={{160,-80},{180,-60}})));
  CDL.Logical.TrueFalseHold truFalHol11(trueHoldDuration=3300,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-260,-270},{-240,-250}})));
  CDL.Logical.Or or1
    annotation (Placement(transformation(extent={{-230,-240},{-210,-220}})));
  CDL.Logical.TrueFalseHold truFalHol12(trueHoldDuration=3300,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{130,-280},{150,-260}})));
  CDL.Logical.Or or3
    annotation (Placement(transformation(extent={{170,-250},{190,-230}})));
  CDL.Logical.TrueFalseHold truFalHol13(trueHoldDuration=3300,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{-250,-430},{-230,-410}})));
  CDL.Logical.Or or4
    annotation (Placement(transformation(extent={{-210,-400},{-190,-380}})));
  CDL.Logical.TrueFalseHold truFalHol14(trueHoldDuration=3300,
      falseHoldDuration=0)
    annotation (Placement(transformation(extent={{110,-460},{130,-440}})));
  CDL.Logical.Or or5
    annotation (Placement(transformation(extent={{150,-430},{170,-410}})));
equation

  connect(conInt.y, priPumCon.uPumLeaLag) annotation (Line(points={{-198,450},{-180,
          450},{-180,427},{-172,427}}, color={255,127,0}));
  connect(priPumCon.yHotWatPum, pre1.u)
    annotation (Line(points={{-148,400},{-132,400}}, color={255,0,255}));
  connect(con2.y, priPumCon.uMinPriPumSpeCon) annotation (Line(points={{-288,350},
          {-180,350},{-180,388},{-172,388}}, color={0,0,127}));
  connect(sin1.y, priPumCon.VHotWat_flow) annotation (Line(points={{-248,400},{
          -194,400},{-194,415},{-172,415}},                  color={0,0,127}));
  connect(sin.y, priPumCon.dpHotWat_remote) annotation (Line(points={{-198,370},
          {-186,370},{-186,394},{-172,394}}, color={0,0,127}));
  connect(conInt1.y, priPumCon1.uPumLeaLag) annotation (Line(points={{162,440},{
          180,440},{180,417},{188,417}}, color={255,127,0}));
  connect(priPumCon1.yHotWatPum, pre2.u)
    annotation (Line(points={{212,390},{228,390}}, color={255,0,255}));
  connect(con5.y, priPumCon1.uMinPriPumSpeCon) annotation (Line(points={{70,338},
          {180,338},{180,378},{188,378}}, color={0,0,127}));
  connect(sin3.y, priPumCon1.VHotWat_flow) annotation (Line(points={{100,358},{142,
          358},{142,394},{166,394},{166,405},{188,405}}, color={0,0,127}));
  connect(sin2.y, priPumCon1.dpHotWat_remote) annotation (Line(points={{168,358},
          {174,358},{174,384},{188,384}}, color={0,0,127}));
  connect(sin4.y, priPumCon1.dpHotWat_local) annotation (Line(points={{180,318},
          {184,318},{184,387},{188,387}}, color={0,0,127}));
  connect(conInt2.y,priPumCon2. uPumLeaLag) annotation (Line(points={{-198,300},
          {-180,300},{-180,277},{-172,277}},
                                         color={255,127,0}));
  connect(priPumCon2.yHotWatPum,pre3. u)
    annotation (Line(points={{-148,250},{-142,250}},
                                                   color={255,0,255}));
  connect(con8.y,priPumCon2. uMinPriPumSpeCon) annotation (Line(points={{-288,200},
          {-180,200},{-180,238},{-172,238}},
                                          color={0,0,127}));
  connect(sin6.y,priPumCon2. VHotWat_flow) annotation (Line(points={{-258,220},{
          -256,220},{-256,238},{-218,238},{-218,254},{-194,254},{-194,265},{-172,
          265}},                                         color={0,0,127}));
  connect(sin5.y, priPumCon2.VHotWatSec_flow) annotation (Line(points={{-192,218},
          {-184,218},{-184,235},{-172,235}}, color={0,0,127}));
  connect(priPumCon2.yPumChaPro, truFalHol.u) annotation (Line(points={{-148,264},
          {-140,264},{-140,290},{-132,290}}, color={255,0,255}));
  connect(booPul1.y, priPumCon2.uStaUp) annotation (Line(points={{-258,180},{-254,
          180},{-254,248},{-180,248},{-180,259},{-172,259}}, color={255,0,255}));
  connect(booPul1.y, priPumCon2.uOnOff) annotation (Line(points={{-258,180},{-254,
          180},{-254,248},{-180,248},{-180,256},{-172,256}}, color={255,0,255}));
  connect(booPul1.y, priPumCon2.uBoiSta[2]) annotation (Line(points={{-258,180},
          {-254,180},{-254,248},{-180,248},{-180,263},{-172,263}}, color={255,0,
          255}));
  connect(con9.y, priPumCon2.uBoiSta[1]) annotation (Line(points={{-228,220},{-226,
          220},{-226,244},{-188,244},{-188,261},{-172,261}}, color={255,0,255}));
  connect(conInt3.y,priPumCon3. uPumLeaLag) annotation (Line(points={{162,280},{
          180,280},{180,257},{188,257}}, color={255,127,0}));
  connect(priPumCon3.yHotWatPum,pre4. u)
    annotation (Line(points={{212,230},{218,230}}, color={255,0,255}));
  connect(con12.y, priPumCon3.uMinPriPumSpeCon) annotation (Line(points={{72,180},
          {180,180},{180,218},{188,218}}, color={0,0,127}));
  connect(sin8.y,priPumCon3. VHotWat_flow) annotation (Line(points={{102,200},{104,
          200},{104,218},{142,218},{142,234},{166,234},{166,245},{188,245}},
                                                         color={0,0,127}));
  connect(priPumCon3.yPumChaPro, truFalHol1.u) annotation (Line(points={{212,244},
          {220,244},{220,270},{228,270}}, color={255,0,255}));
  connect(booPul3.y, priPumCon3.uStaUp) annotation (Line(points={{102,160},{106,
          160},{106,228},{180,228},{180,239},{188,239}}, color={255,0,255}));
  connect(booPul3.y, priPumCon3.uOnOff) annotation (Line(points={{102,160},{106,
          160},{106,228},{180,228},{180,236},{188,236}}, color={255,0,255}));
  connect(booPul3.y, priPumCon3.uBoiSta[2]) annotation (Line(points={{102,160},{
          106,160},{106,228},{180,228},{180,243},{188,243}}, color={255,0,255}));
  connect(con13.y, priPumCon3.uBoiSta[1]) annotation (Line(points={{132,200},{134,
          200},{134,224},{172,224},{172,241},{188,241}}, color={255,0,255}));
  connect(sin7.y, priPumCon3.VHotWatDec_flow) annotation (Line(points={{162,198},
          {176,198},{176,212},{188,212}}, color={0,0,127}));
  connect(conInt4.y,priPumCon4. uPumLeaLag) annotation (Line(points={{-198,140},
          {-180,140},{-180,117},{-172,117}},
                                         color={255,127,0}));
  connect(priPumCon4.yHotWatPum,pre5. u)
    annotation (Line(points={{-148,90},{-142,90}}, color={255,0,255}));
  connect(con16.y, priPumCon4.uMinPriPumSpeCon) annotation (Line(points={{-288,40},
          {-180,40},{-180,78},{-172,78}}, color={0,0,127}));
  connect(sin10.y, priPumCon4.VHotWat_flow) annotation (Line(points={{-258,60},{
          -256,60},{-256,78},{-218,78},{-218,94},{-194,94},{-194,105},{-172,105}},
        color={0,0,127}));
  connect(priPumCon4.yPumChaPro, truFalHol2.u) annotation (Line(points={{-148,104},
          {-140,104},{-140,130},{-132,130}}, color={255,0,255}));
  connect(booPul5.y, priPumCon4.uStaUp) annotation (Line(points={{-258,20},{-254,
          20},{-254,88},{-180,88},{-180,99},{-172,99}}, color={255,0,255}));
  connect(booPul5.y, priPumCon4.uOnOff) annotation (Line(points={{-258,20},{-254,
          20},{-254,88},{-180,88},{-180,96},{-172,96}}, color={255,0,255}));
  connect(booPul5.y, priPumCon4.uBoiSta[2]) annotation (Line(points={{-258,20},{
          -254,20},{-254,88},{-180,88},{-180,103},{-172,103}}, color={255,0,255}));
  connect(con17.y, priPumCon4.uBoiSta[1]) annotation (Line(points={{-228,60},{-226,
          60},{-226,84},{-188,84},{-188,101},{-172,101}}, color={255,0,255}));
  connect(sin9.y, priPumCon4.THotWatPri) annotation (Line(points={{-192,58},{-182,
          58},{-182,69},{-172,69}}, color={0,0,127}));
  connect(con18.y, priPumCon4.THotWatSec) annotation (Line(points={{-288,0},{
          -224,0},{-224,38},{-176,38},{-176,66},{-172,66}},
                                   color={0,0,127}));
  connect(conInt5.y,priPumCon5. uPumLeaLag) annotation (Line(points={{162,120},{
          180,120},{180,97},{188,97}},   color={255,127,0}));
  connect(priPumCon5.yHotWatPum,pre6. u)
    annotation (Line(points={{212,70},{218,70}},   color={255,0,255}));
  connect(con21.y, priPumCon5.uMinPriPumSpeCon) annotation (Line(points={{72,20},
          {180,20},{180,58},{188,58}}, color={0,0,127}));
  connect(sin12.y, priPumCon5.VHotWat_flow) annotation (Line(points={{102,40},{104,
          40},{104,58},{142,58},{142,74},{166,74},{166,85},{188,85}}, color={0,0,
          127}));
  connect(priPumCon5.yPumChaPro, truFalHol3.u) annotation (Line(points={{212,84},
          {220,84},{220,110},{228,110}}, color={255,0,255}));
  connect(booPul7.y, priPumCon5.uStaUp) annotation (Line(points={{102,0},{106,0},
          {106,68},{180,68},{180,79},{188,79}}, color={255,0,255}));
  connect(booPul7.y, priPumCon5.uOnOff) annotation (Line(points={{102,0},{106,0},
          {106,68},{180,68},{180,76},{188,76}}, color={255,0,255}));
  connect(booPul7.y, priPumCon5.uBoiSta[2]) annotation (Line(points={{102,0},{106,
          0},{106,68},{180,68},{180,83},{188,83}}, color={255,0,255}));
  connect(con22.y, priPumCon5.uBoiSta[1]) annotation (Line(points={{132,40},{134,
          40},{134,64},{172,64},{172,81},{188,81}}, color={255,0,255}));
  connect(sin11.y, priPumCon5.THotWatBoiSup) annotation (Line(points={{168,38},{
          178,38},{178,43},{188,43}}, color={0,0,127}));
  connect(con23.y, priPumCon5.THotWatSec) annotation (Line(points={{72,-20},{
          136,-20},{136,18},{184,18},{184,46},{188,46}},
                                   color={0,0,127}));
  connect(conInt6.y,priPumCon6. uPumLeaLag) annotation (Line(points={{-208,-40},
          {-190,-40},{-190,-63},{-182,-63}},
                                         color={255,127,0}));
  connect(priPumCon6.yHotWatPum,pre7. u)
    annotation (Line(points={{-158,-90},{-152,-90}},
                                                   color={255,0,255}));
  connect(sin14.y, priPumCon6.VHotWat_flow) annotation (Line(points={{-268,-120},
          {-266,-120},{-266,-102},{-228,-102},{-228,-86},{-204,-86},{-204,-75},{
          -182,-75}}, color={0,0,127}));
  connect(priPumCon6.yPumChaPro, truFalHol4.u) annotation (Line(points={{-158,-76},
          {-150,-76},{-150,-50},{-142,-50}}, color={255,0,255}));
  connect(booPul9.y, priPumCon6.uStaUp) annotation (Line(points={{-268,-160},{-264,
          -160},{-264,-92},{-190,-92},{-190,-81},{-182,-81}}, color={255,0,255}));
  connect(booPul9.y, priPumCon6.uOnOff) annotation (Line(points={{-268,-160},{-264,
          -160},{-264,-92},{-190,-92},{-190,-84},{-182,-84}}, color={255,0,255}));
  connect(booPul9.y, priPumCon6.uBoiSta[2]) annotation (Line(points={{-268,-160},
          {-264,-160},{-264,-92},{-190,-92},{-190,-77},{-182,-77}}, color={255,0,
          255}));
  connect(con27.y, priPumCon6.uBoiSta[1]) annotation (Line(points={{-238,-120},{
          -236,-120},{-236,-96},{-198,-96},{-198,-79},{-182,-79}}, color={255,0,
          255}));
  connect(priPumCon7.yHotWatPum,pre8. u)
    annotation (Line(points={{232,-110},{238,-110}},
                                                   color={255,0,255}));
  connect(con29.y, priPumCon7.uMinPriPumSpeCon) annotation (Line(points={{92,-160},
          {200,-160},{200,-122},{208,-122}}, color={0,0,127}));
  connect(sin15.y, priPumCon7.VHotWat_flow) annotation (Line(points={{122,-140},
          {124,-140},{124,-122},{160,-122},{160,-106},{186,-106},{186,-95},{208,
          -95}}, color={0,0,127}));
  connect(sin13.y, priPumCon7.VHotWatSec_flow) annotation (Line(points={{188,-142},
          {196,-142},{196,-125},{208,-125}}, color={0,0,127}));
  connect(priPumCon7.yPumChaPro, truFalHol5.u) annotation (Line(points={{232,-96},
          {240,-96},{240,-70},{248,-70}}, color={255,0,255}));
  connect(booPul11.y, priPumCon7.uBoiSta[2]) annotation (Line(points={{122,-180},
          {126,-180},{126,-112},{200,-112},{200,-97},{208,-97}}, color={255,0,255}));
  connect(conInt7.y, priPumCon7.uNexEnaBoi) annotation (Line(points={{152,-140},
          {162,-140},{162,-116},{202,-116},{202,-110},{208,-110}},
                                           color={255,127,0}));
  connect(priPumCon8.yHotWatPum,pre9. u)
    annotation (Line(points={{-158,-270},{-152,-270}},
                                                   color={255,0,255}));
  connect(con32.y, priPumCon8.uMinPriPumSpeCon) annotation (Line(points={{-298,-320},
          {-190,-320},{-190,-282},{-182,-282}}, color={0,0,127}));
  connect(sin17.y, priPumCon8.VHotWat_flow) annotation (Line(points={{-268,-300},
          {-266,-300},{-266,-282},{-228,-282},{-228,-266},{-204,-266},{-204,-255},
          {-182,-255}}, color={0,0,127}));
  connect(priPumCon8.yPumChaPro, truFalHol6.u) annotation (Line(points={{-158,-256},
          {-150,-256},{-150,-230},{-142,-230}}, color={255,0,255}));
  connect(booPul13.y, priPumCon8.uBoiSta[2]) annotation (Line(points={{-268,-340},
          {-264,-340},{-264,-272},{-190,-272},{-190,-257},{-182,-257}}, color={255,
          0,255}));
  connect(sin16.y, priPumCon8.VHotWatDec_flow) annotation (Line(points={{-208,-302},
          {-194,-302},{-194,-288},{-182,-288}}, color={0,0,127}));
  connect(conInt8.y, priPumCon8.uNexEnaBoi) annotation (Line(points={{-238,-300},
          {-234,-300},{-234,-284},{-194,-284},{-194,-270},{-182,-270}},
                                                color={255,127,0}));
  connect(priPumCon9.yHotWatPum, pre10.u)
    annotation (Line(points={{232,-280},{238,-280}}, color={255,0,255}));
  connect(con35.y, priPumCon9.uMinPriPumSpeCon) annotation (Line(points={{92,-330},
          {200,-330},{200,-292},{208,-292}}, color={0,0,127}));
  connect(sin19.y, priPumCon9.VHotWat_flow) annotation (Line(points={{122,-310},
          {124,-310},{124,-292},{162,-292},{162,-276},{186,-276},{186,-265},{208,
          -265}}, color={0,0,127}));
  connect(priPumCon9.yPumChaPro, truFalHol7.u) annotation (Line(points={{232,-266},
          {240,-266},{240,-240},{248,-240}}, color={255,0,255}));
  connect(booPul15.y, priPumCon9.uBoiSta[2]) annotation (Line(points={{122,-350},
          {126,-350},{126,-282},{200,-282},{200,-267},{208,-267}}, color={255,0,
          255}));
  connect(sin18.y, priPumCon9.THotWatPri) annotation (Line(points={{188,-312},{198,
          -312},{198,-301},{208,-301}}, color={0,0,127}));
  connect(con37.y, priPumCon9.THotWatSec) annotation (Line(points={{92,-370},{
          156,-370},{156,-332},{204,-332},{204,-304},{208,-304}},
                                        color={0,0,127}));
  connect(conInt9.y, priPumCon9.uNexEnaBoi) annotation (Line(points={{152,-310},
          {160,-310},{160,-294},{164,-294},{164,-286},{204,-286},{204,-280},{208,
          -280}},                            color={255,127,0}));
  connect(priPumCon10.yHotWatPum, pre11.u)
    annotation (Line(points={{-148,-430},{-142,-430}}, color={255,0,255}));
  connect(con39.y, priPumCon10.uMinPriPumSpeCon) annotation (Line(points={{-288,
          -480},{-180,-480},{-180,-442},{-172,-442}}, color={0,0,127}));
  connect(sin21.y, priPumCon10.VHotWat_flow) annotation (Line(points={{-258,-460},
          {-256,-460},{-256,-442},{-218,-442},{-218,-426},{-194,-426},{-194,-415},
          {-172,-415}}, color={0,0,127}));
  connect(priPumCon10.yPumChaPro, truFalHol8.u) annotation (Line(points={{-148,-416},
          {-140,-416},{-140,-390},{-132,-390}}, color={255,0,255}));
  connect(booPul17.y, priPumCon10.uBoiSta[2]) annotation (Line(points={{-258,-500},
          {-254,-500},{-254,-432},{-180,-432},{-180,-417},{-172,-417}}, color={255,
          0,255}));
  connect(sin20.y, priPumCon10.THotWatBoiSup) annotation (Line(points={{-192,-462},
          {-182,-462},{-182,-457},{-172,-457}}, color={0,0,127}));
  connect(con41.y, priPumCon10.THotWatSec) annotation (Line(points={{-288,-520},
          {-224,-520},{-224,-482},{-174,-482},{-174,-454},{-172,-454}},
                                                color={0,0,127}));
  connect(conInt10.y, priPumCon10.uNexEnaBoi) annotation (Line(points={{-228,-460},
          {-220,-460},{-220,-444},{-212,-444},{-212,-436},{-176,-436},{-176,-430},
          {-172,-430}},                         color={255,127,0}));
  connect(priPumCon11.yHotWatPum, pre12.u)
    annotation (Line(points={{212,-460},{218,-460}}, color={255,0,255}));
  connect(sin22.y, priPumCon11.VHotWat_flow) annotation (Line(points={{102,-490},
          {104,-490},{104,-472},{142,-472},{142,-456},{166,-456},{166,-445},{188,
          -445}}, color={0,0,127}));
  connect(priPumCon11.yPumChaPro, truFalHol9.u) annotation (Line(points={{212,-446},
          {220,-446},{220,-420},{228,-420}}, color={255,0,255}));
  connect(booPul19.y, priPumCon11.uBoiSta[2]) annotation (Line(points={{102,-530},
          {106,-530},{106,-462},{180,-462},{180,-447},{188,-447}}, color={255,0,
          255}));
  connect(conInt11.y, priPumCon11.uNexEnaBoi) annotation (Line(points={{142,-490},
          {182,-490},{182,-460},{188,-460}}, color={255,127,0}));
  connect(cha17.y, priPumCon7.uPumChaPro) annotation (Line(points={{162,-180},{166,
          -180},{166,-158},{206,-158},{206,-107},{208,-107}},     color={255,0,
          255}));
  connect(cha12.y, priPumCon2.uPumChaPro) annotation (Line(points={{-198,180},{
          -176,180},{-176,253},{-172,253}}, color={255,0,255}));
  connect(cha13.y, priPumCon3.uPumChaPro) annotation (Line(points={{162,160},{
          184,160},{184,233},{188,233}}, color={255,0,255}));
  connect(cha14.y, priPumCon4.uPumChaPro) annotation (Line(points={{-198,20},{
          -178,20},{-178,93},{-172,93}}, color={255,0,255}));
  connect(cha15.y, priPumCon5.uPumChaPro) annotation (Line(points={{162,0},{182,
          0},{182,73},{188,73}}, color={255,0,255}));
  connect(cha16.y, priPumCon6.uPumChaPro) annotation (Line(points={{-208,-160},
          {-186,-160},{-186,-87},{-182,-87}}, color={255,0,255}));
  connect(cha18.y, priPumCon8.uPumChaPro) annotation (Line(points={{-228,-340},
          {-220,-340},{-220,-318},{-184,-318},{-184,-267},{-182,-267}}, color={
          255,0,255}));
  connect(cha19.y, priPumCon9.uPumChaPro) annotation (Line(points={{154,-350},{
          160,-350},{160,-334},{206,-334},{206,-277},{208,-277}}, color={255,0,
          255}));
  connect(cha20.y, priPumCon10.uPumChaPro) annotation (Line(points={{-228,-500},
          {-220,-500},{-220,-478},{-186,-478},{-186,-427},{-172,-427}}, color={
          255,0,255}));
  connect(cha21.y, priPumCon11.uPumChaPro) annotation (Line(points={{142,-530},
          {146,-530},{146,-500},{184,-500},{184,-457},{188,-457}}, color={255,0,
          255}));
  connect(booPul1.y, cha12.u)
    annotation (Line(points={{-258,180},{-222,180}}, color={255,0,255}));
  connect(booPul3.y, cha13.u)
    annotation (Line(points={{102,160},{138,160}}, color={255,0,255}));
  connect(booPul5.y, cha14.u)
    annotation (Line(points={{-258,20},{-222,20}}, color={255,0,255}));
  connect(booPul7.y, cha15.u)
    annotation (Line(points={{102,0},{138,0}}, color={255,0,255}));
  connect(booPul9.y, cha16.u)
    annotation (Line(points={{-268,-160},{-232,-160}}, color={255,0,255}));
  connect(booPul11.y, cha17.u)
    annotation (Line(points={{122,-180},{138,-180}}, color={255,0,255}));
  connect(booPul13.y, cha18.u)
    annotation (Line(points={{-268,-340},{-252,-340}}, color={255,0,255}));
  connect(booPul15.y, cha19.u)
    annotation (Line(points={{122,-350},{130,-350}}, color={255,0,255}));
  connect(booPul17.y, cha20.u)
    annotation (Line(points={{-258,-500},{-252,-500}}, color={255,0,255}));
  connect(booPul19.y, cha21.u)
    annotation (Line(points={{102,-530},{118,-530}}, color={255,0,255}));
  connect(booPul15.y, edg.u) annotation (Line(points={{122,-350},{126,-350},{
          126,-366},{170,-366},{170,-350},{178,-350}}, color={255,0,255}));
  connect(edg.y, priPumCon9.uStaUp) annotation (Line(points={{202,-350},{202,
          -271},{208,-271}}, color={255,0,255}));
  connect(edg.y, priPumCon9.uOnOff) annotation (Line(points={{202,-350},{202,
          -274},{208,-274}}, color={255,0,255}));
  connect(booPul11.y, edg1.u) annotation (Line(points={{122,-180},{126,-180},{
          126,-196},{172,-196},{172,-180},{178,-180}}, color={255,0,255}));
  connect(edg1.y, priPumCon7.uStaUp) annotation (Line(points={{202,-180},{204,
          -180},{204,-101},{208,-101}}, color={255,0,255}));
  connect(edg1.y, priPumCon7.uOnOff) annotation (Line(points={{202,-180},{204,
          -180},{204,-104},{208,-104}}, color={255,0,255}));
  connect(booPul13.y, edg2.u) annotation (Line(points={{-268,-340},{-264,-340},
          {-264,-354},{-214,-354},{-214,-340},{-212,-340}}, color={255,0,255}));
  connect(edg2.y, priPumCon8.uStaUp) annotation (Line(points={{-188,-340},{-186,
          -340},{-186,-261},{-182,-261}}, color={255,0,255}));
  connect(edg2.y, priPumCon8.uOnOff) annotation (Line(points={{-188,-340},{-186,
          -340},{-186,-264},{-182,-264}}, color={255,0,255}));
  connect(booPul17.y, edg3.u) annotation (Line(points={{-258,-500},{-254,-500},
          {-254,-514},{-214,-514},{-214,-500},{-212,-500}}, color={255,0,255}));
  connect(edg3.y, priPumCon10.uStaUp) annotation (Line(points={{-188,-500},{
          -178,-500},{-178,-421},{-172,-421}}, color={255,0,255}));
  connect(edg3.y, priPumCon10.uOnOff) annotation (Line(points={{-188,-500},{
          -178,-500},{-178,-424},{-172,-424}}, color={255,0,255}));
  connect(booPul19.y, edg4.u) annotation (Line(points={{102,-530},{106,-530},{
          106,-550},{150,-550},{150,-530},{158,-530}}, color={255,0,255}));
  connect(edg4.y, priPumCon11.uStaUp) annotation (Line(points={{182,-530},{186,
          -530},{186,-451},{188,-451}}, color={255,0,255}));
  connect(edg4.y, priPumCon11.uOnOff) annotation (Line(points={{182,-530},{186,
          -530},{186,-454},{188,-454}}, color={255,0,255}));
  connect(pul.y, priPumCon.uHotIsoVal) annotation (Line(points={{-288,390},{
          -280,390},{-280,418},{-172,418}}, color={0,0,127}));
  connect(con1.y, priPumCon.dpHotWatSet) annotation (Line(points={{-238,450},{
          -234,450},{-234,391},{-172,391}}, color={0,0,127}));
  connect(pre1.y, priPumCon.uHotWatPum) annotation (Line(points={{-108,400},{
          -100,400},{-100,440},{-190,440},{-190,424},{-172,424}}, color={255,0,
          255}));
  connect(pre2.y, priPumCon1.uHotWatPum) annotation (Line(points={{252,390},{
          272,390},{272,460},{110,460},{110,414},{188,414}}, color={255,0,255}));
  connect(pul1.y, priPumCon1.uHotIsoVal) annotation (Line(points={{62,410},{126,
          410},{126,408},{188,408}}, color={0,0,127}));
  connect(con3.y, priPumCon1.dpHotWatSet) annotation (Line(points={{102,390},{
          160,390},{160,381},{188,381}}, color={0,0,127}));
  connect(pul2.y, priPumCon2.uHotIsoVal) annotation (Line(points={{-278,270},{
          -224,270},{-224,268},{-172,268}}, color={0,0,127}));
  connect(pre3.y, priPumCon2.uHotWatPum) annotation (Line(points={{-118,250},{
          -88,250},{-88,320},{-240,320},{-240,274},{-172,274}}, color={255,0,
          255}));
  connect(pul3.y, priPumCon3.uHotIsoVal) annotation (Line(points={{82,250},{136,
          250},{136,248},{188,248}}, color={0,0,127}));
  connect(pre4.y, priPumCon3.uHotWatPum) annotation (Line(points={{242,230},{
          260,230},{260,300},{130,300},{130,254},{188,254}}, color={255,0,255}));
  connect(pul4.y, priPumCon4.uHotIsoVal) annotation (Line(points={{-278,110},{
          -224,110},{-224,108},{-172,108}}, color={0,0,127}));
  connect(pre5.y, priPumCon4.uHotWatPum) annotation (Line(points={{-118,90},{
          -100,90},{-100,160},{-230,160},{-230,114},{-172,114}}, color={255,0,
          255}));
  connect(pre6.y, priPumCon5.uHotWatPum) annotation (Line(points={{242,70},{260,
          70},{260,140},{130,140},{130,94},{188,94}}, color={255,0,255}));
  connect(pul5.y, priPumCon5.uHotIsoVal) annotation (Line(points={{82,90},{136,
          90},{136,88},{188,88}}, color={0,0,127}));
  connect(pre7.y, priPumCon6.uHotWatPum) annotation (Line(points={{-128,-90},{
          -100,-90},{-100,-20},{-240,-20},{-240,-66},{-182,-66}}, color={255,0,
          255}));
  connect(pul6.y, priPumCon6.uHotIsoVal) annotation (Line(points={{-258,-70},{
          -220,-70},{-220,-72},{-182,-72}}, color={0,0,127}));
  connect(pre8.y, priPumCon7.uHotWatPum) annotation (Line(points={{262,-110},{
          280,-110},{280,-32},{150,-32},{150,-86},{208,-86}}, color={255,0,255}));
  connect(pre9.y, priPumCon8.uHotWatPum) annotation (Line(points={{-128,-270},{
          -100,-270},{-100,-190},{-240,-190},{-240,-246},{-182,-246}}, color={
          255,0,255}));
  connect(pre10.y, priPumCon9.uHotWatPum) annotation (Line(points={{262,-280},{
          280,-280},{280,-200},{150,-200},{150,-256},{208,-256}}, color={255,0,
          255}));
  connect(pre11.y, priPumCon10.uHotWatPum) annotation (Line(points={{-118,-430},
          {-100,-430},{-100,-360},{-230,-360},{-230,-406},{-172,-406}}, color={
          255,0,255}));
  connect(pre12.y, priPumCon11.uHotWatPum) annotation (Line(points={{242,-460},
          {260,-460},{260,-390},{132,-390},{132,-436},{188,-436}}, color={255,0,
          255}));
  connect(conInt7.y, priPumCon7.uLasDisBoi) annotation (Line(points={{152,-140},
          {162,-140},{162,-116},{202,-116},{202,-113},{208,-113}},
                                            color={255,127,0}));
  connect(conInt8.y, priPumCon8.uLasDisBoi) annotation (Line(points={{-238,-300},
          {-234,-300},{-234,-284},{-194,-284},{-194,-273},{-182,-273}},
                                                color={255,127,0}));
  connect(conInt9.y, priPumCon9.uLasDisBoi) annotation (Line(points={{152,-310},
          {160,-310},{160,-294},{164,-294},{164,-286},{204,-286},{204,-283},{208,
          -283}},                            color={255,127,0}));
  connect(conInt10.y, priPumCon10.uLasDisBoi) annotation (Line(points={{-228,-460},
          {-220,-460},{-220,-444},{-212,-444},{-212,-436},{-176,-436},{-176,-433},
          {-172,-433}},                               color={255,127,0}));
  connect(conInt11.y, priPumCon11.uLasDisBoi) annotation (Line(points={{142,-490},
          {182,-490},{182,-463},{188,-463}},       color={255,127,0}));
  connect(booPul11.y, truFalHol10.u) annotation (Line(points={{122,-180},{126,-180},
          {126,-100},{128,-100}}, color={255,0,255}));
  connect(truFalHol10.y, priPumCon7.uBoiSta[1]) annotation (Line(points={{152,-100},
          {192,-100},{192,-99},{208,-99}}, color={255,0,255}));
  connect(truFalHol10.y, or2.u2) annotation (Line(points={{152,-100},{154,-100},
          {154,-78},{158,-78}}, color={255,0,255}));
  connect(booPul11.y, or2.u1) annotation (Line(points={{122,-180},{126,-180},{126,
          -70},{158,-70}}, color={255,0,255}));
  connect(or2.y, priPumCon7.uPlaEna) annotation (Line(points={{182,-70},{190,-70},
          {190,-89},{208,-89}}, color={255,0,255}));
  connect(booPul13.y, truFalHol11.u) annotation (Line(points={{-268,-340},{-264,
          -340},{-264,-260},{-262,-260}}, color={255,0,255}));
  connect(truFalHol11.y, or1.u2) annotation (Line(points={{-238,-260},{-236,-260},
          {-236,-238},{-232,-238}}, color={255,0,255}));
  connect(booPul13.y, or1.u1) annotation (Line(points={{-268,-340},{-264,-340},{
          -264,-230},{-232,-230}}, color={255,0,255}));
  connect(or1.y, priPumCon8.uPlaEna) annotation (Line(points={{-208,-230},{-200,
          -230},{-200,-249},{-182,-249}}, color={255,0,255}));
  connect(truFalHol11.y, priPumCon8.uBoiSta[1]) annotation (Line(points={{-238,-260},
          {-236,-260},{-236,-259},{-182,-259}}, color={255,0,255}));
  connect(booPul15.y, truFalHol12.u) annotation (Line(points={{122,-350},{126,-350},
          {126,-270},{128,-270}}, color={255,0,255}));
  connect(truFalHol12.y, priPumCon9.uBoiSta[1]) annotation (Line(points={{152,-270},
          {160,-270},{160,-269},{208,-269}}, color={255,0,255}));
  connect(truFalHol12.y, or3.u2) annotation (Line(points={{152,-270},{160,-270},
          {160,-248},{168,-248}}, color={255,0,255}));
  connect(booPul15.y, or3.u1) annotation (Line(points={{122,-350},{126,-350},{126,
          -240},{168,-240}}, color={255,0,255}));
  connect(or3.y, priPumCon9.uPlaEna) annotation (Line(points={{192,-240},{200,-240},
          {200,-259},{208,-259}}, color={255,0,255}));
  connect(booPul17.y, truFalHol13.u) annotation (Line(points={{-258,-500},{-254,
          -500},{-254,-420},{-252,-420}}, color={255,0,255}));
  connect(truFalHol13.y, priPumCon10.uBoiSta[1]) annotation (Line(points={{-228,
          -420},{-220,-420},{-220,-419},{-172,-419}}, color={255,0,255}));
  connect(truFalHol13.y, or4.u2) annotation (Line(points={{-228,-420},{-220,-420},
          {-220,-398},{-212,-398}}, color={255,0,255}));
  connect(booPul17.y, or4.u1) annotation (Line(points={{-258,-500},{-254,-500},{
          -254,-390},{-212,-390}}, color={255,0,255}));
  connect(or4.y, priPumCon10.uPlaEna) annotation (Line(points={{-188,-390},{-180,
          -390},{-180,-409},{-172,-409}}, color={255,0,255}));
  connect(truFalHol14.y, or5.u2) annotation (Line(points={{132,-450},{140,-450},
          {140,-428},{148,-428}}, color={255,0,255}));
  connect(booPul19.y, truFalHol14.u) annotation (Line(points={{102,-530},{106,-530},
          {106,-450},{108,-450}}, color={255,0,255}));
  connect(booPul19.y, or5.u1) annotation (Line(points={{102,-530},{106,-530},{106,
          -420},{148,-420}}, color={255,0,255}));
  connect(or5.y, priPumCon11.uPlaEna) annotation (Line(points={{172,-420},{180,-420},
          {180,-439},{188,-439}}, color={255,0,255}));
  connect(truFalHol14.y, priPumCon11.uBoiSta[1]) annotation (Line(points={{132,-450},
          {140,-450},{140,-449},{188,-449}}, color={255,0,255}));
annotation (
  experiment(
      StopTime=3600,
      Interval=0.5,
      Tolerance=1e-06,
      __Dymola_Algorithm="Cvode"),
  __Dymola_Commands(file="modelica://Buildings/Resources/Scripts/Dymola/Controls/OBC/ASHRAE/PrimarySystem/BoilerPlant/Pumps/PrimaryPumps/Validation/Controller.mos"
    "Simulate and plot"),
  Documentation(info="<html>
<p>
This example validates
<a href=\"modelica://Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller\">
Buildings.Controls.OBC.ASHRAE.PrimarySystem.BoilerPlant.Pumps.PrimaryPumps.Controller</a>.
</p>
</html>", revisions="<html>
<ul>
<li>
August 21, 2020, by Karthik Devaprasad:<br/>
First implementation.
</li>
</ul>
</html>"),
  Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}),
                         graphics={
        Ellipse(lineColor = {75,138,73},
                fillColor={255,255,255},
                fillPattern = FillPattern.Solid,
                extent = {{-100,-100},{100,100}}),
        Polygon(lineColor = {0,0,255},
                fillColor = {75,138,73},
                pattern = LinePattern.None,
                fillPattern = FillPattern.Solid,
                points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Diagram(
        coordinateSystem(preserveAspectRatio=false, extent={{-340,-560},{340,480}})));
end Controller;
