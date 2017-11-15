within Modelica_DeviceDrivers.Blocks.Examples;
model TestSerialPackager_PCAN_Accel
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Communication.PCAN.Connect2CAN connect2CAN
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Communication.PCAN.ReadMessage readMSG112_Accel(pcan=connect2CAN.pcan, id=112)
    annotation (Placement(transformation(extent={{-40,60},{-20,80}})));
  Packaging.SerialPackager.UnpackUnsignedInteger euler_x(nu=1, width=16,
    bitOffset=0)
    annotation (Placement(transformation(extent={{-10,46},{10,66}})));
  Packaging.SerialPackager.UnpackUnsignedInteger euler_y(nu=1, width=16)
    annotation (Placement(transformation(extent={{-10,14},{10,34}})));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Packaging.SerialPackager.UnpackUnsignedInteger euler_z(width=16, nu=1)
    annotation (Placement(transformation(extent={{-10,-18},{10,2}})));
  Packaging.SerialPackager.UnpackUnsignedInteger
    unpackInt4(nu=1, width=8)
    annotation (Placement(transformation(extent={{-10,-50},{10,-30}})));
  Packaging.SerialPackager.UnpackUnsignedInteger
    unpackInt5(width=8)
    annotation (Placement(transformation(extent={{-10,-78},{10,-58}})));

  Real ax, ax2,  ay, ay2,  az, az2;
  discrete Real vx,  vy,  vz;
  discrete Real x,  y,  z;
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{18,46},{38,66}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal1
    annotation (Placement(transformation(extent={{20,14},{40,34}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal2
    annotation (Placement(transformation(extent={{20,-18},{40,2}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(
    length=1,
    width=0.6,
    height=0.2,
    r={x,y,z})
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
  Modelica.Blocks.Continuous.LowpassButterworth filterx(f=1)
    annotation (Placement(transformation(extent={{80,-40},{100,-20}})));
  Modelica.Blocks.Sources.RealExpression realExpression(y=ax)
    annotation (Placement(transformation(extent={{50,-40},{70,-20}})));
  Modelica.Blocks.Continuous.LowpassButterworth filtery(f=1)
    annotation (Placement(transformation(extent={{80,-70},{100,-50}})));
  Modelica.Blocks.Sources.RealExpression realExpression1(y=ay)
    annotation (Placement(transformation(extent={{50,-70},{70,-50}})));
  Modelica.Blocks.Continuous.LowpassButterworth filterz(f=1)
    annotation (Placement(transformation(extent={{80,-98},{100,-78}})));
  Modelica.Blocks.Sources.RealExpression realExpression2(y=az)
    annotation (Placement(transformation(extent={{50,-100},{70,-80}})));
equation
  when sample(0, 0.01) then
    ax = if (integerToReal.y>50000) then (-65535+(integerToReal.y))/100 else integerToReal.y/100;
    ay = if (integerToReal1.y>50000) then (-65535+(integerToReal1.y))/100 else integerToReal1.y/100;
    az = if (integerToReal2.y>50000) then (-65535+(integerToReal2.y))/100 else integerToReal2.y/100;

    vx = ax2*0.01;
    vy = ay2*0.01;
    vz = az2*0.01;

    x = pre(x) + vx*0.1;
    y = pre(y) + vy*0.1;
    z = pre(z) + vz*0.1;
  end when;

  ax2 = if ((filterx.y<0.2) and (filterx.y >-0.2)) then 0 else filterx.y;
  ay2 = if ((filtery.y<0.2) and (filtery.y >-0.2)) then 0 else filtery.y;
  az2 = if ((filterz.y<0.2) and (filterz.y >-0.2)) then 0 else filterz.y;

  connect(readMSG112_Accel.pkgOut,euler_x. pkgIn) annotation (Line(
      points={{-19.2,70},{0,70},{0,66.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(euler_y.pkgIn,euler_x. pkgOut[1]) annotation (Line(
      points={{0,34.8},{0,45.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(euler_y.pkgOut[1], euler_z.pkgIn) annotation (Line(
      points={{0,13.2},{0,2.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(euler_z.pkgOut[1], unpackInt4.pkgIn) annotation (Line(
      points={{0,-18.8},{0,-29.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(unpackInt4.pkgOut[1], unpackInt5.pkgIn) annotation (Line(
      points={{0,-50.8},{0,-57.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(euler_x.y, integerToReal.u) annotation (Line(
      points={{11,56},{16,56}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(integerToReal1.u, euler_y.y) annotation (Line(
      points={{18,24},{11,24}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(integerToReal2.u, euler_z.y) annotation (Line(
      points={{18,-8},{11,-8}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(filterx.u, realExpression.y) annotation (Line(
      points={{78,-30},{71,-30}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(filtery.u, realExpression1.y) annotation (Line(
      points={{78,-60},{71,-60}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(filterz.u, realExpression2.y) annotation (Line(
      points={{78,-88},{74,-88},{74,-90},{71,-90}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(
      StopTime=100,
      Interval=0.001,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput);
end TestSerialPackager_PCAN_Accel;
