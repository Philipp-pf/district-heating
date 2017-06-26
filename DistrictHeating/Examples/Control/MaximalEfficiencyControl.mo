within DistrictHeating.Examples.Control;
model MaximalEfficiencyControl "shows function of efficiency control"

extends Modelica.Icons.Example;
  Components.Control.MaximalEfficiencyControl maximalEfficiencyControl(
    HHighload=2,
    HLowload=20,
    EfficiencyTable=[0.1,0.1; 100000,0.3; 300000,0.6; 600000,0.7; 800000,0.8;
        1200000,0.7],
    Qstart(displayUnit="W") = 1,
    H=22,
    Triggerdelay(displayUnit="s") = 1,
    Triggerperiod(displayUnit="s") = 1,
    m=5,
    Overproduction=50000,
    Underproduction=50000,
    QHighload=50000,
    QLowload=50000)
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.TimeTable timeTable(
    offset=0,
    startTime=0,
    table=[0,0; 1,200000; 2,300000; 3,500000; 4,800000; 5,700000; 6,720000; 7,
        750000; 8,710000; 9,730000; 10,700000])
    annotation (Placement(transformation(extent={{-60,-10},{-40,10}})));
  Modelica.Blocks.Sources.TimeTable timeTable1(
    offset=0,
    startTime=0,
    table=[0.0,12; 1,12; 2,15; 3,14; 4,15; 5,15; 6,19; 7,21; 8,11; 9,1; 10,11])
    annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=270,
        origin={0,50})));
equation
  connect(maximalEfficiencyControl.u, timeTable.y)
    annotation (Line(points={{-11.2,0},{-39,0}}, color={0,0,127}));
  connect(maximalEfficiencyControl.u1, timeTable1.y)
    annotation (Line(points={{0,10.6},{0,10.6},{0,39}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    experiment(StopTime=10),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>This model shows, how the best efficiency control works. </p>
</html>"));
end MaximalEfficiencyControl;
