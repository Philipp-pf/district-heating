package Modelica "Modelica Standard Library - Version 3.2.1 (Build 4)"
extends Modelica.Icons.Package;

  package Blocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

    package Continuous
    "Library of continuous control blocks with internal states"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.Package;

      block Integrator "Output the integral of the input signal"
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit="1")=1 "Integrator gain";

        /* InitialState is the default, because it was the default in Modelica 2.2
     and therefore this setting is backward compatible
  */
        parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.InitialState
        "Type of initialization (1: no init, 2: steady state, 3,4: initial output)"
                                                                                          annotation(Evaluate=true,
            Dialog(group="Initialization"));
        parameter Real y_start=0 "Initial or guess value of output (= state)"
          annotation (Dialog(group="Initialization"));
        extends Interfaces.SISO(y(start=y_start));

      initial equation
        if initType == Init.SteadyState then
           der(y) = 0;
        elseif initType == Init.InitialState or
               initType == Init.InitialOutput then
          y = y_start;
        end if;
      equation
        der(y) = k*u;
        annotation (
          Documentation(info="<html>
<p>
This blocks computes output <b>y</b> (element-wise) as
<i>integral</i> of the input <b>u</b> multiplied with
the gain <i>k</i>:
</p>
<pre>
         k
     y = - u
         s
</pre>

<p>
It might be difficult to initialize the integrator in steady state.
This is discussed in the description of package
<a href=\"modelica://Modelica.Blocks.Continuous#info\">Continuous</a>.
</p>

</html>"),       Icon(coordinateSystem(
                preserveAspectRatio=true,
                extent={{-100.0,-100.0},{100.0,100.0}},
                initialScale=0.1),
              graphics={
                Line(
                  visible=true,
                  points={{-80.0,78.0},{-80.0,-90.0}},
                  color={192,192,192}),
                Polygon(
                  visible=true,
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
                Line(
                  visible=true,
                  points={{-90.0,-80.0},{82.0,-80.0}},
                  color={192,192,192}),
                Polygon(
                  visible=true,
                  lineColor={192,192,192},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid,
                  points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
                Text(
                  visible=true,
                  lineColor={192,192,192},
                  extent={{0.0,-70.0},{60.0,-10.0}},
                  textString="I"),
                Text(
                  visible=true,
                  extent={{-150.0,-150.0},{150.0,-110.0}},
                  textString="k=%k"),
                Line(
                  visible=true,
                  points={{-80.0,-80.0},{80.0,80.0}},
                  color={0,0,127})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
              Line(points={{-100,0},{-60,0}}, color={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{-36,60},{32,2}},
                lineColor={0,0,0},
                textString="k"),
              Text(
                extent={{-32,0},{36,-58}},
                lineColor={0,0,0},
                textString="s"),
              Line(points={{-46,0},{46,0}}, color={0,0,0})}));
      end Integrator;
      annotation (
        Documentation(info="<html>
<p>
This package contains basic <b>continuous</b> input/output blocks
described by differential equations.
</p>

<p>
All blocks of this package can be initialized in different
ways controlled by parameter <b>initType</b>. The possible
values of initType are defined in
<a href=\"modelica://Modelica.Blocks.Types.Init\">Modelica.Blocks.Types.Init</a>:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>Name</b></td>
      <td valign=\"top\"><b>Description</b></td></tr>

  <tr><td valign=\"top\"><b>Init.NoInit</b></td>
      <td valign=\"top\">no initialization (start values are used as guess values with fixed=false)</td></tr>

  <tr><td valign=\"top\"><b>Init.SteadyState</b></td>
      <td valign=\"top\">steady state initialization (derivatives of states are zero)</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialState</b></td>
      <td valign=\"top\">Initialization with initial states</td></tr>

  <tr><td valign=\"top\"><b>Init.InitialOutput</b></td>
      <td valign=\"top\">Initialization with initial outputs (and steady state of the states if possible)</td></tr>
</table>

<p>
For backward compatibility reasons the default of all blocks is
<b>Init.NoInit</b>, with the exception of Integrator and LimIntegrator
where the default is <b>Init.InitialState</b> (this was the initialization
defined in version 2.2 of the Modelica standard library).
</p>

<p>
In many cases, the most useful initial condition is
<b>Init.SteadyState</b> because initial transients are then no longer
present. The drawback is that in combination with a non-linear
plant, non-linear algebraic equations occur that might be
difficult to solve if appropriate guess values for the
iteration variables are not provided (i.e., start values with fixed=false).
However, it is often already useful to just initialize
the linear blocks from the Continuous blocks library in SteadyState.
This is uncritical, because only linear algebraic equations occur.
If Init.NoInit is set, then the start values for the states are
interpreted as <b>guess</b> values and are propagated to the
states with fixed=<b>false</b>.
</p>

<p>
Note, initialization with Init.SteadyState is usually difficult
for a block that contains an integrator
(Integrator, LimIntegrator, PI, PID, LimPID).
This is due to the basic equation of an integrator:
</p>

<pre>
  <b>initial equation</b>
     <b>der</b>(y) = 0;   // Init.SteadyState
  <b>equation</b>
     <b>der</b>(y) = k*u;
</pre>

<p>
The steady state equation leads to the condition that the input to the
integrator is zero. If the input u is already (directly or indirectly) defined
by another initial condition, then the initialization problem is <b>singular</b>
(has none or infinitely many solutions). This situation occurs often
for mechanical systems, where, e.g., u = desiredSpeed - measuredSpeed and
since speed is both a state and a derivative, it is always defined by
Init.InitialState or Init.SteadyState initialization.
</p>

<p>
In such a case, <b>Init.NoInit</b> has to be selected for the integrator
and an additional initial equation has to be added to the system
to which the integrator is connected. E.g., useful initial conditions
for a 1-dim. rotational inertia controlled by a PI controller are that
<b>angle</b>, <b>speed</b>, and <b>acceleration</b> of the inertia are zero.
</p>

</html>"),     Icon(graphics={Line(
              origin={0.061,4.184},
              points={{81.939,36.056},{65.362,36.056},{14.39,-26.199},{-29.966,
                  113.485},{-65.374,-61.217},{-78.061,-78.184}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Continuous;

    package Interfaces
    "Library of connectors and partial models for input/output blocks"
      import Modelica.SIunits;
      extends Modelica.Icons.InterfacesPackage;

      connector RealInput = input Real "'input Real' as connector" annotation (
        defaultComponentName="u",
        Icon(graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})},
          coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(
          coordinateSystem(preserveAspectRatio=true,
            initialScale=0.2,
            extent={{-100.0,-100.0},{100.0,100.0}}),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={0,0,127},
            fillPattern=FillPattern.Solid,
            points={{0.0,50.0},{100.0,0.0},{0.0,-50.0},{0.0,50.0}}),
          Text(
            lineColor={0,0,127},
            extent={{-10.0,60.0},{-10.0,85.0}},
            textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Real.
</p>
</html>"));

      connector RealOutput = output Real "'output Real' as connector" annotation (
        defaultComponentName="y",
        Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{-100.0,100.0},{100.0,0.0},{-100.0,-100.0}})}),
        Diagram(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Polygon(
            lineColor={0,0,127},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid,
            points={{-100.0,50.0},{0.0,0.0},{-100.0,-50.0}}),
          Text(
            lineColor={0,0,127},
            extent={{30.0,60.0},{30.0,110.0}},
            textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Real.
</p>
</html>"));

      partial block SO "Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal.
</p>
</html>"));

      end SO;

      partial block SISO "Single Input Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealInput u "Connector of Real input signal" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real input and one continuous Real output signal.
</p>
</html>"));
      end SISO;
      annotation (Documentation(info="<HTML>
<p>
This package contains interface definitions for
<b>continuous</b> input/output blocks with Real,
Integer and Boolean signals. Furthermore, it contains
partial models for continuous and discrete blocks.
</p>

</html>",     revisions="<html>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Added several new interfaces.
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       RealInputSignal renamed to RealInput. RealOutputSignal renamed to
       output RealOutput. GraphBlock renamed to BlockIcon. SISOreal renamed to
       SISO. SOreal renamed to SO. I2SOreal renamed to M2SO.
       SignalGenerator renamed to SignalSource. Introduced the following
       new models: MIMO, MIMOs, SVcontrol, MVcontrol, DiscreteBlockIcon,
       DiscreteBlock, DiscreteSISO, DiscreteMIMO, DiscreteMIMOs,
       BooleanBlockIcon, BooleanSISO, BooleanSignalSource, MI2BooleanMOs.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
    end Interfaces;

    package Math
    "Library of Real mathematical functions as input/output blocks"
      import Modelica.SIunits;
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block Feedback "Output difference between commanded and feedback input"

        Interfaces.RealInput u1 annotation (Placement(transformation(extent={{-100,
                  -20},{-60,20}}, rotation=0)));
        Interfaces.RealInput u2 annotation (Placement(transformation(
              origin={0,-80},
              extent={{-20,-20},{20,20}},
              rotation=90)));
        Interfaces.RealOutput y annotation (Placement(transformation(extent={{80,-10},
                  {100,10}}, rotation=0)));

      equation
        y = u1 - u2;
        annotation (
          Documentation(info="<html>
<p>
This blocks computes output <b>y</b> as <i>difference</i> of the
commanded input <b>u1</b> and the feedback
input <b>u2</b>:
</p>
<pre>
    <b>y</b> = <b>u1</b> - <b>u2</b>;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   n = 2

  results in the following equations:

     y = u1 - u2
</pre>

</html>"),Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              initialScale=0.1), graphics={
              Ellipse(
                lineColor={0,0,127},
                fillColor={235,235,235},
                fillPattern=FillPattern.Solid,
                extent={{-20,-20},{20,20}}),
              Line(points={{-60,0},{-20,0}}, color={0,0,127}),
              Line(points={{20,0},{80,0}}, color={0,0,127}),
              Line(points={{0,-20},{0,-60}}, color={0,0,127}),
              Text(extent={{-14,-94},{82,0}}, textString="-"),
              Text(
                lineColor={0,0,255},
                extent={{-150,44},{150,94}},
                textString="%name")}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Ellipse(
                  extent={{-20,20},{20,-20}},
                  pattern=LinePattern.Solid,
                  lineThickness=0.25,
                  fillColor={235,235,235},
                  fillPattern=FillPattern.Solid,
                  lineColor={0,0,255}),Line(points={{-60,0},{-20,0}}, color={0,0,
                255}),Line(points={{20,0},{80,0}}, color={0,0,255}),Line(points={{0,
                -20},{0,-60}}, color={0,0,255}),Text(
                  extent={{-12,10},{84,-84}},
                  lineColor={0,0,0},
                  textString="-")}));
      end Feedback;
      annotation (Documentation(info="<html>
<p>
This package contains basic <b>mathematical operations</b>,
such as summation and multiplication, and basic <b>mathematical
functions</b>, such as <b>sqrt</b> and <b>sin</b>, as
input/output blocks. All blocks of this library can be either
connected with continuous blocks or with sampled-data blocks.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New blocks added: RealToInteger, IntegerToReal, Max, Min, Edge, BooleanChange, IntegerChange.</li>
<li><i>August 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized (partly based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist).
</li>
</ul>
</html>"),     Icon(graphics={Line(
              points={{-80,-2},{-68.7,32.2},{-61.5,51.1},{-55.1,64.4},{-49.4,72.6},
                  {-43.8,77.1},{-38.2,77.8},{-32.6,74.6},{-26.9,67.7},{-21.3,57.4},
                  {-14.9,42.1},{-6.83,19.2},{10.1,-32.8},{17.3,-52.2},{23.7,-66.2},
                  {29.3,-75.1},{35,-80.4},{40.6,-82},{46.2,-79.6},{51.9,-73.5},{
                  57.5,-63.9},{63.9,-49.2},{72,-26.8},{80,-2}},
              color={95,95,95},
              smooth=Smooth.Bezier)}));
    end Math;

    package Nonlinear
    "Library of discontinuous or non-differentiable algebraic control blocks"
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

          block Limiter "Limit the range of a signal"
            parameter Real uMax(start=1) "Upper limits of input signals";
            parameter Real uMin= -uMax "Lower limits of input signals";
            parameter Boolean strict=false
        "= true, if strict limits with noEvent(..)"
              annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
            parameter Boolean limitsAtInit=true
        "= false, if limits are ignored during initialization (i.e., y=u)"
              annotation (Evaluate=true, choices(checkBox=true), Dialog(tab="Advanced"));
            extends Interfaces.SISO;

          equation
            assert(uMax >= uMin, "Limiter: Limits must be consistent. However, uMax (=" + String(uMax) +
                                 ") < uMin (=" + String(uMin) + ")");
            if initial() and not limitsAtInit then
               y = u;
               assert(u >= uMin - 0.01*abs(uMin) and
                      u <= uMax + 0.01*abs(uMax),
                     "Limiter: During initialization the limits have been ignored.\n"+
                     "However, the result is that the input u is not within the required limits:\n"+
                     "  u = " + String(u) + ", uMin = " + String(uMin) + ", uMax = " + String(uMax));
            elseif strict then
               y = smooth(0, noEvent(if u > uMax then uMax else if u < uMin then uMin else u));
            else
               y = smooth(0,if u > uMax then uMax else if u < uMin then uMin else u);
            end if;
            annotation (
              Documentation(info="<html>
<p>
The Limiter block passes its input signal as output signal
as long as the input is within the specified upper and lower
limits. If this is not the case, the corresponding limits are passed
as output.
</p>
</html>"),           Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{0,-90},{0,68}}, color={192,192,192}),
              Polygon(
                points={{0,90},{-8,68},{8,68},{0,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                points={{90,0},{68,-8},{68,8},{90,0}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}, color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="uMax=%uMax"),
              Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
              Line(
                visible=strict,
                points={{50,70},{80,70}},
                color={255,0,0},
                smooth=Smooth.None),
              Line(
                visible=strict,
                points={{-80,-70},{-50,-70}},
                color={255,0,0},
                smooth=Smooth.None)}),
              Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{0,-60},{0,50}}, color={192,192,192}),
              Polygon(
                points={{0,60},{-5,50},{5,50},{0,60}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-60,0},{50,0}}, color={192,192,192}),
              Polygon(
                points={{60,0},{50,-5},{50,5},{60,0}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-50,-40},{-30,-40},{30,40},{50,40}}, color={0,0,0}),
              Text(
                extent={{46,-6},{68,-18}},
                lineColor={128,128,128},
                textString="u"),
              Text(
                extent={{-30,70},{-5,50}},
                lineColor={128,128,128},
                textString="y"),
              Text(
                extent={{-58,-54},{-28,-42}},
                lineColor={128,128,128},
                textString="uMin"),
              Text(
                extent={{26,40},{66,56}},
                lineColor={128,128,128},
                textString="uMax")}));
          end Limiter;
          annotation (
            Documentation(info="<html>
<p>
This package contains <b>discontinuous</b> and
<b>non-differentiable, algebraic</b> input/output blocks.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New block VariableLimiter added.
<li><i>August 22, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.
</li>
</ul>
</html>"),     Icon(graphics={Line(points={{-80,-66},{-26,-66},{28,52},{88,52}},
                color={95,95,95})}));
    end Nonlinear;

    package Sources
    "Library of signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.SourcesPackage;

      block Ramp "Generate ramp signal"
        parameter Real height=1 "Height of ramps";
        parameter Modelica.SIunits.Time duration(min=0.0, start=2)
        "Duration of ramp (= 0.0 gives a Step)";
        parameter Real offset=0 "Offset of output signal";
        parameter Modelica.SIunits.Time startTime=0
        "Output = offset for time < startTime";
        extends Interfaces.SO;

      equation
        y = offset + (if time < startTime then 0 else if time < (startTime +
          duration) then (time - startTime)*height/duration else height);
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(points={{-80,68},{-80,-80}}, color={192,192,192}),
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-90,-70},{82,-70}}, color={192,192,192}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{-40,-70},{31,38}}, color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="duration=%duration"),
              Line(points={{31,38},{86,38}}, color={0,0,0})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-86,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(
                points={{-80,-20},{-20,-20},{50,50}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-40,-20},{-42,-30},{-38,-30},{-40,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(
                points={{-40,-20},{-40,-70}},
                color={95,95,95},
                thickness=0.25,
                arrow={Arrow.None,Arrow.None}),
              Polygon(
                points={{-40,-70},{-42,-60},{-38,-60},{-40,-70},{-40,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,-39},{-34,-50}},
                lineColor={0,0,0},
                textString="offset"),
              Text(
                extent={{-38,-72},{6,-83}},
                lineColor={0,0,0},
                textString="startTime"),
              Text(
                extent={{-78,92},{-37,72}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{70,-80},{94,-91}},
                lineColor={0,0,0},
                textString="time"),
              Line(points={{-20,-20},{-20,-70}}, color={95,95,95}),
              Line(
                points={{-19,-20},{50,-20}},
                color={95,95,95},
                thickness=0.25,
                arrow={Arrow.None,Arrow.None}),
              Line(
                points={{50,50},{101,50}},
                color={0,0,255},
                thickness=0.5),
              Line(
                points={{50,50},{50,-20}},
                color={95,95,95},
                thickness=0.25,
                arrow={Arrow.None,Arrow.None}),
              Polygon(
                points={{50,-20},{42,-18},{42,-22},{50,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-20,-20},{-11,-18},{-11,-22},{-20,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{50,50},{48,40},{52,40},{50,50}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{50,-20},{48,-10},{52,-10},{50,-20},{50,-20}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{53,23},{82,10}},
                lineColor={0,0,0},
                textString="height"),
              Text(
                extent={{-2,-21},{37,-33}},
                lineColor={0,0,0},
                textString="duration")}),
          Documentation(info="<html>
<p>
The Real output y is a ramp signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Ramp.png\"
     alt=\"Ramp.png\">
</p>

<p>
If parameter duration is set to 0.0, the limiting case of a Step signal is achieved.
</p>
</html>"));
      end Ramp;
      annotation (Documentation(info="<HTML>
<p>
This package contains <b>source</b> components, i.e., blocks which
have only output signals. These blocks are used as signal generators
for Real, Integer and Boolean signals.
</p>

<p>
All Real source signals (with the exception of the Constant source)
have at least the following two parameters:
</p>

<table border=1 cellspacing=0 cellpadding=2>
  <tr><td valign=\"top\"><b>offset</b></td>
      <td valign=\"top\">Value which is added to the signal</td>
  </tr>
  <tr><td valign=\"top\"><b>startTime</b></td>
      <td valign=\"top\">Start time of signal. For time &lt; startTime,
                the output y is set to offset.</td>
  </tr>
</table>

<p>
The <b>offset</b> parameter is especially useful in order to shift
the corresponding source, such that at initial time the system
is stationary. To determine the corresponding value of offset,
usually requires a trimming calculation.
</p>
</html>",     revisions="<html>
<ul>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Integer sources added. Step, TimeTable and BooleanStep slightly changed.</li>
<li><i>Nov. 8, 1999</i>
       by <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       New sources: Exponentials, TimeTable. Trapezoid slightly enhanced
       (nperiod=-1 is an infinite number of periods).</li>
<li><i>Oct. 31, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       <a href=\"mailto:clauss@eas.iis.fhg.de\">Christoph Clau&szlig;</a>,
       <a href=\"mailto:Andre.Schneider@eas.iis.fraunhofer.de\">Andre.Schneider@eas.iis.fraunhofer.de</a>,
       All sources vectorized. New sources: ExpSine, Trapezoid,
       BooleanConstant, BooleanStep, BooleanPulse, SampleTrigger.
       Improved documentation, especially detailed description of
       signals in diagram layer.</li>
<li><i>June 29, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
    end Sources;

    package Types
    "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.TypesPackage;

      type Init = enumeration(
        NoInit
          "No initialization (start values are used as guess values with fixed=false)",

        SteadyState
          "Steady state initialization (derivatives of states are zero)",
        InitialState "Initialization with initial states",
        InitialOutput
          "Initialization with initial outputs (and steady state of the states if possible)")
      "Enumeration defining initialization of a block"   annotation (Evaluate=true,
        Documentation(info="<html>
  <p>The following initialization alternatives are available:</p>
  <dl>
    <dt><code><strong>NoInit</strong></code></dt>
      <dd>No initialization (start values are used as guess values with <code>fixed=false</code>)</dd>
    <dt><code><strong>SteadyState</strong></code></dt>
      <dd>Steady state initialization (derivatives of states are zero)</dd>
    <dt><code><strong>InitialState</strong></code></dt>
      <dd>Initialization with initial states</dd>
    <dt><code><strong>InitialOutput</strong></code></dt>
      <dd>Initialization with initial outputs (and steady state of the states if possible)</dd>
  </dl>
</html>"));
      annotation (Documentation(info="<HTML>
<p>
In this package <b>types</b>, <b>constants</b> and <b>external objects</b> are defined that are used
in library Modelica.Blocks. The types have additional annotation choices
definitions that define the menus to be built up in the graphical
user interface when the type is used as parameter in a declaration.
</p>
</HTML>"));
    end Types;

    package Icons "Icons for Blocks"
        extends Modelica.Icons.IconsPackage;

        partial block Block "Basic graphical layout of input/output block"

          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                extent={{-100,-100},{100,100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255})}),
          Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output
block (no declarations, no equations). Most blocks
of package Modelica.Blocks inherit directly or indirectly
from this block.
</p>
</html>"));

        end Block;
    end Icons;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100.0,-100.0},{100.0,100.0}}, initialScale=0.1), graphics={
        Rectangle(
          origin={0.0,35.1488},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Rectangle(
          origin={0.0,-34.8512},
          fillColor={255,255,255},
          extent={{-30.0,-20.1488},{30.0,20.1488}}),
        Line(
          origin={-51.25,0.0},
          points={{21.25,-35.0},{-13.75,-35.0},{-13.75,35.0},{6.25,35.0}}),
        Polygon(
          origin={-40.0,35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{10.0,0.0},{-5.0,5.0},{-5.0,-5.0}}),
        Line(
          origin={51.25,0.0},
          points={{-21.25,35.0},{13.75,35.0},{13.75,-35.0},{-6.25,-35.0}}),
        Polygon(
          origin={40.0,-35.0},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.0,0.0},{5.0,5.0},{5.0,-5.0}})}), Documentation(info="<html>
<p>
This library contains input/output blocks to build up block diagrams.
</p>

<dl>
<dt><b>Main Author:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    email: <A HREF=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</A><br>
</dl>
<p>
Copyright &copy; 1998-2015, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>June 23, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Introduced new block connectors and adapted all blocks to the new connectors.
       Included subpackages Continuous, Discrete, Logical, Nonlinear from
       package ModelicaAdditions.Blocks.
       Included subpackage ModelicaAdditions.Table in Modelica.Blocks.Sources
       and in the new package Modelica.Blocks.Tables.
       Added new blocks to Blocks.Sources and Blocks.Logical.
       </li>
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       New subpackage Examples, additional components.
       </li>
<li><i>June 20, 2000</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
       Michael Tiller:<br>
       Introduced a replaceable signal type into
       Blocks.Interfaces.RealInput/RealOutput:
<pre>
   replaceable type SignalType = Real
</pre>
       in order that the type of the signal of an input/output block
       can be changed to a physical type, for example:
<pre>
   Sine sin1(outPort(redeclare type SignalType=Modelica.SIunits.Torque))
</pre>
      </li>
<li><i>Sept. 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Renamed to Blocks. New subpackages Math, Nonlinear.
       Additional components in subpackages Interfaces, Continuous
       and Sources. </li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized a first version, based on an existing Dymola library
       of Dieter Moormann and Hilding Elmqvist.</li>
</ul>
</html>"));
  end Blocks;

  package Thermal
  "Library of thermal system components to model heat transfer and simple thermo-fluid pipe flow"
    extends Modelica.Icons.Package;

    package HeatTransfer
    "Library of 1-dimensional heat transfer with lumped elements"
      extends Modelica.Icons.Package;

      package Sensors "Thermal sensors"
        extends Modelica.Icons.SensorsPackage;

        model HeatFlowSensor "Heat flow rate sensor"
          extends Modelica.Icons.RotationalSensor;
          Modelica.Blocks.Interfaces.RealOutput Q_flow(unit="W")
          "Heat flow from port_a to port_b as output signal"   annotation (Placement(
                transformation(
                origin={0,-100},
                extent={{-10,-10},{10,10}},
                rotation=270)));
          Interfaces.HeatPort_a port_a annotation (Placement(transformation(extent={{
                    -110,-10},{-90,10}}, rotation=0)));
          Interfaces.HeatPort_b port_b annotation (Placement(transformation(extent={{
                    90,-10},{110,10}}, rotation=0)));
        equation
          port_a.T = port_b.T;
          port_a.Q_flow + port_b.Q_flow = 0;
          Q_flow = port_a.Q_flow;
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Line(points={{-70,0},{-95,0}}, color={191,0,0}),
                Line(points={{0,-70},{0,-90}}, color={0,0,127}),
                Line(points={{94,0},{69,0}}, color={191,0,0})}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Text(
                  extent={{5,-86},{116,-110}},
                  lineColor={0,0,0},
                  textString="Q_flow"),
                Line(points={{-70,0},{-90,0}}, color={191,0,0}),
                Line(points={{69,0},{90,0}}, color={191,0,0}),
                Line(points={{0,-70},{0,-90}}, color={0,0,127}),
                Text(
                  extent={{-150,125},{150,85}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Documentation(info="<HTML>
<p>
This model is capable of monitoring the heat flow rate flowing through
this component. The sensed value of heat flow rate is the amount that
passes through this sensor while keeping the temperature drop across the
sensor zero.  This is an ideal model so it does not absorb any energy
and it has no direct effect on the thermal response of a system it is included in.
The output signal is positive, if the heat flows from port_a to port_b.
</p>
</html>"));
        end HeatFlowSensor;
        annotation (   Documentation(info="<html>

</html>"));
      end Sensors;

      package Sources "Thermal sources"
      extends Modelica.Icons.SourcesPackage;

        model FixedTemperature "Fixed temperature boundary condition in Kelvin"

          parameter Modelica.SIunits.Temperature T "Fixed temperature at port";
          Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                    -10},{110,10}}, rotation=0)));
        equation
          port.T = T;
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255}),
                Text(
                  extent={{-150,-110},{150,-140}},
                  lineColor={0,0,0},
                  textString="T=%T"),
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillColor={159,159,223},
                  fillPattern=FillPattern.Backward),
                Text(
                  extent={{0,0},{-100,-100}},
                  lineColor={0,0,0},
                  textString="K"),
                Line(
                  points={{-52,0},{56,0}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{50,-20},{50,20},{90,0},{50,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<HTML>
<p>
This model defines a fixed temperature T at its port in Kelvin,
i.e., it defines a fixed temperature as a boundary condition.
</p>
</html>"),         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Rectangle(
                  extent={{-100,100},{100,-101}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillColor={159,159,223},
                  fillPattern=FillPattern.Backward),
                Line(
                  points={{-52,0},{56,0}},
                  color={191,0,0},
                  thickness=0.5),
                Text(
                  extent={{0,0},{-100,-100}},
                  lineColor={0,0,0},
                  textString="K"),
                Polygon(
                  points={{52,-20},{52,20},{90,0},{52,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}));
        end FixedTemperature;

        model PrescribedHeatFlow "Prescribed heat flow boundary condition"
          parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature";
          parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of heat flow rate";
          Modelica.Blocks.Interfaces.RealInput Q_flow(unit="W")
                annotation (Placement(transformation(
                origin={-100,0},
                extent={{20,-20},{-20,20}},
                rotation=180)));
          Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                    -10},{110,10}}, rotation=0)));
        equation
          port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Line(
                  points={{-60,-20},{40,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-60,20},{40,20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-80,0},{-60,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-80,0},{-60,20}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{40,0},{40,40},{70,20},{40,0}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{40,-40},{40,0},{70,-20},{40,-40}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{70,40},{90,-40}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Documentation(info="<HTML>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The amount of heat
is given by the input signal Q_flow into the model. The heat flows into the
component to which the component PrescribedHeatFlow is connected,
if the input signal is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"),         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={
                Line(
                  points={{-60,-20},{68,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-60,20},{68,20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-80,0},{-60,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-80,0},{-60,20}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{60,0},{60,40},{90,20},{60,0}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{60,-40},{60,0},{90,-20},{60,-40}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}));
        end PrescribedHeatFlow;
        annotation (   Documentation(info="<html>

</html>"));
      end Sources;

      package Interfaces "Connectors and partial models"
        extends Modelica.Icons.InterfacesPackage;

        partial connector HeatPort "Thermal port for 1-dim. heat transfer"
          Modelica.SIunits.Temperature T "Port temperature";
          flow Modelica.SIunits.HeatFlowRate Q_flow
          "Heat flow rate (positive if flowing from outside into the component)";
          annotation (Documentation(info="<html>

</html>"));
        end HeatPort;

        connector HeatPort_a
        "Thermal port for 1-dim. heat transfer (filled rectangular icon)"

          extends HeatPort;

          annotation(defaultComponentName = "port_a",
            Documentation(info="<HTML>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <b>positive</b> heat flow
rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <b>HeatPort_a</b> and
<b>HeatPort_b</b> are identical with the only exception of the different
<b>icon layout</b>.</p></html>"),         Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                  extent={{-50,50},{50,-50}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-120,120},{100,60}},
                  lineColor={191,0,0},
                  textString="%name")}));
        end HeatPort_a;

        connector HeatPort_b
        "Thermal port for 1-dim. heat transfer (unfilled rectangular icon)"

          extends HeatPort;

          annotation(defaultComponentName = "port_b",
            Documentation(info="<HTML>
<p>This connector is used for 1-dimensional heat flow between components.
The variables in the connector are:</p>
<pre>
   T       Temperature in [Kelvin].
   Q_flow  Heat flow rate in [Watt].
</pre>
<p>According to the Modelica sign convention, a <b>positive</b> heat flow
rate <b>Q_flow</b> is considered to flow <b>into</b> a component. This
convention has to be used whenever this connector is used in a model
class.</p>
<p>Note, that the two connector classes <b>HeatPort_a</b> and
<b>HeatPort_b</b> are identical with the only exception of the different
<b>icon layout</b>.</p></html>"),         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={Rectangle(
                  extent={{-50,50},{50,-50}},
                  lineColor={191,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid), Text(
                  extent={{-100,120},{120,60}},
                  lineColor={191,0,0},
                  textString="%name")}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={191,0,0},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid)}));
        end HeatPort_b;
        annotation (                               Documentation(info="<html>

</html>"));
      end Interfaces;
      annotation (
         Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
          Polygon(
            origin=  {13.758,27.517},
            lineColor=  {128,128,128},
            fillColor=  {192,192,192},
            fillPattern=  FillPattern.Solid,
            points=  {{-54,-6},{-61,-7},{-75,-15},{-79,-24},{-80,-34},{-78,-42},{-73,-49},{-64,-51},{-57,-51},{-47,-50},{-41,-43},{-38,-35},{-40,-27},{-40,-20},{-42,-13},{-47,-7},{-54,-5},{-54,-6}}),
        Polygon(
            origin=  {13.758,27.517},
            fillColor=  {160,160,164},
            fillPattern=  FillPattern.Solid,
            points=  {{-75,-15},{-79,-25},{-80,-34},{-78,-42},{-72,-49},{-64,-51},{-57,-51},{-47,-50},{-57,-47},{-65,-45},{-71,-40},{-74,-33},{-76,-23},{-75,-15},{-75,-15}}),
          Polygon(
            origin=  {13.758,27.517},
            lineColor=  {160,160,164},
            fillColor=  {192,192,192},
            fillPattern=  FillPattern.Solid,
            points=  {{39,-6},{32,-7},{18,-15},{14,-24},{13,-34},{15,-42},{20,-49},{29,-51},{36,-51},{46,-50},{52,-43},{55,-35},{53,-27},{53,-20},{51,-13},{46,-7},{39,-5},{39,-6}}),
          Polygon(
            origin=  {13.758,27.517},
            fillColor=  {160,160,164},
            fillPattern=  FillPattern.Solid,
            points=  {{18,-15},{14,-25},{13,-34},{15,-42},{21,-49},{29,-51},{36,-51},{46,-50},{36,-47},{28,-45},{22,-40},{19,-33},{17,-23},{18,-15},{18,-15}}),
          Polygon(
            origin=  {13.758,27.517},
            lineColor=  {191,0,0},
            fillColor=  {191,0,0},
            fillPattern=  FillPattern.Solid,
            points=  {{-9,-23},{-9,-10},{18,-17},{-9,-23}}),
          Line(
            origin=  {13.758,27.517},
            points=  {{-41,-17},{-9,-17}},
            color=  {191,0,0},
            thickness=  0.5),
          Line(
            origin=  {13.758,27.517},
            points=  {{-17,-40},{15,-40}},
            color=  {191,0,0},
            thickness=  0.5),
          Polygon(
            origin=  {13.758,27.517},
            lineColor=  {191,0,0},
            fillColor=  {191,0,0},
            fillPattern=  FillPattern.Solid,
            points=  {{-17,-46},{-17,-34},{-40,-40},{-17,-46}})}),
                                Documentation(info="<HTML>
<p>
This package contains components to model <b>1-dimensional heat transfer</b>
with lumped elements. This allows especially to model heat transfer in
machines provided the parameters of the lumped elements, such as
the heat capacity of a part, can be determined by measurements
(due to the complex geometries and many materials used in machines,
calculating the lumped element parameters from some basic analytic
formulas is usually not possible).
</p>
<p>
Example models how to use this library are given in subpackage <b>Examples</b>.<br>
For a first simple example, see <b>Examples.TwoMasses</b> where two masses
with different initial temperatures are getting in contact to each
other and arriving after some time at a common temperature.<br>
<b>Examples.ControlledTemperature</b> shows how to hold a temperature
within desired limits by switching on and off an electric resistor.<br>
A more realistic example is provided in <b>Examples.Motor</b> where the
heating of an electrical motor is modelled, see the following screen shot
of this example:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Thermal/HeatTransfer/driveWithHeatTransfer.png\" ALT=\"driveWithHeatTransfer\">
</p>

<p>
The <b>filled</b> and <b>non-filled red squares</b> at the left and
right side of a component represent <b>thermal ports</b> (connector HeatPort).
Drawing a line between such squares means that they are thermally connected.
The variables of a HeatPort connector are the temperature <b>T</b> at the port
and the heat flow rate <b>Q_flow</b> flowing into the component (if Q_flow is positive,
the heat flows into the element, otherwise it flows out of the element):
</p>
<pre>   Modelica.SIunits.Temperature  T  \"absolute temperature at port in Kelvin\";
   Modelica.SIunits.HeatFlowRate Q_flow  \"flow rate at the port in Watt\";
</pre>
<p>
Note, that all temperatures of this package, including initial conditions,
are given in Kelvin. For convenience, in subpackages <b>HeatTransfer.Celsius</b>,
 <b>HeatTransfer.Fahrenheit</b> and <b>HeatTransfer.Rankine</b> components are provided such that source and
sensor information is available in degree Celsius, degree Fahrenheit, or degree Rankine,
respectively. Additionally, in package <b>SIunits.Conversions</b> conversion
functions between the units Kelvin and Celsius, Fahrenheit, Rankine are
provided. These functions may be used in the following way:
</p>
<pre>  <b>import</b> SI=Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature T = from_degC(25);  // convert 25 degree Celsius to Kelvin
</pre>

<p>
There are several other components available, such as AxialConduction (discretized PDE in
axial direction), which have been temporarily removed from this library. The reason is that
these components reference material properties, such as thermal conductivity, and currently
the Modelica design group is discussing a general scheme to describe material properties.
</p>
<p>
For technical details in the design of this library, see the following reference:<br>
<b>Michael Tiller (2001)</b>: <a href=\"http://www.amazon.de\">
Introduction to Physical Modeling with Modelica</a>.
Kluwer Academic Publishers Boston.
</p>
<p>
<b>Acknowledgements:</b><br>
Several helpful remarks from the following persons are acknowledged:
John Batteh, Ford Motors, Dearborn, U.S.A;
<a href=\"http://www.haumer.at/\">Anton Haumer</a>, Technical Consulting &amp; Electrical Engineering, Austria;
Ludwig Marvan, VA TECH ELIN EBG Elektronik GmbH, Wien, Austria;
Hans Olsson, Dassault Syst&egrave;mes AB, Sweden;
Hubertus Tummescheit, Lund Institute of Technology, Lund, Sweden.
</p>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
  </dd>
</dl>
<p><b>Copyright &copy; 2001-2015, Modelica Association, Michael Tiller and DLR.</b></p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",     revisions="<html>
<ul>
<li><i>July 15, 2002</i>
       by Michael Tiller, <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and Nikolaus Sch&uuml;rmann:<br>
       Implemented.
</li>
<li><i>June 13, 2005</i>
       by <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
       Refined placing of connectors (cosmetic).<br>
       Refined all Examples; removed Examples.FrequencyInverter, introducing Examples.Motor<br>
       Introduced temperature dependent correction (1 + alpha*(T - T_ref)) in Fixed/PrescribedHeatFlow<br>
</li>
  <li> v1.1.1 2007/11/13 Anton Haumer<br>
       components moved to sub-packages</li>
  <li> v1.2.0 2009/08/26 Anton Haumer<br>
       added component ThermalCollector</li>

</ul>
</html>"));
    end HeatTransfer;
    annotation (
     Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Line(
      origin={-47.5,11.6667},
      points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
        smooth=Smooth.Bezier),
      Polygon(
      origin={-50.0,68.333},
      pattern=LinePattern.None,
      fillPattern=FillPattern.Solid,
        points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}),
      Line(
      origin={2.5,11.6667},
      points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
        smooth=Smooth.Bezier),
      Polygon(
      origin={0.0,68.333},
      pattern=LinePattern.None,
      fillPattern=FillPattern.Solid,
        points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}}),
      Line(
      origin={52.5,11.6667},
      points={{-2.5,-91.6667},{17.5,-71.6667},{-22.5,-51.6667},{17.5,-31.6667},{-22.5,-11.667},{17.5,8.3333},{-2.5,28.3333},{-2.5,48.3333}},
        smooth=Smooth.Bezier),
      Polygon(
      origin={50.0,68.333},
      pattern=LinePattern.None,
      fillPattern=FillPattern.Solid,
        points={{0.0,21.667},{-10.0,-8.333},{10.0,-8.333}})}),
      Documentation(info="<html>
<p>
This package contains libraries to model heat transfer
and fluid heat flow.
</p>
</html>"));
  end Thermal;

  package Icons "Library of icons"
    extends Icons.Package;

    partial package ExamplesPackage
    "Icon for packages containing runnable examples"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(
              origin={8.0,14.0},
              lineColor={78,138,73},
              fillColor={78,138,73},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-58.0,46.0},{42.0,-14.0},{-58.0,-74.0},{-58.0,46.0}})}), Documentation(info="<html>
<p>This icon indicates a package that contains executable examples.</p>
</html>"));
    end ExamplesPackage;

    partial model Example "Icon for runnable examples"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(lineColor = {75,138,73},
                    fillColor={255,255,255},
                    fillPattern = FillPattern.Solid,
                    extent = {{-100,-100},{100,100}}),
            Polygon(lineColor = {0,0,255},
                    fillColor = {75,138,73},
                    pattern = LinePattern.None,
                    fillPattern = FillPattern.Solid,
                    points = {{-36,60},{64,0},{-36,-60},{-36,60}})}), Documentation(info="<html>
<p>This icon indicates an example. The play button suggests that the example can be executed.</p>
</html>"));
    end Example;

    partial package Package "Icon for standard packages"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Rectangle(
              lineColor={200,200,200},
              fillColor={248,248,248},
              fillPattern=FillPattern.HorizontalCylinder,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0),
            Rectangle(
              lineColor={128,128,128},
              fillPattern=FillPattern.None,
              extent={{-100.0,-100.0},{100.0,100.0}},
              radius=25.0)}),   Documentation(info="<html>
<p>Standard package icon.</p>
</html>"));
    end Package;

    partial package InterfacesPackage "Icon for packages containing interfaces"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(origin={20.0,0.0},
              lineColor={64,64,64},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid,
              points={{-10.0,70.0},{10.0,70.0},{40.0,20.0},{80.0,20.0},{80.0,-20.0},{40.0,-20.0},{10.0,-70.0},{-10.0,-70.0}}),
            Polygon(fillColor={102,102,102},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-100.0,20.0},{-60.0,20.0},{-30.0,70.0},{-10.0,70.0},{-10.0,-70.0},{-30.0,-70.0},{-60.0,-20.0},{-100.0,-20.0}})}),
                                Documentation(info="<html>
<p>This icon indicates packages containing interfaces.</p>
</html>"));
    end InterfacesPackage;

    partial package SourcesPackage "Icon for packages containing sources"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Polygon(origin={23.3333,0.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-23.333,30.0},{46.667,0.0},{-23.333,-30.0}}),
            Rectangle(
              fillColor=  {128,128,128},
              pattern=  LinePattern.None,
              fillPattern=  FillPattern.Solid,
              extent=  {{-70,-4.5},{0,4.5}})}),
                                Documentation(info="<html>
<p>This icon indicates a package which contains sources.</p>
</html>"));
    end SourcesPackage;

    partial package SensorsPackage "Icon for packages containing sensors"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(origin={0.0,-30.0},
              fillColor={255,255,255},
              extent={{-90.0,-90.0},{90.0,90.0}},
              startAngle=20.0,
              endAngle=160.0),
            Ellipse(origin={0.0,-30.0},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-20.0,-20.0},{20.0,20.0}}),
            Line(origin={0.0,-30.0},
              points={{0.0,60.0},{0.0,90.0}}),
            Ellipse(origin={-0.0,-30.0},
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-10.0,-10.0},{10.0,10.0}}),
            Polygon(
              origin={-0.0,-30.0},
              rotation=-35.0,
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-7.0,0.0},{-3.0,85.0},{0.0,90.0},{3.0,85.0},{7.0,0.0}})}),
                                Documentation(info="<html>
<p>This icon indicates a package containing sensors.</p>
</html>"));
    end SensorsPackage;

    partial package TypesPackage
    "Icon for packages containing type definitions"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-12.167,-23},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{12.167,65},{14.167,93},{36.167,89},{24.167,20},{4.167,-30},
                  {14.167,-30},{24.167,-30},{24.167,-40},{-5.833,-50},{-15.833,
                  -30},{4.167,20},{12.167,65}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Polygon(
              origin={2.7403,1.6673},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{49.2597,22.3327},{31.2597,24.3327},{7.2597,18.3327},{-26.7403,
                10.3327},{-46.7403,14.3327},{-48.7403,6.3327},{-32.7403,0.3327},{-6.7403,
                4.3327},{33.2597,14.3327},{49.2597,14.3327},{49.2597,22.3327}},
              smooth=Smooth.Bezier)}));
    end TypesPackage;

    partial package IconsPackage "Icon for packages containing icons"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-8.167,-17},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                  4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                  -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Ellipse(
              origin={-0.5,56.5},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-12.5,-12.5},{12.5,12.5}},
              lineColor={0,0,0})}));
    end IconsPackage;

    partial class RotationalSensor
    "Icon representing a round measurement device"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Ellipse(
              fillColor={245,245,245},
              fillPattern=FillPattern.Solid,
              extent={{-70.0,-70.0},{70.0,70.0}}),
            Line(points={{0.0,70.0},{0.0,40.0}}),
            Line(points={{22.9,32.8},{40.2,57.3}}),
            Line(points={{-22.9,32.8},{-40.2,57.3}}),
            Line(points={{37.6,13.7},{65.8,23.9}}),
            Line(points={{-37.6,13.7},{-65.8,23.9}}),
            Ellipse(
              lineColor={64,64,64},
              fillColor={255,255,255},
              extent={{-12.0,-12.0},{12.0,12.0}}),
            Polygon(
              origin={0,0},
              rotation=-17.5,
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-5.0,0.0},{-2.0,60.0},{0.0,65.0},{2.0,60.0},{5.0,0.0}}),
            Ellipse(
              fillColor={64,64,64},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-7.0,-7.0},{7.0,7.0}})}),
        Documentation(info="<html>
<p>
This icon is designed for a <b>rotational sensor</b> model.
</p>
</html>"));
    end RotationalSensor;
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={Polygon(
              origin={-8.167,-17},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              points={{-15.833,20.0},{-15.833,30.0},{14.167,40.0},{24.167,20.0},{
                  4.167,-30.0},{14.167,-30.0},{24.167,-30.0},{24.167,-40.0},{-5.833,
                  -50.0},{-15.833,-30.0},{4.167,20.0},{-5.833,20.0}},
              smooth=Smooth.Bezier,
              lineColor={0,0,0}), Ellipse(
              origin={-0.5,56.5},
              fillColor={128,128,128},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Solid,
              extent={{-12.5,-12.5},{12.5,12.5}},
              lineColor={0,0,0})}), Documentation(info="<html>
<p>This package contains definitions for the graphical layout of components which may be used in different libraries. The icons can be utilized by inheriting them in the desired class using &quot;extends&quot; or by directly copying the &quot;icon&quot; layer. </p>

<h4>Main Authors:</h4>

<dl>
<dt><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a></dt>
    <dd>Deutsches Zentrum fuer Luft und Raumfahrt e.V. (DLR)</dd>
    <dd>Oberpfaffenhofen</dd>
    <dd>Postfach 1116</dd>
    <dd>D-82230 Wessling</dd>
    <dd>email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
<dt>Christian Kral</dt>
    <dd><a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a></dd>
    <dd>1060 Vienna, Austria</dd>
    <dd>email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a></dd>
<dt>Johan Andreasson</dt>
    <dd><a href=\"http://www.modelon.se/\">Modelon AB</a></dd>
    <dd>Ideon Science Park</dd>
    <dd>22370 Lund, Sweden</dd>
    <dd>email: <a href=\"mailto:johan.andreasson@modelon.se\">johan.andreasson@modelon.se</a></dd>
</dl>

<p>Copyright &copy; 1998-2015, Modelica Association, DLR, AIT, and Modelon AB. </p>
<p><i>This Modelica package is <b>free</b> software; it can be redistributed and/or modified under the terms of the <b>Modelica license</b>, see the license conditions and the accompanying <b>disclaimer</b> in <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a>.</i> </p>
</html>"));
  end Icons;

  package SIunits
  "Library of type and unit definitions based on SI units according to ISO 31-1992"
    extends Modelica.Icons.Package;

    type Time = Real (final quantity="Time", final unit="s");

    type ThermodynamicTemperature = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K",
        min = 0.0,
        start = 288.15,
        nominal = 300,
        displayUnit="degC")
    "Absolute temperature (use type TemperatureDifference for relative temperatures)"
                                                                                                        annotation(absoluteValue=true);

    type Temperature = ThermodynamicTemperature;

    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit="1/K");

    type Heat = Real (final quantity="Energy", final unit="J");

    type HeatFlowRate = Real (final quantity="Power", final unit="W");
    annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
              -100},{100,100}}), graphics={
          Line(
            points={{-66,78},{-66,-40}},
            color={64,64,64},
            smooth=Smooth.None),
          Ellipse(
            extent={{12,36},{68,-38}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Rectangle(
            extent={{-74,78},{-66,-40}},
            lineColor={64,64,64},
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-66,-4},{-66,6},{-16,56},{-16,46},{-66,-4}},
            lineColor={64,64,64},
            smooth=Smooth.None,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{-46,16},{-40,22},{-2,-40},{-10,-40},{-46,16}},
            lineColor={64,64,64},
            smooth=Smooth.None,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid),
          Ellipse(
            extent={{22,26},{58,-28}},
            lineColor={64,64,64},
            fillColor={255,255,255},
            fillPattern=FillPattern.Solid),
          Polygon(
            points={{68,2},{68,-46},{64,-60},{58,-68},{48,-72},{18,-72},{18,-64},
                {46,-64},{54,-60},{58,-54},{60,-46},{60,-26},{64,-20},{68,-6},{68,
                2}},
            lineColor={64,64,64},
            smooth=Smooth.Bezier,
            fillColor={175,175,175},
            fillPattern=FillPattern.Solid)}), Documentation(info="<html>
<p>This package provides predefined types, such as <i>Mass</i>,
<i>Angle</i>, <i>Time</i>, based on the international standard
on units, e.g.,
</p>

<pre>   <b>type</b> Angle = Real(<b>final</b> quantity = \"Angle\",
                     <b>final</b> unit     = \"rad\",
                     displayUnit    = \"deg\");
</pre>

<p>
as well as conversion functions from non SI-units to SI-units
and vice versa in subpackage
<a href=\"modelica://Modelica.SIunits.Conversions\">Conversions</a>.
</p>

<p>
For an introduction how units are used in the Modelica standard library
with package SIunits, have a look at:
<a href=\"modelica://Modelica.SIunits.UsersGuide.HowToUseSIunits\">How to use SIunits</a>.
</p>

<p>
Copyright &copy; 1998-2015, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>May 25, 2011</i> by Stefan Wischhusen:<br/>Added molar units for energy and enthalpy.</li>
<li><i>Jan. 27, 2010</i> by Christian Kral:<br/>Added complex units.</li>
<li><i>Dec. 14, 2005</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Add User&#39;;s Guide and removed &quot;min&quot; values for Resistance and Conductance.</li>
<li><i>October 21, 2002</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br/>Added new package <b>Conversions</b>. Corrected typo <i>Wavelenght</i>.</li>
<li><i>June 6, 2000</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Introduced the following new types<br/>type Temperature = ThermodynamicTemperature;<br/>types DerDensityByEnthalpy, DerDensityByPressure, DerDensityByTemperature, DerEnthalpyByPressure, DerEnergyByDensity, DerEnergyByPressure<br/>Attribute &quot;final&quot; removed from min and max values in order that these values can still be changed to narrow the allowed range of values.<br/>Quantity=&quot;Stress&quot; removed from type &quot;Stress&quot;, in order that a type &quot;Stress&quot; can be connected to a type &quot;Pressure&quot;.</li>
<li><i>Oct. 27, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>New types due to electrical library: Transconductance, InversePotential, Damping.</li>
<li><i>Sept. 18, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Renamed from SIunit to SIunits. Subpackages expanded, i.e., the SIunits package, does no longer contain subpackages.</li>
<li><i>Aug 12, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Type &quot;Pressure&quot; renamed to &quot;AbsolutePressure&quot; and introduced a new type &quot;Pressure&quot; which does not contain a minimum of zero in order to allow convenient handling of relative pressure. Redefined BulkModulus as an alias to AbsolutePressure instead of Stress, since needed in hydraulics.</li>
<li><i>June 29, 1999</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br/>Bug-fix: Double definition of &quot;Compressibility&quot; removed and appropriate &quot;extends Heat&quot; clause introduced in package SolidStatePhysics to incorporate ThermodynamicTemperature.</li>
<li><i>April 8, 1998</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and Astrid Jaschinski:<br/>Complete ISO 31 chapters realized.</li>
<li><i>Nov. 15, 1997</i> by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and <a href=\"http://www.control.lth.se/~hubertus/\">Hubertus Tummescheit</a>:<br/>Some chapters realized.</li>
</ul>
</html>"));
  end SIunits;
annotation (
preferredView="info",
version="3.2.1",
versionBuild=4,
versionDate="2013-08-14",
dateModified = "2015-09-30 09:15:00Z",
revisionId="$Id:: package.mo 8512 2015-09-30 14:11:39Z #$",
uses(Complex(version="3.2.1"), ModelicaServices(version="3.2.1")),
conversion(
 noneFromVersion="3.2",
 noneFromVersion="3.1",
 noneFromVersion="3.0.1",
 noneFromVersion="3.0",
 from(version="2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.1", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos"),
 from(version="2.2.2", script="modelica://Modelica/Resources/Scripts/Dymola/ConvertModelica_from_2.2.2_to_3.0.mos")),
Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
  Polygon(
    origin={-6.9888,20.048},
    fillColor={0,0,0},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    points={{-93.0112,10.3188},{-93.0112,10.3188},{-73.011,24.6},{-63.011,31.221},{-51.219,36.777},{-39.842,38.629},{-31.376,36.248},{-25.819,29.369},{-24.232,22.49},{-23.703,17.463},{-15.501,25.135},{-6.24,32.015},{3.02,36.777},{15.191,39.423},{27.097,37.306},{32.653,29.633},{35.035,20.108},{43.501,28.046},{54.085,35.19},{65.991,39.952},{77.897,39.688},{87.422,33.338},{91.126,21.696},{90.068,9.525},{86.099,-1.058},{79.749,-10.054},{71.283,-21.431},{62.816,-33.337},{60.964,-32.808},{70.489,-16.14},{77.368,-2.381},{81.072,10.054},{79.749,19.05},{72.605,24.342},{61.758,23.019},{49.587,14.817},{39.003,4.763},{29.214,-6.085},{21.012,-16.669},{13.339,-26.458},{5.401,-36.777},{-1.213,-46.037},{-6.24,-53.446},{-8.092,-52.387},{-0.684,-40.746},{5.401,-30.692},{12.81,-17.198},{19.424,-3.969},{23.658,7.938},{22.335,18.785},{16.514,23.283},{8.047,23.019},{-1.478,19.05},{-11.267,11.113},{-19.734,2.381},{-29.259,-8.202},{-38.519,-19.579},{-48.044,-31.221},{-56.511,-43.392},{-64.449,-55.298},{-72.386,-66.939},{-77.678,-74.612},{-79.53,-74.083},{-71.857,-61.383},{-62.861,-46.037},{-52.278,-28.046},{-44.869,-15.346},{-38.784,-2.117},{-35.344,8.731},{-36.403,19.844},{-42.488,23.813},{-52.013,22.49},{-60.744,16.933},{-68.947,10.054},{-76.884,2.646},{-93.0112,-12.1707},{-93.0112,-12.1707}},
    smooth=Smooth.Bezier),
  Ellipse(
    origin={40.8208,-37.7602},
    fillColor={161,0,4},
    pattern=LinePattern.None,
    fillPattern=FillPattern.Solid,
    extent={{-17.8562,-17.8563},{17.8563,17.8562}})}),
Documentation(info="<HTML>
<p>
Package <b>Modelica&reg;</b> is a <b>standardized</b> and <b>free</b> package
that is developed together with the Modelica&reg; language from the
Modelica Association, see
<a href=\"https://www.Modelica.org\">https://www.Modelica.org</a>.
It is also called <b>Modelica Standard Library</b>.
It provides model components in many domains that are based on
standardized interface definitions. Some typical examples are shown
in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/UsersGuide/ModelicaLibraries.png\">
</p>

<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.UsersGuide.Overview\">Overview</a>
  provides an overview of the Modelica Standard Library
  inside the <a href=\"modelica://Modelica.UsersGuide\">User's Guide</a>.</li>
<li><a href=\"modelica://Modelica.UsersGuide.ReleaseNotes\">Release Notes</a>
 summarizes the changes of new versions of this package.</li>
<li> <a href=\"modelica://Modelica.UsersGuide.Contact\">Contact</a>
  lists the contributors of the Modelica Standard Library.</li>
<li> The <b>Examples</b> packages in the various libraries, demonstrate
  how to use the components of the corresponding sublibrary.</li>
</ul>

<p>
This version of the Modelica Standard Library consists of
</p>
<ul>
<li><b>1360</b> models and blocks, and</li>
<li><b>1280</b> functions</li>
</ul>
<p>
that are directly usable (= number of public, non-partial classes). It is fully compliant
to <a href=\"https://www.modelica.org/documents/ModelicaSpec32Revision2.pdf\">Modelica Specification Version 3.2 Revision 2</a>
and it has been tested with Modelica tools from different vendors.
</p>

<p>
<b>Licensed by the Modelica Association under the Modelica License 2</b><br>
Copyright &copy; 1998-2015, ABB, AIT, T.&nbsp;B&ouml;drich, DLR, Dassault Syst&egrave;mes AB, Fraunhofer, A.&nbsp;Haumer, ITI, C.&nbsp;Kral, Modelon,
TU Hamburg-Harburg, Politecnico di Milano, XRG Simulation.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

<p>
<b>Modelica&reg;</b> is a registered trademark of the Modelica Association.
</p>
</html>"));
end Modelica;

package DistrictHeating

  package Components

    package Boiler "Contains all heat sources"

      model BoilerBasicPeak "Boiler which divides into basic and peak load"
        //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

      parameter Modelica.SIunits.HeatFlowRate Qbase "maximal basic load power";
      parameter Modelica.SIunits.HeatFlowRate Qpeak "maximal peak load power";
      Modelica.SIunits.HeatFlowRate HeatFlowBase;
      Modelica.SIunits.HeatFlowRate HeatFlowPeak;
      Modelica.SIunits.HeatFlowRate HeatFlow;
      Modelica.SIunits.Heat HeatBase;
      Modelica.SIunits.Heat HeatPeak;
      Modelica.SIunits.Heat Heat;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow base_boiler
          annotation (Placement(transformation(extent={{-6,-10},{14,10}})));
        Modelica.Blocks.Interfaces.RealInput nominal_heat
        "specification of the heat flow"
          annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b thermal_heat_flow
        "thermal heat flow output"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Continuous.Integrator heat_flow_counter_base(y_start=0, k=1)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={34,-62})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={34,0})));
        Modelica.Blocks.Nonlinear.Limiter limiter(uMax=Qbase, uMin=0)
          annotation (Placement(transformation(extent={{-68,-10},{-48,10}})));
        Modelica.Blocks.Math.Feedback feedback annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-56,-32})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow peak_boiler
          annotation (Placement(transformation(extent={{-2,-42},{18,-22}})));
        Modelica.Blocks.Nonlinear.Limiter limiter1(uMax=Qpeak, uMin=0)
          annotation (Placement(transformation(extent={{-34,-42},{-14,-22}})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor1
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={66,-32})));
        Modelica.Blocks.Continuous.Integrator heat_flow_counter_peak(y_start=0, k=1)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={66,-62})));
      equation

      HeatFlowBase=heatFlowSensor.Q_flow;
      HeatFlowPeak=heatFlowSensor1.Q_flow;
      HeatFlow=HeatFlowBase+HeatFlowPeak;
      HeatBase=heat_flow_counter_base.y;
      HeatPeak=heat_flow_counter_peak.y;
      Heat=HeatBase+HeatPeak;
        connect(base_boiler.port, heatFlowSensor.port_a)
          annotation (Line(points={{14,0},{14,0},{24,0}}, color={191,0,0}));
        connect(thermal_heat_flow, heatFlowSensor.port_b)
          annotation (Line(points={{100,0},{44,0}},        color={191,0,0}));
        connect(limiter.u, nominal_heat)
          annotation (Line(points={{-70,0},{-70,0},{-104,0}}, color={0,0,127}));
        connect(base_boiler.Q_flow, limiter.y)
          annotation (Line(points={{-6,0},{-28,0},{-47,0}}, color={0,0,127}));
        connect(feedback.u1, nominal_heat) annotation (Line(points={{-64,-32},{
                -78,-32},{-78,0},{-104,0}},
                                        color={0,0,127}));
        connect(feedback.u2, limiter.y) annotation (Line(points={{-56,-40},{-56,
                -56},{-42,-56},{-42,0},{-47,0}},
                                            color={0,0,127}));
        connect(limiter1.u, feedback.y)
          annotation (Line(points={{-36,-32},{-42,-32},{-47,-32}},
                                                         color={0,0,127}));
        connect(peak_boiler.Q_flow, limiter1.y)
          annotation (Line(points={{-2,-32},{-8,-32},{-13,-32}},
                                                        color={0,0,127}));
        connect(peak_boiler.port, heatFlowSensor1.port_a)
          annotation (Line(points={{18,-32},{56,-32}},          color={191,0,0}));
        connect(heatFlowSensor1.port_b, heatFlowSensor.port_b) annotation (Line(
              points={{76,-32},{90,-32},{90,0},{44,0}}, color={191,0,0}));
        connect(heat_flow_counter_peak.u, heatFlowSensor1.Q_flow)
          annotation (Line(points={{66,-50},{66,-46},{66,-42}},
                                                       color={0,0,127}));
        connect(heat_flow_counter_base.u, heatFlowSensor.Q_flow)
          annotation (Line(points={{34,-50},{34,-50},{34,-10}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Rectangle(
                extent={{-40,16},{-2,-40}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Text(
                extent={{-50,-96},{52,-48}},
                lineColor={0,0,0},
                lineThickness=0.5,
                textString="boiler"),
              Bitmap(extent={{-48,-36},{8,14}}, fileName=
                    "modelica://DistrictHeating/Resources/Images/fire-30276_960_720.png"),
              Text(
                extent={{-92,-12},{-48,-22}},
                lineColor={28,108,200},
                lineThickness=0.5,
                fontSize=16,
                textString="nominal heat"),
              Text(
                extent={{52,-12},{90,-22}},
                lineColor={238,46,47},
                lineThickness=0.5,
                textString="heat flow",
                fontSize=16),
              Text(
                extent={{-32,94},{36,84}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fontSize=16,
                textString="heat flow counter"),
              Rectangle(
                extent={{4,16},{42,-40}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Bitmap(extent={{-4,-36},{52,14}}, fileName=
                    "modelica://DistrictHeating/Resources/Images/fire-30276_960_720.png"),
              Line(
                points={{-44,84},{-44,36},{46,36}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-44,80},{-40,68},{-30,62},{-4,54},{18,50},{38,50},{38,36}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{42,32},{46,36},{42,40}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-48,80},{-44,84},{-40,80}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{-46,58},{42,58}},
                color={0,0,0},
                thickness=0.5,
                pattern=LinePattern.Dot),
              Text(
                extent={{-54,20},{48,68}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fontSize=18,
                textString="basic"),
              Text(
                extent={{-54,46},{48,94}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fontSize=18,
                textString="peak"),
              Text(
                extent={{-82,-106},{88,-138}},
                lineColor={28,108,200},
                textString="%name")}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This model of a boiler needs a real input for his nomial heat. </p>
<p>The output is a heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
<p>The real input &QUOT;nominal heat&QUOT; is divided into to parts: A basic load and a peak load. </p>
<p>The basic load boiler handles the base load. If the nominal heat rises above the maximal heat output of the base load boiler, the peak load boiler gets activated. </p>
<p>The maximal heat output is the sum of the maximal heat of base load and peak load boiler. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/base_peak.png\"/></p>
</html>"));
      end BoilerBasicPeak;
    end Boiler;
  end Components;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

    package Boiler
        extends Modelica.Icons.ExamplesPackage;

      model BoilerBasicPeak

        extends Modelica.Icons.Example;

        Components.Boiler.BoilerBasicPeak boilerInFinite(Qbase=1000, Qpeak=500)
          annotation (Placement(transformation(extent={{-36,-10},{-16,10}})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={2,0})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={66,0})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{6,58},{26,78}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=2000,
          duration=2,
          offset=0,
          startTime=1)
          annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
      equation
        connect(ramp.y, boilerInFinite.nominal_heat)
          annotation (Line(points={{-63,0},{-50,0},{-36.4,0}},
                                                       color={0,0,127}));
        connect(boilerInFinite.thermal_heat_flow, heatFlowSensor.port_a)
          annotation (Line(points={{-16,0},{-16,0},{-8,0}}, color={191,0,0}));
        connect(heatFlowSensor.Q_flow, feedback.u2) annotation (Line(points={{2,-10},
                {2,-10},{2,-18},{2,-20},{16,-20},{16,60}}, color={0,0,127}));
        connect(feedback.u1, boilerInFinite.nominal_heat) annotation (Line(
              points={{8,68},{-50,68},{-50,0},{-36.4,0}}, color={0,0,127}));
        connect(heatFlowSensor.port_b, fixedTemperature.port)
          annotation (Line(points={{12,0},{34,0},{56,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=5),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This example shows that the Real input of the Model is directly converted into a heat flow output.</span></p>
<p>With Real inputs lower than the maximum heat flow of the basic load boiler only this boiler is in use.</p>
<p>With Real inputs higher than the maximum heat flow of the basic load boiler additionaly the peak load boiler is in use. </p>
<p>With Real inputs higher than the sum of the maximum heat flow of basic and peak load boiler the heat output stays at its maximum.</p>
</html>"));
      end BoilerBasicPeak;
    end Boiler;
  end Examples;
  annotation (uses(Modelica(version="3.2.1")),
           version = "0.6.0");
end DistrictHeating;
model DistrictHeating_Examples_Boiler_BoilerBasicPeak
 extends DistrictHeating.Examples.Boiler.BoilerBasicPeak;
  annotation(experiment(StopTime=5),uses(DistrictHeating(version="0.6.0")));
end DistrictHeating_Examples_Boiler_BoilerBasicPeak;
