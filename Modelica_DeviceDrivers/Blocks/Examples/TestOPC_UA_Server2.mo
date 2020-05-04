within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server2
  extends Modelica.Icons.Example;
  Communication.OPC_UA.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={-22,84},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Communication.OPC_UA.OPC_UA_addIntNode addAIntComponent(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    parentRefId=Modelica_DeviceDrivers.Blocks.Communication.OPC_UA.Types.ReferenceID.hasComponent,

    nodeName="someIntComponent")
    annotation (Placement(transformation(extent={{-32,38},{-12,58}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=0.01)
    annotation (Placement(transformation(extent={{-102,-28},{-82,-8}})));
  Communication.OPC_UA.OPC_UA_addObjectNode oPC_UA_addObjectNode
    annotation (Placement(transformation(extent={{12,36},{32,56}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-72,-28},{-52,-8}})));
  Communication.OPC_UA.OPC_UA_addIntNode addAChildIntProp(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeId=104,
    parentRefId=Modelica_DeviceDrivers.Blocks.Communication.OPC_UA.Types.ReferenceID.hasProperty,

    nodeName="intProperty")
    annotation (Placement(transformation(extent={{12,0},{32,20}})));
  Communication.OPC_UA.OPC_UA_addRealNode addARealORganizedNode(nodeName=
        "realChild")
    annotation (Placement(transformation(extent={{58,0},{78,20}})));
  Communication.OPC_UA.OPC_UA_addIntNode addAIntComponent1(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    parentRefId=Modelica_DeviceDrivers.Blocks.Communication.OPC_UA.Types.ReferenceID.hasComponent,

    nodeId=106,
    nodeName="someNewIntComponent")
    annotation (Placement(transformation(extent={{-32,0},{-12,20}})));
equation
  connect(sine.y, realToInteger.u) annotation (Line(
      points={{-81,-18},{-74,-18}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(addAIntComponent.intVarIn, realToInteger.y) annotation (Line(
      points={{-32.4,48},{-40,48},{-40,-18},{-51,-18}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(addAChildIntProp.intVarIn, realToInteger.y) annotation (Line(
      points={{11.6,10},{4,10},{4,-18},{-51,-18}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(sine.y, addARealORganizedNode.realVarIn) annotation (Line(
      points={{-81,-18},{-74,-18},{-74,-40},{50,-40},{50,9.8},{59,9.8}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(oPC_UA_Server1.oPC_UA_ServerConnectorOut, addAIntComponent.oPC_UA_ServerConnectorIn)
    annotation (Line(
      points={{-22.6,73.5},{-22.6,63.75},{-22.3,63.75},{-22.3,58.1}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_Server1.oPC_UA_ServerConnectorOut, oPC_UA_addObjectNode.oPC_UA_ServerConnectorIn)
    annotation (Line(
      points={{-22.6,73.5},{22,73.5},{22,58},{22,56},{22,56.1},{21.7,56.1}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_addObjectNode.oPC_UA_ServerConnectorOut, addAChildIntProp.oPC_UA_ServerConnectorIn)
    annotation (Line(
      points={{22,35.8},{22,20.1},{21.7,20.1}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(addARealORganizedNode.oPC_UA_ServerConnectorIn, addAChildIntProp.oPC_UA_ServerConnectorIn)
    annotation (Line(
      points={{67.7,20.1},{67.7,32},{22,32},{22,20.1},{21.7,20.1}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(addAIntComponent1.oPC_UA_ServerConnectorIn, addAIntComponent.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-22.3,20.1},{-22.3,29.05},{-22.4,29.05},{-22.4,37.8}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(addAIntComponent1.intVarIn, realToInteger.y) annotation (Line(
      points={{-32.4,10},{-34,10},{-34,-18},{-51,-18}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TestOPC_UA_Server2;
