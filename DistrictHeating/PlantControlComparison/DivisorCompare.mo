within DistrictHeating.PlantControlComparison;
model DivisorCompare
  "defines HeatFlowDivisor parameters so that simulation works as measurement data"
  extends Modelica.Icons.Example;

  parameter String fileNameNetNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present";
  parameter String fileNameWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

  Components.Control.HeatFlowDivisor heatFlowDivisor(
    WaitingTime(displayUnit="h") = 43200,
    ActivateBaseBoiler=713000,
    ActivateBothBoiler=1889000.0,
    DeactivateBothBoiler=2310000.0,
    DeactivateBaseBoiler=711000.0,
    MaxBaseLoad=2600000,
    MaxPeakLoad=500000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNetNew)
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,0})));
  Modelica.Blocks.Sources.Constant const(k=3000000)
    annotation (Placement(transformation(extent={{-60,-4},{-40,16}})));
  Modelica.Blocks.Sources.CombiTimeTable Wood_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Hackgutleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameWood)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,50})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStraw)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,80})));
equation
  connect(Net_source.y[6], heatFlowDivisor.u2) annotation (Line(points={{69,0},
          {50,0},{50,-30},{-28,-30},{-28,-6},{-12,-6}}, color={0,0,127}));
  connect(heatFlowDivisor.u1, const.y)
    annotation (Line(points={{-12,6},{-26,6},{-39,6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2.0028e+006,
      StopTime=2.43134e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model compares measurement data and simulation data for times, which boiler is in use. </p>
</html>"));
end DivisorCompare;
