within DistrictHeating.Components.Control;
model MaximalEfficiencyControl "Work in maximal efficiency boiler heat flow"

parameter Real EfficiencyTable[:,2] "Table which shows the efficiency of the boiler, left column 
contains boiler heat flow, right column contains boiler efficiency";
parameter Integer m(min=1)
    "Number of steps as sampling rate within toleranceband(boiler heat flow step height=1/m)";
parameter Modelica.SIunits.HeatFlowRate Overproduction
    "allowed overproduced heat flow above consumer heat flow" annotation (Dialog(group="Control"));
parameter Modelica.SIunits.HeatFlowRate Underproduction
    "allowed underproduced heat flow below consumer heat flow" annotation (Dialog(group="Control"));
    parameter Modelica.SIunits.Height HHighload
    "high storage load, small value" annotation (Dialog(group="Store"));
    parameter Modelica.SIunits.HeatFlowRate QHighload( min=0)
    "heat flow reduction to avoid overloaded store" annotation (Dialog(group="Store"));
    parameter Modelica.SIunits.Height HLowload "low storage load, high value" annotation (Dialog(group="Store"));
    parameter Modelica.SIunits.HeatFlowRate QLowload(  min=0)
    "heat flow surplus to avoid underloaded store" annotation (Dialog(group="Store"));
    parameter Modelica.SIunits.Height H "total storage height" annotation (Dialog(group="Store"));
    parameter Modelica.SIunits.HeatFlowRate Qstart
    "start value of boiler heat flow" annotation (Dialog(group="Initialization"));
parameter Modelica.SIunits.Time Triggerdelay
    "if boiler heat flow is out of limit, wait time before boiler heat flow is reseted"
                                                                                        annotation (Dialog(group="Trigger"));
    parameter Modelica.SIunits.Time Triggerperiod
    "Time between boiler heat reset if out of limit (after triggerdelay)" annotation (Dialog(group="Trigger"));

Modelica.SIunits.HeatFlowRate ConsumerHeatFlow "input consumer heat flow";
Modelica.SIunits.HeatFlowRate MaxHeatFlow "maximal allowed heat flow";
Modelica.SIunits.HeatFlowRate MinHeatFlow "minimal allowed heat flow";
Boolean OuterLimits "=true, if consumer heat flow is outer limits";
Modelica.SIunits.HeatFlowRate BoilerHeatFlow "output boiler heat flow";
Modelica.SIunits.HeatFlowRate StoreCorrector
    "heat flow corrector to stay in store limits";
   Modelica.SIunits.Height Hboard "boarder height";
   Integer counter[m]
    "defines, which heat flow has the highest efficiency, vector";
   Integer numb "defines, which heat flow has the highest efficiency,integer";
   Real eta[m] "vector, which shows efficiency of all tast rate steps";
   Real etaMax "maximum efficiency";

  Modelica.Blocks.Interfaces.RealInput u "consumer heat flow"
    annotation (Placement(transformation(extent={{-132,-20},{-92,20}})));
  Modelica.Blocks.Tables.CombiTable1Ds EffTable[m](
    tableOnFile=fill(false, m),
    table=fill(EfficiencyTable, m),
    smoothness=fill(Modelica.Blocks.Types.Smoothness.LinearSegments, m))
    annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));

  Modelica.Blocks.Interfaces.RealOutput y
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  Modelica.Blocks.Discrete.TriggeredSampler triggeredSampler(y_start=Qstart)
    annotation (Placement(transformation(extent={{10,-10},{30,10}})));
  Modelica.Blocks.Interfaces.RealInput u1 "storage boarder height" annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,106})));
  Modelica.Blocks.Math.Max max1
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant const(k=0)
    annotation (Placement(transformation(extent={{10,20},{30,40}})));
  Modelica.Blocks.Sources.BooleanPulse booleanPulse(
    width=50,
    startTime=0,
    period=Triggerperiod)
    annotation (Placement(transformation(extent={{-72,-30},{-52,-10}})));
  Modelica.Blocks.Logical.LogicalSwitch logicalSwitch
    annotation (Placement(transformation(extent={{-40,-60},{-20,-40}})));
  Modelica.Blocks.Sources.BooleanConstant booleanConstant(k=false)
    annotation (Placement(transformation(extent={{-72,-90},{-52,-70}})));
  Modelica.Blocks.MathBoolean.ChangingEdge changing1
    annotation (Placement(transformation(extent={{-12,-76},{-4,-68}})));
  Modelica.Blocks.MathBoolean.Or or1(nu=2)
    annotation (Placement(transformation(extent={{6,-66},{18,-54}})));
  Modelica.Blocks.MathBoolean.ChangingEdge changing2
    annotation (Placement(transformation(extent={{-12,-54},{-4,-46}})));
  Modelica.Blocks.Logical.Timer timer
    annotation (Placement(transformation(extent={{-100,-60},{-80,-40}})));
  Modelica.Blocks.Logical.GreaterEqualThreshold greaterEqualThreshold(threshold=
       Triggerdelay)
    annotation (Placement(transformation(extent={{-72,-60},{-52,-40}})));

