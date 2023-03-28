within Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Validation;
model SingleSpeedHeatingPLREnergyPlusDefrost_TimedReverseCycle
  "Validation model for single speed heating DX coil with defrost operation"
  extends Modelica.Icons.Example;

  package Medium = Buildings.Media.Air "Medium model";

  parameter Modelica.Units.SI.Power Q_flow_nominal=datCoi.sta[1].nomVal.Q_flow_nominal
    "Nominal power";
  parameter Modelica.Units.SI.MassFlowRate m_flow_nominal=datCoi.sta[1].nomVal.m_flow_nominal
    "Nominal mass flow rate";
  parameter Modelica.Units.SI.PressureDifference dp_nominal=1141
    "Pressure drop at m_flow_nominal";
  Buildings.Fluid.Sources.Boundary_pT sin(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 101325,
    nPorts=1,
    T=294.15) "Sink"
    annotation (Placement(transformation(extent={{40,-20},{20,0}})));
  Buildings.Fluid.Sources.Boundary_pT sou(
    redeclare package Medium = Medium,
    p(displayUnit="Pa") = 101325 + dp_nominal,
    use_T_in=true,
    nPorts=1,
    use_p_in=true,
    use_X_in=true,
    T=299.85) "Source"
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Buildings.Fluid.HeatExchangers.DXCoils.AirSource.SingleSpeedDXHeating
    sinSpeDX(
    redeclare package Medium = Medium,
    dp_nominal=dp_nominal,
    datCoi=datCoi,
    T_start=datCoi.sta[1].nomVal.TEvaIn_nominal,
    from_dp=true,
    energyDynamics=Modelica.Fluid.Types.Dynamics.FixedInitial,
    defCur=defCur,
    defOpe=Buildings.Fluid.HeatExchangers.DXCoils.BaseClasses.DefrostOperation.resistive,
    defTri=Buildings.Fluid.HeatExchangers.DXCoils.BaseClasses.DefrostTriggers.timed,
    tDefRun=0.166667)
    "Single speed DX coil"
    annotation (Placement(transformation(extent={{-10,0},{10,20}})));

  Modelica.Blocks.Routing.Multiplex2 mux "Converts in an array"
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  Buildings.Utilities.IO.BCVTB.From_degC TEvaIn_K "Converts degC to K"
    annotation (Placement(transformation(extent={{-100,70},{-80,90}})));
  Buildings.Utilities.IO.BCVTB.From_degC TConIn_K "Converts degC to K"
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Math.Mean TOutMea(f=1/3600)
    annotation (Placement(transformation(extent={{80,80},{100,100}})));
  Buildings.Utilities.IO.BCVTB.To_degC TOutDegC
    annotation (Placement(transformation(extent={{120,80},{140,100}})));
  Modelica.Blocks.Sources.RealExpression TOut(y=sinSpeDX.vol.T)
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
  Modelica.Blocks.Math.Mean XConOutMea(f=1/3600)
    annotation (Placement(transformation(extent={{80,120},{100,140}})));
  Modelica.Blocks.Sources.RealExpression XConOut(y=sum(sinSpeDX.vol.Xi))
    annotation (Placement(transformation(extent={{40,120},{60,140}})));
  Modelica.Blocks.Math.Mean Q_flowMea(f=1/3600) "Mean of cooling rate"
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
  Modelica.Blocks.Math.Mean PMea(f=1/3600) "Mean of power"
    annotation (Placement(transformation(extent={{40,10},{60,30}})));
  Modelica.Blocks.Math.Add add(k1=-1)
    annotation (Placement(transformation(extent={{-100,-100},{-80,-80}})));
  Modelica.Blocks.Sources.Constant XConInMoiAir(k=1.0) "Moist air fraction = 1"
    annotation (Placement(transformation(extent={{-140,-120},{-120,-100}})));
  Modelica.Blocks.Sources.Pulse p(
    nperiod=1,
    offset=101325,
    width=100,
    period=36000,
    startTime=25200,
    amplitude=1086) "Pressure"
    annotation (Placement(transformation(extent={{-140,10},{-120,30}})));
  Modelica.Blocks.Sources.RealExpression XConInMod(y=XConIn.y/(1 + XConIn.y))
    "Modified XConIn"
    annotation (Placement(transformation(extent={{-140,-54},{-120,-34}})));
  Modelica.Blocks.Sources.RealExpression XConOutEPluMod(y=XConOutEPlu.y/(1 +
        XConOutEPlu.y))
    "Modified XConOut of energyPlus to comapre with the model results"
    annotation (Placement(transformation(extent={{0,-110},{20,-90}})));
  Modelica.Blocks.Sources.BooleanTable onOff(startValue=true, table={0,25200,28335.33835,
        28800,31430.44239,32400,34507.24081,36000,37693.52174,39600,40987.60937,
        43200,44354.28059,46800,47802.30301,50400,51328.61818,54000,54994.97321,
        57600,58729.15311,61200})
                   "EnergyPlus PLR converted into on-off signal for this model"
    annotation (Placement(transformation(extent={{-120,100},{-100,120}})));
  Modelica.Blocks.Sources.TimeTable TEvaIn(table=[0, -7.825;
3600, -7.825;
3600, -11.90833333;
7200, -11.90833333;
7200, -11.35;
10800, -11.35;
10800, -11.1;
14400, -11.1;
14400, -10.80833333;
18000, -10.80833333;
18000, -10.6;
21600, -10.6;
21600, -10.6;
25200, -10.6;
25200, -10.25;
28800, -10.25;
28800, -9.358333333;
32400, -9.358333333;
32400, -7.616666667;
36000, -7.616666667;
36000, -5.708333333;
39600, -5.708333333;
39600, -4.008333333;
43200, -4.008333333;
43200, -2.658333333;
46800, -2.658333333;
46800, -1.558333333;
50400, -1.558333333;
50400, -1.1;
54000, -1.1;
54000, -1.1;
57600, -1.1;
57600, -1.1;
61200, -1.1;
61200, -1.45;
64800, -1.45;
64800, -1.991666667;
68400, -1.991666667;
68400, -1.558333333;
72000, -1.558333333;
72000, -1.45;
75600, -1.45;
75600, -1.35;
79200, -1.35;
79200, -1.45;
82800, -1.45;
82800, -1.7;
86400, -1.7]) "Evaporator inlet temperature"
    annotation (Placement(transformation(extent={{-140,70},{-120,90}})));
  Modelica.Blocks.Sources.TimeTable TConIn(table=[0, 7.951860704;
3600, 7.951860704;
3600, 6.632519542;
7200, 6.632519542;
7200, 5.99492191;
10800, 5.99492191;
10800, 5.361778081;
14400, 5.361778081;
14400, 4.728966747;
18000, 4.728966747;
18000, 4.166197294;
21600, 4.166197294;
21600, 3.602166509;
25200, 3.602166509;
25200, 5.642551931;
28800, 5.642551931;
28800, 7.526679793;
32400, 7.526679793;
32400, 11.85625509;
36000, 11.85625509;
36000, 16.07508103;
39600, 16.07508103;
39600, 17.63929528;
43200, 17.63929528;
43200, 17.75548172;
46800, 17.75548172;
46800, 17.80854478;
50400, 17.80854478;
50400, 17.89010361;
54000, 17.89010361;
54000, 17.9176233;
57600, 17.9176233;
57600, 17.93577336;
61200, 17.93577336;
61200, 14.3617359;
64800, 14.3617359;
64800, 11.6261002;
68400, 11.6261002;
68400, 10.83882651;
72000, 10.83882651;
72000, 10.35396203;
75600, 10.35396203;
75600, 9.851165997;
79200, 9.851165997;
79200, 9.352269932;
82800, 9.352269932;
82800, 8.824051451;
86400, 8.824051451])
                    "Coil inlet temperature"
    annotation (Placement(transformation(extent={{-140,-20},{-120,0}})));
  Modelica.Blocks.Sources.TimeTable XConIn(table=[0, 0.002415798;
3600, 0.002415798;
3600, 0.001910966;
7200, 0.001910966;
7200, 0.001540862;
10800, 0.001540862;
10800, 0.00134493;
14400, 0.00134493;
14400, 0.001237541;
18000, 0.001237541;
18000, 0.001188093;
21600, 0.001188093;
21600, 0.00116648;
25200, 0.00116648;
25200, 0.001185371;
28800, 0.001185371;
28800, 0.001220762;
32400, 0.001220762;
32400, 0.001255824;
36000, 0.001255824;
36000, 0.00133358;
39600, 0.00133358;
39600, 0.001507785;
43200, 0.001507785;
43200, 0.001696558;
46800, 0.001696558;
46800, 0.001874923;
50400, 0.001874923;
50400, 0.002024613;
54000, 0.002024613;
54000, 0.002163441;
57600, 0.002163441;
57600, 0.002290996;
61200, 0.002290996;
61200, 0.002338623;
64800, 0.002338623;
64800, 0.002356039;
68400, 0.002356039;
68400, 0.002381858;
72000, 0.002381858;
72000, 0.002437251;
75600, 0.002437251;
75600, 0.00250328;
79200, 0.00250328;
79200, 0.002554417;
82800, 0.002554417;
82800, 0.002568107;
86400, 0.002568107])
                "Water fraction of moist air"
    annotation (Placement(transformation(extent={{-140,-80},{-120,-60}})));
  Modelica.Blocks.Sources.TimeTable TOutEPlu_ori(table=[0, 7.951860704;
3600, 7.951860704;
3600, 6.632519542;
7200, 6.632519542;
7200, 5.99492191;
10800, 5.99492191;
10800, 5.361778081;
14400, 5.361778081;
14400, 4.728966747;
18000, 4.728966747;
18000, 4.166197294;
21600, 4.166197294;
21600, 3.602166509;
25200, 3.602166509;
25200, 5.642551931;
28800, 5.642551931;
28800, 7.526679793;
32400, 7.526679793;
32400, 21.63672617;
36000, 21.63672617;
36000, 30.95920264;
39600, 30.95920264;
39600, 32.64136462;
43200, 32.64136462;
43200, 32.87252356;
46800, 32.87252356;
46800, 33.08401509;
50400, 33.08401509;
50400, 33.1394051;
54000, 33.1394051;
54000, 32.88423816;
57600, 32.88423816;
57600, 32.75974393;
61200, 32.75974393;
61200, 14.3617359;
64800, 14.3617359;
64800, 11.6261002;
68400, 11.6261002;
68400, 10.83882651;
72000, 10.83882651;
72000, 10.35396203;
75600, 10.35396203;
75600, 9.851165997;
79200, 9.851165997;
79200, 9.352269932;
82800, 9.352269932;
82800, 8.824051451;
86400, 8.824051451])
    "EnergyPlus result: outlet temperature"
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Sources.TimeTable PEPlu_ori(table=[0, 0;
3600, 0;
3600, 0;
7200, 0;
7200, 0;
10800, 0;
10800, 0;
14400, 0;
14400, 0;
18000, 0;
18000, 0;
21600, 0;
21600, 0;
25200, 0;
25200, 0;
28800, 0;
28800, 0;
32400, 0;
32400, 3336.445425;
36000, 3336.445425;
36000, 4894.010392;
39600, 4894.010392;
39600, 4772.824613;
43200, 4772.824613;
43200, 4686.053747;
46800, 4686.053747;
46800, 4634.638248;
50400, 4634.638248;
50400, 4614.587376;
54000, 4614.587376;
54000, 4590.546797;
57600, 4590.546797;
57600, 4579.13799;
61200, 4579.13799;
61200, 0;
64800, 0;
64800, 0;
68400, 0;
68400, 0;
72000, 0;
72000, 0;
75600, 0;
75600, 0;
79200, 0;
79200, 0;
82800, 0;
82800, 0;
86400, 0]) "EnergyPlus result: electric power"
    annotation (Placement(transformation(extent={{-100,-140},{-80,-120}})));
  Modelica.Blocks.Sources.TimeTable XConOutEPlu_ori(table=[0, 0.002415798;
3600, 0.002415798;
3600, 0.001910966;
7200, 0.001910966;
7200, 0.001540862;
10800, 0.001540862;
10800, 0.00134493;
14400, 0.00134493;
14400, 0.001237541;
18000, 0.001237541;
18000, 0.001188093;
21600, 0.001188093;
21600, 0.00116648;
25200, 0.00116648;
25200, 0.001185371;
28800, 0.001185371;
28800, 0.001220762;
32400, 0.001220762;
32400, 0.001255824;
36000, 0.001255824;
36000, 0.00133358;
39600, 0.00133358;
39600, 0.001507785;
43200, 0.001507785;
43200, 0.001696558;
46800, 0.001696558;
46800, 0.001874923;
50400, 0.001874923;
50400, 0.002024613;
54000, 0.002024613;
54000, 0.002163441;
57600, 0.002163441;
57600, 0.002290996;
61200, 0.002290996;
61200, 0.002338623;
64800, 0.002338623;
64800, 0.002356039;
68400, 0.002356039;
68400, 0.002381858;
72000, 0.002381858;
72000, 0.002437251;
75600, 0.002437251;
75600, 0.00250328;
79200, 0.00250328;
79200, 0.002554417;
82800, 0.002554417;
82800, 0.002568107;
86400, 0.002568107])
    "EnergyPlus result: outlet water mass fraction"
    annotation (Placement(transformation(extent={{-40,-140},{-20,-120}})));
  Modelica.Blocks.Sources.TimeTable Q_flowEPlu_ori(table=[0, 0;
3600, 0;
3600, 0;
7200, 0;
7200, 0;
10800, 0;
10800, 0;
14400, 0;
14400, 0;
18000, 0;
18000, 0;
21600, 0;
21600, 0;
25200, 0;
25200, 0;
28800, 0;
28800, 0;
32400, 0;
32400, 7705.47207;
36000, 7705.47207;
36000, 11727.88665;
39600, 11727.88665;
39600, 11824.62577;
43200, 11824.62577;
43200, 11919.39508;
46800, 11919.39508;
46800, 12048.27597;
50400, 12048.27597;
50400, 12030.94751;
54000, 12030.94751;
54000, 11810.94033;
57600, 11810.94033;
57600, 11701.1276;
61200, 11701.1276;
61200, 0;
64800, 0;
64800, 0;
68400, 0;
68400, 0;
72000, 0;
72000, 0;
75600, 0;
75600, 0;
79200, 0;
79200, 0;
82800, 0;
82800, 0;
86400, 0])
"EnergyPlus result: heat flow"
    annotation (Placement(transformation(extent={{60,-140},{80,-120}})));
  parameter
    Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Data.Generic.CoolingCoil
    datCoi(sta={
        Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Data.Generic.BaseClasses.Stage(
        spe=1800/60,
        nomVal=
          Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Data.Generic.BaseClasses.NominalValues(
          activate_CooCoi=false,
          Q_flow_nominal=15000,
          COP_nominal=2.75,
          SHR_nominal=1,
          m_flow_nominal=0.782220983308365,
          TEvaIn_nominal=273.15 + 6,
          TConIn_nominal=273.15 + 21),
        perCur=
          Buildings.Fluid.HeatExchangers.DXCoils.AirSource.Examples.PerformanceCurves.DXHeating_Curve_II())},
      nSta=1) "Coil data"
    annotation (Placement(transformation(extent={{80,40},{100,60}})));
  UnitDelay PEPlu(samplePeriod=3600)
    annotation (Placement(transformation(extent={{-68,-140},{-48,-120}})));
  UnitDelay Q_flowEPlu(samplePeriod=3600)
    annotation (Placement(transformation(extent={{100,-140},{120,-120}})));
  UnitDelay TOutEPlu(samplePeriod=3600, y_start=29.34948133)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  UnitDelay XConOutEPlu(samplePeriod=1)
    annotation (Placement(transformation(extent={{20,-140},{40,-120}})));

  // The UnitDelay is reimplemented to avoid in Dymola 2016 the translation warning
  //   The initial conditions for variables of type Boolean are not fully specified.
  //   Dymola has selected default initial conditions.
  //   Assuming fixed default start value for the discrete non-states:
  //     PEPlu.firstTrigger(start = false)
  //     ...
  Data.Generic.BaseClasses.Defrost defCur(
    defOpe=Buildings.Fluid.HeatExchangers.DXCoils.BaseClasses.DefrostOperation.resistive,
    QDefResCap=10500,
    QCraCap=200,
    PLFraFunPLR={1})
    annotation (Placement(transformation(extent={{80,-6},{100,14}})));

  Modelica.Blocks.Sources.TimeTable XOut(table=[0, 0.001478673;
3600, 0.001478673;
3600, 0.001001022;
7200, 0.001001022;
7200, 0.001052853;
10800, 0.001052853;
10800, 0.00107708;
14400, 0.00107708;
14400, 0.001105676;
18000, 0.001105676;
18000, 0.001126383;
21600, 0.001126383;
21600, 0.001162454;
25200, 0.001162454;
25200, 0.00122605;
28800, 0.00122605;
28800, 0.001266156;
32400, 0.001266156;
32400, 0.001295061;
36000, 0.001295061;
36000, 0.001465805;
39600, 0.001465805;
39600, 0.00173053;
43200, 0.00173053;
43200, 0.001941132;
46800, 0.001941132;
46800, 0.002089642;
50400, 0.002089642;
50400, 0.002203257;
54000, 0.002203257;
54000, 0.002350111;
57600, 0.002350111;
57600, 0.002423559;
61200, 0.002423559;
61200, 0.002413535;
64800, 0.002413535;
64800, 0.002404725;
68400, 0.002404725;
68400, 0.002476843;
72000, 0.002476843;
72000, 0.002577387;
75600, 0.002577387;
75600, 0.002626468;
79200, 0.002626468;
79200, 0.002623316;
82800, 0.002623316;
82800, 0.00249463;
86400, 0.00249463])
    "Evaporator inlet temperature"
    annotation (Placement(transformation(extent={{-140,40},{-120,60}})));
  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAir
    annotation (Placement(transformation(extent={{-100,40},{-80,60}})));
  Buildings.Utilities.Psychrometrics.ToTotalAir toTotAir1
    annotation (Placement(transformation(extent={{-10,-140},{10,-120}})));
  UnitDelay PMod(samplePeriod=1)
    annotation (Placement(transformation(extent={{120,10},{140,30}})));
  UnitDelay TOutMod(samplePeriod=1)
    annotation (Placement(transformation(extent={{140,50},{160,70}})));
  UnitDelay Q_flowMeaMod(samplePeriod=1)
    annotation (Placement(transformation(extent={{40,50},{60,70}})));
  Modelica.Blocks.Sources.TimeTable uOnOff(table=[
0, 0;
3600, 0;
3600, 0;
7200, 0;
7200, 0;
10800, 0;
10800, 0;
14400, 0;
14400, 0;
18000, 0;
18000, 0;
21600, 0;
21600, 0;
25200, 0;
25200, 0;
28800, 0;
28800, 0;
32400, 0;
32400, 0;
33600, 0;
33600, 1;
36000, 1;
36000, 1;
39600, 1;
39600, 1;
43200, 1;
43200, 1;
46800, 1;
46800, 1;
50400, 1;
50400, 1;
54000, 1;
54000, 1;
57600, 1;
57600, 1;
61200, 1;
61200, 0;
64800, 0;
64800, 0;
68400, 0;
68400, 0;
72000, 0;
72000, 0;
75600, 0;
75600, 0;
79200, 0;
79200, 0;
82800, 0;
82800, 0;
86400, 0])
    "On-off signal for coil"
    annotation (Placement(transformation(extent={{-152,116},{-132,136}})));
  Controls.OBC.CDL.Continuous.GreaterThreshold greThr(t=0.5)
    annotation (Placement(transformation(extent={{-80,110},{-60,130}})));
  Modelica.Blocks.Sources.TimeTable PDefEPlu_ori(table=[0, 0;
3600, 0;
3600, 0;
7200, 0;
7200, 0;
10800, 0;
10800, 0;
14400, 0;
14400, 0;
18000, 0;
18000, 0;
21600, 0;
21600, 0;
25200, 0;
25200, 0;
28800, 0;
28800, 0;
32400, 0;
32400, 1166.669;
36000, 1166.669;
36000, 1750.0035;
39600, 1750.0035;
39600, 1750.0035;
43200, 1750.0035;
43200, 1750.0035;
46800, 1750.0035;
46800, 1750.0035;
50400, 1750.0035;
50400, 1750.0035;
54000, 1750.0035;
54000, 1750.0035;
57600, 1750.0035;
57600, 1750.0035;
61200, 1750.0035;
61200, 0;
64800, 0;
64800, 0;
68400, 0;
68400, 0;
72000, 0;
72000, 0;
75600, 0;
75600, 0;
79200, 0;
79200, 0;
82800, 0;
82800, 0;
86400, 0])
   "EnergyPlus result: defrost power"
    annotation (Placement(transformation(extent={{60,-50},{80,-30}})));
  UnitDelay PDefEPlu(samplePeriod=1)
    annotation (Placement(transformation(extent={{100,-50},{120,-30}})));
  Modelica.Blocks.Sources.TimeTable PCraEPlu_ori(table=[0, 200;
3600, 200;
3600, 200;
7200, 200;
7200, 200;
10800, 200;
10800, 200;
14400, 200;
14400, 200;
18000, 200;
18000, 200;
21600, 200;
21600, 200;
25200, 200;
25200, 200;
28800, 200;
28800, 200;
32400, 200;
32400, 66.66666667;
36000, 66.66666667;
36000, 0;
39600, 0;
39600, 0;
43200, 0;
43200, 0;
46800, 0;
46800, 0;
50400, 0;
50400, 0;
54000, 0;
54000, 0;
57600, 0;
57600, 0;
61200, 0;
61200, 200;
64800, 200;
64800, 200;
68400, 200;
68400, 200;
72000, 200;
72000, 200;
75600, 200;
75600, 200;
79200, 200;
79200, 200;
82800, 200;
82800, 200;
86400, 200])
    "EnergyPlus result: crankcase heater power"
    annotation (Placement(transformation(extent={{60,-90},{80,-70}})));
  UnitDelay PCraEPlu(samplePeriod=3600)
    annotation (Placement(transformation(extent={{100,-90},{120,-70}})));
