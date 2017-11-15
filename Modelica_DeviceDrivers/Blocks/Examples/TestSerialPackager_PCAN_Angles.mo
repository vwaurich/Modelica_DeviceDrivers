within Modelica_DeviceDrivers.Blocks.Examples;
model TestSerialPackager_PCAN_Angles
  extends Modelica.Icons.Example;
  import Modelica.Constants.pi;
  Communication.PCAN.Connect2CAN connect2CAN
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Communication.PCAN.ReadMessage readMSG114_Euler(pcan=connect2CAN.pcan, id=114)
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

  Real ex, ex2, ey, ey2, ez;
  Modelica.Mechanics.MultiBody.Frames.Orientation R;
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{18,46},{38,66}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal1
    annotation (Placement(transformation(extent={{20,14},{40,34}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal2
    annotation (Placement(transformation(extent={{20,-18},{40,2}})));
  Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape shape(
    R=R,
    length=1,
    width=0.6,
    height=0.2,
    r_shape={-0.5,0,0})
    annotation (Placement(transformation(extent={{-80,-60},{-60,-40}})));
  inner Modelica.Mechanics.MultiBody.World world
    annotation (Placement(transformation(extent={{-100,-20},{-80,0}})));
equation

  ex = integerToReal.y/16.0;
  ex2 = Modelica.SIunits.Conversions.from_deg(if (ex>90) then -90+(ex-4005) else ex);
  ey = integerToReal1.y/16.0;
  ey2 = Modelica.SIunits.Conversions.from_deg(if (ey>90) then -90+(ey-4005) else ey);
  ez = Modelica.SIunits.Conversions.from_deg(integerToReal2.y/16.0);
  R = Modelica.Mechanics.MultiBody.Frames.axesRotations({1,2,3},{ex2,ey2,ez}, zeros(3));

  connect(readMSG114_Euler.pkgOut,euler_x. pkgIn) annotation (Line(
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
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics),
    experiment(
      StopTime=100,
      Interval=0.001,
      __Dymola_Algorithm="Euler"),
    __Dymola_experimentSetupOutput);
end TestSerialPackager_PCAN_Angles;
