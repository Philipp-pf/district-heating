within DistrictHeating.Components.Control;
model HeatFlowDivisor
  "divides input heat flow into two heat flows for base and peak load boiler"

parameter Modelica.SIunits.HeatFlowRate ActivateBaseBoiler
    "activate base boiler after low load time (preseason)";
parameter Modelica.SIunits.HeatFlowRate ActivateBothBoiler
    "activate both boilers in peak load times";
parameter Modelica.SIunits.HeatFlowRate DeactivateBothBoiler
    "only using base boiler after peak load time";
parameter Modelica.SIunits.HeatFlowRate DeactivateBaseBoiler
    "deactivate base boiler after high load time (afterseason)";
parameter Modelica.SIunits.Time WaitingTime
    "Time that is waited before another boiler state activates";
  parameter Modelica.SIunits.HeatFlowRate BaseHeatFlowBoth
    "base boiler heat flow in times, when both boiler are in use (idealy in point with best efficiency)";
parameter Modelica.SIunits.HeatFlowRate MaxBaseLoad
    "maximal boiler heat flow of base load boiler";
parameter Modelica.SIunits.HeatFlowRate MaxPeakLoad
    "maximal boiler heat flow of peak load boiler";

    Integer State
    "Shows boiler state(1=only peak boiler, 2=only base boiler, 3=both)";
    Modelica.SIunits.HeatFlowRate BoilerHeatFlow=u1 "input boiler heat flow";
    Modelica.SIunits.HeatFlowRate ConsumerHeatFlow=u2 "consumer heat flow";
    Modelica.SIunits.HeatFlowRate BaseHeatFlow=y1 "base boiler heat flow";
    Modelica.SIunits.HeatFlowRate PeakHeatFlow=y2 "peak boiler heat flow";

