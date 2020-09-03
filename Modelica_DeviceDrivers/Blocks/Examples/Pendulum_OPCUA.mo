within Modelica_DeviceDrivers.Blocks.Examples;
model Pendulum_OPCUA
  extends Modelica.Icons.Example;
  Communication.OPC_UA.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin={10,70},      extent = {{-10, -10}, {10, 10}}, rotation=0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-80,60},{-60,80}})));
  Communication.OPC_UA.OPC_UA_addRealNode oPC_UA_addRealNode(
    sampleTime=0.05,
    nodeName="phi1",
    parentRefId=Modelica_DeviceDrivers.Blocks.Communication.OPC_UA.Types.ReferenceID.hasComponent)
    annotation (Placement(transformation(extent={{0,20},{20,40}})));
  inner Modelica.Mechanics.MultiBody.World world annotation (Placement(
        transformation(extent={{-100,-60},{-80,-40}},
                                                  rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute1(
    useAxisFlange=true,
    phi(fixed=true),
    w(fixed=true))                                               annotation (Placement(transformation(extent={{-62,-62},
            {-42,-42}},rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody1(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{-24,-62},{-4,-42}},
                                                                   rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-52,-22})));
  Modelica.Mechanics.Rotational.Components.Damper damper(d=0.1)
    annotation (Placement(transformation(extent={{-64,-88},{-44,-68}},
                                                                     rotation=0)));
  Modelica.Mechanics.MultiBody.Joints.Revolute revolute2(
    useAxisFlange=true,
    phi(fixed=true),
    w(fixed=true))                                       annotation (Placement(transformation(extent={{20,-62},
            {40,-42}},
                     rotation=0)));
  Modelica.Mechanics.MultiBody.Parts.BodyBox boxBody2(r={0.5,0,0}, width=0.06)
    annotation (Placement(transformation(extent={{60,-62},{80,-42}},
                                                                  rotation=0)));
  Modelica.Mechanics.Rotational.Sensors.RelAngleSensor relAngleSensor1
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,-22})));
  Communication.OPC_UA.OPC_UA_addRealNode oPC_UA_addRealNode1(
    sampleTime=0.05,
    nodeName="phi1",
    nodeId=103,
    parentRefId=Modelica_DeviceDrivers.Blocks.Communication.OPC_UA.Types.ReferenceID.hasComponent)
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Mechanics.Rotational.Components.Damper damper1(d=0.2)
    annotation (Placement(transformation(extent={{22,-92},{42,-72}}, rotation=0)));
equation
  connect(oPC_UA_addRealNode.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(
      points={{9.7,40.1},{9.7,59.4},{9.5,59.4}},
      color={0,0,0},
      smooth=Smooth.None));
  connect(revolute1.frame_b,boxBody1. frame_a)
    annotation (Line(
      points={{-42,-52},{-24,-52}},
      color={95,95,95},
      thickness=0.5));
  connect(world.frame_b,revolute1. frame_a)
    annotation (Line(
      points={{-80,-50},{-72,-50},{-72,-52},{-62,-52}},
      color={95,95,95},
      thickness=0.5));
  connect(relAngleSensor.flange_a, revolute1.support) annotation (Line(points={
          {-62,-22},{-68,-22},{-68,-42},{-58,-42}}, color={0,0,0}));
  connect(relAngleSensor.flange_b, revolute1.axis) annotation (Line(points={{
          -42,-22},{-36,-22},{-36,-42},{-52,-42}}, color={0,0,0}));
  connect(oPC_UA_addRealNode.realVarIn, relAngleSensor.phi_rel) annotation (
      Line(points={{1,29.8},{-8,29.8},{-8,30},{-26,30},{-26,-33},{-52,-33}},
        color={0,0,127}));
  connect(damper.flange_b, revolute1.axis) annotation (Line(points={{-44,-78},{
          -36,-78},{-36,-42},{-52,-42}},       color={0,0,0}));
  connect(revolute1.support,damper. flange_a) annotation (Line(points={{-58,-42},
          {-68,-42},{-68,-78},{-64,-78}},       color={0,0,0}));
  connect(boxBody1.frame_b, revolute2.frame_a) annotation (Line(
      points={{-4,-52},{20,-52}},
      color={95,95,95},
      thickness=0.5));
  connect(boxBody2.frame_a, revolute2.frame_b) annotation (Line(
      points={{60,-52},{40,-52}},
      color={95,95,95},
      thickness=0.5));
  connect(relAngleSensor1.flange_a, revolute2.support) annotation (Line(points=
          {{20,-22},{14,-22},{14,-42},{24,-42}}, color={0,0,0}));
  connect(relAngleSensor1.flange_b, revolute2.axis) annotation (Line(points={{
          40,-22},{46,-22},{46,-42},{30,-42}}, color={0,0,0}));
  connect(oPC_UA_addRealNode1.oPC_UA_ServerConnectorIn, oPC_UA_Server1.oPC_UA_ServerConnectorOut)
    annotation (Line(points={{49.7,40.1},{50,40.1},{50,59.4},{9.5,59.4}}, color
        ={0,127,0}));
  connect(relAngleSensor1.phi_rel, oPC_UA_addRealNode1.realVarIn) annotation (
      Line(points={{30,-33},{54,-33},{54,4},{38,4},{38,29.8},{41,29.8}}, color=
          {0,0,127}));
  connect(damper1.flange_a, revolute2.support) annotation (Line(points={{22,-82},
          {14,-82},{14,-42},{24,-42}}, color={0,0,0}));
  connect(damper1.flange_b, revolute2.axis) annotation (Line(points={{42,-82},{
          46,-82},{46,-42},{30,-42}}, color={0,0,0}));
  annotation (experiment(StopTime=100, __Dymola_Algorithm="Dassl"),
                                       __Dymola_experimentSetupOutput(textual=
          true),
    Diagram(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{
            100,100}})));
end Pendulum_OPCUA;
