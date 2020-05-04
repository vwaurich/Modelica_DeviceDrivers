within Modelica_DeviceDrivers.Communication;
package OPC_UA_Server_
  extends Modelica_DeviceDrivers.Utilities.Icons.DriverIcon;
  encapsulated function addIntVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Integer nodeNsIdx;
    input Integer nodeId;
    input Integer parentNsIdx = 0;
    input Integer parentNodeId = 85;
    input Integer intVal;
    external "C" MDD_opcuaAddIntVar(opcua, nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId, intVal)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end addIntVar;

  encapsulated function writeIntVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
      input Integer nodeNsIdx;
    input Integer nodeId;
    input Integer intVal;
    external "C" MDD_opcuaWriteIntVar(opcua, nodeName, nodeNsIdx, nodeId, intVal)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end writeIntVar;

  encapsulated function addRealVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Integer nodeNsIdx;
    input Integer nodeId;
    input Integer parentNsIdx = 0;
    input Integer parentNodeId = 85;
    input Real realVal;
    external "C" MDD_opcuaAddRealVar(opcua, nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId, realVal)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end addRealVar;

  encapsulated function writeRealVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
      input Integer nodeNsIdx;

    input Integer nodeId;
    input Real realVal;
    external "C" MDD_opcuaWriteRealVar(opcua, nodeName, nodeNsIdx, nodeId, realVal)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end writeRealVar;

  encapsulated function addObject
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Integer nodeNsIdx;
    input Integer nodeId;
    input Integer parentNsIdx;
    input Integer parentNodeId;
    external "C" MDD_opcuaAddObjectNode(opcua, nodeName, nodeNsIdx, nodeId, parentNsIdx, parentNodeId)
      annotation (
        Include = "#include \"MDDopcuaServer.h\"",
        Library = {"open62541Wrapper"},
        __iti_dllNoExport = true);
  end addObject;
end OPC_UA_Server_;
