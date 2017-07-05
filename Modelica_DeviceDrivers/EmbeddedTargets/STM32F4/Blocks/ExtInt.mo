within Modelica_DeviceDrivers.EmbeddedTargets.STM32F4.Blocks;
model ExtInt
  import Modelica_DeviceDrivers.EmbeddedTargets.STM32F4.Functions;
  import Modelica_DeviceDrivers.EmbeddedTargets.STM32F4.Functions.HAL;
  import Modelica_DeviceDrivers.EmbeddedTargets.STM32F4.Types;
  import Modelica.SIunits;
  constant HAL.Init handle annotation(Dialog(
    enable = true,
    tab = "General",
    group = "Constants"));
  constant Types.Port port annotation(Dialog(
    enable = true,
    tab = "General",
    group = "Constants"));
  constant Types.Pin pin annotation(Dialog(
    enable = true,
    tab = "General",
    group = "Constants"));
  constant Types.Mode mode annotation(Dialog(
    enable = true,
    tab = "General",
    group = "Constants"));
  constant Types.Prio preemtPrio annotation(Dialog(
    enable = true,
    tab = "General",
    group = "Constants"));
  constant Types.Prio subPrio annotation(Dialog(
    enable = true,
    tab = "General",
    group = "Constants"));
protected
  Functions.Digital.InitExtInt hport = Functions.Digital.InitExtInt(handle, port, pin, mode, preemtPrio, subPrio );
annotation(Icon(graphics = {Text(extent = {{-95, -95}, {95, 95}}, textString = "Digital %hportl%port%pin%mode%preemtPrio%subPrio", fontName = "Arial")}));
end ExtInt;
