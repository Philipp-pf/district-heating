within DistrictHeating.PlantControlComparison.Comparison;
model ConstantBoilerHeatFlowUse
  parameter String fileNameTemperatureNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation (Dialog(loadSelector(filter=
            "Text files (*.txt)", caption=
            "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew=Modelica.Utilities.Files.loadResource(
      "modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation (Dialog(loadSelector(filter=
            "Text files (*.txt)", caption=
            "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameEffWood = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Wood.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
 parameter String fileNameEffStraw = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Efficiency_Straw.txt")
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
    annotation (Placement(transformation(extent={{52,-10},{72,10}})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  Modelica.Blocks.Sources.CombiTimeTable Net_source(
    tableOnFile=true,
    tableName="Netzleistung",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameNetNew)
                          annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
    tableOnFile=true,
    tableName="Aussentemperatur",
    columns={2,3,4,5,6,7},
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
    fileName=fileNameTemperatureNew)
                                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={30,-30})));
  Components.Control.MeanBoilerHeatTwoLayer
                         meanBoilerHeat(
    preYstart=true,
    TimeConstant(displayUnit="h") = twentyFourHrs.TimeConstant,
    Hhighload1=twentyFourHrs.Hhighload1,
    khigh1=twentyFourHrs.khigh1,
    Hhighload2=twentyFourHrs.Hhighload2,
    khigh2=twentyFourHrs.khigh2,
    Hlowload2=twentyFourHrs.Hlowload2,
    klow2=twentyFourHrs.klow2,
    Hlowload1=twentyFourHrs.Hlowload1,
    klow1=twentyFourHrs.klow1,
    QStart=twentyFourHrs.QStart,
    TStart=twentyFourHrs.TStart)
                  annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={30,60})));
  Components.Storage.StorageTwoLayer                 storageTwoLayer(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    U=13,
    Thigh=363.15,
    Tlow=313.15,
    Tref=313.15,
    Hboard(start=5.0, fixed=true))
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  ConstantBoilerHeatFlowTwoLayer.FourHrs fourHrs(klow1=0.84)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
  ConstantBoilerHeatFlowTwoLayer.EightHrs eightHrs(
    khigh1=1.5,
    khigh2=1.3,
    klow1=0.64,
    QStart=100000,
    TStart=2016800.0,
    Hhighload1=4.8,
    Hlowload1=15.8)
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  ConstantBoilerHeatFlowTwoLayer.TwelveHrs twelveHrs(khigh1=1.41, klow1=0.99)
    annotation (Placement(transformation(extent={{0,80},{20,100}})));
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
    AllowedGap=1000,
    etaMin=0.59,
    useExternalFile=true,
    fileName=fileNameEffWood,
    tableName="Efficiency")
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,44})));
  Components.Control.FuelEfficiency fuelEfficiencyStraw(
    EfficiencyTable=effTable.DataTable,
    etaMin=0.57,
    useExternalFile=true,
    tableName="Efficiency",
    AllowedGap=1000,
    fileName=fileNameEffStraw)
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-20})));
  BestEfficiencyTwoLayer.Table
        effTable(DataTable(displayUnit="W") = [Modelica.Constants.eps,Modelica.Constants.eps; 500000,0.12;
        1000000,0.25; 2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8; 3600000,
        0.81; 3800000,0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
  ConstantBoilerHeatFlowTwoLayer.TwentyFourHrs twentyFourHrs
    annotation (Placement(transformation(extent={{40,80},{60,100}})));
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
    annotation (Line(points={{72.6,0},{72.6,0},{79,0}},      color={0,0,127}));
  connect(consumerTimeDependExt.heat_demand, meanBoilerHeat.u) annotation (Line(
        points={{51.4,7},{46,7},{46,60},{41.2,60}}, color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{52,0},{52,0},{40,0}}, color={191,0,0}));
  connect(meanBoilerHeat.u1, storageTwoLayer.y) annotation (Line(points={{30,49.6},
          {30,10.6}},               color={0,0,127}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points={{30,-19},
          {30,-19},{30,-11.4}},                  color={0,0,127}));
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
        points={{-2,-50},{-2,-50},{8,-50},{8,0},{20,0}},color={191,0,0}));
  connect(heatFlowSensorWood.port_b, storageTwoLayer.port_a)
    annotation (Line(points={{-2,14},{8,14},{8,0},{20,0}}, color={191,0,0}));
  connect(meanBoilerHeat.y, heatFlowDivisor.u1) annotation (Line(points={{19.2,60},
          {4,60},{-96,60},{-96,-14},{-90,-14}}, color={0,0,127}));
  connect(heatFlowDivisor.u2, meanBoilerHeat.u) annotation (Line(points={{-90,-26},
          {-96,-26},{-96,-80},{46,-80},{46,60},{41.2,60}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2.0028e+006,
      StopTime=2.43134e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This Model shows the use of the constant boiler heat flow control unit. </p>
<p>Time constants of 4, 8, 12 and 24 hours are available. </p>
<p>Choose the time constant you need by filling in the name of the record in meanBoilerHeat object.</p>
<p><br>Note: at the end of the simulation, the storage goes out of limits of storage. So an error occurs. </p>
</html>"));
end ConstantBoilerHeatFlowUse;
