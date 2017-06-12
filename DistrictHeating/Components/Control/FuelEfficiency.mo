within DistrictHeating.Components.Control;
model FuelEfficiency

extends Modelica.Blocks.Interfaces.SISO;
    parameter Real EfficiencyTable[:,2]
    "Dependency between heat flow and fuel efficiency";
    parameter Modelica.SIunits.Time ChangeTime
    "Time which is needed to reach new boiler heat value (first order time)";
    parameter Real ChangeEfficiency(min=0.01, max=1)
    "Efficiency Factor while heat flow changes (not needed if ChamgeTime=0)";

  Real Efficiency=combiTable1D.y[1] "Efficiency";
   Modelica.SIunits.HeatFlowRate HeatFlowIn
    "Useful heat flow which the boiler produced";
    Modelica.SIunits.HeatFlowRate FuelHeatFlow
    "Fuel Heat flow which is needed to produce the boiler heat";
    Modelica.SIunits.Heat FuelHeat "Used fuel heat (integrated)";

  Modelica.Blocks.Tables.CombiTable1D combiTable1D(
    tableOnFile=false,
    table=EfficiencyTable,
    smoothness=Modelica.Blocks.Types.Smoothness.ContinuousDerivative)
    annotation (Placement(transformation(extent={{-88,-10},{-68,10}})));
  Modelica.Blocks.Math.Division division
    annotation (Placement(transformation(extent={{8,0},{28,20}})));
  Modelica.Blocks.Logical.LessEqualThreshold lessEqualThreshold(threshold=0)
    annotation (Placement(transformation(extent={{-54,40},{-34,60}})));
  Modelica.Blocks.Logical.Switch preventZero
    annotation (Placement(transformation(extent={{40,20},{60,40}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{8,40},{28,60}})));
  Modelica.Blocks.Logical.Switch preventZero1
    annotation (Placement(transformation(extent={{-24,-10},{-4,10}})));
  Modelica.Blocks.Sources.Constant const1(k=1)
    annotation (Placement(transformation(extent={{-54,-2},{-34,18}})));
  Modelica.Blocks.Continuous.Integrator integrator(
    k=1,
    initType=Modelica.Blocks.Types.Init.InitialState,
    y_start=0) annotation (Placement(transformation(
        extent={{-10,-10},{10,10}},
        rotation=180,
        origin={80,70})));
  Modelica.Blocks.Continuous.Derivative derivative(
    k=1,
    T=0.01,
    initType=Modelica.Blocks.Types.Init.InitialState,
    x_start=0) annotation (Placement(transformation(extent={{-60,-60},{-40,-40}})));
  Modelica.Blocks.Continuous.FirstOrder firstOrder(k=1, initType=Modelica.Blocks.Types.Init.InitialState,
    T=ChangeTime)
    annotation (Placement(transformation(extent={{-88,-60},{-68,-40}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=0)
    annotation (Placement(transformation(extent={{-30,-60},{-10,-40}})));
  Modelica.Blocks.Math.Division division1
    annotation (Placement(transformation(extent={{72,-10},{92,10}})));
  Modelica.Blocks.Logical.Switch heatChange
    annotation (Placement(transformation(extent={{40,-60},{60,-40}})));
  Modelica.Blocks.Sources.Constant changeHeat(k=ChangeEfficiency)
    annotation (Placement(transformation(extent={{0,-40},{20,-20}})));
  Modelica.Blocks.Sources.Constant constHeat(k=1)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
equation
  HeatFlowIn=u;
  FuelHeatFlow=y;
integrator.y=FuelHeat;

  connect(u, combiTable1D.u[1])
    annotation (Line(points={{-120,0},{-90,0}},         color={0,0,127}));
  connect(lessEqualThreshold.u, combiTable1D.y[1]) annotation (Line(points={{-56,50},
          {-56,50},{-60,50},{-60,48},{-60,48},{-60,28},{-60,28},{-60,28},{-60,16},
          {-60,0},{-67,0}},                color={0,0,127}));
  connect(firstOrder.u, u) annotation (Line(points={{-90,-50},{-96,-50},{-96,0},
          {-120,0}}, color={0,0,127}));
  connect(firstOrder.y, derivative.u)
    annotation (Line(points={{-67,-50},{-67,-50},{-62,-50}},color={0,0,127}));
  connect(greaterThreshold.y, heatChange.u2)
    annotation (Line(points={{-9,-50},{38,-50}}, color={255,0,255}));
  connect(heatChange.y, division1.u2) annotation (Line(points={{61,-50},{64,-50},
          {64,-6},{70,-6}}, color={0,0,127}));
  connect(derivative.y, greaterThreshold.u)
    annotation (Line(points={{-39,-50},{-39,-50},{-32,-50}}, color={0,0,127}));
  connect(const.y, preventZero.u1) annotation (Line(points={{29,50},{32,50},{32,
          38},{38,38}}, color={0,0,127}));
  connect(division.y, preventZero.u3) annotation (Line(points={{29,10},{32,10},{
          32,22},{38,22}}, color={0,0,127}));
  connect(y, division1.y)
    annotation (Line(points={{110,0},{102,0},{93,0}}, color={0,0,127}));
  connect(integrator.u, division1.y)
    annotation (Line(points={{92,70},{96,70},{96,0},{93,0}}, color={0,0,127}));
  connect(changeHeat.y, heatChange.u1) annotation (Line(points={{21,-30},{28,-30},
          {28,-42},{38,-42}}, color={0,0,127}));
  connect(constHeat.y, heatChange.u3) annotation (Line(points={{21,-70},{26,-70},
          {26,-58},{38,-58}}, color={0,0,127}));
  connect(preventZero.y, division1.u1)
    annotation (Line(points={{61,30},{64,30},{64,6},{70,6}}, color={0,0,127}));
  connect(preventZero1.y, division.u2)
    annotation (Line(points={{-3,0},{0,0},{0,4},{6,4}}, color={0,0,127}));
  connect(preventZero1.u3, combiTable1D.y[1]) annotation (Line(points={{-26,-8},
          {-60,-8},{-60,0},{-67,0}}, color={0,0,127}));
  connect(preventZero1.u2, lessEqualThreshold.y) annotation (Line(points={{-26,0},
          {-30,0},{-30,50},{-33,50}}, color={255,0,255}));
  connect(preventZero.u2, lessEqualThreshold.y) annotation (Line(points={{38,30},
          {-30,30},{-30,50},{-33,50}}, color={255,0,255}));
  connect(const1.y, preventZero1.u1)
    annotation (Line(points={{-33,8},{-29.5,8},{-26,8}}, color={0,0,127}));
  connect(division.u1, u) annotation (Line(points={{6,16},{-8,16},{-8,70},{-96,70},
          {-96,0},{-120,0}}, color={0,0,127}));
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
<p>In times where input heat flow is not constant (derivative unequal zero), the boiler efficiency can be reduced by factor ChangeEfficiency. </p>
<p>Fuel Heat Flow=Actual Heat Flow/(Efficiencyfactor by CombiTimeTable * Change Efficiency).</p>
</html>"));
end FuelEfficiency;
