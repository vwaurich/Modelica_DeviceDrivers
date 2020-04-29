within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server
  extends Modelica.Icons.Example;
  Communication.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={24,62},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-92,32},{-72,52}})));
  Communication.OPC_UA_addIntNode oPC_UA_addIntNode(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1)
    annotation (Placement(transformation(extent={{-36,-34},{-16,-14}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=0.1)
    annotation (Placement(transformation(extent={{-126,-32},{-106,-12}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-86,-36},{-66,-16}})));
  Communication.OPC_UA_addIntNode oPC_UA_addIntNode1(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeName="eieiei")
    annotation (Placement(transformation(extent={{-36,-58},{-16,-38}})));
  Communication.OPC_UA_addIntNode oPC_UA_addIntNode2(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeName="caramba")
    annotation (Placement(transformation(extent={{-36,-82},{-16,-62}})));
equation
  connect(oPC_UA_addIntNode.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-15.8,-24},{54,-24},{54,62},{34.2,62}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(realToInteger.u, sine.y) annotation (Line(
      points={{-88,-26},{-88,-22},{-105,-22}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, oPC_UA_addIntNode.intVarIn) annotation (Line(
      points={{-65,-26},{-52,-26},{-52,-24},{-36.4,-24}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode1.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-15.8,-48},{34.2,-48},{34.2,62}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(realToInteger.y, oPC_UA_addIntNode1.intVarIn) annotation (Line(
      points={{-65,-26},{-52,-26},{-52,-48},{-36.4,-48}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode2.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(points={{-15.8,-72},{14,-72},{14,-70},{44,-70},{44,62},{
          34.2,62}}, smooth=Smooth.None));
  connect(realToInteger.y, oPC_UA_addIntNode2.intVarIn) annotation (Line(
      points={{-65,-26},{-52,-26},{-52,-72},{-36.4,-72}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TestOPC_UA_Server;
