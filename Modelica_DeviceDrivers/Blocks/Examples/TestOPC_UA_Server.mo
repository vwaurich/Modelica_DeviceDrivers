within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server
  extends Modelica.Icons.Example;
  Communication.OPC_UA.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={-22,84},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Modelica.Blocks.Sources.Sine sine(               freqHz=0.5, amplitude=100)
    annotation (Placement(transformation(extent={{-112,32},{-92,52}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-82,32},{-62,52}})));
  Communication.OPC_UA.OPC_UA_addIntNode oPC_UA_addIntNode
    annotation (Placement(transformation(extent={{-30,32},{-10,52}})));
equation
  connect(realToInteger.u, sine.y) annotation (Line(
      points={{-84,42},{-91,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-20.3,52.1},{-20.3,73.5},{-22.6,73.5}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(realToInteger.y, oPC_UA_addIntNode.intVarIn) annotation (Line(
      points={{-61,42},{-30.4,42}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TestOPC_UA_Server;
