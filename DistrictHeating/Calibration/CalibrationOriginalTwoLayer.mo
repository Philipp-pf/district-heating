within DistrictHeating.Calibration;
model CalibrationOriginalTwoLayer

extends Modelica.Icons.Example;

  parameter String fileNameStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Oil_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameStore = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Store.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameTemperature = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNet = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

Modelica.SIunits.Heat StoreLossesOrig
    "Difference between int produced heat and int used heat (messured)";
    Real EtaStore "Store Energy Efficiency";

  DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
    Qmax=2300000,
    TimeFirstOrder=0.001)
    annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=false,
    Qmax=1600000,
    TimeFirstOrder=0.001)
    annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=false,
    Qmax=1300000,
    TimeFirstOrder=0.001)
    annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{50,-10},{70,10}})));

  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNet)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));

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
  Modelica.Blocks.Sources.CombiTimeTable Store_source(
    tableOnFile=true,
    tableName="Speicherenergie",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStore)                                     annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={10,70})));

  DistrictHeating.Calibration.From_Scalar_To_Heat Original_heat
    annotation (Placement(transformation(extent={{30,60},{50,80}})));
  Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0.0001)                                   annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-70})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,0})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={30,0})));
  Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={30,-70})));
  Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
    y_start=0,
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-70,70})));
  Modelica.Blocks.Math.Feedback Absolute_Difference_Actual_Target
    annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=0,
        origin={70,70})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperature)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-34})));

  DistrictHeating.Components.Storage.StorageTwoLayer Store(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    U=13.0,
    Hboard(fixed=true, start=37.0),
    Thigh=363.15,
    Tlow=313.15,
    Tref=280) annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  Store.Qloss=Int_Store_Losses.u
    "Connection between Store Losses and its Integrator";
  Store.Q=Absolute_Difference_Actual_Target.u2
    "Connection for calculation of the difference between Meassurement and Simulation";
    StoreLossesOrig=Int_Prod_Heat.y-Int_Used_Heat.y
    "for calculation of StoreLossesOrig";
    EtaStore=Int_Used_Heat.y/Int_Prod_Heat.y "fo calculation of EtaStore";

  connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
    annotation (Line(points={{70.6,0},{79,0}},        color={0,0,127}));
  connect(Oil.nominal_heat, Oil_source.y[6])
    annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
  connect(Wood.nominal_heat, Wood_source.y[6])
    annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                         color={0,0,127}));
  connect(Straw.nominal_heat, Straw_source.y[6])
    annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
  connect(Store_source.y[6], Original_heat.u)
    annotation (Line(points={{21,70},{29.4,70}}, color={0,0,127}));
  connect(Used_Heat.Q_flow, Int_Used_Heat.u)
    annotation (Line(points={{30,-10},{30,-58}},         color={0,0,127}));
  connect(Wood.thermal_heat_flow, Produced_heat.port_a)
    annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
  connect(Oil.thermal_heat_flow, Produced_heat.port_a) annotation (Line(points={
          {-52,-30},{-46,-30},{-46,0},{-40,0}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
        points={{-52,30},{-46,30},{-46,0},{-40,0}}, color={191,0,0}));
  connect(Used_Heat.port_b, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{40,0},{50,0}}, color={191,0,0}));
  connect(Produced_heat.Q_flow, Int_Prod_Heat.u)
    annotation (Line(points={{-30,-10},{-30,-58}}, color={0,0,127}));
  connect(Original_heat.y, Absolute_Difference_Actual_Target.u1)
    annotation (Line(points={{50.4,70},{62,70}},         color={0,0,127}));
  connect(Produced_heat.port_b, Store.port_a)
    annotation (Line(points={{-20,0},{-16,0},{-10,0}}, color={191,0,0}));
  connect(Used_Heat.port_a, Store.port_b)
    annotation (Line(points={{20,0},{16,0},{10,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], Store.u)
    annotation (Line(points={{0,-23},{0,-11.4}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.4886e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This calibration model uses the two layer storage. Adjustable parameters in the model are:</p>
<p>Store.U</p>
<p>Store.Tref</p>
<p>The simulation time concludes all measurements-data. Simulation time from 0 to 24,886,020s.</p>
<p>Temperatures of the upper and lower layer are given by the real storage. </p>
</html>"));
end CalibrationOriginalTwoLayer;
