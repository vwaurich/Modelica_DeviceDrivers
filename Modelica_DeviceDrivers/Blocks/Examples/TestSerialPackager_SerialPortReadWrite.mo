within Modelica_DeviceDrivers.Blocks.Examples;
model TestSerialPackager_SerialPortReadWrite
  "Test case to send two integer values using serial interface"
extends Modelica.Icons.Example;
  Communication.SerialPortSendReceive seriaSendlReceive(
    Serial_Port="COM6",
    baud=Modelica_DeviceDrivers.Utilities.Types.SerialBaudRate.B9600,
    userBufferSizeOut=2,
    autoBufferSize=true,
    sampleTime=0.1)
    annotation (Placement(transformation(extent={{0,0},{20,20}})));
  Modelica_DeviceDrivers.Blocks.OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Packaging.SerialPackager.UnpackUnsignedInteger unpackInt(width=8, nu=1)
    annotation (Placement(transformation(extent={{40,-20},{60,0}})));
  Packaging.SerialPackager.Packager packager
    annotation (Placement(transformation(extent={{-40,68},{-20,88}})));
  Packaging.SerialPackager.AddInteger addInteger(nu=1)
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=13)
    annotation (Placement(transformation(extent={{-80,20},{-60,40}})));
  Packaging.SerialPackager.UnpackUnsignedInteger unpackInt1(width=8)
    annotation (Placement(transformation(extent={{40,-46},{60,-26}})));
equation
  connect(seriaSendlReceive.pkgOut, unpackInt.pkgIn)
    annotation (Line(points={{20.8,10},{50,10},{50,0.8}}));
  connect(addInteger.pkgIn, packager.pkgOut) annotation (Line(points={{-30,40.8},
          {-30,67.2}},                       color={0,0,0}));
  connect(addInteger.pkgOut[1], seriaSendlReceive.pkgIn) annotation (Line(
        points={{-30,19.2},{-30,10},{-0.8,10}},
        color={0,0,0}));
  connect(integerExpression.y, addInteger.u[1])
    annotation (Line(points={{-59,30},{-42,30}}, color={255,127,0}));
  connect(unpackInt.pkgOut[1], unpackInt1.pkgIn)
    annotation (Line(points={{50,-20.8},{50,-25.2}}, color={0,0,0}));
  annotation (Documentation(info="<html>
<h4><span style=\"color:#008000\">Example for serial port support</span></h4>
<h4><span style=\"color:#008000\">Hardware setup</span></h4>
<p>In order to execute the example an appropriate physical connection between the sending and the receiving serial port needs to be established, (e.g., by using a null modem cable between the two serial port interfaces <a href=\"http://en.wikipedia.org/wiki/Null_modem\">http://en.wikipedia.org/wiki/Null_modem</a>). In fact a minimal mull modem with lines (<code>TxD</code>, <code>Rxd</code> and <code>GND</code>) is sufficient. Next, the <code>SerialPortReceive</code> and <code>SerialPortSend</code> blocks parameters must be updated with the device filenames corresponding to the connected physical serial ports. Now, the example can be executed.</p>
<h4><span style=\"color:#008000\">Alternative: Using virtual serial port devices for test purposes</span></h4>
<p>To run the example without serial port hardware, it is possible to resort to virtual serial ports. Possible ways of doing this are described in the following.</p>
<p>On Linux, make sure that <i>socat</i> is installed, e.g., on an Ubuntu machine do</p>
<pre>sudo aptitude install socat</pre>
<p>Now open a console and create two virtual serial port interfaces using socat:</p>
<pre>socat -d -d pty,raw,echo=0 pty,raw,echo=0</pre>
<p>The socat program will print the device file names that it created. The output will resemble the following:</p>
<pre>2013/11/24 15:20:21 socat[3262] N PTY is /dev/pts/1
2013/11/24 15:20:21 socat[3262] N PTY is /dev/pts/3
2013/11/24 15:20:21 socat[3262] N starting data transfer loop with FDs [3,3] and [5,5]</pre>
<p>Use them in the Send and Receive block. E.g., for the output above you would use <code>&quot;/dev/pts/1&quot;</code> in <code>SerialPortReceive</code> and <code>&quot;/dev/pts/3&quot;</code> in <code>SerialPortSend</code>.</p>
<p>You may have also have a look at the discussion about virtual serial port devices on stackoverflow<a href=\"http://stackoverflow.com/questions/52187/virtual-serial-port-for-linux\">http://stackoverflow.com/questions/52187/virtual-serial-port-for-linux</a>.</p>
<p>On Windows, make sure that the null modem emulator <i>com0com</i> is installed.</p>
<p>Start the Setup for <i>com0com</i> and check the device names of the created virtual port pair. E.g. you could type <code>&quot;COM6&quot;</code> in <code>SerialPortReceive</code> and <code>&quot;COM7&quot;</code> in <code>SerialPortSend</code>.</p>
</html>"), experiment(StopTime=5));
end TestSerialPackager_SerialPortReadWrite;
