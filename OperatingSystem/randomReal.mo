within Modelica_DeviceDrivers.OperatingSystem;
function randomReal "returns a random real within the given Range."
input Real minValue = 0;
input Real maxValue = 1;
output Real y;
external "C" y = MDD_OS_getRandomNumberDouble(minValue, maxValue)
annotation (Include = "#include \"MDDOperatingSystem.h\"",
            __iti_dll = "ITI_MDD.dll");
annotation(__OpenModelica_Impure=true);
end randomReal;
