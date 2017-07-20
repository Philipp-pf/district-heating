within DistrictHeating.PlantControlComparison.Comparison;
model OutTempUse
  parameter String fileNameTemperatureNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameEffWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Wood.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
 parameter String fileNameEffStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Straw.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
Modelica.SIunits.Heat FuelEnergy "sum of fuel energy over whole season";
  Real zero=0 "for storage limitation in diagramme";

  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{54,-10},{74,10}})));
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
    fileName=fileNameTemperatureNew)                            annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-30})));
  Components.Control.OutsideTempControl
                              outsideTempControlContinous(Table=table.DataTable)
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,60})));
  OutsideTempControlTwoLayer.Table table(DataTable(displayUnit="kW") = [0,2,11,20;
      268,2600000,2800000,3400000; 270,2400000,2700000,3300000; 280,400000,1500000,
      2700000; 290,400000,900000,1500000; 300,400000,450000,500000; 310,400000,420000,
      450000]) annotation (Placement(transformation(extent={{60,80},{80,100}})));
  DistrictHeating.Components.Storage.StorageTwoLayer storageTwoLayer(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    U=13,
    Hboard(fixed=true, start=15),
    D(start=2),
    Thigh=363.15,
    Tlow=313.15,
    Tref=313.15)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Components.Boiler.BoilerInFinite Wood(
    limited_heat=true,
    Qmax=2420000,
    TimeFirstOrder(displayUnit="min") = 600,
    PartLoad=0)
    annotation (Placement(transformation(extent={{-56,4},{-36,24}})));
  Components.Boiler.BoilerInFinite Straw(
    limited_heat=true,
    Qmax=3250000,
    TimeFirstOrder(displayUnit="min") = 600,
    PartLoad=0)
    annotation (Placement(transformation(extent={{-56,-60},{-36,-40}})));
  Components.Control.HeatFlowDivisor heatFlowDivisor(
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
  Components.Control.FuelEfficiency fuelEfficiencyWood(
    EfficiencyTable=effTable.DataTable,
    useExternalFile=true,
    fileName=fileNameEffWood,
    tableName="Efficiency",
    AllowedGap=1000,
    etaMin=0.59)     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,44})));
  Components.Control.FuelEfficiency fuelEfficiencyStraw(
    EfficiencyTable=effTable.DataTable,
    AllowedGap=1000,
    etaMin=0.57,
    useExternalFile=true,
    fileName=fileNameEffStraw,
    tableName="Efficiency")
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-20})));
  BestEfficiencyTwoLayer.Table
        effTable(DataTable(displayUnit="W") = [Modelica.Constants.eps,Modelica.Constants.eps; 500000,0.12;
        1000000,0.25; 2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8; 3600000,
        0.81; 3800000,0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
equation
fuelEfficiencyWood.integrator.y+fuelEfficiencyStraw.integrator.y=FuelEnergy;
connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
  annotation (Line(points={{74.6,0},{74.6,0},{79,0}},      color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{54,0},{54,0},{40,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points={{30,-19},
          {30,-19},{30,-11.4}},                   color={0,0,127}));
  connect(storageTwoLayer.y, outsideTempControlContinous.u1)
    annotation (Line(points={{30,10.6},{30,49.6}},
                                                 color={0,0,127}));
  connect(outsideTempControlContinous.u, storageTwoLayer.u) annotation (Line(
        points={{41.2,60},{46,60},{46,-16},{30,-16},{30,-11.4}},
                                                               color={0,0,127}));
  connect(heatFlowDivisor.y2,Wood. nominal_heat) annotation (Line(points={{-67,-14},
          {-60,-14},{-60,14},{-56.4,14}},
                                        color={0,0,127}));
  connect(heatFlowDivisor.y1,Straw. nominal_heat) annotation (Line(points={{-67,-26},
          {-60,-26},{-60,-50},{-56.4,-50}},    color={0,0,127}));
  connect(Wood.thermal_heat_flow,heatFlowSensorWood. port_a)
    annotation (Line(points={{-36,14},{-22,14}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow,heatFlowSensorStraw. port_a)
    annotation (Line(points={{-36,-50},{-22,-50}}, color={191,0,0}));
  connect(fuelEfficiencyWood.u1,heatFlowSensorWood. Q_flow) annotation (Line(
        points={{-34,32},{-34,32},{-34,-2},{-34,-4},{-12,-4},{-12,4}}, color={0,
          0,127}));
  connect(fuelEfficiencyWood.u,Wood. nominal_heat) annotation (Line(points={{-46,32},
          {-46,28},{-60,28},{-60,14},{-56.4,14}},     color={0,0,127}));
  connect(heatFlowSensorStraw.Q_flow,fuelEfficiencyStraw. u1) annotation (Line(
        points={{-12,-60},{-12,-60},{-12,-68},{-34,-68},{-34,-32}}, color={0,0,127}));
  connect(fuelEfficiencyStraw.u,Straw. nominal_heat) annotation (Line(points={{-46,-32},
          {-46,-36},{-60,-36},{-60,-50},{-56.4,-50}},      color={0,0,127}));
  connect(heatFlowSensorStraw.port_b, storageTwoLayer.port_a) annotation (Line(
        points={{-2,-50},{4,-50},{8,-50},{8,0},{20,0}}, color={191,0,0}));
  connect(heatFlowSensorWood.port_b, storageTwoLayer.port_a)
    annotation (Line(points={{-2,14},{8,14},{8,0},{20,0}}, color={191,0,0}));
  connect(outsideTempControlContinous.y, heatFlowDivisor.u1) annotation (Line(
        points={{19.2,60},{-96,60},{-96,-14},{-90,-14}}, color={0,0,127}));
  connect(heatFlowDivisor.u2, consumerTimeDependExt.heat_demand) annotation (
      Line(points={{-90,-26},{-96,-26},{-96,-80},{48,-80},{48,7},{53.4,7}},
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
<p>This model shows how the outsidetemperature control object works. </p>
<p>The relation between outside temperature and boiler heat flow is given in object table. </p>
<p>Note: At the end of the simulation, storage gets overloaded and an error occurs. </p>
</html>"));
end OutTempUse;
