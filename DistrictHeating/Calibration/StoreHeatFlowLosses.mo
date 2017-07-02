within DistrictHeating.Calibration;
model StoreHeatFlowLosses
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

Modelica.SIunits.HeatFlowRate AvStoreLoss
    "Average Store Heat Flow Losses calculated by StoreLossEnergy divided by time";

  Modelica.Blocks.Sources.CombiTimeTable Store_source(
    tableOnFile=true,
    tableName="Speicherenergie",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStore)                                     annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,-78})));
  From_Scalar_To_Heat Original_heat
    annotation (Placement(transformation(extent={{-70,-88},{-50,-68}})));
  Modelica.Blocks.Continuous.Derivative derivative(
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0,
    T=60,
    k=1)  annotation (Placement(transformation(extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-8,-38})));
  DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=true,
    Qmax=3000000,
    TimeFirstOrder=0)
    annotation (Placement(transformation(extent={{-72,74},{-52,94}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=true,
    Qmax=2200000,
    TimeFirstOrder=0)
    annotation (Placement(transformation(extent={{-72,44},{-52,64}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=true, Qmax(
        displayUnit="kW") = 1950000,
    TimeFirstOrder=0)
    annotation (Placement(transformation(extent={{-72,14},{-52,34}})));
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{50,44},{70,64}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNet)                                       annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,54})));
  Modelica.Blocks.Sources.CombiTimeTable Oil_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Oelleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameOil)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,24})));
  Modelica.Blocks.Sources.CombiTimeTable Wood_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Hackgutleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameWood)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,54})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStraw)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-90,84})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-30,54})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={26,54})));
  DistrictHeating.Components.Storage.StorageInfiniteLossesExt Store(
    der_T=0,
    C=137*water.rho*water.cp,
    Tref(displayUnit="degC") = 313.15,
    Tstart=313.15,
    G=1157.91)
    annotation (Placement(transformation(extent={{-12,44},{8,64}})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperature)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={10,14})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{80,0},{100,20}})));
  Modelica.Blocks.Continuous.Integrator Int_Prod(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-30,-10})));
  Modelica.Blocks.Continuous.Integrator Int_Used(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={26,-10})));

  Modelica.Blocks.Math.MultiSum multiSum(nu=3, k={1,-1,-1}) annotation (
      Placement(transformation(
        extent={{-6,-6},{6,6}},
        rotation=90,
        origin={-8,-64})));
equation

if time<0.00001 then
AvStoreLoss=0;
else
  AvStoreLoss=(Int_Prod.y-Int_Used.y)/time;
end if;

  connect(Store_source.y[6],Original_heat. u)
    annotation (Line(points={{-79,-78},{-74,-78},{-70.6,-78}},
                                                 color={0,0,127}));

  connect(consumerTimeDependExt.positive_heat_flow,Net_source. y[6])
    annotation (Line(points={{70.6,54},{79,54}},      color={0,0,127}));
  connect(Oil.nominal_heat,Oil_source. y[6])
    annotation (Line(points={{-72.4,24},{-79,24}},   color={0,0,127}));
  connect(Wood.nominal_heat,Wood_source. y[6])
    annotation (Line(points={{-72.4,54},{-72.4,54},{-79,54}},
                                                         color={0,0,127}));
  connect(Wood.thermal_heat_flow,Produced_heat. port_a)
    annotation (Line(points={{-52,54},{-40,54}},
                                               color={191,0,0}));
  connect(Oil.thermal_heat_flow,Produced_heat. port_a) annotation (Line(points={{-52,24},
          {-46,24},{-46,54},{-40,54}},          color={191,0,0}));
  connect(Straw.thermal_heat_flow,Produced_heat. port_a) annotation (Line(
        points={{-52,84},{-46,84},{-46,54},{-40,54}},
                                                    color={191,0,0}));
  connect(Used_Heat.port_b,consumerTimeDependExt. heat_flow)
    annotation (Line(points={{36,54},{50,54}},
                                             color={191,0,0}));
  connect(Straw.nominal_heat, Straw_source.y[6])
    annotation (Line(points={{-72.4,84},{-79,84}}, color={0,0,127}));
  connect(Produced_heat.port_b, Store.heat_input)
    annotation (Line(points={{-20,54},{-16,54},{-12,54}}, color={191,0,0}));
  connect(Used_Heat.port_a, Store.heat_output)
    annotation (Line(points={{16,54},{12,54},{8,54}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], Store.outside_temp) annotation (Line(
        points={{10,25},{10,25},{10,32},{-2,32},{-2,43.6}}, color={0,0,127}));
  connect(Used_Heat.Q_flow, Int_Used.u)
    annotation (Line(points={{26,44},{26,2}},         color={0,0,127}));
  connect(Produced_heat.Q_flow, Int_Prod.u)
    annotation (Line(points={{-30,44},{-30,2}},          color={0,0,127}));
  connect(Int_Prod.y, multiSum.u[1]) annotation (Line(points={{-30,-21},{-30,-21},
          {-30,-68},{-30,-72},{-30,-74},{-10.8,-74},{-10.8,-70}}, color={0,0,127}));
  connect(Original_heat.y, multiSum.u[2]) annotation (Line(points={{-49.6,-78},{
          -44,-78},{-8,-78},{-8,-70}}, color={0,0,127}));
  connect(Int_Used.y, multiSum.u[3]) annotation (Line(points={{26,-21},{26,-78},
          {-5.2,-78},{-5.2,-70}}, color={0,0,127}));
  connect(Store.Store_losses, derivative.y) annotation (Line(points={{-8.6,43.6},
          {-8.6,-27},{-8,-27}}, color={0,0,127}));
  connect(multiSum.y, derivative.u) annotation (Line(points={{-8,-56.98},{-8,-56.98},
          {-8,-50}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2.0028e+006,
      StopTime=2.41596e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Differentiation of the original data of the stored heat leads to a heat flow, which tells if the store is loaded or unloaded. </p>
<p>Take this heat flow and use additionally the heat flow input and the heat flow output the difference heat flow that results equals to the store losses. </p>
<p>The Model of the store contains the variable &QUOT;Q&QUOT;. This is an calculated heat flow loss of the storage to the environment, with an average &QUOT;G&QUOT; as parameter. The temperature difference equals to the store temperature minus outside temperature. </p>
<p>The parameter average G equals the arithmetic mean of the variable Gvar from the store. </p>
</html>"));
end StoreHeatFlowLosses;
