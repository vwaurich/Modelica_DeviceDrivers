within Modelica_DeviceDrivers.Communication;
package PCAN_ "Accompanying functions for the PCAN object"
  extends Modelica_DeviceDrivers.Utilities.Icons.DriverIcon;
  function write "Write CAN frame/message to PCAN hardware"
    import Modelica;
    extends Modelica.Icons.Function;
    import Modelica_DeviceDrivers.Communication.PCAN;
    import Modelica_DeviceDrivers.Packaging.SerialPackager;
    input PCAN pcan;
    input Integer id = 0 "message identifier";
    input Integer len = 8 " message length";
    input String msgType = "PCAN_MESSAGE_STANDARD" "PCAN message types";

    input SerialPackager pkg;

    external "C" MDD_PCANWriteP(pcan, id, len, msgType, pkg)
    annotation (Include="#include \"MDDPCAN.h\"",
                Library={"MDD_PCan"});
  end write;

  function read "Read message from CAN bus."
    import Modelica;
    extends Modelica.Icons.Function;
    import Modelica_DeviceDrivers.Communication.SocketCAN;
    import Modelica_DeviceDrivers.Packaging.SerialPackager;
    input PCAN pcan;
    input Integer id "message identifier";
    input SerialPackager pkg;
    output Integer len = 0 "length of received message";
    output Integer timeStamp = 0 "timestamp in milliseconds";

    external "C" MDD_PCANReadP(pcan, id, pkg, len, timeStamp)
    annotation (Include="#include \"MDDPCAN.h\"",
                Library={"MDD_PCan"});
  end read;
end PCAN_;
