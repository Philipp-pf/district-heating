within DistrictHeating.Examples.Control;
model OutsideTempControl "Example to show work of control object"

extends Modelica.Icons.Example;
  Modelica.Blocks.Sources.Ramp boarderheight(
    duration=5,
    startTime=2,
    offset=2,
    height=18)
    annotation (Placement(transformation(extent={{-40,40},{-20,60}})));
  OutsideTempControl.OutsideTempControlContinous outsideTempControlContinous(Table(
        displayUnit="W") = [0,2,11,20; 270,1300000,1400000,1500000; 275,1100000,
      1200000,1300000; 280,900000,1000000,1100000])
    annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
  Modelica.Blocks.Sources.Ramp temperature(
    duration=5,
    startTime=2,
    height=-10,
    offset=280)
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
equation
  connect(boarderheight.y, outsideTempControlContinous.u1)
    annotation (Line(points={{-19,50},{0,50},{0,10.4}}, color={0,0,127}));
  connect(outsideTempControlContinous.u, temperature.y)
    annotation (Line(points={{-11.2,0},{-16,0},{-19,0}}, color={0,0,127}));
  annotation (
    Icon(coordinateSystem(preserveAspectRatio=false)),
    Diagram(coordinateSystem(preserveAspectRatio=false)),
    experiment(
      StartTime=1,
      StopTime=10,
      __Dymola_NumberOfIntervals=200),
    __Dymola_experimentSetupOutput,
    Documentation(info="<html>
<p>Example to check function of OutsideTempControl. </p>
<p><br>At beginning the storage boarder height is 2 m ( high stoage loading) and the outside temperature is 280 K. </p>
<p>During simulation the boarder height raises to 20 m (low storage loading) and the temperature falls to 270 K. </p>
<p><br>Raising boarder height causes raising heat flow and falling temperature also causes raising  heat flow. </p>
<p>So, the heat flow demand raises from 900 kW to 1500 kW. </p>
</html>"));
end OutsideTempControl;
