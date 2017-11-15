within Modelica_DeviceDrivers.Communication;
class PCAN "Support for the PEAK-Systems CAN-devices."
extends ExternalObject;
function constructor "Create external PCAN object and connect to CAN bus"
  import Modelica;
  extends Modelica.Icons.Function;
  import Modelica_DeviceDrivers.Communication.PCAN;
  input Integer channelName = 81 "identifier for the CAN-bus handle";
  input Integer baudrate = 250 "baud rate, see PCANBasic.h";

  output PCAN pcan;

  external "C" pcan = MDD_PCAN_Constructor(channelName, baudrate)
  annotation (Include="#include \"MDDPCAN.h\"",
              Library={"MDD_PCan"});
end constructor;

function destructor "Destroy object, free resources"
  import Modelica;
  extends Modelica.Icons.Function;
  import Modelica_DeviceDrivers.Communication.PCAN;
  input PCAN pcan;

  external "C" MDD_PCAN_Destructor(pcan)
  annotation (Include="#include \"MDDPCAN.h\"",
              Library={"MDD_PCan"});
end destructor;

end PCAN;
