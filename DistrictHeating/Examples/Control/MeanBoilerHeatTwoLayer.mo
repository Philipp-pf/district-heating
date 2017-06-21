within DistrictHeating.Examples.Control;
model MeanBoilerHeatTwoLayer "Example to show function of control object"
  extends Modelica.Icons.Example;

  ConstantBoilerHeatFlow.MeanBoilerHeatTwoLayer meanBoilerHeatTwoLayer(
    preYstart=false,
    TimeConstant=1,
    Hhighload1=0,
    Hhighload2=4.4,
    Hlowload2=17.6,
    Hlowload1=22)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Constant ConsumerHeatFlow(k=1)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
  Modelica.Blocks.Sources.Sine Boarderheight(
    amplitude=11.05,
    freqHz=0.2,
    phase=0,
    offset=11,
    startTime=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,38})));
  Modelica.Blocks.Sources.Cosine StoreLoad(
    freqHz=0.2,
    startTime=0,
    offset=11,
    amplitude=11.05,
    phase=1.5707963267949) "shows the load of the store"
    annotation (Placement(transformation(extent={{-50,62},{-30,82}})));
equation
  connect(meanBoilerHeatTwoLayer.u, ConsumerHeatFlow.y)
    annotation (Line(points={{-11.2,0},{-16,0},{-19,0}}, color={0,0,127}));
  connect(meanBoilerHeatTwoLayer.u1, Boarderheight.y)
    annotation (Line(points={{0,10.4},{0,10.4},{0,27}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This example shows, how the object MeanBoilerHeatTwoLayer works. </p>
<p>The storage loading is simulated by a sinus- curve.</p>
<p>Depending to the storage loading,  factor k is choosen. </p>
</html>"));
end MeanBoilerHeatTwoLayer;
