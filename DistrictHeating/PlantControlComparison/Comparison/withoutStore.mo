within DistrictHeating.PlantControlComparison.Comparison;
model withoutStore
  parameter String fileNameTemperature = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameEffWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Wood.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
 parameter String fileNameEffStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Straw.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

  Real zero=0 "for storage limitation in diagramme";
Modelica.SIunits.Heat FuelEnergy "sum of fuel energy over whole season";
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
  DistrictHeating.Components.Boiler.BoilerInFinite Wood(
    limited_heat=true,
    Qmax=2420000,
    TimeFirstOrder(displayUnit="min") = 600,
    PartLoad=0)
    annotation (Placement(transformation(extent={{-56,4},{-36,24}})));
  DistrictHeating.Components.Boiler.BoilerInFinite Straw(
    limited_heat=true,
    Qmax=3250000,
    TimeFirstOrder(displayUnit="min") = 600,
    PartLoad=0)
    annotation (Placement(transformation(extent={{-56,-60},{-36,-40}})));
  DistrictHeating.Components.Control.HeatFlowDivisor heatFlowDivisor(
    WaitingTime(displayUnit="h") = 43200,
    ActivateBaseBoiler=713000,
    ActivateBothBoiler=1889000,
    DeactivateBothBoiler=2310000,
    DeactivateBaseBoiler=711000,
    BaseHeatFlowBoth=1600000,
    MaxBaseLoad=3250000,
    MaxPeakLoad=2420000)
    annotation (Placement(transformation(extent={{-88,-30},{-68,-10}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorWood
    annotation (Placement(transformation(extent={{-22,4},{-2,24}})));
  Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensorStraw
    annotation (Placement(transformation(extent={{-22,-60},{-2,-40}})));
  DistrictHeating.Components.Control.FuelEfficiency fuelEfficiencyWood(
    useExternalFile=true,
    fileName=fileNameEffWood,
    tableName="Efficiency",
    etaMin=0.59,
    EfficiencyTable=effTable.DataTable,
    AllowedGap=1000) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,44})));
  DistrictHeating.Components.Control.FuelEfficiency fuelEfficiencyStraw(
    useExternalFile=true,
    tableName="Efficiency",
    fileName=fileNameEffStraw,
    etaMin=0.57,
    AllowedGap=1000,
    EfficiencyTable=effTable.DataTable) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-18})));
  DistrictHeating.PlantControlComparison.BestEfficiencyTwoLayer.Table effTable(DataTable(
        displayUnit="W") = [Modelica.Constants.eps,Modelica.Constants.eps; 500000,
      0.12; 1000000,0.25; 2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8;
      3600000,0.81; 3800000,0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{60,60},{80,80}})));
  Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=90*
        water.cp*water.rho, T(fixed=true, start=273.15))
    annotation (Placement(transformation(extent={{20,20},{40,40}})));

equation
fuelEfficiencyWood.integrator.y+fuelEfficiencyStraw.integrator.y=FuelEnergy;

consumerTimeDependExt.heat_demand=der(UsedHeat);
heatFlowSensorWood.Q_flow+heatFlowSensorStraw.Q_flow=der(ProducedHeat);
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
  connect(heatFlowDivisor.y2, Wood.nominal_heat) annotation (Line(points={{-67,-14},
          {-60,-14},{-60,14},{-56.4,14}},
                                        color={0,0,127}));
  connect(heatFlowDivisor.y1, Straw.nominal_heat) annotation (Line(points={{-67,-26},
          {-60,-26},{-60,-50},{-56.4,-50}},    color={0,0,127}));
  connect(heatFlowDivisor.u2, consumerTimeDependExt.heat_demand) annotation (
      Line(points={{-90,-26},{-94,-26},{-94,-42},{-94,-80},{44,-80},{44,7},{49.4,
          7}},
        color={0,0,127}));
  connect(Wood.thermal_heat_flow, heatFlowSensorWood.port_a)
    annotation (Line(points={{-36,14},{-22,14}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow, heatFlowSensorStraw.port_a)
    annotation (Line(points={{-36,-50},{-22,-50}}, color={191,0,0}));
  connect(heatFlowSensorStraw.port_b, heatFlowSensorWood.port_b) annotation (
      Line(points={{-2,-50},{10,-50},{10,14},{-2,14}}, color={191,0,0}));
  connect(fuelEfficiencyWood.u1, heatFlowSensorWood.Q_flow) annotation (Line(
        points={{-34,32},{-34,32},{-34,-2},{-34,-4},{-12,-4},{-12,4}}, color={0,
          0,127}));
  connect(fuelEfficiencyWood.u, Wood.nominal_heat) annotation (Line(points={{-46,
          32},{-46,28},{-60,28},{-60,14},{-56.4,14}}, color={0,0,127}));
  connect(heatFlowSensorStraw.Q_flow,fuelEfficiencyStraw. u1) annotation (Line(
        points={{-12,-60},{-12,-60},{-12,-68},{-34,-68},{-34,-30}}, color={0,0,127}));
  connect(fuelEfficiencyStraw.u, Straw.nominal_heat) annotation (Line(points={{-46,-30},
          {-46,-36},{-60,-36},{-60,-50},{-56.4,-50}},      color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, heatFlowSensorWood.port_b)
    annotation (Line(points={{50,0},{10,0},{10,14},{-2,14}}, color={191,0,0}));
  connect(heatCapacitor.port, heatFlowSensorWood.port_b) annotation (Line(
        points={{30,20},{30,0},{10,0},{10,14},{-2,14}}, color={191,0,0}));
  connect(heatFlowDivisor.u1, consumerTimeDependExt.heat_demand) annotation (
      Line(points={{-90,-14},{-94,-14},{-94,-80},{44,-80},{44,7},{49.4,7}},
        color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2.0028e+006,
      StopTime=2.43134e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Model without storage for compare purposes.</p>
</html>"));
end withoutStore;