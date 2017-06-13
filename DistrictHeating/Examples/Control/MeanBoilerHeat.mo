within DistrictHeating.Examples.Control;
model MeanBoilerHeat "Shows the usage of the MeanBoilerHeat object"
  extends Modelica.Icons.Example;

  Components.Control.MeanBoilerHeat
                                  meanBoilerHeat(
    TimeConstant=2,
    khigh1=1.3,
    khigh2=1.2,
    preYstart=false,
    klow1=1,
    klow2=1.1,
    Tmax=363.15,
    Thigh=353.15,
    Tlow=323.15,
    Tmin=313.15)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Sine sine(
    freqHz=0.2,
    phase=0,
    startTime=0,
    amplitude=25.1,
    offset=338.15) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
  Modelica.Blocks.Sources.TimeTable timeTable(
    table=[0,0; 2,30; 4,50; 6,40; 8,40; 10,0],
    offset=0,
    startTime=0)
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
equation
  connect(meanBoilerHeat.u1, sine.y) annotation (Line(points={{0,10.4},{0,10.4},
          {0,39},{-1.9984e-015,39}}, color={0,0,127}));
  connect(meanBoilerHeat.u, timeTable.y)
    annotation (Line(points={{-11.2,0},{-26,0},{-39,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This example shows how the object MeanBoilerHeat works. </span></p>
</html>"));
end MeanBoilerHeat;
