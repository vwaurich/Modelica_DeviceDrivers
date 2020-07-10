within Modelica_DeviceDrivers.Communication;
package OPC_UA_Client_
  extends Modelica_DeviceDrivers.Utilities.Icons.DriverIcon;
  encapsulated function readIntVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Client;
    extends Modelica.Icons.Function;
    input OPC_UA_Client opcua;
    input Integer nodeNsIdx;
    input Integer nodeId;
    output Integer value;

    external "C" value = MDD_opcuaClientReadInt(opcua, nodeNsIdx, nodeId)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end readIntVar;

  encapsulated function readDoubleVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Client;
    extends Modelica.Icons.Function;
    input OPC_UA_Client opcua;
    input Integer nodeNsIdx;
    input Integer nodeId;
    output Real value;

    external "C" value = MDD_opcuaClientReadDouble(opcua, nodeNsIdx, nodeId)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end readDoubleVar;
end OPC_UA_Client_;
