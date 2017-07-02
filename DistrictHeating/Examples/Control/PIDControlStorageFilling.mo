within DistrictHeating.Examples.Control;
model PIDControlStorageFilling "Test Model for PID Controller "
  extends Modelica.Icons.Example;
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{40,-10},{60,10}})));
  Modelica.Thermal.FluidHeatFlow.Media.Water water
    annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
  DistrictHeating.Components.Storage.StorageInfinite Store(
    der_T=0,
    G=2300.0,
    C=137*water.rho*water.cp,
    Tstart=303.15,
    Tref=303.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  DistrictHeating.Components.Boiler.BoilerBasicPeak boilerBasicPeak(Qbase(
        displayUnit="kW") = 2000000, Qpeak(displayUnit="kW") = 1000000,
    TimeFirstOrderBase=0,
    TimeFirstOrderPeak=0)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  DistrictHeating.Components.Control.PIDControlStorageFilling
                              Store_Temp_Control(
    Target_Store_Fill=323.15,
    initType=Modelica.Blocks.Types.InitPID.InitialState,
    xi_start=0,
    xd_start=0,
    DelayTime=0,
    k=80000.0,
    Td=Modelica.Constants.eps,
    Nd=Modelica.Constants.eps,
    useExternVariable=true,
    Ti=20000.0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={-50,30})));
  Modelica.Blocks.Sources.Constant const(k=1500000) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={90,0})));
  Modelica.Blocks.Sources.Ramp ramp(
    height=20,
    duration=7200,
    offset=313.15,
    startTime(displayUnit="h") = 198000)
                   annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={-50,70})));
  Modelica.Blocks.Sources.Constant const1(k=278.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-30})));
equation
  connect(Store.heat_output, consumerTimeDependExt.heat_flow)
    annotation (Line(points={{10,0},{40,0}},        color={191,0,0}));
  connect(Store.heat_input, boilerBasicPeak.thermal_heat_flow)
    annotation (Line(points={{-10,0},{-26,0},{-40,0}}, color={191,0,0}));
  connect(Store_Temp_Control.u, Store.store_temp) annotation (Line(points={{-38,
          30},{-38,30},{0,30},{0,10.4}}, color={0,0,127}));
  connect(boilerBasicPeak.nominal_heat, Store_Temp_Control.y) annotation (Line(
        points={{-60.4,0},{-80,0},{-80,30},{-61,30}}, color={0,0,127}));
  connect(consumerTimeDependExt.positive_heat_flow, const.y) annotation (Line(
        points={{60.6,0},{70,0},{70,1.38778e-015},{79,1.38778e-015}}, color={0,0,
          127}));
  connect(ramp.y, Store_Temp_Control.u1)
    annotation (Line(points={{-50,59},{-50,50.5},{-50,42}}, color={0,0,127}));
  connect(Store.outside_temp, const1.y)
    annotation (Line(points={{0,-10.4},{0,-10.4},{0,-19}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=400000, Interval=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: Arial,sans-serif;\">This model shows how the PID controler works. At the beginning the store temperature target is 40 &deg;C. After 55 h the temperature target is raised to 60 &deg;C. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">At the beginning the store temperature decreases until the PID sets a higher boiler heat flow until the set temperature is reached asymptotically. </span></p>
<p><span style=\"font-family: Arial,sans-serif;\">After the raise of the store temeprature target the actuall temperature raises above the set temperature until it reaches the set temperature. </span></p>
</html>"));
end PIDControlStorageFilling;
