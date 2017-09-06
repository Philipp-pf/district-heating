within DistrictHeating.PlantControlComparison.Comparison;
model ReferenceModel
  parameter String fileNameTemperature = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameEffWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Wood.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
 parameter String fileNameEffStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Straw.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
 parameter String fileNameEffOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Oil.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameStrawNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Straw_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameOil = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Oil_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameWoodNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Wood_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameStore = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Store.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

Modelica.SIunits.Heat FuelEnergy "sum of fuel energy over whole season";
  Real zero=0 "for storage limitation in diagramme";
  Real BoilerEfficiency "Efficiency of both boiler";
  Real StoreEfficiency "Efficiency of store";
  Real OverAllEfficiency "Efficiency of whole plant";
  Modelica.SIunits.Heat UsedHeat(start=0, fixed=true)
    "Heat demand of consumers over season";
  Modelica.SIunits.Heat ProducedHeat(start=0, fixed=true)
    "Produced heat of boilers";

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
    fileName=fileNameNetNew)                                    annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperature)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-30})));
  DistrictHeating.Components.Boiler.BoilerInFinite Wood(
    limited_heat=true,
    Qmax=2420000,
    PartLoad=0,
    TimeFirstOrder(displayUnit="s") = 1)
    annotation (Placement(transformation(extent={{-54,46},{-34,66}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Straw(
    limited_heat=true,
    Qmax=3250000,
    PartLoad=0,
    TimeFirstOrder(displayUnit="s") = 1)
    annotation (Placement(transformation(extent={{-56,-16},{-36,4}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorWood
    annotation (Placement(transformation(extent={{-20,46},{0,66}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorStraw
    annotation (Placement(transformation(extent={{-22,-16},{-2,4}})));
  DistrictHeating.Components.Control.FuelEfficiency fuelEfficiencyWood(
    useExternalFile=true,
    fileName=fileNameEffWood,
    tableName="Efficiency",
    etaMin=0.59,
    EfficiencyTable=effTable.DataTable,
    AllowedGap=1000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,88})));
  DistrictHeating.Components.Control.FuelEfficiency fuelEfficiencyStraw(
    useExternalFile=true,
    tableName="Efficiency",
    fileName=fileNameEffStraw,
    etaMin=0.57,
    AllowedGap=1000,
    EfficiencyTable=effTable.DataTable) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,26})));
  DistrictHeating.PlantControlComparison.BestEfficiencyTwoLayer.Table effTable(DataTable(
        displayUnit="W") = [Modelica.Constants.eps,Modelica.Constants.eps;
      500000,0.12; 1000000,0.25; 2000000,0.45; 3000000,0.7; 3200000,0.75;
      3400000,0.8; 3600000,0.81; 3800000,0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  Modelica.Blocks.Sources.CombiTimeTable Oil_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Oelleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameOil)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,-62})));
  Modelica.Blocks.Sources.CombiTimeTable Wood_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Hackgutleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameWoodNew)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-80,68})));
  Modelica.Blocks.Sources.CombiTimeTable Straw_source(
    tableOnFile=true,
    columns={2,3,4,5,6,7},
    tableName="Strohleistung",
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameStrawNew)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-82,8})));
  DistrictHeating.Components.Boiler.BoilerInFinite Oil(
    PartLoad=0,
    limited_heat=true,
    Qmax=1800000,
    TimeFirstOrder(displayUnit="s") = 1)
    annotation (Placement(transformation(extent={{-56,-84},{-36,-64}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorOil
    annotation (Placement(transformation(extent={{-20,-84},{0,-64}})));
  DistrictHeating.Components.Control.FuelEfficiency fuelEfficiencyOil(
    useExternalFile=true,
    tableName="Efficiency",
    etaMin=0.57,
    EfficiencyTable=effTable.DataTable,
    AllowedGap=1000,
    fileName=fileNameEffOil)            annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={-10,-40})));
  DistrictHeating.Components.Storage.StorageTwoLayerNoLimit
                              Store(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    U=13,
    Thigh=363.15,
    Tlow=313.15,
    Tref=280,
    Hboard(fixed=true, start=22))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Components.Others.ReverseFirstOrder
                    reverseFirstOrderOil(
    k=1,
    yMax=3158000,
    T=60,
    u_start=0,
    yMin=0.01)
         annotation (Placement(transformation(extent={{-56,-56},{-36,-36}})));
  Components.Others.ReverseFirstOrder
                    reverseFirstOrderStraw(
    k=1,
    u_start=0,
    yMax=5702000,
    T=600,
    yMin=0.01)
           annotation (Placement(transformation(extent={{-56,10},{-36,30}})));
  Components.Others.ReverseFirstOrder
                    reverseFirstOrderWood(
    u_start=0,
    k=1,
    yMax=4093000,
    T=600,
    yMin=0.01)
           annotation (Placement(transformation(extent={{-54,72},{-34,92}})));
equation
fuelEfficiencyWood.integrator.y+fuelEfficiencyStraw.integrator.y+fuelEfficiencyOil.integrator.y=FuelEnergy;
consumerTimeDependExt.heat_demand=der(UsedHeat);
heatFlowSensorWood.Q_flow+heatFlowSensorStraw.Q_flow+heatFlowSensorOil.Q_flow=der(ProducedHeat);
if FuelEnergy<=0 or ProducedHeat<=0 then
  BoilerEfficiency=0;
StoreEfficiency=0;
  else
BoilerEfficiency=ProducedHeat/FuelEnergy;
StoreEfficiency=UsedHeat/ProducedHeat;
end if;
OverAllEfficiency=BoilerEfficiency*StoreEfficiency;
connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
  annotation (Line(points={{70.6,0},{70.6,0},{79,0}},      color={0,0,127}));
  connect(Wood.thermal_heat_flow, heatFlowSensorWood.port_a)
    annotation (Line(points={{-34,56},{-20,56}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow, heatFlowSensorStraw.port_a)
    annotation (Line(points={{-36,-6},{-22,-6}},   color={191,0,0}));
  connect(heatFlowSensorStraw.port_b, heatFlowSensorWood.port_b) annotation (
      Line(points={{-2,-6},{10,-6},{10,56},{0,56}},    color={191,0,0}));
  connect(Wood_source.y[6], Wood.nominal_heat) annotation (Line(points={{-69,68},
          {-64,68},{-64,56},{-54.4,56}}, color={0,0,127}));
  connect(Straw.nominal_heat, Straw_source.y[6]) annotation (Line(points={{-56.4,
          -6},{-62,-6},{-64,-6},{-64,8},{-71,8}},   color={0,0,127}));
  connect(Oil.thermal_heat_flow, heatFlowSensorOil.port_a)
    annotation (Line(points={{-36,-74},{-28,-74},{-20,-74}}, color={191,0,0}));
  connect(heatFlowSensorOil.port_b, heatFlowSensorWood.port_b) annotation (Line(
        points={{0,-74},{10,-74},{10,56},{0,56}}, color={191,0,0}));
  connect(Oil.nominal_heat, Oil_source.y[6]) annotation (Line(points={{-56.4,
          -74},{-64,-74},{-64,-62},{-71,-62}},
                                          color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, Store.port_b)
    annotation (Line(points={{50,0},{46,0},{40,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], Store.u) annotation (Line(points={{30,-19},
          {30,-19},{30,-11.4}},           color={0,0,127}));
  connect(Store.port_a, heatFlowSensorWood.port_b)
    annotation (Line(points={{20,0},{10,0},{10,56},{0,56}}, color={191,0,0}));
  connect(fuelEfficiencyWood.u, heatFlowSensorWood.Q_flow) annotation (Line(
        points={{-22,94},{-28,94},{-28,40},{-10,40},{-10,46}}, color={0,0,127}));
  connect(heatFlowSensorStraw.Q_flow, fuelEfficiencyStraw.u) annotation (Line(
        points={{-12,-16},{-12,-20},{-28,-20},{-28,32},{-22,32}}, color={0,0,
          127}));
  connect(heatFlowSensorOil.Q_flow, fuelEfficiencyOil.u) annotation (Line(
        points={{-10,-84},{-10,-88},{-28,-88},{-28,-34},{-22,-34}}, color={0,0,
          127}));
  connect(fuelEfficiencyOil.u1, reverseFirstOrderOil.y)
    annotation (Line(points={{-22,-46},{-35,-46}}, color={0,0,127}));
  connect(reverseFirstOrderOil.u, Oil_source.y[6]) annotation (Line(points={{
          -58,-46},{-64,-46},{-64,-62},{-71,-62}}, color={0,0,127}));
  connect(fuelEfficiencyStraw.u1, reverseFirstOrderStraw.y)
    annotation (Line(points={{-22,20},{-28,20},{-35,20}}, color={0,0,127}));
  connect(reverseFirstOrderStraw.u, Straw_source.y[6]) annotation (Line(points=
          {{-58,20},{-64,20},{-64,8},{-71,8}}, color={0,0,127}));
  connect(fuelEfficiencyWood.u1, reverseFirstOrderWood.y)
    annotation (Line(points={{-22,82},{-28,82},{-33,82}}, color={0,0,127}));
  connect(reverseFirstOrderWood.u, Wood.nominal_heat) annotation (Line(points={
          {-56,82},{-64,82},{-64,56},{-54.4,56}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2.0028e+006,
      StopTime=2.43134e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This Model shows the use of the PI/ PID-Control unit. </p>
<p>For switching between both Control units change the parameter names in PID-object to choose between PI and PID Record.</p>
<p>In the given arrangement a (intern) constant store temperature target is given. </p>
<p>For an (extern) variable temperature change the Boolean parameter in PID and give an signal input for the temperature (In this model an extern StoreTemp object is shown, but it is not in use.)</p>
</html>"));
end ReferenceModel;
