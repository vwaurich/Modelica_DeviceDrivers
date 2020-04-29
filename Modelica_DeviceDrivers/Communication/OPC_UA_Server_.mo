within Modelica_DeviceDrivers.Communication;
package OPC_UA_Server_
  extends Modelica_DeviceDrivers.Utilities.Icons.DriverIcon;
  encapsulated function addIntVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Integer intVal;
    external "C" MDD_opcuaAddIntVar(opcua, nodeName, intVal)
      annotation (
        Include = "#include \"MDDMQTT.h\"",
        Library = {"pthread"},
        __iti_dll = "ITI_MDDMQTT.dll",
        __iti_dllNoExport = true);
  end addIntVar;

  encapsulated function writeIntVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Integer intVal;
    external "C" MDD_opcuaWriteIntVar(opcua, nodeName, intVal)
      annotation (
        Include = "#include \"MDDMQTT.h\"",
        Library = {"pthread"},
        __iti_dll = "ITI_MDDMQTT.dll",
        __iti_dllNoExport = true);
  end writeIntVar;

  encapsulated function addRealVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Real realVal;
    external "C" MDD_opcuaAddRealVar(opcua, nodeName, realVal)
      annotation (
        Include = "#include \"MDDMQTT.h\"",
        Library = {"pthread"},
        __iti_dll = "ITI_MDDMQTT.dll",
        __iti_dllNoExport = true);
  end addRealVar;

  encapsulated function writeRealVar
    import Modelica;
    import Modelica_DeviceDrivers.Communication.OPC_UA_Server;
    extends Modelica.Icons.Function;
    input OPC_UA_Server opcua;
    input String nodeName;
    input Real realVal;
    external "C" MDD_opcuaWriteRealVar(opcua, nodeName, realVal)
      annotation (
        Include = "#include \"MDDMQTT.h\"",
        Library = {"pthread"},
        __iti_dll = "ITI_MDDMQTT.dll",
        __iti_dllNoExport = true);
  end writeRealVar;
end OPC_UA_Server_;