equation
  //Connectors from outside
  u=ConsumerHeatFlow;
  u1=Hboard;
  y=BoilerHeatFlow;

//Connectors inside
triggeredSampler.u=EffTable[numb].u;
timer.u=OuterLimits;
changing1.u=OuterLimits;

//Definition work area
  MaxHeatFlow=ConsumerHeatFlow+Overproduction;
  if ConsumerHeatFlow-Underproduction>0 then
  MinHeatFlow=ConsumerHeatFlow-Underproduction;
  else
  MinHeatFlow=0;
  end if;

  //assignment to all EffTables
  for i in 1:m loop
  EffTable[i].u=MinHeatFlow+(MaxHeatFlow-MinHeatFlow)/m*i;
  end for;

//max eta vector
  for i in 1:m loop
  eta[i]=EffTable[i].y[1];
  end for;

//define highest efficiency from vector eta
  max(eta)=etaMax;

//Lookup, which table is the best
  for i in 1:m loop
  if etaMax<=EffTable[i].y[1] then
  counter[i]=i;
  else
   counter[i]=0;
  end if;
  end for;

//number of best table
  sum(counter)=numb;

//Out of limits
  if pre(triggeredSampler.y)>=MaxHeatFlow or pre(triggeredSampler.y)<=MinHeatFlow then
   OuterLimits=true;
  else
    OuterLimits=false;
  end if;

//Store limitation
  if Hboard<=HHighload then
  StoreCorrector=QHighload/HHighload*(Hboard-HHighload);
  elseif Hboard>=HLowload then
  StoreCorrector=-QLowload/(H-HLowload)*(HLowload-Hboard);
  else
  StoreCorrector=0;
  end if;

