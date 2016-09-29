within Modelica_DeviceDrivers.Blocks.Examples;
model Arduino_readInt
  "Test case to send two integer values using serial interface"
extends Modelica.Icons.Example;
  Modelica_DeviceDrivers.Blocks.Communication.SerialPortReceive serialReceive(
    Serial_Port="COM3",
    baud=Modelica_DeviceDrivers.Utilities.Types.SerialBaudRate.B9600,
    autoBufferSize=false,
    parity=0,
    startTime=0.1,
    userBufferSize=2,
    sampleTime=2,
    enableExternalTrigger=false)
    annotation (Placement(transformation(extent={{-100,60},{-80,80}})));
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{0,60},{20,80}})));
  Modelica_DeviceDrivers.Blocks.Packaging.SerialPackager.UnpackUnsignedInteger unpackInt(bitOffset=
       0, width=16)
    annotation (Placement(transformation(extent={{-78,20},{-58,40}})));
  Modelica.Blocks.Math.IntegerToReal integerToReal
    annotation (Placement(transformation(extent={{-46,20},{-26,40}})));
equation
  connect(serialReceive.pkgOut, unpackInt.pkgIn) annotation (Line(
      points={{-79.2,70},{-68,70},{-68,40.8}}));
  connect(unpackInt.y, integerToReal.u) annotation (Line(
      points={{-57,30},{-48,30}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,
            -100},{100,100}}), graphics));
end Arduino_readInt;
