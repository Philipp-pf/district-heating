within DistrictHeating.PlantControlComparison.BestEfficiencyTwoLayer;
model BestEfficiency "Shows the work best efficiency control unit"
  parameter String fileNameTemperatureNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
    Real zero=0 "for storage limit in diagramme";

  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
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
        origin={0,-30})));
  DistrictHeating.Components.Storage.StorageTwoLayer storageTwoLayer(
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
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  DistrictHeating.Components.Boiler.BoilerInFinite boilerInFinite
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Components.Control.MaximalEfficiencyControl maximalEfficiencyControl(
    OuterLimits(start=false, fixed=true),
    H=22,
    Qstart(displayUnit="mW") = 0.01,
    Triggerdelay(displayUnit="h") = 3600,
    Triggerperiod(displayUnit="h") = 3600,
    m=10,
    HLowload=18,
    QLowload(displayUnit="kW") = 250000,
    Overproduction(displayUnit="kW") = 250000,
    Underproduction(displayUnit="kW") = 500000,
    QHighload(displayUnit="kW") = 250000,
    HHighload=2,
    EfficiencyTable=effTable.DataTable)
                 annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={0,50})));
  Table effTable(DataTable(displayUnit="W") = [Modelica.Constants.eps,Modelica.Constants.eps; 500000,0.12;
        1000000,0.25; 2000000,0.45; 3000000,0.7; 3200000,0.75; 3400000,0.8; 3600000,
        0.81; 3800000,0.75; 4000000,0.7; 4200000,0.65])
    annotation (Placement(transformation(extent={{40,60},{60,80}})));
equation
connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
  annotation (Line(points={{60.6,0},{70,0},{79,0}},        color={0,0,127}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{40,0},{26,0},{10,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points={{
          7.21645e-016,-19},{0,-19},{0,-11.4}},            color={0,0,127}));
  connect(storageTwoLayer.port_a, boilerInFinite.thermal_heat_flow)
    annotation (Line(points={{-10,0},{-40,0}}, color={191,0,0}));
  connect(consumerTimeDependExt.heat_demand, maximalEfficiencyControl.u)
    annotation (Line(points={{39.4,7},{28,7},{28,50},{11.2,50}}, color={0,0,127}));
  connect(maximalEfficiencyControl.y, boilerInFinite.nominal_heat) annotation (
      Line(points={{-10.8,50},{-20,50},{-80,50},{-80,0},{-60.4,0}}, color={0,0,
          127}));
  connect(storageTwoLayer.y, maximalEfficiencyControl.u1)
    annotation (Line(points={{0,10.6},{0,39.4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.4886e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">This model shows the work of best efficiency control unit. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">This controlling keeps boiler heat flow within best working points, where fuel efficiency is high.</span></p>
<p><span style=\"font-family: Arial,sans-serif;\">The most important thing is the table, which shows the relation between boiler heat flow and boiler efficiency. </span></p>
</html>"));
end BestEfficiency;