//Heat flow limit zero
  max1.u2=triggeredSampler.y+StoreCorrector;

  connect(max1.u1, const.y)
    annotation (Line(points={{58,6},{50,6},{50,30},{31,30}}, color={0,0,127}));
  connect(max1.y, y)
    annotation (Line(points={{81,0},{108,0}}, color={0,0,127}));
  connect(logicalSwitch.u3,booleanConstant. y) annotation (Line(points={{-42,-58},
          {-46,-58},{-46,-80},{-51,-80}},
                                     color={255,0,255}));
  connect(changing2.y,or1. u[1]) annotation (Line(points={{-3.2,-50},{2,-50},{2,
          -57.9},{6,-57.9}},
                          color={255,0,255}));
  connect(changing1.y,or1. u[2]) annotation (Line(points={{-3.2,-72},{2,-72},{2,
          -62.1},{6,-62.1}},color={255,0,255}));
  connect(timer.y,greaterEqualThreshold. u)
    annotation (Line(points={{-79,-50},{-79,-50},{-74,-50}},
                                                          color={0,0,127}));
  connect(logicalSwitch.u2,greaterEqualThreshold. y)
    annotation (Line(points={{-42,-50},{-42,-50},{-51,-50}},
                                                         color={255,0,255}));
  connect(triggeredSampler.trigger, or1.y) annotation (Line(points={{20,-11.8},{
          20,-20},{20,-60},{18.9,-60}},          color={255,0,255}));
  connect(booleanPulse.y, logicalSwitch.u1) annotation (Line(points={{-51,-20},{
          -46,-20},{-46,-42},{-42,-42}},color={255,0,255}));
  connect(logicalSwitch.y, changing2.u)
    annotation (Line(points={{-19,-50},{-13.6,-50}},
                                                   color={255,0,255}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
                                Rectangle(
        extent={{-100,-100},{100,100}},
        lineColor={0,0,127},
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid), Text(
        extent={{-150,150},{150,110}},
        textString="%name",
        lineColor={0,0,255}),
        Line(points={{-72,76},{-72,-64},{78,-64}}, color={28,108,200}),
        Line(points={{-72,76},{-76,68}}, color={28,108,200}),
        Line(points={{-72,76},{-68,68}}, color={28,108,200}),
        Line(points={{78,-64},{70,-60}}, color={28,108,200}),
        Line(points={{78,-64},{70,-68}}, color={28,108,200}),
        Line(points={{-62,-40},{-58,-32},{-54,-24},{-46,-14},{-32,-2},{-16,8},{6,
              16},{10,16},{24,18},{40,18},{48,14},{58,6},{64,-2}}, color={255,0,
              0}),
        Line(points={{22,-64},{22,18},{-72,18}}, color={28,108,200}),
        Line(points={{-58,-40},{-52,-26},{-40,-12},{-22,2},{2,12},{26,16},{44,12},
              {52,4},{58,-2}}, color={28,108,200}),
        Line(points={{-66,-34},{-56,-16},{-40,-2},{-22,10},{-2,18},{18,22},{34,22},
              {52,20},{56,14},{64,2}}, color={28,108,200})}),    Diagram(
        coordinateSystem(preserveAspectRatio=false)),
                Line(points={{11,0},{20,0},{20,60},{36,60}}, color={0,0,127}),
    Documentation(info="<html>
<p>This controlling keeps boiler heat flow within best working points, where fuel efficiency is high.</p>
<p>Define overproduction and underproduction from actual consumer heat flow. From that, a minimal and maximal heat flow is calculated.Within this tolerance, the heat flow with the highest efficiency is choosed. This boiler heat is used until the tolerance band is exceeded. Then a new boiler heat flow within the tolerance band is choosen. If the boiler heat flow is outside the limit and the boiler heat doesn&apos;t change, then triggerdelay time starts. If that time is ran out, the boiler heat changes, so that it is within the limit. If it further runs out of limit after triggerperiod time the boiler heat flow is changed again. </p>
<p>If the storage reaches its limits, then the boiler heat flow is changed linearly, independent from limits. The higher the boarder height exceeds the limit, the higher the boiler heat flow is changed. </p>
<p>Parameter m defines the step height of heat flow within the tolerance band. The higher the number, the &QUOT;better&QUOT; the sampling rate and the higher the accuracy of the best point. </p>
<p>The table defines th efficiency graph of the boiler. Left column contains boiler heat flow. Right column contains the efficiency.</p>
<p><br>The following picture shows the work of the control. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/MaxEfficiency.png\"/></p>
<p>At simulation beginning time boiler heat flow equals zero. After exceeding lower limit (blue graph), a new boiler heat flow is changed to the best working point (green graph). The best working point is at upper limit (red graph). This heat flow keeps constant until the lower limit is reached. These procedure repeats until the highest consumer heat flow is reached. Then the demand is decreasing. The boiler heat flow exceeds the limt and a new boiler heat flow is choosen. The new best point is at upper limit. So the boiler heat flow exceeds limits. After exceeding, triggerdelay time starts. After that time, the boiler heat is changed to upper limit (at Time 5.5). After approximately Time 6.5, the storage is underloaded. So the boiler heat flow raises linearly. Then the storage is in limits again and the heat flow decreases. After Time 8.8 the store is overloaded for short time, so the boiler heat flow is reduced and raised again. </p>
</html>"));
end MaximalEfficiencyControl;