Boolean Start=true;
Boolean one( start=false, fixed=true);
Boolean two( start=false, fixed=true);
Boolean three( start=false, fixed=true);
Boolean four( start=false, fixed=true);

  Modelica.Blocks.Interfaces.RealInput u1 "boiler heat flow"
    annotation (Placement(transformation(extent={{-140,40},{-100,80}})));
  Modelica.Blocks.Interfaces.RealInput u2 "consumer heat flow"
    annotation (Placement(transformation(extent={{-140,-80},{-100,-40}})));
  Modelica.Blocks.Interfaces.RealOutput y1 "basic load boiler"
    annotation (Placement(transformation(extent={{100,-70},{120,-50}})));
  Modelica.Blocks.Interfaces.RealOutput y2 "peak load boiler"
    annotation (Placement(transformation(extent={{100,50},{120,70}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold(threshold=
        ActivateBaseBoiler)
    annotation (Placement(transformation(extent={{-80,10},{-60,30}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold(threshold=
        DeactivateBothBoiler)
    annotation (Placement(transformation(extent={{-80,-50},{-60,-30}})));
  Modelica.Blocks.Logical.GreaterThreshold greaterThreshold1(threshold=
        ActivateBothBoiler)
    annotation (Placement(transformation(extent={{-80,-20},{-60,0}})));
  Modelica.Blocks.Logical.LessThreshold lessThreshold1(threshold=
        DeactivateBaseBoiler)
    annotation (Placement(transformation(extent={{-80,-80},{-60,-60}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-40,10},{-20,30}})));
  Modelica.Blocks.Logical.Timer timer1
    annotation (Placement(transformation(extent={{-40,-20},{-20,0}})));
  Modelica.Blocks.Logical.Timer timer2
    annotation (Placement(transformation(extent={{-40,-50},{-20,-30}})));
  Modelica.Blocks.Logical.Timer timer3
    annotation (Placement(transformation(extent={{-40,-80},{-20,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold activateBoth(threshold=WaitingTime)
    annotation (Placement(transformation(extent={{0,-20},{20,0}})));
  Modelica.Blocks.Logical.GreaterThreshold deactivateBoth(threshold=WaitingTime)
    annotation (Placement(transformation(extent={{0,-50},{20,-30}})));
  Modelica.Blocks.Logical.GreaterThreshold deactivateBase(threshold=WaitingTime)
    annotation (Placement(transformation(extent={{0,-80},{20,-60}})));
  Modelica.Blocks.Logical.GreaterThreshold activateBase(threshold=WaitingTime)
    annotation (Placement(transformation(extent={{0,10},{20,30}})));

  Modelica.Blocks.MathBoolean.RisingEdge activateBase1(pre_u_start=false)
    annotation (Placement(transformation(extent={{36,16},{44,24}})));
  Modelica.Blocks.MathBoolean.RisingEdge activateBoth1(pre_u_start=false)
    annotation (Placement(transformation(extent={{36,-14},{44,-6}})));
  Modelica.Blocks.MathBoolean.RisingEdge deactivateBoth1(pre_u_start=false)
    annotation (Placement(transformation(extent={{36,-44},{44,-36}})));
  Modelica.Blocks.MathBoolean.RisingEdge deactivateBase1(pre_u_start=false)
    annotation (Placement(transformation(extent={{36,-74},{44,-66}})));

equation
  //Boolean definition for state
when Start and activateBase1.y then
one=true;
 end when;
when one and activateBoth1.y then
two=true;
end when;
when two and deactivateBoth1.y then
 three=true;
end when;
when three and deactivateBase1.y then
four=true;
end when;

//state declaration
if one and not two then
  State=2;
elseif two and not three then
  State=3;
elseif three and not four then
  State=2;
elseif four then
  State=1;
else
  State=1;
end if;

//output boiler heat
if State==1 then
  BaseHeatFlow=0;
  PeakHeatFlow=min(BoilerHeatFlow,MaxPeakLoad);
elseif State==2 then
BaseHeatFlow=min(BoilerHeatFlow,MaxBaseLoad);
  PeakHeatFlow=0;
else
  BaseHeatFlow=min(BoilerHeatFlow,min( BaseHeatFlowBoth, MaxBaseLoad));
  PeakHeatFlow=max(BoilerHeatFlow-BaseHeatFlow,0);
  end if;

  connect(greaterThreshold1.u, greaterThreshold.u) annotation (Line(points={{-82,-10},
          {-90,-10},{-90,20},{-82,20}},    color={0,0,127}));
  connect(lessThreshold.u, greaterThreshold.u) annotation (Line(points={{-82,-40},
          {-90,-40},{-90,20},{-82,20}}, color={0,0,127}));
  connect(lessThreshold1.u, greaterThreshold.u) annotation (Line(points={{-82,-70},
          {-90,-70},{-90,20},{-82,20}}, color={0,0,127}));
  connect(greaterThreshold.y, timer.u)
    annotation (Line(points={{-59,20},{-50,20},{-42,20}}, color={255,0,255}));
  connect(greaterThreshold1.y, timer1.u)
    annotation (Line(points={{-59,-10},{-42,-10}},
                                                 color={255,0,255}));
  connect(lessThreshold.y, timer2.u)
    annotation (Line(points={{-59,-40},{-42,-40}}, color={255,0,255}));
  connect(lessThreshold1.y, timer3.u)
    annotation (Line(points={{-59,-70},{-42,-70}}, color={255,0,255}));
  connect(timer1.y, activateBoth.u)
    annotation (Line(points={{-19,-10},{-10,-10},{-2,-10}}, color={0,0,127}));
  connect(timer2.y, deactivateBoth.u)
    annotation (Line(points={{-19,-40},{-10,-40},{-2,-40}}, color={0,0,127}));
  connect(timer3.y, deactivateBase.u)
    annotation (Line(points={{-19,-70},{-10,-70},{-2,-70}}, color={0,0,127}));
  connect(u2, greaterThreshold.u) annotation (Line(points={{-120,-60},{-90,-60},
          {-90,20},{-82,20}}, color={0,0,127}));
  connect(timer.y, activateBase.u)
    annotation (Line(points={{-19,20},{-10,20},{-2,20}}, color={0,0,127}));
  connect(activateBase.y, activateBase1.u)
    annotation (Line(points={{21,20},{28,20},{34.4,20}}, color={255,0,255}));
  connect(activateBoth.y, activateBoth1.u)
    annotation (Line(points={{21,-10},{34.4,-10}}, color={255,0,255}));
  connect(deactivateBoth.y, deactivateBoth1.u) annotation (Line(points={{21,-40},
          {28,-40},{34.4,-40}}, color={255,0,255}));
  connect(deactivateBase.y, deactivateBase1.u) annotation (Line(points={{21,-70},
          {28,-70},{34.4,-70}}, color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
          Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
          Text(
          extent={{-64,-112},{68,-140}},
          lineColor={28,108,200},
          textString="%name"),
        Line(points={{-72,70},{-72,-70},{78,-70}}, color={28,108,200}),
        Line(points={{-72,70},{-76,62}}, color={28,108,200}),
        Line(points={{-72,70},{-68,62}}, color={28,108,200}),
        Line(points={{78,-70},{70,-66}}, color={28,108,200}),
        Line(points={{78,-70},{70,-74}}, color={28,108,200}),
        Line(points={{-62,-46},{-52,-40},{-40,-38},{-34,-26},{-18,-16},{-12,2},
              {0,4},{16,6},{32,-6},{36,-18},{44,-26},{52,-32},{64,-36}},
                                                                   color={0,255,
              0}),
        Line(points={{-72,-30},{76,-30}}, color={28,108,200}),
        Line(points={{-72,-4},{76,-4}}, color={28,108,200}),
        Line(points={{8,0},{94,60},{60,-48}}, color={238,46,47}),
        Line(points={{94,60},{-48,-52}}, color={238,46,47}),
        Line(points={{-36,-30},{-36,-70}}, color={28,108,200}),
        Line(points={{-14,-4},{-14,-70}}, color={28,108,200}),
        Line(points={{30,-4},{30,-70}}, color={28,108,200}),
        Line(points={{50,-30},{50,-70}}, color={28,108,200}),
        Line(points={{-22,-44}}, color={238,46,47}),
        Line(points={{10,-42},{94,-60}}, color={238,46,47})}),   Diagram(
        coordinateSystem(preserveAspectRatio=false)),
    Documentation(info="<html>
<p>This model divides the input heat flow of a control unit into two parts for a basic boiler and a peak load boiler. </p>
<p>Therefore the parameters are used. At the beginning of the simulation the peak load boiler is used. </p>
<p>If the consumer heat flow keeps higher than parameter <code>ActivateBaseBoiler</code> for time <code>WaitingTime</code>, then the base load boiler is used. </p>
<p>If the consumer heat flow keeps higher than parameter <code>ActivateBothBoiler</code>r for time <code>WaitingTime</code>, then both boilers are used.Base boiler keeps its heat flow at parameter <code>BaseHeatFlowBoth</code>. If the actual consumer heat flow is lower than this heat flow, it is reduced to the actual heat flow. The difference is produced by peak load boiler. If the difference is negative, the peak load boiler is not in use. </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the consumer heat flow keeps lower than parameter </span><code>DeactivateBaseBoiler</code><span style=\"font-family: MS Shell Dlg 2;\">r for time </span><code>WaitingTime</code><span style=\"font-family: MS Shell Dlg 2;\">, then the base load boiler is used. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the consumer heat flow keeps lower than parameter </span><code>DeactivateBothBoiler</code><span style=\"font-family: MS Shell Dlg 2;\"> for time </span><code>WaitingTime</code><span style=\"font-family: MS Shell Dlg 2;\">, then the peak load boiler is used. </span></p>
</html>"));
end HeatFlowDivisor;
