within Buildings.Extra.PackageTerminalHeatPump.FinalizedModel;
model ConHP
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput THeaSup annotation(Placement(transformation(extent = {{-139.77624945859284,48.160351216519004},{-99.77624945859282,88.160351216519}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealInput TCooSup annotation(Placement(transformation(extent = {{-139.36605682346064,-109.35362067423323},{-99.36605682346064,-69.35362067423323}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ConHeaCoo annotation(Placement(transformation(extent = {{-139.77624945859282,5.910509797905746},{-99.77624945859282,45.910509797905746}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ConHeaSup annotation(Placement(transformation(extent = {{-139.36605682346067,-31.00682736398931},{-99.36605682346067,8.99317263601069}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.BooleanInput ConHP annotation(Placement(transformation(extent = {{-139.3660568234607,-72.026090877206},{-99.3660568234607,-32.026090877205995}},origin = {0.0,0.0},rotation = 0.0)));
    Buildings.Controls.OBC.CDL.Integers.Switch HPHeaCooOff annotation(Placement(transformation(extent = {{-39.1236770943839,21.243014054623924},{-19.1236770943839,41.24301405462393}},origin = {0.0,0.0},rotation = 0.0)));
    Buildings.Controls.OBC.CDL.Integers.Switch HPOnOff annotation(Placement(transformation(extent = {{5.997512770154483,-10.752011485685106},{25.997512770154483,9.247988514314894}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Integers.Sources.Constant conInt(k = -1) annotation(Placement(transformation(extent = {{-63.8346743237901,34.36917837885326},{-83.8346743237901,54.36917837885326}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Integers.Sources.Constant HPOff(k = 0) annotation(Placement(transformation(extent = {{-41.58483290517689,-52.181467634033986},{-21.58483290517689,-32.181467634033986}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Conversions.BooleanToInteger HPHeaOrOff annotation(Placement(transformation(extent = {{-85.06525222918658,-2.137966147909589},{-65.06525222918658,17.862033852090413}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Integers.GreaterThreshold IntGreThr annotation(Placement(transformation(extent = {{37.172153040199156,-10.752011485685134},{57.172153040199156,9.247988514314866}},origin = {0.0,0.0},rotation = 0.0)));
    Buildings.Controls.OBC.CDL.Continuous.Switch swi annotation(Placement(transformation(extent = {{69.9875638507726,-10.752011485685111},{89.9875638507726,9.247988514314889}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.IntegerOutput HPStatus annotation(Placement(transformation(extent = {{100.59663472885718,18.216288851870765},{140.59663472885717,58.216288851870765}},origin = {0.0,0.0},rotation = 0.0)));
    .Buildings.Controls.OBC.CDL.Interfaces.RealOutput yTSupHP annotation(Placement(transformation(extent = {{100.18644209372499,-49.0553033098046},{140.186442093725,-9.0553033098046}},origin = {0.0,0.0},rotation = 0.0)));
equation
    connect(THeaSup,swi.u1) annotation(Line(points = {{-119.77624945859283,68.160351216519},{59.932435053467415,68.160351216519},{59.932435053467415,7.247988514314889},{67.9875638507726,7.247988514314889}},color = {0,0,127}));
    connect(TCooSup,swi.u3) annotation(Line(points = {{-119.36605682346064,-89.35362067423324},{59.93243505346741,-89.35362067423324},{59.93243505346741,-8.752011485685111},{67.9875638507726,-8.752011485685111}},color = {0,0,127}));
    connect(conInt.y,HPHeaCooOff.u1) annotation(Line(points = {{-85.8346743237901,44.36917837885326},{-91.8346743237901,44.36917837885326},{-91.8346743237901,60.36917837885326},{-41.1236770943839,60.36917837885326},{-41.1236770943839,39.24301405462393}},color = {255,127,0}));
    connect(ConHeaCoo,HPHeaCooOff.u2) annotation(Line(points = {{-119.77624945859282,25.910509797905746},{-55.33861026609892,25.910509797905746},{-55.33861026609892,31.243014054623927},{-41.1236770943839,31.243014054623927}},color = {255,0,255}));
    connect(ConHP,HPOnOff.u2) annotation(Line(points = {{-119.3660568234607,-52.026090877206},{-57.684272026653105,-52.026090877206},{-57.684272026653105,-0.7520114856851059},{3.997512770154483,-0.7520114856851059}},color = {255,0,255}));
    connect(HPHeaCooOff.y,HPOnOff.u1) annotation(Line(points = {{-17.1236770943839,31.243014054623927},{3.997512770154483,31.243014054623927},{3.997512770154483,7.247988514314894}},color = {255,127,0}));
    connect(HPOff.y,HPOnOff.u3) annotation(Line(points = {{-19.58483290517689,-42.181467634033986},{3.997512770154483,-42.181467634033986},{3.997512770154483,-8.752011485685106}},color = {255,127,0}));
    connect(ConHeaSup,HPHeaOrOff.u) annotation(Line(points={{-119.366,-11.0068},
          {-92.0003,-11.0068},{-92.0003,7.86203},{-87.0653,7.86203}},                                                                                                                                                           color = {255,0,255}));
    connect(HPHeaOrOff.y,HPHeaCooOff.u3) annotation(Line(points = {{-63.065252229186584,7.862033852090413},{-41.1236770943839,7.862033852090413},{-41.1236770943839,23.243014054623927}},color = {255,127,0}));
    connect(IntGreThr.y,swi.u2) annotation(Line(points = {{59.172153040199156,-0.7520114856851343},{67.9875638507726,-0.7520114856851112}},color = {255,0,255}));
    connect(HPOnOff.y,IntGreThr.u) annotation(Line(points = {{27.997512770154483,-0.7520114856851059},{35.172153040199156,-0.7520114856851343}},color = {255,127,0}));
    connect(HPOnOff.y,HPStatus) annotation(Line(points = {{27.997512770154483,-0.7520114856851059},{31.1784431286369,-0.7520114856851059},{31.1784431286369,38.216288851870765},{120.59663472885717,38.216288851870765}},color = {255,127,0}));
    connect(swi.y,yTSupHP) annotation(Line(points = {{91.9875638507726,-0.7520114856851112},{96.13654975204827,-0.7520114856851112},{96.13654975204827,-29.0553033098046},{120.18644209372499,-29.0553033098046}},color = {0,0,127}));
    annotation(Icon(coordinateSystem(preserveAspectRatio = false,extent = {{-100.0,-100.0},{100.0,100.0}}),graphics={  Rectangle(fillColor={255,255,255},
            fillPattern =                                                                                                                                            FillPattern.Solid,extent={{-100.0,-100.0},{100.0,100.0}}),Text(lineColor={0,0,255},extent={{-150,150},{150,110}},textString
            =                                                                                                                                                                                                        "%name")}));
end ConHP;
