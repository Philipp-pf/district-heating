within DistrictHeating.Calibration;
model CalibrationFindUsedHeat
  extends Modelica.Icons.Example;

  parameter String fileNameStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Oil_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameTemperature = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNet = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
   parameter String fileNameStore = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Store.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
    Modelica.SIunits.HeatFlowRate OrigUsedHeatFlow
    "Used heat flow by net and consumers";
    Real EtaStore "Store Energy Efficiency";

  Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature Storetemp
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor UsedHeat annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Modelica.Thermal.HeatTransfer.Components.ThermalConductor thermalConductor1(G=
       1) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={62,0})));
  Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
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
  Components.Others.JouleToDegreeCelsius jouleToDegreeCelsius(C=137*water.rho*
        water.cp, Tref=285)
    annotation (Placement(transformation(extent={{-38,60},{-18,80}})));
  Components.Boiler.BoilerInFinite                 Straw(limited_heat=false,
    Qmax=2300000,
    TimeFirstOrder=0)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  Components.Boiler.BoilerInFinite                 Wood(limited_heat=false,
    Qmax=1600000,
    TimeFirstOrder=0)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  Components.Boiler.BoilerInFinite                 Oil(limited_heat=false,
    TimeFirstOrder=0,
    Qmax=1300000)
    annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
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
    fileName=fileNameWood)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStraw)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,30})));
  Components.Storage.StorageInfiniteStart storageInfiniteStart(
    C=137*water.rho*water.cp,
    G=2300,
    Tref=285,
    der_T=0) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor ProdHeat
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0.0001)                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-38})));
  Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-38})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperature)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-70})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNet)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,-50})));
equation
OrigUsedHeatFlow=Net_source.y[6];
    EtaStore=Int_Used_Heat.y/Int_Prod_Heat.y "fo calculation of EtaStore";
  connect(Store_source.y[6],Original_heat. u)
    annotation (Line(points={{-79,70},{-74,70},{-70.6,70}},
                                                 color={0,0,127}));
  connect(Original_heat.y, jouleToDegreeCelsius.u) annotation (Line(points={{-49.6,
          70},{-44.8,70},{-40,70}}, color={0,0,127}));
  connect(jouleToDegreeCelsius.y, Storetemp.T) annotation (Line(points={{-17,70},
          {-10,70},{2.22045e-015,70},{2.22045e-015,62}},
                                   color={0,0,127}));
  connect(thermalConductor1.port_a, fixedTemperature.port)
    annotation (Line(points={{72,0},{80,0}},        color={191,0,0}));
  connect(UsedHeat.port_b, thermalConductor1.port_b)
    annotation (Line(points={{40,0},{52,0}},        color={191,0,0}));
  connect(Oil.nominal_heat,Oil_source. y[6])
    annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
  connect(Wood.nominal_heat,Wood_source. y[6])
    annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                         color={0,0,127}));
  connect(Straw.nominal_heat,Straw_source. y[6])
    annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
  connect(UsedHeat.port_a, storageInfiniteStart.heat_output)
    annotation (Line(points={{20,0},{10,0}}, color={191,0,0}));
  connect(ProdHeat.Q_flow,Int_Prod_Heat. u)
    annotation (Line(points={{-30,-10},{-30,-26}},           color={0,0,127}));
  connect(storageInfiniteStart.heat_input, ProdHeat.port_b)
    annotation (Line(points={{-10,0},{-16,0},{-20,0}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow, ProdHeat.port_a) annotation (Line(points={{-52,
          30},{-48,30},{-48,0},{-40,0}}, color={191,0,0}));
  connect(Wood.thermal_heat_flow, ProdHeat.port_a)
    annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
  connect(Oil.thermal_heat_flow, ProdHeat.port_a) annotation (Line(points={{-52,
          -30},{-48,-30},{-48,0},{-40,0}}, color={191,0,0}));
  connect(UsedHeat.Q_flow, Int_Used_Heat.u)
    annotation (Line(points={{30,-10},{30,-10},{30,-26}}, color={0,0,127}));
  connect(storageInfiniteStart.outside_temp, Outside_Temp_source.y[6])
    annotation (Line(points={{0,-10.4},{0,-10.4},{0,-59}}, color={0,0,127}));
  connect(Storetemp.port, thermalConductor1.port_b)
    annotation (Line(points={{0,40},{0,26},{52,26},{52,0}}, color={191,0,0}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.4886e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This model is an other way to calibrate the system. In this model the produced heat and the storage heat are given. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The model calculates the heat, that has to be used (UsedHeat).</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The store temp is given by an PrecribedTemperature. </span></p>
</html>"));
end CalibrationFindUsedHeat;
