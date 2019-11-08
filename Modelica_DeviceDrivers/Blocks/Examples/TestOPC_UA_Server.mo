within Modelica_DeviceDrivers.Blocks.Examples;
model TestOPC_UA_Server
  extends Modelica.Icons.Example;
  Communication.OPC_UA_Server oPC_UA_Server1 annotation (
    Placement(visible = true, transformation(origin = {-74, -84}, extent = {{-10, -10}, {10, 10}}, rotation = 0)));
  OperatingSystem.SynchronizeRealtime synchronizeRealtime
    annotation (Placement(transformation(extent={{-82,-18},{-62,2}})));
  annotation (experiment(StopTime=10));
end TestOPC_UA_Server;
