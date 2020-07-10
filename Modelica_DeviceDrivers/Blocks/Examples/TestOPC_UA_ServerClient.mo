within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_ServerClient
  extends Modelica.Icons.Example;
  Communication.OPC_UA.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={-22,76},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Communication.OPC_UA.OPC_UA_addIntNode addAIntComponent(
    enableExternalTrigger=false,
    startTime=0.0,
    parentRefId=Modelica_DeviceDrivers.Blocks.Communication.OPC_UA.Types.ReferenceID.hasComponent,
    nodeName="someIntComponent",
    sampleTime=0.05)
    annotation (Placement(transformation(extent={{-32,34},{-12,54}})));

  Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=0.01)
    annotation (Placement(transformation(extent={{-102,38},{-82,58}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-72,38},{-52,58}})));
  Communication.OPC_UA.OPC_UA_Client oPC_UA_Client(endPointURL=
        "opc.tcp://BFT172:4840/")
    annotation (Placement(transformation(extent={{12,66},{32,86}})));
  Communication.OPC_UA.OPC_UA_readIntNode oPC_UA_readIntNode(sampleTime=0.1)
                                                             annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={22,44})));
  Communication.OPC_UA.OPC_UA_readDoubleNode oPC_UA_readDoubleNode(nodeId=102)
    annotation (Placement(transformation(extent={{44,34},{64,54}})));
  Communication.OPC_UA.OPC_UA_addRealNode addARealORganizedNode(nodeName=
        "realChild", nodeId=102)
    annotation (Placement(transformation(extent={{-32,-2},{-12,18}})));
equation
  connect(sine.y, realToInteger.u) annotation (Line(
      points={{-81,48},{-74,48}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(addAIntComponent.intVarIn, realToInteger.y) annotation (Line(
      points={{-32.4,44},{-42,44},{-42,48},{-51,48}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_Client.oPC_UA_ClientConnectorOut, oPC_UA_readIntNode.oPC_UA_ClientConnectorIn)
    annotation (Line(
      points={{21.9,65.9},{21.9,57.95},{22,57.95},{22,54}},
      color={85,170,255},
      smooth=Smooth.None));
  connect(oPC_UA_Server1.oPC_UA_ServerConnectorOut, addAIntComponent.oPC_UA_ServerConnectorIn)
    annotation (Line(
      points={{-22.5,65.4},{-22.5,58.7},{-22.3,58.7},{-22.3,54.1}},
      color={0,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_Client.oPC_UA_ClientConnectorOut, oPC_UA_readDoubleNode.oPC_UA_ClientConnectorIn)
    annotation (Line(points={{21.9,65.9},{37.95,65.9},{37.95,54},{54,54}},
        color={85,170,255}));
  connect(addARealORganizedNode.oPC_UA_ServerConnectorIn, addAIntComponent.oPC_UA_ServerConnectorOut)
    annotation (Line(points={{-22.3,18.1},{-22.3,24.05},{-22.4,24.05},{-22.4,
          33.8}}, color={0,127,0}));
  connect(addARealORganizedNode.realVarIn, sine.y)
    annotation (Line(points={{-31,7.8},{-81,7.8},{-81,48}}, color={0,0,127}));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end TestOPC_UA_ServerClient;
