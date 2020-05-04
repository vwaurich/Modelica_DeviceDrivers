within Modelica_DeviceDrivers.Communication;
class OPC_UA_Client "An OPC UA Client"
extends ExternalObject;

encapsulated function constructor "Creates an OPC UA server"
  import Modelica;
  import                 Modelica_DeviceDrivers.Communication.OPC_UA_Client;
  extends Modelica.Icons.Function;
  input String endpointURL;
  output OPC_UA_Client opcuaClient;
external "C" opcuaClient = MDD_opcuaClientConstructor(endpointURL)
annotation(Include = "#include \"MDDopcuaServer.h\"",
           Library = {"open62541Wrapper"},
           __iti_dll = "ITI_MDD.dll",
           __iti_dllNoExport = true);

end constructor;

encapsulated function destructor
  import Modelica;
  extends Modelica.Icons.Function;
  import Modelica_DeviceDrivers.Communication.OPC_UA_Client;

  input OPC_UA_Client opcuaClient;
external "C" MDD_opcuaClientDestructor(opcuaClient)
annotation(Include = "#include \"MDDopcuaServer.h\"",
           Library = {"open62541Wrapper"},
           __iti_dll = "ITI_MDD.dll",
           __iti_dllNoExport = true);
end destructor;

  annotation ();
end OPC_UA_Client;
