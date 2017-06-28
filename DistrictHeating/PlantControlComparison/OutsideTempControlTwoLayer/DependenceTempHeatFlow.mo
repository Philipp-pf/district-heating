within DistrictHeating.PlantControlComparison.OutsideTempControlTwoLayer;
model DependenceTempHeatFlow

  parameter String fileNameStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Oil_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameTemperatureNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

Modelica.SIunits.HeatFlowRate StrawHeatFlow=Straw_source.y[6]
    "Heat Flow of straw boiler";
Modelica.SIunits.HeatFlowRate WoodHeatFlow=Wood_source.y[6]
    "Heat Flow of wood boiler";
Modelica.SIunits.HeatFlowRate OilHeatFlow=Oil_source.y[6]
    "Heat Flow of oil boiler";
Modelica.SIunits.HeatFlowRate AllHeatFlow=StrawHeatFlow+WoodHeatFlow+OilHeatFlow
    "Heat Flow of all boilers";
    Modelica.SIunits.Temperature OutsideTemp( displayUnit="degC")=Outside_Temp_source.y[6]
    "Outside Temperature";

  Modelica.Blocks.Sources.CombiTimeTable Oil_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Oelleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameOil)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-30})));
  Modelica.Blocks.Sources.CombiTimeTable Wood_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Hackgutleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameWood)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,0})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStraw)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,30})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperatureNew)                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Table table(DataTable=[0,2,11,20; 268,2600,2800,3400; 270,2400,2700,3300; 280,
        400,1500,2700; 290,400,900,1500; 300,400,450,500; 310,440,420,450])
    annotation (Placement(transformation(extent={{20,60},{40,80}})));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.5e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model shows the relation between outside temperature and boiler heat flow. </p>
<p>The upper heat flow is used if storage has a high load, the lower heat flow is used if storage has a low load. </p>
</html>"));
end DependenceTempHeatFlow;
