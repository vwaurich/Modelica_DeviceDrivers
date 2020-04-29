within Modelica_DeviceDrivers.Communication;
class OPC_UA_Server "A OPC UA Server that provides acces to given variables"
extends ExternalObject;

encapsulated function constructor "Creates an OPC UA server"
  import Modelica;
  import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
  extends Modelica.Icons.Function;
  output OPC_UA_Server opcuaServer;
external "C" opcuaServer = MDD_opcuaServerConstructor()
annotation(Include = "#include \"MDDopcuaServer.h\"",
           Library = {"pthread","Ws2_32","wsock32","open62541Wrapper","open62541"},
           __iti_dll = "ITI_MDD.dll",
           __iti_dllNoExport = true);

end constructor;

encapsulated function destructor
  import Modelica;
  extends Modelica.Icons.Function;
  import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
  input OPC_UA_Server opcuaServer;
external "C" MDD_opcuaServerDestructor(opcuaServer)
annotation(Include = "#include \"MDDopcuaServer.h\"",
           Library = {"pthread","Ws2_32","wsock32","open62541Wrapper","open62541"},
           __iti_dll = "ITI_MDD.dll",
           __iti_dllNoExport = true);
end destructor;

end OPC_UA_Server;
