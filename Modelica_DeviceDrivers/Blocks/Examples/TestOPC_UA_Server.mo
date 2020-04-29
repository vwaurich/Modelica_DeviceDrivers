within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server
  extends Modelica.Icons.Example;
  Communication.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={24,62},      extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-92,32},{-72,52}})));
  Communication.OPC_UA_addIntNode oPC_UA_addIntNode
    annotation (Placement(transformation(extent={{-36,-32},{-16,-12}})));
  Modelica.Blocks.Sources.IntegerExpression integerExpression(y=12345)
    annotation (Placement(transformation(extent={{-118,-32},{-98,-12}})));
equation
  connect(oPC_UA_addIntNode.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{-15.8,-22},{4,-22},{4,-22},{54,-22},{54,62},{34.2,62}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(integerExpression.y, oPC_UA_addIntNode.intVarIn) annotation (Line(
      points={{-97,-22},{-36.4,-22}},
      color={255,127,0},
      smooth=Smooth.None));
  annotation (experiment(StopTime=20), __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}}), graphics));
end TestOPC_UA_Server;
