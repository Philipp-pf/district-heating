within DistrictHeating.PlantControlComparison.ConstantVariableStoreTwoLayer;
model PidUse
  parameter String fileNameTemperature = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Outsidetemperature_original.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));
  parameter String fileNameNetNew = Modelica.Utilities.Files.loadResource("modelica://DistrictHeating/Resources/Data/Net_original_changed.txt")
    "File on which data is present" annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Open text file to read parameters of the form \"name = value\"")));

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
    fileName=fileNameTemperature)                               annotation (
      Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
  DistrictHeating.Components.Boiler.BoilerBasicPeak boilerBasicPeak(
                                     Qpeak(displayUnit="kW") = 1000000, Qbase(
        displayUnit="kW") = 4000000,
    TimeFirstOrderBase=0.001,
    TimeFirstOrderPeak=0.001)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  DistrictHeating.Components.Control.PIDControlStorageFilling
                              PID(
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    xd_start=0,
    DelayTime=0,
  useExternVariable=false,
    Target_Store_Fill=17,
    k=pidParameter.k,
    Ti(displayUnit="h") = pidParameter.Ti,
    Td=pidParameter.Td,
    Nd=pidParameter.Nd)
    annotation (Placement(transformation(extent={{20,38},{40,58}})));
  Modelica.Blocks.Sources.Constant StoreTemp(k=17)     annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,30})));
  PidParameter pidParameter
    annotation (Placement(transformation(extent={{-40,80},{-20,100}})));
  DistrictHeating.Components.Storage.StorageTwoLayer storageTwoLayer(
    V=137,
    H=22,
    rho=water.rho,
    cp=water.cp,
    D(start=2),
    U=13,
    Hboard(start=17, fixed=true),
    Thigh=363.15,
    Tlow=313.15,
    Tref=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  PiParameter piParameter(k=-606578, Ti=225391)
    annotation (Placement(transformation(extent={{-80,80},{-60,100}})));
equation
  connect(PID.y, boilerBasicPeak.nominal_heat) annotation (Line(points={{41,48},
        {50,48},{50,72},{-72,72},{-72,0},{-60.4,0}},   color={0,0,127}));
connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
  annotation (Line(points={{60.6,0},{70,0},{79,0}},        color={0,0,127}));
  connect(StoreTemp.y, PID.u1) annotation (Line(points={{59,30},{59,30},{30,30},
          {30,36}}, color={0,0,127}));
  connect(boilerBasicPeak.thermal_heat_flow, storageTwoLayer.port_a)
    annotation (Line(points={{-40,0},{-26,0},{-10,0}}, color={191,0,0}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{40,0},{26,0},{10,0}}, color={191,0,0}));
  connect(Outside_Temp_source.y[6], storageTwoLayer.u) annotation (Line(points={{
          7.21645e-016,-19},{0,-19},{0,-11.4}},            color={0,0,127}));
  connect(storageTwoLayer.y, PID.u) annotation (Line(points={{0,10.6},{0,10.6},{
          0,24},{0,48},{18,48}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=2.4886e+007, Interval=60),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This Model shows the use of the PI/ PID-Control unit. </p>
<p>For switching between both Control units change the parameter names in PID-object to choose between PI and PID Record.</p>
<p>In the given arrangement a (intern) constant store temperature target is given. </p>
<p>For an (extern) variable temperature change the Boolean parameter in PID and give an signal input for the temperature (In this model an extern StoreTemp object is shown, but it is not in use.)</p>
</html>"));
end PidUse;
