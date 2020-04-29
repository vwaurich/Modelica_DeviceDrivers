within Modelica_DeviceDrivers.Communication;
package OPC_UA_Server_
  extends Modelica_DeviceDrivers.Utilities.Icons.DriverIcon;
  encapsulated function addIntVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input Integer nodeID;
    input String nodeName;
    input Integer intVal;
    external "C" MDD_opcuaAddIntVar(opcua, nodeID, intVal)
      annotation (
        Include = "#include \"MDDMQTT.h\"",
        Library = {"pthread"},
        __iti_dll = "ITI_MDDMQTT.dll",
        __iti_dllNoExport = true);
  end addIntVar;
end OPC_UA_Server_;
