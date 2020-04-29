within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server
  extends Modelica.Icons.Example;
  Communication.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={-22,84},     extent = {{-10, -10}, {10, 10}}, rotation=0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-100,80},{-80,100}})));
  Communication.OPC_UA_addIntNode oPC_UA_addIntNode(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeName="eieiei")
    annotation (Placement(transformation(extent={{-52,32},{-32,52}})));
  Modelica.Blocks.Sources.Sine sine(amplitude=100, freqHz=0.5)
    annotation (Placement(transformation(extent={{-112,32},{-92,52}})));
  Modelica.Blocks.Math.RealToInteger realToInteger
    annotation (Placement(transformation(extent={{-82,32},{-62,52}})));
  Communication.OPC_UA_addIntNode oPC_UA_addIntNode1(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeName="huhuhu")
    annotation (Placement(transformation(extent={{-48,10},{-28,30}})));
  Communication.OPC_UA_addRealNode oPC_UA_addIntNode2(
    enableExternalTrigger=false,
    startTime=0.0,
    sampleTime=0.1,
    nodeName="realNode1")
    annotation (Placement(transformation(extent={{-24,-26},{-4,-6}})));
  Modelica.Blocks.Sources.Sine sine1(amplitude=100, freqHz=0.2)
    annotation (Placement(transformation(extent={{-84,-26},{-64,-6}})));
equation
  connect(realToInteger.u, sine.y) annotation (Line(
      points={{-84,42},{-91,42}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(realToInteger.y, oPC_UA_addIntNode.intVarIn) annotation (Line(
      points={{-61,42},{-52.4,42}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-31.8,42},{-22,42},{-22,74.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode1.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-27.8,20},{-22,20},{-22,74.2}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode1.intVarIn, realToInteger.y) annotation (Line(
      points={{-48.4,20},{-61,20},{-61,42}},
      color={255,127,0},
      smooth=Smooth.None));
  connect(sine1.y, oPC_UA_addIntNode2.realVarIn) annotation (Line(
      points={{-63,-16},{-24.4,-16}},
      color={0,0,127},
      smooth=Smooth.None));
  connect(oPC_UA_addIntNode2.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(points={{-3.8,-16},{26,-16},{26,66},{-22,66},{-22,74.2}},
        smooth=Smooth.None));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TestOPC_UA_Server;
