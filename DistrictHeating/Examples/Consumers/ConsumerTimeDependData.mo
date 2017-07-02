within DistrictHeating.Examples.Consumers;
model ConsumerTimeDependData
  extends Modelica.Icons.Example;
  parameter String fileNameExample = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_example1.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
        273.15)
    annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
  DistrictHeating.Components.Consumers.ConsumerTimeDependData
    consumerTimeDependExt(
    tstart=0,
    tableName="Strohleistung",
    fileName=
        "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_example1.txt")
    annotation (Placement(transformation(extent={{12,-10},{32,10}})));
equation
  connect(fixedTemperature.port, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{-12,0},{0,0},{12,0}}, color={191,0,0}));
  annotation (experiment(StopTime=10),
      __Dymola_experimentSetupOutput);
end ConsumerTimeDependData;
