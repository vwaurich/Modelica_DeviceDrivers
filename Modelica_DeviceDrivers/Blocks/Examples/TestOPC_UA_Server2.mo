within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server2
  extends Modelica.Icons.Example;
  Communication.OPC_UA.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={-22,84},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Communication.OPC_UA.OPC_UA_addIntNode oPC_UA_addIntNode(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1)
    annotation (Placement(transformation(extent={{-32,36},{-12,56}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=0.05)
    annotation (Placement(transformation(extent={{-96,36},{-76,56}})));
  Communication.OPC_UA.OPC_UA_addObjectNode oPC_UA_addObjectNode
    annotation (Placement(transformation(extent={{12,36},{32,56}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-66,36},{-46,56}})));
  Communication.OPC_UA.OPC_UA_addIntNode oPC_UA_addIntNode1(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeId=104,
    nodeName="aChildIntNode")
    annotation (Placement(transformation(extent={{12,6},{32,26}})));
equation
  connect(oPC_UA_addObjectNode.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{22,56},{22,74.2},{-22,74.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(sine.y, realToInteger.u) annotation (Line(
      points={{-75,46},{-68,46}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode.intVarIn, realToInteger.y) annotation (Line(
      points={{-32.4,46},{-45,46}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode1.oPC_UA_ServerConnectorIn, oPC_UA_addObjectNode.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{22,26},{22,35.8}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode1.intVarIn, realToInteger.y) annotation (Line(
      points={{11.6,16},{-45,16},{-45,46}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_Server1.oPC_UA_ServerConnectorOut, oPC_UA_addIntNode.oPC_UA_ServerConnectorIn)
    annotation (Line(
      points={{-22,74.2},{-22,56}},
      color={0,0,0},
      smooth=Smooth.None));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TestOPC_UA_Server2;
