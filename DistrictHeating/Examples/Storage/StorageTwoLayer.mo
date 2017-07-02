within DistrictHeating.Examples.Storage;
model StorageTwoLayer

extends Modelica.Icons.Example;

  DistrictHeating.Components.Boiler.BoilerInFinite boilerInFinite(limited_heat=false,
    Qmax=1,
    TimeFirstOrder=0)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  DistrictHeating.Components.Consumers.ConsumerTimeDependExt
    consumerTimeDependExt
    annotation (Placement(transformation(extent={{20,-10},{40,10}})));
  Modelica.Blocks.Sources.Constant const(k=2e6)
    annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
  Modelica.Blocks.Sources.Constant const1(k=1.99e6) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={70,0})));
  Modelica.Blocks.Sources.Constant const2(k=283.15) annotation (Placement(
        transformation(
        extent={{-10,-10},{10,10}},
        rotation=90,
        origin={0,-50})));
  Components.Storage.StorageTwoLayer storageTwoLayer(
    V=137,
    H=22,
    U=10,
    Thigh=363.15,
    Tlow=323.15,
    Tref=323.15,
    Hboard(fixed=true, start=15))
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
equation
  connect(const.y, boilerInFinite.nominal_heat)
    annotation (Line(points={{-59,0},{-40.4,0}}, color={0,0,127}));
  connect(consumerTimeDependExt.positive_heat_flow, const1.y)
    annotation (Line(points={{40.6,0},{59,0}}, color={0,0,127}));
  connect(boilerInFinite.thermal_heat_flow, storageTwoLayer.port_a)
    annotation (Line(points={{-20,0},{-16,0},{-10,0}}, color={191,0,0}));
  connect(consumerTimeDependExt.heat_flow, storageTwoLayer.port_b)
    annotation (Line(points={{20,0},{16,0},{10,0}}, color={191,0,0}));
  connect(const2.y, storageTwoLayer.u) annotation (Line(points={{7.21645e-016,
          -39},{0,-39},{0,-11.4}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10000, Interval=20),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>The sum of consumer heat flow and store loss heat flow is higher than the produced boiler heat flow. So the stored heat decreases.</p>
</html>"));
end StorageTwoLayer;