protected
  block UnitDelay
    extends Modelica.Blocks.Discrete.UnitDelay(
      firstTrigger(start=false, fixed=true));
  end UnitDelay;
equation
  connect(sou.ports[1], sinSpeDX.port_a)
                                        annotation (Line(
      points={{-20,-10},{-16,-10},{-16,10},{-10,10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(sinSpeDX.port_b, sin.ports[1])
                                        annotation (Line(
      points={{10,10},{16,10},{16,-10},{20,-10}},
      color={0,127,255},
      smooth=Smooth.None));
  connect(mux.y, sou.X_in)          annotation (Line(
      points={{-59,-50},{-52,-50},{-52,-14},{-42,-14}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEvaIn_K.Kelvin, sinSpeDX.TOut) annotation (Line(
      points={{-79,79.8},{-66.5,79.8},{-66.5,13},{-11,13}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TConIn_K.Kelvin, sou.T_in)    annotation (Line(
      points={{-79,-10.2},{-51.7,-10.2},{-51.7,-6},{-42,-6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TOut.y, TOutMea.u)
                           annotation (Line(
      points={{61,90},{78,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TOutMea.y, TOutDegC.Kelvin)
                                    annotation (Line(
      points={{101,90},{118,90}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(XConOut.y,XConOutMea. u)
                           annotation (Line(
      points={{61,130},{78,130}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(XConInMoiAir.y, add.u2)
                           annotation (Line(
      points={{-119,-110},{-112,-110},{-112,-96},{-102,-96}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(add.y, mux.u2[1]) annotation (Line(
      points={{-79,-90},{-68,-90},{-68,-68},{-96,-68},{-96,-56},{-82,-56}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(p.y, sou.p_in) annotation (Line(
      points={{-119,20},{-74,20},{-74,-2},{-42,-2}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(XConInMod.y, mux.u1[1]) annotation (Line(
      points={{-119,-44},{-82,-44}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(XConInMod.y, add.u1) annotation (Line(
      points={{-119,-44},{-110,-44},{-110,-84},{-102,-84}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TEvaIn.y, TEvaIn_K.Celsius) annotation (Line(
      points={{-119,80},{-110.5,80},{-110.5,79.6},{-102,79.6}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TConIn.y,TConIn_K. Celsius) annotation (Line(
      points={{-119,-10},{-110.5,-10},{-110.5,-10.4},{-102,-10.4}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PEPlu_ori.y, PEPlu.u) annotation (Line(
      points={{-79,-130},{-70,-130}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(Q_flowEPlu_ori.y, Q_flowEPlu.u) annotation (Line(
      points={{81,-130},{98,-130}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(TOutEPlu_ori.y, TOutEPlu.u) annotation (Line(
      points={{-19,-70},{-2,-70}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(sinSpeDX.QSen_flow, Q_flowMea.u) annotation (Line(points={{11,17},{20,
          17},{20,54},{-10,54},{-10,90},{-2,90}}, color={0,0,127}));
  connect(XOut.y, toTotAir.XiDry)
    annotation (Line(points={{-119,50},{-101,50}}, color={0,0,127}));
  connect(toTotAir.XiTotalAir, sinSpeDX.XOut) annotation (Line(points={{-79,50},
          {-20,50},{-20,1},{-11,1}}, color={0,0,127}));
  connect(XConOutEPlu_ori.y, toTotAir1.XiDry)
    annotation (Line(points={{-19,-130},{-11,-130}}, color={0,0,127}));
  connect(toTotAir1.XiTotalAir, XConOutEPlu.u)
    annotation (Line(points={{11,-130},{18,-130}}, color={0,0,127}));
  connect(sinSpeDX.P, PMea.u) annotation (Line(points={{11,19},{25.5,19},{25.5,20},
          {38,20}}, color={0,0,127}));
  connect(PMea.y, PMod.u)
    annotation (Line(points={{61,20},{118,20}}, color={0,0,127}));
  connect(TOutDegC.Celsius, TOutMod.u) annotation (Line(points={{141,90},{152,90},
          {152,78},{130,78},{130,60},{138,60}}, color={0,0,127}));
  connect(Q_flowMea.y, Q_flowMeaMod.u) annotation (Line(points={{21,90},{21,75},
          {38,75},{38,60}}, color={0,0,127}));
  connect(uOnOff.y, greThr.u) annotation (Line(points={{-131,126},{-86,126},{-86,
          120},{-82,120}}, color={0,0,127}));
  connect(greThr.y, sinSpeDX.on) annotation (Line(points={{-58,120},{-30,120},{-30,
          18},{-11,18}}, color={255,0,255}));
  connect(PDefEPlu_ori.y, PDefEPlu.u) annotation (Line(
      points={{81,-40},{98,-40}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(PCraEPlu_ori.y, PCraEPlu.u) annotation (Line(
      points={{81,-80},{98,-80}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-160,-140},
            {160,140}})),
             __Dymola_Commands(file="modelica://Buildings/Resources/cripts/Dymola/Fluid/HeatExchangers/DXCoils/AirSource/Validation/SingleSpeedHeatingPLREnergyPlusDefrost_TimedReverseCycle.mos"
        "Simulate and Plot"),
    experiment(Tolerance=1e-6, StopTime=86400),
            Documentation(info="<html>
<p>
This model validates the model
<a href=\"modelica://Buildings.Fluid.HeatExchangers.DXCoils.AirSource.SingleSpeed\">
Buildings.Fluid.HeatExchangers.DXCoils.AirSource.SingleSpeed</a>.
</p>
<p>
The difference in results of
<i>T<sub>Out</sub></i> and
<i>X<sub>Out</sub></i>
at the beginning and end of the simulation is because the mass flow rate is zero.
For zero mass flow rate, EnergyPlus assumes steady state condition,
whereas the Modelica model is a dynamic model and hence the properties at the outlet
are equal to the state variables of the model.
</p>
<p>
The EnergyPlus results were generated using the example file <code>DXCoilSystemAuto.idf</code>
from EnergyPlus 7.1.
<p>
The EnergyPlus results were generated using the example file
<code>DXCoilSystemAuto.idf</code> from EnergyPlus 7.1.
On the summer design day, the PLR is below 1.
A similar effect has been achieved in this example by turning on the coil only for the period
during which it run in EnergyPlus.
This results in on-off cycle and fluctuating results.
To compare the results, the Modelica outputs are averaged over <i>3600</i> seconds,
and the EnergyPlus outputs are used with a zero order delay to avoid the time shift in results.
</p>
<p>
Note that EnergyPlus mass fractions (<code>X</code>) are in mass of water vapor per mass of dry air,
whereas Modelica uses the total mass as a reference. Hence, the EnergyPlus values
are corrected by dividing them by
<code>1+X</code>.
</p>
</html>",
revisions="<html>
<ul>
<li>
January 22, 2016, by Michael Wetter:<br/>
Corrected type declaration of pressure difference.
This is
for <a href=\"https://github.com/ibpsa/modelica-ibpsa/issues/404\">#404</a>.
</li>
<li>
September 24, 2015 by Michael Wetter:<br/>
Implemented <code>UnitDelay</code> to avoid a translation warning
because <code>UnitDelay.firstTrigger</code> does not set the <code>fixed</code>
attribute in MSL 3.2.1.
</li>
<li>
June 9, 2015, by Michael Wetter:<br/>
Corrected wrong link to run script.
</li>
<li>
December 22, 2014 by Michael Wetter:<br/>
Removed <code>Modelica.Fluid.System</code>
to address issue
<a href=\"https://github.com/lbl-srg/modelica-buildings/issues/311\">#311</a>.
</li>
<li>
September 4, 2012 by Michael Wetter:<br/>
Modified example to avoid having to access protected data.
</li>
<li>
August 20, 2012 by Kaustubh Phalak:<br/>
First implementation.
</li>
</ul>
</html>"));
end SingleSpeedHeatingPLREnergyPlusDefrost_TimedReverseCycle;
