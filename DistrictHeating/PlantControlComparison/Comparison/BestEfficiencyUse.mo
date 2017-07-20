within DistrictHeating.PlantControlComparison.Comparison;
model BestEfficiencyUse "Shows the work best efficiency control unit"
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

  //for getting maximal efficiency points
  Integer State=heatFlowDivisor.State "gives state of which boiler is in use";
  Modelica.SIunits.HeatFlowRate ConsumerBoth
    "Defines heat flow in for max eff object in cases of use two boilers";
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
  Components.Storage.StorageTwoLayer                 storageTwoLayer(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    D(start=2),
    U=13,
    Hboard(start=18, fixed=true),
    Thigh=363.15,
    Tlow=313.15,
    Tref=313.15)
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  BestEfficiencyTwoLayer.Table effTableStraw(DataTable(displayUnit="W") = [
      Modelica.Constants.eps,Modelica.Constants.eps; 500000,0.12; 1000000,0.25;
      2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8; 3600000,0.81; 3800000,
      0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{60,40},{80,60}})));
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
    MaxBaseLoad=3250000,
    MaxPeakLoad=2420000,
    BaseHeatFlowBoth(displayUnit="kW") = 1600000)
    annotation (Placement(transformation(extent={{-88,-30},{-68,-10}})));
  Components.Control.FuelEfficiency fuelEfficiencyWood(
    EfficiencyTable=effTableWood.DataTable,
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
    EfficiencyTable=effTableStraw.DataTable,
    AllowedGap=1000,
    etaMin=0.57,
    useExternalFile=true,
    fileName=fileNameEffStraw,
    tableName="Efficiency")
                     annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={-40,-20})));
  BestEfficiencyTwoLayer.Table effTableWood(DataTable(displayUnit="W") = [
      Modelica.Constants.eps,Modelica.Constants.eps; 500000,0.12; 1000000,0.25;
      2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8; 3600000,0.81; 3800000,
      0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{60,80},{80,100}})));
  Components.Control.MaximalEfficiencyControl maximalEfficiencyControlWood(
    OuterLimits(start=false, fixed=true),
    H=22,
    Qstart(displayUnit="mW") = 0.01,
    Triggerdelay(displayUnit="h") = 3600,
    Triggerperiod(displayUnit="h") = 3600,
    HLowload=18,
    QLowload(displayUnit="kW") = 250000,
    Overproduction(displayUnit="kW") = 250000,
    Underproduction(displayUnit="kW") = 500000,
    QHighload(displayUnit="kW") = 250000,
    HHighload=2,
    EfficiencyTable=effTableWood.DataTable,
    useExternalFile=true,
    tableName="Efficiency",
    m=10,
    fileName=fileNameEffWood)               annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,70})));
  Components.Control.MaximalEfficiencyControl maximalEfficiencyControlStraw(
    OuterLimits(start=false, fixed=true),
    H=22,
    Qstart(displayUnit="mW") = 0.01,
    Triggerdelay(displayUnit="h") = 3600,
    Triggerperiod(displayUnit="h") = 3600,
    HLowload=18,
    QLowload(displayUnit="kW") = 250000,
    Overproduction(displayUnit="kW") = 250000,
    Underproduction(displayUnit="kW") = 500000,
    QHighload(displayUnit="kW") = 250000,
    HHighload=2,
    EfficiencyTable=effTableStraw.DataTable,
    useExternalFile=true,
    fileName=fileNameEffStraw,
    tableName="Efficiency",
    m=10)                                    annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={10,40})));
equation
fuelEfficiencyWood.integrator.y+fuelEfficiencyStraw.integrator.y=FuelEnergy;

//connections
fuelEfficiencyWood.u1=Wood.heatFlowSensor.Q_flow;
fuelEfficiencyStraw.u1=Straw.heatFlowSensor.Q_flow;

//for heatFlowDivisor
if State==1 then
  heatFlowDivisor.u1=maximalEfficiencyControlWood.y;
elseif State==2 then
  heatFlowDivisor.u1=maximalEfficiencyControlStraw.y;
else
heatFlowDivisor.u1=maximalEfficiencyControlWood.y+ConsumerBoth;
end if;

//for input efficiency object wood
if State==1 then
    maximalEfficiencyControlWood.u=consumerTimeDependExt.heat_demand;
elseif State==3 then
  maximalEfficiencyControlWood.u=consumerTimeDependExt.heat_demand-ConsumerBoth;
else
     maximalEfficiencyControlWood.u=consumerTimeDependExt.heat_demand;
end if;

//definition consumer both
  ConsumerBoth=min(consumerTimeDependExt.heat_demand,min(heatFlowDivisor.BaseHeatFlowBoth, heatFlowDivisor.MaxBaseLoad));

connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
  annotation (Line(points={{72.6,0},{72.6,0},{79,0}},      color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{52,0},{52,0},{40,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points={{30,-19},
          {30,-19},{30,-11.4}},                            color={0,0,127}));
  connect(heatFlowDivisor.y2,Wood. nominal_heat) annotation (Line(points={{-67,-14},
          {-60,-14},{-60,14},{-56.4,14}},
                                        color={0,0,127}));
  connect(heatFlowDivisor.y1,Straw. nominal_heat) annotation (Line(points={{-67,-26},
          {-60,-26},{-60,-50},{-56.4,-50}},    color={0,0,127}));
  connect(fuelEfficiencyWood.u,Wood. nominal_heat) annotation (Line(points={{-46,32},
          {-46,28},{-60,28},{-60,14},{-56.4,14}},     color={0,0,127}));
  connect(fuelEfficiencyStraw.u,Straw. nominal_heat) annotation (Line(points={{-46,-32},
          {-46,-36},{-60,-36},{-60,-50},{-56.4,-50}},      color={0,0,127}));
  connect(heatFlowDivisor.u2, consumerTimeDependExt.heat_demand) annotation (
      Line(points={{-90,-26},{-96,-26},{-96,-80},{46,-80},{46,7},{51.4,7}},
        color={0,0,127}));
  connect(storageTwoLayer.y, maximalEfficiencyControlWood.u1) annotation (Line(
        points={{30,10.6},{30,10.6},{30,38},{30,56},{10,56},{10,59.4}}, color={0,
          0,127}));
  connect(maximalEfficiencyControlStraw.u1, maximalEfficiencyControlWood.u1)
    annotation (Line(points={{10,29.4},{10,20},{30,20},{30,56},{10,56},{10,59.4}},
        color={0,0,127}));
  connect(Wood.thermal_heat_flow, storageTwoLayer.port_a)
    annotation (Line(points={{-36,14},{8,14},{8,0},{20,0}}, color={191,0,0}));
  connect(Straw.thermal_heat_flow, storageTwoLayer.port_a) annotation (Line(
        points={{-36,-50},{8,-50},{8,0},{20,0}}, color={191,0,0}));
  connect(maximalEfficiencyControlStraw.u, consumerTimeDependExt.heat_demand)
    annotation (Line(points={{21.2,40},{46,40},{46,7},{51.4,7}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=2.0028e+006,
      StopTime=2.43134e+007,
      Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">This model shows the work of best efficiency control unit. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">This controlling keeps boiler heat flow within best working points, where fuel efficiency is high.</span></p>
<p><span style=\"font-family: Arial,sans-serif;\">The most important thing is the table, which shows the relation between boiler heat flow and boiler efficiency. </span></p>
</html>"));
end BestEfficiencyUse;
