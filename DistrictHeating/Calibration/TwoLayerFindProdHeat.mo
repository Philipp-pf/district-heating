within DistrictHeating.Calibration;
model TwoLayerFindProdHeat
  extends Modelica.Icons.Example;

  parameter String fileNameStrawNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Oil_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameWoodNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameStore = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Store.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameTemperatureNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
    Modelica.SIunits.HeatFlowRate OrigProdHeatFlow
    "Sum of the produced heat flow from oil, wood and straw boiler";
    Real EtaStore "Store Energy Efficiency";

  Components.Consumers.ConsumerTimeDependExt consumerTimeDependExt
    annotation (Placement(transformation(extent={{48,-10},{68,10}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNetNew)                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Store_source(
    tableOnFile=true,
    tableName="Speicherenergie",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStore)                                     annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,70})));
  Calibration.From_Scalar_To_Heat
                      Original_heat
    annotation (Placement(transformation(extent={{-70,60},{-50,80}})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Blocks.Sources.CombiTimeTable Oil_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Oelleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameOil)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-30})));
  Modelica.Blocks.Sources.CombiTimeTable Wood_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Hackgutleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameWoodNew)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStrawNew)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,30})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor UsedHeat
    annotation (Placement(transformation(extent={{22,-10},{42,10}})));
  Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0.0001)                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-44,0})));
  Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={32,-38})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperatureNew)                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  Components.Storage.StorageTwoLayerNoLimitVariableUFindProd
                                                     Store(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    Thigh=363.15,
    Tlow=313.15,
    Tref=280,
    Hboard(fixed=false, start=22))
              annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable timeTable(
    offset=0,
    startTime=0,
    table=[0,0; 2002800,0; 2002801,13; 24313375,13; 24313376,0; 2.5e7,0])
    annotation (Placement(transformation(extent={{-40,20},{-20,40}})));
  Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-50,-50})));
equation
OrigProdHeatFlow=Straw_source.y[6]+Wood_source.y[6]+Oil_source.y[6];
    EtaStore=Int_Used_Heat.y/Int_Prod_Heat.y "fo calculation of EtaStore";
Int_Prod_Heat.u=Store.Qload;
Int_Store_Losses.u=Store.Qloss;

  connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
    annotation (Line(points={{68.6,0},{79,0}},        color={0,0,127}));
  connect(Store_source.y[6],Original_heat. u)
    annotation (Line(points={{-79,70},{-74,70},{-70.6,70}},
                                                 color={0,0,127}));
  connect(UsedHeat.port_b, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{42,0},{42,0},{48,0}}, color={191,0,0}));
  connect(Int_Used_Heat.u, UsedHeat.Q_flow)
    annotation (Line(points={{32,-26},{32,-10}}, color={0,0,127}));
  connect(UsedHeat.port_a, Store.port_b)
    annotation (Line(points={{22,0},{16,0},{10,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], Store.u) annotation (Line(points={{7.21645e-016,
          -59},{0,-59},{0,-11.4}}, color={0,0,127}));
  connect(Original_heat.y, Store.u2)
    annotation (Line(points={{-49.6,70},{0,70},{0,10.6}}, color={0,0,127}));
  connect(Store.u1, timeTable.y) annotation (Line(points={{-10.6,-7},{-14,-7},{-14,
          30},{-19,30}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2e+006,
      StopTime=2.43134e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model is an other way to calibrate the system. In this model the used heat and the storage heat are given. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The model calculates the heat, that has to be produced (ProdHeat). </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The store temp is given by an PrecribedTemperature. </span></p>
</html>"));
end TwoLayerFindProdHeat;
