within DistrictHeating.Components.Control;
model FuelEfficiency

extends Modelica.Blocks.Interfaces.SISO;
    Real Efficiency=combiTable1D.y[1] "Efficiency";
   Modelica.SIunits.HeatFlowRate HeatFlowIn
    "Useful heat flow which the boiler produced";
    Modelica.SIunits.HeatFlowRate FuelHeatFlow
    "Fuel Heat flow which is needed to produce the boiler heat";
    Modelica.SIunits.Heat FuelHeat "Used fuel heat (integrated)";
parameter Real EfficiencyTable[:,2]
    "Dependency between heat flow and fuel efficiency";

  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
    tableOnFile=false,
    table=EfficiencyTable,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-90,-10},{-70,10}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=0)
    annotation (Placement(transformation(extent={{-56,-78},{-36,-58}})));
  Modelica.Blocks.Logical.Switch switch1
    annotation (Placement(transformation(extent={{52,-38},{72,-18}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{8,-76},{28,-56}})));
  Modelica.Blocks.Logical.Switch switch2
    annotation (Placement(transformation(extent={{-22,-24},{-2,-4}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-58,-32},{-38,-12}})));
  Modelica.Blocks.Logical.Not not1
    annotation (Placement(transformation(extent={{-26,-78},{-6,-58}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=0,
        origin={78,30})));
equation
  HeatFlowIn=u;
  FuelHeatFlow=y;
integrator.y=FuelHeat;

  connect(u, combiTable1D.u[1])
    annotation (Line(points={{-120,0},{-92,0}},         color={0,0,127}));
  connect(division.u1, combiTable1D.u[1]) annotation (Line(points={{8,6},{-20,6},
          {-20,32},{-92,32},{-92,0}}, color={0,0,127}));
  connect(division.y, switch1.u1) annotation (Line(points={{31,0},{36,0},{38,0},
          {38,-20},{50,-20}}, color={0,0,127}));
  connect(switch1.u3, const.y) annotation (Line(points={{50,-36},{42,-36},{42,-66},
          {29,-66}}, color={0,0,127}));
  connect(switch1.y, y) annotation (Line(points={{73,-28},{82,-28},{82,0},{110,0}},
        color={0,0,127}));
  connect(lessEqualThreshold.u, combiTable1D.y[1]) annotation (Line(points={{-58,
          -68},{-62,-68},{-62,0},{-69,0}}, color={0,0,127}));
  connect(switch2.y, division.u2) annotation (Line(points={{-1,-14},{2,-14},{2,-6},
          {8,-6}}, color={0,0,127}));
  connect(switch2.u1, combiTable1D.y[1]) annotation (Line(points={{-24,-6},{-42,
          -6},{-42,0},{-69,0}}, color={0,0,127}));
  connect(switch2.u3, const1.y)
    annotation (Line(points={{-24,-22},{-24,-22},{-37,-22}}, color={0,0,127}));
  connect(not1.u, lessEqualThreshold.y) annotation (Line(points={{-28,-68},{-35,
          -68},{-35,-68}}, color={255,0,255}));
  connect(not1.y, switch1.u2) annotation (Line(points={{-5,-68},{-2,-68},{2,-68},
          {2,-28},{50,-28}}, color={255,0,255}));
  connect(switch2.u2, switch1.u2) annotation (Line(points={{-24,-14},{-32,-14},{
          -32,-40},{2,-40},{2,-28},{50,-28}}, color={255,0,255}));
  connect(integrator.u, y) annotation (Line(points={{66,30},{60,30},{60,0},{110,
          0}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Line(points={{-72,76},{-72,-64},{78,-64}}, color={28,108,200}),
        Line(points={{-72,76},{-76,68}}, color={28,108,200}),
        Line(points={{-72,76},{-68,68}}, color={28,108,200}),
        Line(points={{78,-64},{70,-60}}, color={28,108,200}),
        Line(points={{78,-64},{70,-68}}, color={28,108,200}),
        Line(points={{-62,-40},{-58,-32},{-54,-24},{-46,-14},{-32,-2},{-16,8},{6,
              16},{10,16},{24,18},{40,18},{48,14},{58,6},{64,-2}}, color={28,108,
              200}),
        Line(points={{22,-64},{22,18},{-72,18}}, color={28,108,200})}),
                                                                 Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This object turns the actual heat flow of a boiler into the needed fuel heat flow dependent to the efficiency of the boiler.</p>
<p>The table defines the heat flow efficiency (right column) dependent of the actual heat flow (left column). </p>
<p>Efficiency=Actual Heat Flow/ Fuel Heat Flow</p>
</html>"));
end FuelEfficiency;
