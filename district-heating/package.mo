package ModelicaServices
  "(version = 3.2.1, target = \"Dymola\") Models and functions used in the Modelica Standard Library requiring a tool specific implementation"

package Machine

  final constant Real eps=1.e-15 "Biggest number such that 1.0 + eps = 1.0";
  annotation (Documentation(info="<html>
<p>
Package in which processor specific constants are defined that are needed
by numerical algorithms. Typically these constants are not directly used,
but indirectly via the alias definition in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.
</p>
</html>"));
end Machine;
annotation (
  Protection(access=Access.hide),
  preferredView="info",
  version="3.2.1",
  versionDate="2013-01-17",
  versionBuild=1,
  uses(Modelica(version="3.2.1")),
  conversion(
    noneFromVersion="1.0",
    noneFromVersion="1.1",
    noneFromVersion="1.2"),
  Documentation(info="<html>
<p>
This package contains a set of functions and models to be used in the
Modelica Standard Library that requires a tool specific implementation.
These are:
</p>

<ul>
<li> <a href=\"modelica://ModelicaServices.Animation.Shape\">Shape</a>
     provides a 3-dim. visualization of elementary
     mechanical objects. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Shape</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Animation.Surface\">Surface</a>
     provides a 3-dim. visualization of
     moveable parameterized surface. It is used in
<a href=\"modelica://Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface\">Modelica.Mechanics.MultiBody.Visualizers.Advanced.Surface</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.ExternalReferences.loadResource\">loadResource</a>
     provides a function to return the absolute path name of an URI or a local file name. It is used in
<a href=\"modelica://Modelica.Utilities.Files.loadResource\">Modelica.Utilities.Files.loadResource</a>
     via inheritance.</li>

<li> <a href=\"modelica://ModelicaServices.Machine\">ModelicaServices.Machine</a>
     provides a package of machine constants. It is used in
<a href=\"modelica://Modelica.Constants\">Modelica.Constants</a>.</li>

<li> <a href=\"modelica://ModelicaServices.Types.SolverMethod\">Types.SolverMethod</a>
     provides a string defining the integration method to solve differential equations in
     a clocked discretized continuous-time partition (see Modelica 3.3 language specification).
     It is not yet used in the Modelica Standard Library, but in the Modelica_Synchronous library
     that provides convenience blocks for the clock operators of Modelica version &ge; 3.3.</li>
</ul>

<p>
This implementation is targeted for Dymola.
</p>

<p>
<b>Licensed by DLR and Dassault Syst&egrave;mes AB under the Modelica License 2</b><br>
Copyright &copy; 2009-2013, DLR and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"http://www.modelica.org/licenses/ModelicaLicense2\"> http://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>"));
end ModelicaServices;

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

      block Derivative "Approximated derivative block"
        import Modelica.Blocks.Types.Init;
        parameter Real k(unit="1")=1 "Gains";
        parameter SIunits.Time T(min=Modelica.Constants.small) = 0.01
        "Time constants (T>0 required; T=0 is ideal derivative block)";
        parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
        "Type of initialization (1: no init, 2: steady state, 3: initial state, 4: initial output)"
                                                                                          annotation(Evaluate=true,
            Dialog(group="Initialization"));
        parameter Real x_start=0 "Initial or guess value of state"
          annotation (Dialog(group="Initialization"));
        parameter Real y_start=0 "Initial value of output (= state)"
          annotation(Dialog(enable=initType == Init.InitialOutput, group=
                "Initialization"));
        extends Interfaces.SISO;

        output Real x(start=x_start) "State of block";

    protected
        parameter Boolean zeroGain = abs(k) < Modelica.Constants.eps;
      initial equation
        if initType == Init.SteadyState then
          der(x) = 0;
        elseif initType == Init.InitialState then
          x = x_start;
        elseif initType == Init.InitialOutput then
          if zeroGain then
             x = u;
          else
             y = y_start;
          end if;
        end if;
      equation
        der(x) = if zeroGain then 0 else (u - x)/T;
        y = if zeroGain then 0 else (k/T)*(u - x);
        annotation (
          Documentation(info="<html>
<p>
This blocks defines the transfer function between the
input u and the output y
(element-wise) as <i>approximated derivative</i>:
</p>
<pre>
             k * s
     y = ------------ * u
            T * s + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a derivative block with parameters<br>
b = {k,0}, a = {T, 1}.
</p>

<p>
If k=0, the block reduces to y=0.
</p>
</html>"),       Icon(
          coordinateSystem(preserveAspectRatio=true,
              extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Line(visible=true,
              points={{-80.0,78.0},{-80.0,-90.0}},
            color={192,192,192}),
        Polygon(visible=true,
            lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
        Line(visible=true,
            points={{-90.0,-80.0},{82.0,-80.0}},
          color={192,192,192}),
        Polygon(visible=true,
            lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90.0,-80.0},{68.0,-72.0},{68.0,-88.0},{90.0,-80.0}}),
        Line(visible = true,
          origin = {-24.667,-27.333},
          points = {{-55.333,87.333},{-19.333,-40.667},{86.667,-52.667}},
          color = {0,0,127},
          smooth = Smooth.Bezier),
        Text(visible=true,
            lineColor={192,192,192},
          extent={{-30.0,14.0},{86.0,60.0}},
          textString="DT1"),
        Text(visible=true,
            extent={{-150.0,-150.0},{150.0,-110.0}},
          textString="k=%k")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Text(
                extent={{-54,52},{50,10}},
                lineColor={0,0,0},
                textString="k s"),
              Text(
                extent={{-54,-6},{52,-52}},
                lineColor={0,0,0},
                textString="T s + 1"),
              Line(points={{-50,0},{50,0}}, color={0,0,0}),
              Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
              Line(points={{-100,0},{-60,0}}, color={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255})}));
      end Derivative;
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

      connector BooleanInput = input Boolean "'input Boolean' as connector"
        annotation (
        defaultComponentName="u",
        Icon(graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid)}, coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            initialScale=0.2,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{0,50},{100,0},{0,-50},{0,50}},
              lineColor={255,0,255},
              fillColor={255,0,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{-10,85},{-10,60}},
              lineColor={255,0,255},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one input signal of type Boolean.
</p>
</html>"));

      connector BooleanOutput = output Boolean "'output Boolean' as connector"
        annotation (
        defaultComponentName="y",
        Icon(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{-100,100},{100,0},{-100,-100},{-100,100}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid)}),
        Diagram(coordinateSystem(
            preserveAspectRatio=true,
            extent={{-100,-100},{100,100}}), graphics={Polygon(
              points={{-100,50},{0,0},{-100,-50},{-100,50}},
              lineColor={255,0,255},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid), Text(
              extent={{30,110},{30,60}},
              lineColor={255,0,255},
              textString="%name")}),
        Documentation(info="<html>
<p>
Connector with one output signal of type Boolean.
</p>
</html>"));

      connector RealVectorInput = input Real
      "Real input connector used for vector of connectors"   annotation (
        defaultComponentName="u",
        Icon(graphics={Ellipse(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)}, coordinateSystem(
            extent={{-100,-100},{100,100}},
            preserveAspectRatio=true,
            initialScale=0.2)),
        Diagram(coordinateSystem(
            preserveAspectRatio=false,
            initialScale=0.2,
            extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-10,85},{-10,60}},
              lineColor={0,0,127},
              textString="%name"), Ellipse(
              extent={{-50,50},{50,-50}},
              lineColor={0,0,127},
              fillColor={0,0,127},
              fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Real input connector that is used for a vector of connectors,
for example <a href=\"modelica://Modelica.Blocks.Interfaces.PartialRealMISO\">PartialRealMISO</a>,
and has therefore a different icon as RealInput connector.
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

      partial block MO "Multiple Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        parameter Integer nout(min=1) = 1 "Number of outputs";
        RealOutput y[nout] "Connector of Real output signals" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<html>
<p>
Block has one continuous Real output signal vector.
</p>
</html>"));

      end MO;

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

      partial block SI2SO
      "2 Single Input / 1 Single Output continuous control block"
        extends Modelica.Blocks.Icons.Block;

        RealInput u1 "Connector of Real input signal 1" annotation (Placement(
              transformation(extent={{-140,40},{-100,80}}, rotation=0)));
        RealInput u2 "Connector of Real input signal 2" annotation (Placement(
              transformation(extent={{-140,-80},{-100,-40}}, rotation=0)));
        RealOutput y "Connector of Real output signal" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));

        annotation (Documentation(info="<html>
<p>
Block has two continuous Real input signals u1 and u2 and one
continuous Real output signal y.
</p>
</html>"));

      end SI2SO;

      partial block PartialRealMISO
      "Partial block with a RealVectorInput and a RealOutput signal"

        parameter Integer significantDigits(min=1) = 3
        "Number of significant digits to be shown in dynamic diagram layer for y"
          annotation (Dialog(tab="Advanced"));
        parameter Integer nu(min=0) = 0 "Number of input connections"
          annotation (Dialog(connectorSizing=true), HideResult=true);
        Modelica.Blocks.Interfaces.RealVectorInput u[nu]
          annotation (Placement(transformation(extent={{-120,70},{-80,-70}})));
        Modelica.Blocks.Interfaces.RealOutput y
          annotation (Placement(transformation(extent={{100,-17},{134,17}})));
        annotation (Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              initialScale=0.06), graphics={
              Text(
                extent={{110,-50},{300,-70}},
                lineColor={0,0,0},
                textString=DynamicSelect(" ", String(y, significantDigits=
                    significantDigits))),
              Text(
                extent={{-250,170},{250,110}},
                textString="%name",
                lineColor={0,0,255}),
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={255,137,0},
                lineThickness=5.0,
                fillColor={255,255,255},
                borderPattern=BorderPattern.Raised,
                fillPattern=FillPattern.Solid)}));
      end PartialRealMISO;

      partial block MIMOs
      "Multiple Input Multiple Output continuous control block with same number of inputs and outputs"

        extends Modelica.Blocks.Icons.Block;
        parameter Integer n=1 "Number of inputs (= number of outputs)";
        RealInput u[n] "Connector of Real input signals" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        RealOutput y[n] "Connector of Real output signals" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));
        annotation (Documentation(info="<HTML>
<p>
Block has a continuous Real input and a continuous Real output signal vector
where the signal sizes of the input and output vector are identical.
</p>
</html>"));
      end MIMOs;

      partial block partialBooleanSource
      "Partial source block (has 1 output Boolean signal and an appropriate default icon)"
        extends Modelica.Blocks.Icons.PartialBooleanBlock;

        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));

        annotation (
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Polygon(
                points={{-80,88},{-88,66},{-72,66},{-80,88}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,66},{-80,-82}}, color={255,0,255}),
              Line(points={{-90,-70},{72,-70}}, color={255,0,255}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={255,0,255},
                fillColor={255,0,255},
                fillPattern=FillPattern.Solid),
              Ellipse(
                extent={{71,7},{85,-7}},
                lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
                     else {235,235,235}),
                fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
                     else {235,235,235}),
                fillPattern=FillPattern.Solid)}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Polygon(
                  points={{-70,92},{-76,70},{-64,70},{-70,92}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-70,70},{-70,-88}},
                color={95,95,95}),Line(points={{-90,-70},{68,-70}}, color={95,95,95}),
                Polygon(
                  points={{90,-70},{68,-64},{68,-76},{90,-70}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{54,-80},{106,-92}},
                  lineColor={0,0,0},
                  textString="time"),Text(
                  extent={{-64,92},{-46,74}},
                  lineColor={0,0,0},
                  textString="y")}),
          Documentation(info="<html>
<p>
Basic block for Boolean sources of package Blocks.Sources.
This component has one continuous Boolean output signal y
and a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

      end partialBooleanSource;

      partial block partialBooleanComparison
      "Partial block with 2 Real input and 1 Boolean output signal (the result of a comparison of the two Real inputs)"

        Blocks.Interfaces.RealInput u1
        "Connector of first Boolean input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
                rotation=0)));
        Blocks.Interfaces.RealInput u2
        "Connector of second Boolean input signal"
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}},
                rotation=0)));
        Blocks.Interfaces.BooleanOutput y "Connector of Boolean output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));

        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=5.0,
                fillColor={210,210,210},
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised),
              Ellipse(
                extent={{73,7},{87,-7}},
                lineColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
                     else {235,235,235}),
                fillColor=DynamicSelect({235,235,235}, if y > 0.5 then {0,255,0}
                     else {235,235,235}),
                fillPattern=FillPattern.Solid),
              Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
              Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127})}),
            Documentation(info="<html>
<p>
Block has two continuous Real input and one continuous Boolean output signal
as a result of the comparison of the two input signals. The block
has a 3D icon (e.g., used in Blocks.Logical library).
</p>
</html>"));

      end partialBooleanComparison;
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

    package Logical
    "Library of components with Boolean input and output signals"
      extends Modelica.Icons.Package;

      block Greater "Output y is true, if input u1 is greater than input u2"
        extends Blocks.Interfaces.partialBooleanComparison;

      equation
        y = u1 > u2;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
              Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
              Line(
                points={{-54,22},{-8,2},{-54,-18}},
                color={0,0,0},
                smooth=Smooth.None,
                thickness=0.5)}), Documentation(info="<html>
<p>
The output is <b>true</b> if Real input u1 is greater than
Real input u2, otherwise the output is <b>false</b>.
</p>
</html>"));
      end Greater;

      block Less "Output y is true, if input u1 is less than input u2"
        extends Blocks.Interfaces.partialBooleanComparison;

      equation
        y = u1 < u2;
        annotation (Icon(coordinateSystem(preserveAspectRatio=false,extent={{-100,
                  -100},{100,100}}), graphics={
              Ellipse(extent={{32,10},{52,-10}}, lineColor={0,0,127}),
              Line(points={{-100,-80},{42,-80},{42,0}}, color={0,0,127}),
              Line(
                points={{-6,18},{-50,-2},{-6,-20}},
                color={0,0,0},
                thickness=0.5,
                smooth=Smooth.None)}), Documentation(info="<html>
<p>
The output is <b>true</b> if Real input u1 is less than
Real input u2, otherwise the output is <b>false</b>.
</p>
</html>"));
      end Less;

      block Switch "Switch between two Real signals"
        extends Modelica.Blocks.Icons.PartialBooleanBlock;
        Blocks.Interfaces.RealInput u1 "Connector of first Real input signal"
          annotation (Placement(transformation(extent={{-140,60},{-100,100}},
                rotation=0)));
        Blocks.Interfaces.BooleanInput u2 "Connector of Boolean input signal"
          annotation (Placement(transformation(extent={{-140,-20},{-100,20}},
                rotation=0)));
        Blocks.Interfaces.RealInput u3 "Connector of second Real input signal"
          annotation (Placement(transformation(extent={{-140,-100},{-100,-60}},
                rotation=0)));
        Blocks.Interfaces.RealOutput y "Connector of Real output signal"
          annotation (Placement(transformation(extent={{100,-10},{120,10}},
                rotation=0)));

      equation
        y = if u2 then u1 else u3;
        annotation (
          defaultComponentName="switch1",
          Documentation(info="<html>
<p>The Logical.Switch switches, depending on the
logical connector u2 (the middle connector)
between the two possible input signals
u1 (upper connector) and u3 (lower connector).</p>
<p>If u2 is <b>true</b>, the output signal y is set equal to
u1, else it is set equal to u3.</p>
</html>"),Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              initialScale=0.1), graphics={
              Line(points={{12.0,0.0},{100.0,0.0}},
                color={0,0,127}),
              Line(points={{-100.0,0.0},{-40.0,0.0}},
                color={255,0,255}),
              Line(points={{-100.0,-80.0},{-40.0,-80.0},{-40.0,-80.0}},
                color={0,0,127}),
              Line(points={{-40.0,12.0},{-40.0,-12.0}},
                color={255,0,255}),
              Line(points={{-100.0,80.0},{-38.0,80.0}},
                color={0,0,127}),
              Line(points={{-38.0,80.0},{6.0,2.0}},
                color={0,0,127},
                thickness=1.0),
              Ellipse(lineColor={0,0,255},
                pattern=LinePattern.None,
                fillPattern=FillPattern.Solid,
                extent={{2.0,-8.0},{18.0,8.0}})}));
      end Switch;
      annotation (Documentation(info="<html>
<p>
This package provides blocks with Boolean input and output signals
to describe logical networks. A typical example for a logical
network built with package Logical is shown in the next figure:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/LogicalNetwork1.png\"
     alt=\"LogicalNetwork1.png\">
</p>

<p>
The actual value of Boolean input and/or output signals is displayed
in the respective block icon as \"circle\", where \"white\" color means
value <b>false</b> and \"green\" color means value <b>true</b>. These
values are visualized in a diagram animation.
</p>
</html>"),     Icon(graphics={Line(
              visible=true,
              points={{-86,-22},{-50,-22},{-50,22},{48,22},{48,-22},{88,-24}},
              color={255,0,255})}));
    end Logical;

    package Math
    "Library of Real mathematical functions as input/output blocks"
      import Modelica.SIunits;
      import Modelica.Blocks.Interfaces;
      extends Modelica.Icons.Package;

      block Gain "Output the product of a gain value with the input signal"

        parameter Real k(start=1, unit="1")
        "Gain value multiplied with input signal";
    public
        Interfaces.RealInput u "Input signal connector" annotation (Placement(
              transformation(extent={{-140,-20},{-100,20}}, rotation=0)));
        Interfaces.RealOutput y "Output signal connector" annotation (Placement(
              transformation(extent={{100,-10},{120,10}}, rotation=0)));

      equation
        y = k*u;
        annotation (
          Documentation(info="<html>
<p>
This block computes output <i>y</i> as
<i>product</i> of gain <i>k</i> with the
input <i>u</i>:
</p>
<pre>
    y = k * u;
</pre>

</html>"),Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Polygon(
                points={{-100,-100},{-100,100},{100,0},{-100,-100}},
                lineColor={0,0,127},
                fillColor={255,255,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-150,-140},{150,-100}},
                lineColor={0,0,0},
                textString="k=%k"),
              Text(
                extent={{-150,140},{150,100}},
                textString="%name",
                lineColor={0,0,255})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Polygon(
                  points={{-100,-100},{-100,100},{100,0},{-100,-100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{-76,38},{0,-34}},
                  textString="k",
                  lineColor={0,0,255})}));
      end Gain;

      block MultiSum
      "Sum of Reals: y = k[1]*u[1] + k[2]*u[2] + ... + k[n]*u[n]"
        extends Modelica.Blocks.Interfaces.PartialRealMISO;
        parameter Real k[nu]=fill(1, nu) "Input gains";
      equation
        if size(u, 1) > 0 then
          y = k*u;
        else
          y = 0;
        end if;

        annotation (Icon(graphics={Text(
                extent={{-200,-110},{200,-140}},
                lineColor={0,0,0},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid,
                textString="%k"), Text(
                extent={{-72,68},{92,-68}},
                lineColor={0,0,0},
                fillColor={255,213,170},
                fillPattern=FillPattern.Solid,
                textString="+")}), Documentation(info="<html>
<p>
This blocks computes the scalar Real output \"y\" as sum of the elements of the
Real input signal vector u:
</p>
<blockquote><pre>
y = k[1]*u[1] + k[2]*u[2] + ... k[N]*u[N];
</pre></blockquote>

<p>
The input connector is a vector of Real input signals.
When a connection line is drawn, the dimension of the input
vector is enlarged by one and the connection is automatically
connected to this new free index (thanks to the
connectorSizing annotation).
</p>

<p>
The usage is demonstrated, e.g., in example
<a href=\"modelica://Modelica.Blocks.Examples.RealNetwork1\">Modelica.Blocks.Examples.RealNetwork1</a>.
</p>

<p>
If no connection to the input connector \"u\" is present,
the output is set to zero: y=0.
</p>

</html>"));
      end MultiSum;

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

      block Add "Output the sum of the two inputs"
        extends Interfaces.SI2SO;

        parameter Real k1=+1 "Gain of upper input";
        parameter Real k2=+1 "Gain of lower input";

      equation
        y = k1*u1 + k2*u2;
        annotation (
          Documentation(info="<html>
<p>
This blocks computes output <b>y</b> as <i>sum</i> of the
two input signals <b>u1</b> and <b>u2</b>:
</p>
<pre>
    <b>y</b> = k1*<b>u1</b> + k2*<b>u2</b>;
</pre>
<p>
Example:
</p>
<pre>
     parameter:   k1= +2, k2= -3

  results in the following equations:

     y = 2 * u1 - 3 * u2
</pre>

</html>"),Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}},
              initialScale=0.1), graphics={
              Text(
                lineColor={0,0,255},
                extent={{-150,110},{150,150}},
                textString="%name"),
              Line(points={{-100,60},{-74,24},{-44,24}}, color={0,0,127}),
              Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={0,0,127}),
              Ellipse(lineColor={0,0,127}, extent={{-50,-50},{50,50}}),
              Line(points={{50,0},{100,0}}, color={0,0,127}),
              Text(extent={{-38,-34},{38,34}}, textString="+"),
              Text(extent={{-100,52},{5,92}}, textString="%k1"),
              Text(extent={{-100,-92},{5,-52}}, textString="%k2")}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={Rectangle(
                  extent={{-100,-100},{100,100}},
                  lineColor={0,0,127},
                  fillColor={255,255,255},
                  fillPattern=FillPattern.Solid),Line(points={{50,0},{100,0}},
                color={0,0,255}),Line(points={{-100,60},{-74,24},{-44,24}}, color={
                0,0,127}),Line(points={{-100,-60},{-74,-28},{-42,-28}}, color={0,0,
                127}),Ellipse(extent={{-50,50},{50,-50}}, lineColor={0,0,127}),Line(
                points={{50,0},{100,0}}, color={0,0,127}),Text(
                  extent={{-36,38},{40,-30}},
                  lineColor={0,0,0},
                  textString="+"),Text(
                  extent={{-100,52},{5,92}},
                  lineColor={0,0,0},
                  textString="k1"),Text(
                  extent={{-100,-52},{5,-92}},
                  lineColor={0,0,0},
                  textString="k2")}));
      end Add;
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

      block VariableLimiter "Limit the range of a signal with variable limits"
        extends Interfaces.SISO;
        parameter Boolean strict=false
        "= true, if strict limits with noEvent(..)"
          annotation (Evaluate=true, choices(checkBox=true));
        parameter Boolean limitsAtInit=true
        "= false, if limits are ignored during initialization (i.e., y=u)"
          annotation (Evaluate=true, choices(checkBox=true));
        Interfaces.RealInput limit1
        "Connector of Real input signal used as maximum of input u"
                                    annotation (Placement(transformation(extent={{
                  -140,60},{-100,100}}, rotation=0)));
        Interfaces.RealInput limit2
        "Connector of Real input signal used as minimum of input u"
                                    annotation (Placement(transformation(extent={{
                  -140,-100},{-100,-60}}, rotation=0)));
    protected
        Real uMax;
        Real uMin;

      equation
        if strict then
          uMax = noEvent(max(limit1, limit2));
          uMin = noEvent(min(limit1, limit2));
        else
          uMax = max(limit1, limit2);
          uMin = min(limit1, limit2);
        end if;

        if initial() and not limitsAtInit then
           y = u;
           assert(u >= uMin - 0.01*abs(uMin) and
                  u <= uMax + 0.01*abs(uMax),
                 "VariableLimiter: During initialization the limits have been ignored.\n"+
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
as long as the input is within the upper and lower
limits specified by the two additional inputs limit1 and
limit2. If this is not the case, the corresponding limit
is passed as output.
</p>
</html>"),       Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                  100}}), graphics={
              Line(points={{0,-90},{0,68}}, color={192,192,192}),
              Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                points={{90,0},{68,-8},{68,8},{90,0}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,-70},{-50,-70},{50,70},{80,70}}, color={0,0,0}),
              Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255}),
              Line(points={{-100,80},{66,80},{66,70}}, color={0,0,127}),
              Line(points={{-100,-80},{-64,-80},{-64,-70}}, color={0,0,127}),
              Polygon(points={{-64,-70},{-66,-74},{-62,-74},{-64,-70}}, lineColor={
                    0,0,127}),
              Polygon(points={{66,70},{64,74},{68,74},{66,70}}, lineColor={0,0,127}),
              Polygon(
                points={{0,90},{-8,68},{8,68},{0,90}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
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
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
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
                textString="inPort"),
              Text(
                extent={{-30,70},{-5,50}},
                lineColor={128,128,128},
                textString="outPort"),
              Text(
                extent={{-66,-40},{-26,-20}},
                lineColor={128,128,128},
                textString="uMin"),
              Text(
                extent={{30,20},{70,40}},
                lineColor={128,128,128},
                textString="uMax"),
              Line(points={{-100,80},{40,80},{40,40}}, color={0,0,127}),
              Line(points={{-100,-80},{-40,-80},{-40,-40}}, color={0,0,127}),
              Polygon(points={{40,40},{35,50},{45,50},{40,40}}, lineColor={0,0,127}),
              Polygon(points={{-40,-40},{-45,-50},{-35,-50},{-40,-40}}, lineColor={
                    0,0,127})}));
      end VariableLimiter;
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

      block Constant "Generate constant signal of type Real"
        parameter Real k(start=1) "Constant output value";
        extends Interfaces.SO;

      equation
        y = k;
        annotation (
          defaultComponentName="const",
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
              Line(points={{-80,0},{80,0}}, color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="k=%k")}),
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
                points={{-80,0},{80,0}},
                color={0,0,255},
                thickness=0.5),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-64},{68,-76},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-83,92},{-30,74}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{70,-80},{94,-100}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-101,8},{-81,-12}},
                lineColor={0,0,0},
                textString="k")}),
          Documentation(info="<html>
<p>
The Real output y is a constant signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Constant.png\"
     alt=\"Constant.png\">
</p>
</html>"));
      end Constant;

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

      block Cosine "Generate cosine signal"
        parameter Real amplitude=1 "Amplitude of cosine wave";
        parameter SIunits.Frequency freqHz(start=1) "Frequency of cosine wave";
        parameter SIunits.Angle phase=0 "Phase of cosine wave";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0
        "Output = offset for time < startTime";
        extends Interfaces.SO;
    protected
        constant Real pi=Modelica.Constants.pi;

      equation
        y = offset + (if time < startTime then 0 else amplitude*Modelica.Math.cos(2
          *pi*freqHz*(time - startTime) + phase));
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
              Line(points={{-90,0},{68,0}}, color={192,192,192}),
              Polygon(
                points={{90,0},{68,8},{68,-8},{90,0}},
                lineColor={192,192,192},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,80},{-76.2,79.8},{-70.6,76.6},{-64.9,69.7},{-59.3,
                    59.4},{-52.9,44.1},{-44.83,21.2},{-27.9,-30.8},{-20.7,-50.2},{-14.3,
                    -64.2},{-8.7,-73.1},{-3,-78.4},{2.6,-80},{8.2,-77.6},{13.9,-71.5},
                    {19.5,-61.9},{25.9,-47.2},{34,-24.8},{42,0}}, color={0,0,0}, smooth=Smooth.Bezier),
              Text(
                extent={{-147,-152},{153,-112}},
                lineColor={0,0,0},
                textString="freqHz=%freqHz"),
              Line(points={{42,1},{53.3,35.2},{60.5,54.1},{66.9,67.4},{72.6,75.6},{
                    78.2,80.1},{83.8,80.8}}, color={0,0,0})}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Line(points={{-80,-90},{-80,84}}, color={95,95,
                95}),Polygon(
                  points={{-80,97},{-84,81},{-76,81},{-80,97}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{-99,-40},{85,-40}},
                color={95,95,95}),Polygon(
                  points={{97,-40},{81,-36},{81,-45},{97,-40}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(
                  points={{-41,-2},{-80,-2}},
                  color={0,0,255},
                  thickness=0.5),Text(
                  extent={{-87,12},{-40,0}},
                  lineColor={0,0,0},
                  textString="offset"),Line(points={{-41,-2},{-41,-40}}, color={95,
                95,95}),Text(
                  extent={{-60,-43},{-14,-54}},
                  lineColor={0,0,0},
                  textString="startTime"),Text(
                  extent={{75,-47},{100,-60}},
                  lineColor={0,0,0},
                  textString="time"),Text(
                  extent={{-80,99},{-40,82}},
                  lineColor={0,0,0},
                  textString="y"),Line(points={{-41,80},{43,80}}, color={95,95,95}),
                Line(points={{-41,-2},{40,-2}}, color={95,95,95}),Polygon(
                  points={{33,80},{30,67},{36,67},{33,80}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Text(
                  extent={{37,57},{83,39}},
                  lineColor={0,0,0},
                  textString="amplitude"),Polygon(
                  points={{33,-2},{30,11},{36,11},{33,-2},{33,-2}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid),Line(points={{33,80},{33,-2}},
                color={95,95,95}),Line(
                  points={{-41,80},{-38,79},{-35.42,75.6},{-31.201,68.7},{-26.98,
                  58.4},{-22.16,43.1},{-16.1,20.2},{-3.5,-31.8},{2,-51.2},{6.8,-65.2},
                  {11,-74.1},{15.2,-79.4},{19.5,-81},{23.7,-78.6},{27.9,-72.5},{
                  32.1,-62.9},{36.9,-48.2},{43,-25.8},{49,-1},{49,-1},{57.4,33.2},{
                  62.9,52.1},{67.7,65.4},{71.9,73.6},{76.1,78.1},{80,79}},
                  color={0,0,255},
                  thickness=0.5,
                  smooth=Smooth.Bezier),Line(
                  points={{-41,80},{-41,-2}},
                  color={0,0,255},
                  thickness=0.5)}),
          Documentation(info="<html>
<p>
The Real output y is a cosine signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/Cosine.png\"
     alt=\"Cosine.png\">
</p>
</html>"));
      end Cosine;

      block TimeTable
      "Generate a (possibly discontinuous) signal by linear interpolation in a table"

        parameter Real table[:, 2] = fill(0.0, 0, 2)
        "Table matrix (time = first column; e.g., table=[0, 0; 1, 1; 2, 4])";
        parameter Real offset=0 "Offset of output signal";
        parameter SIunits.Time startTime=0
        "Output = offset for time < startTime";
        extends Interfaces.SO;
    protected
        Real a "Interpolation coefficients a of actual interval (y=a*x+b)";
        Real b "Interpolation coefficients b of actual interval (y=a*x+b)";
        Integer last(start=1) "Last used lower grid index";
        discrete SIunits.Time nextEvent(start=0, fixed=true)
        "Next event instant";

        function getInterpolationCoefficients
        "Determine interpolation coefficients and next time event"
          extends Modelica.Icons.Function;
          input Real table[:, 2] "Table for interpolation";
          input Real offset "y-offset";
          input Real startTime "time-offset";
          input Real t "Actual time instant";
          input Integer last "Last used lower grid index";
          input Real TimeEps
          "Relative epsilon to check for identical time instants";
          output Real a "Interpolation coefficients a (y=a*x + b)";
          output Real b "Interpolation coefficients b (y=a*x + b)";
          output Real nextEvent "Next event instant";
          output Integer next "New lower grid index";
      protected
          Integer columns=2 "Column to be interpolated";
          Integer ncol=2 "Number of columns to be interpolated";
          Integer nrow=size(table, 1) "Number of table rows";
          Integer next0;
          Real tp;
          Real dt;
        algorithm
          next := last;
          nextEvent := t - TimeEps*abs(t);
          // in case there are no more time events
          tp := t + TimeEps*abs(t) - startTime;

          if tp < 0.0 then
            // First event not yet reached
            nextEvent := startTime;
            a := 0;
            b := offset;
          elseif nrow < 2 then
            // Special action if table has only one row
            a := 0;
            b := offset + table[1, columns];
          else

            // Find next time event instant. Note, that two consecutive time instants
            // in the table may be identical due to a discontinuous point.
            while next < nrow and tp >= table[next, 1] loop
              next := next + 1;
            end while;

            // Define next time event, if last table entry not reached
            if next < nrow then
              nextEvent := startTime + table[next, 1];
            end if;

            // Determine interpolation coefficients
            next0 := next - 1;
            dt := table[next, 1] - table[next0, 1];
            if dt <= TimeEps*abs(table[next, 1]) then
              // Interpolation interval is not big enough, use "next" value
              a := 0;
              b := offset + table[next, columns];
            else
              a := (table[next, columns] - table[next0, columns])/dt;
              b := offset + table[next0, columns] - a*table[next0, 1];
            end if;
          end if;
          // Take into account startTime "a*(time - startTime) + b"
          b := b - a*startTime;
        end getInterpolationCoefficients;
      algorithm
        when {time >= pre(nextEvent),initial()} then
          (a,b,nextEvent,last) := getInterpolationCoefficients(
              table,
              offset,
              startTime,
              time,
              last,
              100*Modelica.Constants.eps);
        end when;
      equation
        y = a*time + b;
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
              Rectangle(
                extent={{-48,70},{2,-50}},
                lineColor={255,255,255},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-48,-50},{-48,70},{52,70},{52,-50},{-48,-50},{-48,-20},
                    {52,-20},{52,10},{-48,10},{-48,40},{52,40},{52,70},{2,70},{2,-51}},
                  color={0,0,0}),
              Text(
                extent={{-150,-150},{150,-110}},
                lineColor={0,0,0},
                textString="offset=%offset")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Polygon(
                points={{-80,90},{-85,68},{-74,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{88,-70},{68,-65},{68,-74},{88,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,90},{30,-30}},
                lineColor={255,255,255},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-20,-30},{-20,90},{80,90},{80,-30},{-20,-30},{-20,0},{
                    80,0},{80,30},{-20,30},{-20,60},{80,60},{80,90},{30,90},{30,-31}},
                  color={0,0,0}),
              Text(
                extent={{-70,-42},{-32,-54}},
                lineColor={0,0,0},
                textString="offset"),
              Polygon(
                points={{-31,-30},{-33,-40},{-28,-40},{-31,-30}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-31,-70},{-34,-60},{-29,-60},{-31,-70},{-31,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-31,-32},{-31,-70}}, color={95,95,95}),
              Line(points={{-20,-30},{-20,-70}}, color={95,95,95}),
              Text(
                extent={{-38,-73},{8,-83}},
                lineColor={0,0,0},
                textString="startTime"),
              Line(points={{-20,-30},{-80,-30}}, color={95,95,95}),
              Text(
                extent={{-76,93},{-44,75}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{66,-78},{90,-88}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-15,83},{24,68}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{33,83},{76,67}},
                lineColor={0,0,0},
                textString="y")}),
              Documentation(info="<HTML>
<p>
This block generates an output signal by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<strong><code>table[i,j]</code></strong>, where the first column table[:,1] contains the
time points and the second column contains the data to be interpolated.
The table interpolation has the following properties:
</p>
<ul>
<li>The time points need to be <b>monotonically increasing</b>. </li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    <b>extrapolation</b> through the last or first two points of the
    table.</li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the function value is just returned independently of the
    actual time instant.</li>
<li>Via parameters <strong><code>startTime</code></strong> and <strong><code>offset</code></strong> the curve defined
    by the table can be shifted both in time and in the ordinate value.</li>
<li>The first point in time <strong>always</strong> has to be set to <strong><code>0</code></strong>, e.g.,
    <strong><code>table=[1,1;2,2]</code></strong> is <strong>illegal</strong>. If you want to
    shift the time table in time use the  <strong><code>startTime</code></strong> parameter instead.</li>
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
</ul>
<p>
Example:
</p>
<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation).
</pre>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/TimeTable.png\"
     alt=\"TimeTable.png\">
</p>

</html>",     revisions="<html>
<h4>Release Notes</h4>
<ul>
<li><i>Oct. 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Corrected interface from
<pre>
    parameter Real table[:, :]=[0, 0; 1, 1; 2, 4];
</pre>
       to
<pre>
    parameter Real table[:, <b>2</b>]=[0, 0; 1, 1; 2, 4];
</pre>
       </li>
<li><i>Nov. 7, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"));
      end TimeTable;

      block CombiTimeTable
      "Table look-up with respect to time and linear/periodic extrapolation methods (data from matrix/file)"
        extends Modelica.Blocks.Interfaces.MO(final nout=max([size(columns, 1);
              size(offset, 1)]));
        parameter Boolean tableOnFile=false
        "= true, if table is defined on file or in function usertab"
          annotation (Dialog(group="Table data definition"));
        parameter Real table[:, :] = fill(0.0, 0, 2)
        "Table matrix (time = first column; e.g., table=[0,2])"
          annotation (Dialog(group="Table data definition",enable=not tableOnFile));
        parameter String tableName="NoName"
        "Table name on file or in function usertab (see docu)"
          annotation (Dialog(group="Table data definition",enable=tableOnFile));
        parameter String fileName="NoName" "File where matrix is stored"
          annotation (Dialog(
            group="Table data definition",
            enable=tableOnFile,
            loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
                caption="Open file in which table is present")));
        parameter Boolean verboseRead=true
        "= true, if info message that file is loading is to be printed"
          annotation (Dialog(group="Table data definition",enable=tableOnFile));
        parameter Integer columns[:]=2:size(table, 2)
        "Columns of table to be interpolated"
          annotation (Dialog(group="Table data interpretation"));
        parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation"
          annotation (Dialog(group="Table data interpretation"));
        parameter Modelica.Blocks.Types.Extrapolation extrapolation=Modelica.Blocks.Types.Extrapolation.LastTwoPoints
        "Extrapolation of data outside the definition range"
          annotation (Dialog(group="Table data interpretation"));
        parameter Real offset[:]={0} "Offsets of output signals"
          annotation (Dialog(group="Table data interpretation"));
        parameter Modelica.SIunits.Time startTime=0
        "Output = offset for time < startTime"
          annotation (Dialog(group="Table data interpretation"));
        final parameter Modelica.SIunits.Time t_min(fixed=false)
        "Minimum abscissa value defined in table";
        final parameter Modelica.SIunits.Time t_max(fixed=false)
        "Maximum abscissa value defined in table";
    protected
        final parameter Real p_offset[nout]=(if size(offset, 1) == 1 then ones(nout)*offset[1] else offset)
        "Offsets of output signals";
        Modelica.Blocks.Types.ExternalCombiTimeTable tableID=
            Modelica.Blocks.Types.ExternalCombiTimeTable(
              if tableOnFile then tableName else "NoName",
              if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
              table,
              startTime,
              columns,
              smoothness,
              extrapolation) "External table object";
        discrete Modelica.SIunits.Time nextTimeEvent(start=0, fixed=true)
        "Next time event instant";
        parameter Real tableOnFileRead(fixed=false)
        "= 1, if table was successfully read from file";

        function readTableData
        "Read table data from ASCII text or MATLAB MAT-file"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Boolean forceRead = false
          "= true: Force reading of table data; = false: Only read, if not yet read.";
          output Real readSuccess "Table read success";
          input Boolean verboseRead
          "= true: Print info message; = false: No info message";
          external"C" readSuccess = ModelicaStandardTables_CombiTimeTable_read(tableID, forceRead, verboseRead)
            annotation (Library={"ModelicaStandardTables"});
        end readTableData;

        function getTableValue
        "Interpolate 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Integer icol;
          input Modelica.SIunits.Time timeIn;
          discrete input Modelica.SIunits.Time nextTimeEvent;
          discrete input Modelica.SIunits.Time pre_nextTimeEvent;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Real y;
          external"C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
            annotation (Library={"ModelicaStandardTables"});
          annotation (derivative(
              noDerivative=nextTimeEvent,
              noDerivative=pre_nextTimeEvent,
              noDerivative=tableAvailable) = getDerTableValue);
        end getTableValue;

        function getTableValueNoDer
        "Interpolate 1-dim. table where first column is time (but do not provide a derivative function)"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Integer icol;
          input Modelica.SIunits.Time timeIn;
          discrete input Modelica.SIunits.Time nextTimeEvent;
          discrete input Modelica.SIunits.Time pre_nextTimeEvent;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Real y;
          external"C" y = ModelicaStandardTables_CombiTimeTable_getValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent)
            annotation (Library={"ModelicaStandardTables"});
        end getTableValueNoDer;

        function getDerTableValue
        "Derivative of interpolated 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Integer icol;
          input Modelica.SIunits.Time timeIn;
          discrete input Modelica.SIunits.Time nextTimeEvent;
          discrete input Modelica.SIunits.Time pre_nextTimeEvent;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          input Real der_timeIn;
          output Real der_y;
          external"C" der_y = ModelicaStandardTables_CombiTimeTable_getDerValue(tableID, icol, timeIn, nextTimeEvent, pre_nextTimeEvent, der_timeIn)
            annotation (Library={"ModelicaStandardTables"});
        end getDerTableValue;

        function getTableTimeTmin
        "Return minimum time value of 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Modelica.SIunits.Time timeMin "Minimum time value in table";
          external"C" timeMin = ModelicaStandardTables_CombiTimeTable_minimumTime(tableID)
            annotation (Library={"ModelicaStandardTables"});
        end getTableTimeTmin;

        function getTableTimeTmax
        "Return maximum time value of 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Modelica.SIunits.Time timeMax "Maximum time value in table";
          external"C" timeMax = ModelicaStandardTables_CombiTimeTable_maximumTime(tableID)
            annotation (Library={"ModelicaStandardTables"});
        end getTableTimeTmax;

        function getNextTimeEvent
        "Return next time event value of 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTimeTable tableID;
          input Modelica.SIunits.Time timeIn;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Modelica.SIunits.Time nextTimeEvent "Next time event in table";
          external"C" nextTimeEvent = ModelicaStandardTables_CombiTimeTable_nextTimeEvent(tableID, timeIn)
            annotation (Library={"ModelicaStandardTables"});
        end getNextTimeEvent;

      initial algorithm
        if tableOnFile then
          tableOnFileRead := readTableData(tableID, false, verboseRead);
        else
          tableOnFileRead := 1.;
        end if;
        t_min := getTableTimeTmin(tableID, tableOnFileRead);
        t_max := getTableTimeTmax(tableID, tableOnFileRead);
      equation
        if tableOnFile then
          assert(tableName <> "NoName",
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
        when {time >= pre(nextTimeEvent),initial()} then
          nextTimeEvent = getNextTimeEvent(tableID, time, tableOnFileRead);
        end when;
        if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
          for i in 1:nout loop
            y[i] = p_offset[i] + getTableValueNoDer(tableID, i, time, nextTimeEvent, pre(nextTimeEvent), tableOnFileRead);
          end for;
        else
          for i in 1:nout loop
            y[i] = p_offset[i] + getTableValue(tableID, i, time, nextTimeEvent, pre(nextTimeEvent), tableOnFileRead);
          end for;
        end if;
        annotation (
          Documentation(info="<HTML>
<p>
This block generates an output signal y[:] by <b>linear interpolation</b> in
a table. The time points and function values are stored in a matrix
<b>table[i,j]</b>, where the first column table[:,1] contains the
time points and the other columns contain the data to be interpolated.
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/CombiTimeTable.png\"
     alt=\"CombiTimeTable.png\">
</p>

<p>
Via parameter <b>columns</b> it can be defined which columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that
2 output signals are present and that the first output is computed
by interpolation of column 2 and the second output is computed
by interpolation of column 4 of the table matrix.
The table interpolation has the following properties:
</p>
<ul>
<li>The time points need to be <b>strictly increasing</b> if smoothness
    is ContinuousDerivative, otherwise <b>monotonically increasing</b>.</li>
<li><b>Discontinuities</b> are allowed, by providing the same
    time point twice in the table. </li>
<li>Values <b>outside</b> of the table range, are computed by
    extrapolation according to the setting of parameter
    <b>extrapolation</b>:
<pre>
  extrapolation = 1: hold the first or last value of the table,
                     if outside of the table scope.
                = 2: extrapolate by using the derivative at the first/last table
                     points if outside of the table scope.
                     (If smoothness is LinearSegments or ConstantSegments
                     this means to extrapolate linearly through the first/last
                     two table points.).
                = 3: periodically repeat the table data
                     (periodical function).
                = 4: no extrapolation, i.e. extrapolation triggers an error
</pre></li>
<li>Via parameter <b>smoothness</b> it is defined how the data is interpolated:
<pre>
  smoothness = 1: linear interpolation
             = 2: smooth interpolation with Akima-splines such
                  that der(y) is continuous, also if extrapolated.
             = 3: constant segments
</pre></li>
<li>If the table has only <b>one row</b>, no interpolation is performed and
    the table values of this row are just returned.</li>
<li>Via parameters <b>startTime</b> and <b>offset</b> the curve defined
    by the table can be shifted both in time and in the ordinate value.
    The time instants stored in the table are therefore <b>relative</b>
    to <b>startTime</b>.
    If time &lt; startTime, no interpolation is performed and the offset
    is used as ordinate value for all outputs.</li>
<li>The table is implemented in a numerically sound way by
    generating <b>time events</b> at interval boundaries.
    This generates continuously differentiable values for the integrator.</li>
<li>For special applications it is sometimes needed to know the minimum
    and maximum time instant defined in the table as a parameter. For this
    reason parameters <b>t_min</b> and <b>t_max</b> are provided and can be
    accessed from the outside of the table object.</li>
</ul>
<p>
Example:
</p>
<pre>
   table = [0  0
            1  0
            1  1
            2  4
            3  9
            4 16]; extrapolation = 3 (default)
If, e.g., time = 1.0, the output y =  0.0 (before event), 1.0 (after event)
    e.g., time = 1.5, the output y =  2.5,
    e.g., time = 2.0, the output y =  4.0,
    e.g., time = 5.0, the output y = 23.0 (i.e., extrapolation via last 2 points).
</pre>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and MAT-file format is possible.
      (The ASCII format is described below).
      The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
      The library supports at least v4, v6 and v7 whereas v7.3 is optional.
      It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
      by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
      or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
      when the three tables tab1, tab2, tab3 should be used from the model.<br>
      Note, a fileName can be defined as URI by using the helper function
      <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
      preferred as otherwise the table is reallocated and transposed.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(6,2)   # comment line
  0   0
  1   0
  1   1
  2   4
  3   9
  4  16
double tab2(6,2)   # another comment line
  0   0
  2   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>",     revisions="<html>
<p><b>Release Notes:</b></p>
<ul>
<li><i>April 09, 2013</i>
       by Thomas Beutlich:<br>
       Implemented as external object.</li>
<li><i>March 31, 2001</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Used CombiTableTime as a basis and added the
       arguments <b>extrapolation, columns, startTime</b>.
       This allows periodic function definitions.</li>
</ul>
</html>"),Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Polygon(visible=true,
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{-80.0,90.0},{-88.0,68.0},{-72.0,68.0},{-80.0,90.0}}),
          Line(visible=true,
            points={{-80.0,68.0},{-80.0,-80.0}},
            color={192,192,192}),
          Line(visible=true,
            points={{-90.0,-70.0},{82.0,-70.0}},
            color={192,192,192}),
          Polygon(visible=true,
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid,
            points={{90.0,-70.0},{68.0,-62.0},{68.0,-78.0},{90.0,-70.0}}),
          Rectangle(visible=true,
            lineColor={255,255,255},
            fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-48.0,-50.0},{2.0,70.0}}),
          Line(visible=true,
            points={{-48.0,-50.0},{-48.0,70.0},{52.0,70.0},{52.0,-50.0},{-48.0,-50.0},{-48.0,-20.0},{52.0,-20.0},{52.0,10.0},{-48.0,10.0},{-48.0,40.0},{52.0,40.0},{52.0,70.0},{2.0,70.0},{2.0,-51.0}})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Polygon(
                points={{-80,90},{-88,68},{-72,68},{-80,90}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-80,68},{-80,-80}}, color={95,95,95}),
              Line(points={{-90,-70},{82,-70}}, color={95,95,95}),
              Polygon(
                points={{90,-70},{68,-62},{68,-78},{90,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-20,90},{20,-30}},
                lineColor={255,255,255},
                fillColor={192,192,192},
                fillPattern=FillPattern.Solid),
              Line(points={{-20,-30},{-20,90},{80,90},{80,-30},{-20,-30},{-20,0},{
                    80,0},{80,30},{-20,30},{-20,60},{80,60},{80,90},{20,90},{20,-30}},
                  color={0,0,0}),
              Text(
                extent={{-71,-42},{-32,-54}},
                lineColor={0,0,0},
                textString="offset"),
              Polygon(
                points={{-31,-30},{-33,-40},{-28,-40},{-31,-30}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Polygon(
                points={{-31,-70},{-34,-60},{-29,-60},{-31,-70},{-31,-70}},
                lineColor={95,95,95},
                fillColor={95,95,95},
                fillPattern=FillPattern.Solid),
              Line(points={{-31,-31},{-31,-70}}, color={95,95,95}),
              Line(points={{-20,-30},{-20,-70}}, color={95,95,95}),
              Text(
                extent={{-42,-74},{6,-84}},
                lineColor={0,0,0},
                textString="startTime"),
              Line(points={{-20,-30},{-80,-30}}, color={95,95,95}),
              Text(
                extent={{-73,93},{-44,74}},
                lineColor={0,0,0},
                textString="y"),
              Text(
                extent={{66,-81},{92,-92}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{-19,83},{20,68}},
                lineColor={0,0,0},
                textString="time"),
              Text(
                extent={{21,82},{50,68}},
                lineColor={0,0,0},
                textString="y[1]"),
              Line(points={{50,90},{50,-30}}, color={0,0,0}),
              Line(points={{80,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{34,-30},{71,-42}},
                textString="columns",
                lineColor={0,0,255}),
              Text(
                extent={{51,82},{80,68}},
                lineColor={0,0,0},
                textString="y[2]")}));
      end CombiTimeTable;

      block BooleanConstant "Generate constant signal of type Boolean"
        parameter Boolean k=true "Constant output value";
        extends Interfaces.partialBooleanSource;

      equation
        y = k;
        annotation (
          Icon(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={Line(points={{-80,0},{80,0}}, color={0,0,0}),
                Text(
                extent={{-150,-140},{150,-110}},
                lineColor={0,0,0},
                textString="%k")}),
          Diagram(coordinateSystem(
              preserveAspectRatio=true,
              extent={{-100,-100},{100,100}}), graphics={
              Line(
                points={{-70,0},{80,0}},
                color={0,0,255},
                thickness=0.5),
              Text(
                extent={{-69,20},{-49,0}},
                lineColor={0,0,0},
                textString="k"),
              Text(
                extent={{-96,6},{-76,-4}},
                lineColor={0,0,0},
                textString="true"),
              Text(
                extent={{-98,-58},{-72,-68}},
                lineColor={0,0,0},
                textString="false")}),
            Documentation(info="<html>
<p>
The Boolean output y is a constant signal:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Blocks/Sources/BooleanConstant.png\"
     alt=\"BooleanConstant.png\">
</p>
</html>"));
      end BooleanConstant;
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

    package Tables
    "Library of blocks to interpolate in one and two-dimensional tables"
      extends Modelica.Icons.Package;

      block CombiTable1D
      "Table look-up in one dimension (matrix/file) with n inputs and n outputs"
        extends Modelica.Blocks.Interfaces.MIMOs(final n=size(columns, 1));
        parameter Boolean tableOnFile=false
        "= true, if table is defined on file or in function usertab"
          annotation (Dialog(group="Table data definition"));
        parameter Real table[:, :] = fill(0.0, 0, 2)
        "Table matrix (grid = first column; e.g., table=[0,2])"
          annotation (Dialog(group="Table data definition",enable=not tableOnFile));
        parameter String tableName="NoName"
        "Table name on file or in function usertab (see docu)"
          annotation (Dialog(group="Table data definition",enable=tableOnFile));
        parameter String fileName="NoName" "File where matrix is stored"
          annotation (Dialog(
            group="Table data definition",
            enable=tableOnFile,
            loadSelector(filter="Text files (*.txt);;MATLAB MAT-files (*.mat)",
                caption="Open file in which table is present")));
        parameter Boolean verboseRead=true
        "= true, if info message that file is loading is to be printed"
          annotation (Dialog(group="Table data definition",enable=tableOnFile));
        parameter Integer columns[:]=2:size(table, 2)
        "Columns of table to be interpolated"
          annotation (Dialog(group="Table data interpretation"));
        parameter Modelica.Blocks.Types.Smoothness smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments
        "Smoothness of table interpolation"
          annotation (Dialog(group="Table data interpretation"));
    protected
        Modelica.Blocks.Types.ExternalCombiTable1D tableID=
            Modelica.Blocks.Types.ExternalCombiTable1D(
              if tableOnFile then tableName else "NoName",
              if tableOnFile and fileName <> "NoName" and not Modelica.Utilities.Strings.isEmpty(fileName) then fileName else "NoName",
              table,
              columns,
              smoothness) "External table object";
        parameter Real tableOnFileRead(fixed=false)
        "= 1, if table was successfully read from file";

        function readTableData
        "Read table data from ASCII text or MATLAB MAT-file"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Boolean forceRead = false
          "= true: Force reading of table data; = false: Only read, if not yet read.";
          input Boolean verboseRead
          "= true: Print info message; = false: No info message";
          output Real readSuccess "Table read success";
          external"C" readSuccess = ModelicaStandardTables_CombiTable1D_read(tableID, forceRead, verboseRead)
            annotation (Library={"ModelicaStandardTables"});
        end readTableData;

        function getTableValue "Interpolate 1-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Real y;
          external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
            annotation (Library={"ModelicaStandardTables"});
          annotation (derivative(noDerivative=tableAvailable) = getDerTableValue);
        end getTableValue;

        function getTableValueNoDer
        "Interpolate 1-dim. table defined by matrix (but do not provide a derivative function)"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          output Real y;
          external"C" y = ModelicaStandardTables_CombiTable1D_getValue(tableID, icol, u)
            annotation (Library={"ModelicaStandardTables"});
        end getTableValueNoDer;

        function getDerTableValue
        "Derivative of interpolated 1-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input Modelica.Blocks.Types.ExternalCombiTable1D tableID;
          input Integer icol;
          input Real u;
          input Real tableAvailable
          "Dummy input to ensure correct sorting of function calls";
          input Real der_u;
          output Real der_y;
          external"C" der_y = ModelicaStandardTables_CombiTable1D_getDerValue(tableID, icol, u, der_u)
            annotation (Library={"ModelicaStandardTables"});
        end getDerTableValue;

      initial algorithm
        if tableOnFile then
          tableOnFileRead := readTableData(tableID, false, verboseRead);
        else
          tableOnFileRead := 1.;
        end if;
      equation
        if tableOnFile then
          assert(tableName <> "NoName",
            "tableOnFile = true and no table name given");
        else
          assert(size(table, 1) > 0 and size(table, 2) > 0,
            "tableOnFile = false and parameter table is an empty matrix");
        end if;
        if smoothness == Modelica.Blocks.Types.Smoothness.ConstantSegments then
          for i in 1:n loop
            y[i] = getTableValueNoDer(tableID, i, u[i], tableOnFileRead);
          end for;
        else
          for i in 1:n loop
            y[i] = getTableValue(tableID, i, u[i], tableOnFileRead);
          end for;
        end if;
        annotation (
          Documentation(info="<html>
<p>
<b>Linear interpolation</b> in <b>one</b> dimension of a <b>table</b>.
Via parameter <b>columns</b> it can be defined how many columns of the
table are interpolated. If, e.g., columns={2,4}, it is assumed that 2 input
and 2 output signals are present and that the first output interpolates
the first input via column 2 and the second output interpolates the
second input via column 4 of the table matrix.
</p>
<p>
The grid points and function values are stored in a matrix \"table[i,j]\",
where the first column \"table[:,1]\" contains the grid points and the
other columns contain the data to be interpolated. Example:
</p>
<pre>
   table = [0,  0;
            1,  1;
            2,  4;
            4, 16]
   If, e.g., the input u = 1.0, the output y =  1.0,
       e.g., the input u = 1.5, the output y =  2.5,
       e.g., the input u = 2.0, the output y =  4.0,
       e.g., the input u =-1.0, the output y = -1.0 (i.e., extrapolation).
</pre>
<ul>
<li> The interpolation is <b>efficient</b>, because a search for a new interpolation
     starts at the interval used in the last call.</li>
<li> If the table has only <b>one row</b>, the table value is returned,
     independent of the value of the input signal.</li>
<li> If the input signal <b>u[i]</b> is <b>outside</b> of the defined <b>interval</b>, i.e.,
     u[i] &gt; table[size(table,1),i+1] or u[i] &lt; table[1,1], the corresponding
     value is also determined by linear
     interpolation through the last or first two points of the table.</li>
<li> The grid values (first column) have to be strictly increasing.</li>
</ul>
<p>
The table matrix can be defined in the following ways:
</p>
<ol>
<li> Explicitly supplied as <b>parameter matrix</b> \"table\",
     and the other parameters have the following values:
<pre>
   tableName is \"NoName\" or has only blanks,
   fileName  is \"NoName\" or has only blanks.
</pre></li>
<li> <b>Read</b> from a <b>file</b> \"fileName\" where the matrix is stored as
      \"tableName\". Both ASCII and MAT-file format is possible.
      (The ASCII format is described below).
      The MAT-file format comes in four different versions: v4, v6, v7 and v7.3.
      The library supports at least v4, v6 and v7 whereas v7.3 is optional.
      It is most convenient to generate the MAT-file from FreeMat or MATLAB&reg;
      by command
<pre>
   save tables.mat tab1 tab2 tab3
</pre>
      or Scilab by command
<pre>
   savematfile tables.mat tab1 tab2 tab3
</pre>
      when the three tables tab1, tab2, tab3 should be used from the model.<br>
      Note, a fileName can be defined as URI by using the helper function
      <a href=\"modelica://Modelica.Utilities.Files.loadResource\">loadResource</a>.</li>
<li>  Statically stored in function \"usertab\" in file \"usertab.c\".
      The matrix is identified by \"tableName\". Parameter
      fileName = \"NoName\" or has only blanks. Row-wise storage is always to be
      preferred as otherwise the table is reallocated and transposed.
      See the <a href=\"modelica://Modelica.Blocks.Tables\">Tables</a> package
      documentation for more details.</li>
</ol>
<p>
When the constant \"NO_FILE_SYSTEM\" is defined, all file I/O related parts of the
source code are removed by the C-preprocessor, such that no access to files takes place.
</p>
<p>
If tables are read from an ASCII-file, the file needs to have the
following structure (\"-----\" is not part of the file content):
</p>
<pre>
-----------------------------------------------------
#1
double tab1(5,2)   # comment line
  0   0
  1   1
  2   4
  3   9
  4  16
double tab2(5,2)   # another comment line
  0   0
  2   2
  4   8
  6  18
  8  32
-----------------------------------------------------
</pre>
<p>
Note, that the first two characters in the file need to be
\"#1\" (a line comment defining the version number of the file format).
Afterwards, the corresponding matrix has to be declared
with type (= \"double\" or \"float\"), name and actual dimensions.
Finally, in successive rows of the file, the elements of the matrix
have to be given. The elements have to be provided as a sequence of
numbers in row-wise order (therefore a matrix row can span several
lines in the file and need not start at the beginning of a line).
Numbers have to be given according to C syntax (such as 2.3, -2, +2.e4).
Number separators are spaces, tab (\t), comma (,), or semicolon (;).
Several matrices may be defined one after another. Line comments start
with the hash symbol (#) and can appear everywhere.
Other characters, like trailing non comments, are not allowed in the file.
</p>
<p>
MATLAB is a registered trademark of The MathWorks, Inc.
</p>
</html>"),Icon(
          coordinateSystem(preserveAspectRatio=true,
            extent={{-100.0,-100.0},{100.0,100.0}},
            initialScale=0.1),
            graphics={
          Line(points={{-60.0,40.0},{-60.0,-40.0},{60.0,-40.0},{60.0,40.0},{30.0,40.0},{30.0,-40.0},{-30.0,-40.0},{-30.0,40.0},{-60.0,40.0},{-60.0,20.0},{60.0,20.0},{60.0,0.0},{-60.0,0.0},{-60.0,-20.0},{60.0,-20.0},{60.0,-40.0},{-60.0,-40.0},{-60.0,40.0},{60.0,40.0},{60.0,-40.0}}),
          Line(points={{0.0,40.0},{0.0,-40.0}}),
          Rectangle(fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-60.0,20.0},{-30.0,40.0}}),
          Rectangle(fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-60.0,0.0},{-30.0,20.0}}),
          Rectangle(fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-60.0,-20.0},{-30.0,0.0}}),
          Rectangle(fillColor={255,215,136},
            fillPattern=FillPattern.Solid,
            extent={{-60.0,-40.0},{-30.0,-20.0}})}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-60,60},{60,-60}},
                fillColor={235,235,235},
                fillPattern=FillPattern.Solid,
                lineColor={0,0,255}),
              Line(points={{-100,0},{-58,0}}, color={0,0,255}),
              Line(points={{60,0},{100,0}}, color={0,0,255}),
              Text(
                extent={{-100,100},{100,64}},
                textString="1 dimensional linear table interpolation",
                lineColor={0,0,255}),
              Line(points={{-54,40},{-54,-40},{54,-40},{54,40},{28,40},{28,-40},{-28,
                    -40},{-28,40},{-54,40},{-54,20},{54,20},{54,0},{-54,0},{-54,-20},
                    {54,-20},{54,-40},{-54,-40},{-54,40},{54,40},{54,-40}}, color={
                    0,0,0}),
              Line(points={{0,40},{0,-40}}, color={0,0,0}),
              Rectangle(
                extent={{-54,40},{-28,20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,20},{-28,0}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,0},{-28,-20}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-54,-20},{-28,-40}},
                lineColor={0,0,0},
                fillColor={255,255,0},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-50,54},{-32,42}},
                textString="u[1]/[2]",
                lineColor={0,0,255}),
              Text(
                extent={{-24,54},{0,42}},
                textString="y[1]",
                lineColor={0,0,255}),
              Text(
                extent={{-2,-40},{30,-54}},
                textString="columns",
                lineColor={0,0,255}),
              Text(
                extent={{2,54},{26,42}},
                textString="y[2]",
                lineColor={0,0,255})}));
      end CombiTable1D;
      annotation (Documentation(info="<html>
<p>This package contains blocks for one- and two-dimensional interpolation in tables. </p>
<h4>Special interest topic: Statically stored tables for real-time simulation targets</h4>
<p>Especially for use on real-time platform targets (e.g., HIL-simulators) with <b>no file system</b>, it is possible to statically
store tables using a function &quot;usertab&quot; in a file conventionally named &quot;usertab.c&quot;. This can be more efficient than providing the tables as Modelica parameter arrays.</p>
<p>This is achieved by providing the tables in a specific structure as C-code and compiling that C-code together with the rest of the simulation model into a binary
that can be executed on the target platform. The &quot;Resources/Data/Tables/&quot; subdirectory of the MSL installation directory contains the files
<a href=\"modelica://Modelica/Resources/Data/Tables/usertab.c\">&quot;usertab.c&quot;</a> and <a href=\"modelica://Modelica/Resources/Data/Tables/usertab.h\">&quot;usertab.h&quot;</a>
that can be used as a template for own developments. While &quot;usertab.c&quot; would be typically used unmodified, the
&quot;usertab.h&quot; needs to adapted for the own needs.</p>
<p>In order to work it is necessary that the compiler pulls in the &quot;usertab.c&quot; file. Different Modelica tools might provide different mechanisms to do so.
Please consult the respective documentation/support for your Modelica tool.</p>
<p>A possible (though a bit &quot;hackish&quot;) Modelica standard conformant approach is to pull in the required files by utilizing a &quot;dummy&quot;-function that uses the Modelica external function
interface to pull in the required &quot;usertab.c&quot;. An example how this can be done is given below.</p>
<pre>
model Test25_usertab \"Test utilizing the usertab.c interface\"
  extends Modelica.Icons.Example;
public
  Modelica.Blocks.Sources.RealExpression realExpression(y=getUsertab(t_new.y))
    annotation (Placement(transformation(extent={{-40,-34},{-10,-14}})));
  Modelica.Blocks.Tables.CombiTable1D t_new(tableOnFile=true, tableName=\"TestTable_1D_a\")
    annotation (Placement(transformation(extent={{-40,0},{-20,20}})));
  Modelica.Blocks.Sources.Clock clock
    annotation (Placement(transformation(extent={{-80,0},{-60,20}})));
protected
  encapsulated function getUsertab
    input Real dummy_u[:];
    output Real dummy_y;
    external \"C\" dummy_y=  mydummyfunc(dummy_u);
    annotation(IncludeDirectory=\"modelica://Modelica/Resources/Data/Tables\",
           Include = \"#include \"usertab.c\"
 double mydummyfunc(const double* dummy_in) {
        return 0;
}
\");
  end getUsertab;
equation
  connect(clock.y,t_new. u[1]) annotation (Line(
      points={{-59,10},{-42,10}},
      color={0,0,127},
      smooth=Smooth.None));
  annotation (experiment(StartTime=0, StopTime=5), uses(Modelica(version=\"3.2.1\")));
end Test25_usertab;
</pre>
</html>"),     Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},
                {100,100}}), graphics={
            Rectangle(
              extent={{-76,-26},{80,-76}},
              lineColor={95,95,95},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-76,24},{80,-26}},
              lineColor={95,95,95},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Rectangle(
              extent={{-76,74},{80,24}},
              lineColor={95,95,95},
              fillColor={235,235,235},
              fillPattern=FillPattern.Solid),
            Line(
              points={{-28,74},{-28,-76}},
              color={95,95,95}),
            Line(
              points={{24,74},{24,-76}},
              color={95,95,95})}));
    end Tables;

    package Types
    "Library of constants and types with choices, especially to build menus"
      extends Modelica.Icons.TypesPackage;

      type Smoothness = enumeration(
        LinearSegments "Table points are linearly interpolated",
        ContinuousDerivative
          "Table points are interpolated such that the first derivative is continuous",

        ConstantSegments
          "Table points are not interpolated, but the value from the previous abscissa point is returned")
      "Enumeration defining the smoothness of table interpolation";

      type Extrapolation = enumeration(
        HoldLastPoint
          "Hold the first/last table point outside of the table scope",
        LastTwoPoints
          "Extrapolate by using the derivative at the first/last table points outside of the table scope",

        Periodic "Repeat the table scope periodically",
        NoExtrapolation "Extrapolation triggers an error")
      "Enumeration defining the extrapolation of time table interpolation";

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

      class ExternalCombiTimeTable
      "External object of 1-dim. table where first column is time"
        extends ExternalObject;

        function constructor
        "Initialize 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input String tableName "Table name";
          input String fileName "File name";
          input Real table[:, :];
          input Modelica.SIunits.Time startTime;
          input Integer columns[:];
          input Modelica.Blocks.Types.Smoothness smoothness;
          input Modelica.Blocks.Types.Extrapolation extrapolation;
          output ExternalCombiTimeTable externalCombiTimeTable;
        external"C" externalCombiTimeTable =
            ModelicaStandardTables_CombiTimeTable_init(
                tableName,
                fileName,
                table,
                size(table, 1),
                size(table, 2),
                startTime,
                columns,
                size(columns, 1),
                smoothness,
                extrapolation) annotation (Library={"ModelicaStandardTables"});
        end constructor;

        function destructor "Terminate 1-dim. table where first column is time"
          extends Modelica.Icons.Function;
          input ExternalCombiTimeTable externalCombiTimeTable;
        external"C" ModelicaStandardTables_CombiTimeTable_close(
            externalCombiTimeTable) annotation (Library={"ModelicaStandardTables"});
        end destructor;

      end ExternalCombiTimeTable;

      class ExternalCombiTable1D
      "External object of 1-dim. table defined by matrix"
        extends ExternalObject;

        function constructor "Initialize 1-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input String tableName "Table name";
          input String fileName "File name";
          input Real table[:, :];
          input Integer columns[:];
          input Modelica.Blocks.Types.Smoothness smoothness;
          output ExternalCombiTable1D externalCombiTable1D;
        external"C" externalCombiTable1D = ModelicaStandardTables_CombiTable1D_init(
                tableName,
                fileName,
                table,
                size(table, 1),
                size(table, 2),
                columns,
                size(columns, 1),
                smoothness) annotation (Library={"ModelicaStandardTables"});
        end constructor;

        function destructor "Terminate 1-dim. table defined by matrix"
          extends Modelica.Icons.Function;
          input ExternalCombiTable1D externalCombiTable1D;
        external"C" ModelicaStandardTables_CombiTable1D_close(externalCombiTable1D)
            annotation (Library={"ModelicaStandardTables"});
        end destructor;

      end ExternalCombiTable1D;
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

      partial block PartialBooleanBlock
      "Basic graphical layout of logical block"

        annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,
                  -100},{100,100}}), graphics={Rectangle(
                extent={{-100,100},{100,-100}},
                fillColor={210,210,210},
                lineThickness=5.0,
                fillPattern=FillPattern.Solid,
                borderPattern=BorderPattern.Raised), Text(
                extent={{-150,150},{150,110}},
                textString="%name",
                lineColor={0,0,255})}),                        Documentation(info="<html>
<p>
Block that has only the basic icon for an input/output,
Boolean block (no declarations, no equations) used especially
in the Blocks.Logical library.
</p>
</html>"));
      end PartialBooleanBlock;
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

    package FluidHeatFlow
    "Simple components for 1-dimensional incompressible thermo-fluid flow models"
      extends Modelica.Icons.Package;

      package Media "Medium properties"
        extends Modelica.Icons.MaterialPropertiesPackage;

        record Medium "Record containing media properties"
          extends Modelica.Icons.Record;
          parameter Modelica.SIunits.Density rho = 1 "Density";
          parameter Modelica.SIunits.SpecificHeatCapacity cp = 1
          "Specific heat capacity at constant pressure";
          parameter Modelica.SIunits.SpecificHeatCapacity cv = 1
          "Specific heat capacity at constant volume";
          parameter Modelica.SIunits.ThermalConductivity lamda = 1
          "Thermal conductivity";
          parameter Modelica.SIunits.KinematicViscosity nue = 1
          "Kinematic viscosity";
          annotation (Documentation(info="<html>
Record containing (constant) medium properties.
</html>"));
        end Medium;

        record Water "Medium: properties of water"
        extends Medium(
          rho=995.6,
          cp=4177,
          cv=4177,
          lamda=0.615,
          nue=0.8E-6);
          annotation (Documentation(info="<html>
Medium: properties of water
</html>"));
        end Water;
      annotation (Documentation(info="<HTML>
This package contains definitions of medium properties.<br>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
<p>
  Dr. Christian Kral<br>
  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2015, Modelica Association, Anton Haumer, Christian Kral and Austrian Institute of Technology, AIT.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>",     revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  </ul>
</html>"));
      end Media;
      annotation (
        Documentation(info="<HTML>
This package contains very simple-to-use components to model coolant flows as needed to simulate cooling e.g., of electric machines:
<ul>
<li>Components: components like different types of pipe models</li>
<li>Examples: some test examples</li>
<li>Interfaces: definition of connectors and partial models
(containing the core thermodynamic equations)</li>
<li>Media: definition of media properties</li>
<li>Sensors: various sensors for pressure, temperature, volume and enthalpy flow</li>
<li>Sources: various flow sources</li>
</ul>
<b>Variables used in connectors:</b>
<ul>
<li>Pressure p</li>
<li>flow MassFlowRate m_flow</li>
<li>SpecificEnthalpy h</li>
<li>flow EnthalpyFlowRate H_flow</li>
</ul>
EnthalpyFlowRate means the Enthalpy = cp<sub>constant</sub> * m * T that is carried by the medium's flow.<br><br>
<b>Limitations and assumptions:</b>
<ul>
<li>Splitting and mixing of coolant flows (media with the same cp) is possible.</li>
<li>Reversing the direction of flow is possible.</li>
<li>The medium is considered to be incompressible.</li>
<li>No mixtures of media is taken into consideration.</li>
<li>The medium may not change its phase.</li>
<li>Medium properties are kept constant.</li>
<li>Pressure changes are only due to pressure drop and geodetic height difference rho*g*h (if h > 0).</li>
<li>A user-defined part (0..1) of the friction losses (V_flow*dp) are fed to the medium.</li>
<li><b>Note:</b> Connected flowPorts have the same temperature (mixing temperature)!<br>
Since mixing may occur, the outlet temperature may be different from the connector's temperature.<br>
Outlet temperature is defined by variable T of the corresponding component.</li>
</ul>
<b>Further development:</b>
<ul>
<li>Additional components like tanks (if needed)</li>
</ul>
<dl>
  <dt><b>Main Authors:</b></dt>
  <dd>
  <p>
  <a href=\"http://www.haumer.at/\">Anton Haumer</a><br>
  Technical Consulting &amp; Electrical Engineering<br>
  A-3423 St.Andrae-Woerdern, Austria<br>
  email: <a href=\"mailto:a.haumer@haumer.at\">a.haumer@haumer.at</a>
</p>
<p>
  Dr. Christian Kral<br>
  <a href=\"http://christiankral.net/\">Electric Machines, Drives and Systems</a><br>
  A-1060 Vienna, Austria<br>
  email: <a href=\"mailto:dr.christian.kral@gmail.com\">dr.christian.kral@gmail.com</a>
</p>
  </dd>
</dl>
<p>
Copyright &copy; 1998-2015, Modelica Association, Anton Haumer, Christian Kral and AIT.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</HTML>",     revisions="<HTML>
  <ul>
  <li> v1.00 2005/02/01 Anton Haumer<br>
       first stable official release</li>
  <li> v1.10 2005/02/15 Anton Haumer<br>
       reorganisation of the package</li>
  <li> v1.11 2005/02/18 Anton Haumer<br>
       corrected usage of cv and cp</li>
  <li> v1.20 Beta 2005/02/18 Anton Haumer<br>
       introduced geodetic height in Components.Pipes<br>
       <i>new models: Components.Valve, Sources.IdealPump</i></li>
  <li> v1.30 Beta 2005/06/02 Anton Haumer<br>
       friction losses are fed to medium</li>
  <li> v1.31 Beta 2005/06/04 Anton Haumer<br>
       <i>new example: PumpAndValve</i><br>
       <i>new example: PumpDropOut</i></li>
  <li> v1.33 Beta 2005/06/07 Anton Haumer<br>
       corrected usage of simpleFlow</li>
  <li> v1.40 2005/06/13 Anton Haumer<br>
       stable release</li>
  <li> v1.42 Beta 2005/06/18 Anton Haumer<br>
       <i>new test example: ParallelPumpDropOut</i></li>
  <li> v1.43 Beta 2005/06/20 Anton Haumer<br>
       Test of mixing / semiLinear<br>
       <i>new test example: OneMass</i><br>
       <i>new test example: TwoMass</i></li>
  <li> v1.50 2005/09/07 Anton Haumer<br>
       semiLinear works fine</li>
  <li> v1.60 2007/01/23 Anton Haumer<br>
       new parameter tapT defining Temperature of heatPort </li>
  <li> v1.6.1 2007/08/12 Anton Haumer<br>
       improved documentation<br>
       removed type TemperatureDifference since this is defined in Modelica.SIunits</li>
  <li> v1.6.2 2007/08/20 Anton Haumer<br>
       improved documentation</li>
  <li> v1.6.3 2007/08/21 Anton Haumer<br>
       improved documentation</li>
  <li> v1.6.4 2007/08/24 Anton Haumer<br>
       removed redeclare type SignalType</li>
  <li> v1.6.5 2007/08/26 Anton Haumer<br>
       fixed unit bug in SimpleFriction</li>
  <li> v1.6.6 2007/11/13 Anton Haumer<br>
       replaced all nonSIunits<br>
       some renaming to be more concise</li>
  <li> v1.6.7 2010/06/25 Christian Kral<br>
       changed company name to AIT</li>
  </ul>
</html>"),     Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics={
          Polygon(
            origin=  {11.533,37.938},
            lineColor=  {0,128,255},
            fillColor=  {0,128,255},
            fillPattern=  FillPattern.Solid,
            points=  {{-80,10},{-60,-10},{-80,-30},{-20,-30},{0,-10},{-20,10},{-80,10}}),
          Polygon(
            origin=  {11.533,37.938},
            lineColor=  {255,0,0},
            fillColor=  {255,0,0},
            fillPattern=  FillPattern.Solid,
            points=  {{-40,-90},{-20,-70},{0,-90},{0,-50},{-20,-30},{-40,-50},{-40,-90}}),
          Polygon(
            origin=  {11.533,37.938},
            lineColor=  {255,128,0},
            fillColor=  {255,128,0},
            fillPattern=  FillPattern.Solid,
            points=  {{-20,10},{0,-10},{-20,-30},{40,-30},{60,-10},{40,10},{-20,10}})}));
    end FluidHeatFlow;

    package HeatTransfer
    "Library of 1-dimensional heat transfer with lumped elements"
      extends Modelica.Icons.Package;

      package Components "Lumped thermal components"
      extends Modelica.Icons.Package;

        model HeatCapacitor "Lumped thermal element storing heat"
          parameter Modelica.SIunits.HeatCapacity C
          "Heat capacity of element (= cp*m)";
          Modelica.SIunits.Temperature T(start=293.15, displayUnit="degC")
          "Temperature of element";
          Modelica.SIunits.TemperatureSlope der_T(start=0)
          "Time derivative of temperature (= der(T))";
          Interfaces.HeatPort_a port annotation (Placement(transformation(
                origin={0,-100},
                extent={{-10,-10},{10,10}},
                rotation=90)));
        equation
          T = port.T;
          der_T = der(T);
          C*der(T) = port.Q_flow;
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Text(
                  extent={{-150,110},{150,70}},
                  textString="%name",
                  lineColor={0,0,255}),
                Polygon(
                  points={{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,
                      13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},
                      {-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,
                      -89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{
                      70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,
                      33},{44,41},{36,57},{26,65},{0,67}},
                  lineColor={160,160,164},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{
                      -76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,
                      -83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,
                      -77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,
                      -73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},
                      {-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,
                      27},{-48,35},{-44,45},{-40,57},{-58,35}},
                  lineColor={0,0,0},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{-69,7},{71,-24}},
                  lineColor={0,0,0},
                  textString="%C")}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={
                Polygon(
                  points={{0,67},{-20,63},{-40,57},{-52,43},{-58,35},{-68,25},{-72,
                      13},{-76,-1},{-78,-15},{-76,-31},{-76,-43},{-76,-53},{-70,-65},
                      {-64,-73},{-48,-77},{-30,-83},{-18,-83},{-2,-85},{8,-89},{22,
                      -89},{32,-87},{42,-81},{54,-75},{56,-73},{66,-61},{68,-53},{
                      70,-51},{72,-35},{76,-21},{78,-13},{78,3},{74,15},{66,25},{54,
                      33},{44,41},{36,57},{26,65},{0,67}},
                  lineColor={160,160,164},
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Solid),
                Polygon(
                  points={{-58,35},{-68,25},{-72,13},{-76,-1},{-78,-15},{-76,-31},{
                      -76,-43},{-76,-53},{-70,-65},{-64,-73},{-48,-77},{-30,-83},{-18,
                      -83},{-2,-85},{8,-89},{22,-89},{32,-87},{42,-81},{54,-75},{42,
                      -77},{40,-77},{30,-79},{20,-81},{18,-81},{10,-81},{2,-77},{-12,
                      -73},{-22,-73},{-30,-71},{-40,-65},{-50,-55},{-56,-43},{-58,-35},
                      {-58,-25},{-60,-13},{-60,-5},{-60,7},{-58,17},{-56,19},{-52,
                      27},{-48,35},{-44,45},{-40,57},{-58,35}},
                  lineColor={0,0,0},
                  fillColor={160,160,164},
                  fillPattern=FillPattern.Solid),
                Ellipse(
                  extent={{-6,-1},{6,-12}},
                  lineColor={255,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Text(
                  extent={{11,13},{50,-25}},
                  lineColor={0,0,0},
                  textString="T"),
                Line(points={{0,-12},{0,-96}}, color={255,0,0})}),
            Documentation(info="<HTML>
<p>
This is a generic model for the heat capacity of a material.
No specific geometry is assumed beyond a total volume with
uniform temperature for the entire volume.
Furthermore, it is assumed that the heat capacity
is constant (independent of temperature).
</p>
<p>
The temperature T [Kelvin] of this component is a <b>state</b>.
A default of T = 25 degree Celsius (= SIunits.Conversions.from_degC(25))
is used as start value for initialization.
This usually means that at start of integration the temperature of this
component is 25 degrees Celsius. You may, of course, define a different
temperature as start value for initialization. Alternatively, it is possible
to set parameter <b>steadyStateStart</b> to <b>true</b>. In this case
the additional equation '<b>der</b>(T) = 0' is used during
initialization, i.e., the temperature T is computed in such a way that
the component starts in <b>steady state</b>. This is useful in cases,
where one would like to start simulation in a suitable operating
point without being forced to integrate for a long time to arrive
at this point.
</p>
<p>
Note, that parameter <b>steadyStateStart</b> is not available in
the parameter menu of the simulation window, because its value
is utilized during translation to generate quite different
equations depending on its setting. Therefore, the value of this
parameter can only be changed before translating the model.
</p>
<p>
This component may be used for complicated geometries where
the heat capacity C is determined my measurements. If the component
consists mainly of one type of material, the <b>mass m</b> of the
component may be measured or calculated and multiplied with the
<b>specific heat capacity cp</b> of the component material to
compute C:
</p>
<pre>
   C = cp*m.
   Typical values for cp at 20 degC in J/(kg.K):
      aluminium   896
      concrete    840
      copper      383
      iron        452
      silver      235
      steel       420 ... 500 (V2A)
      wood       2500
</pre>
</html>"));
        end HeatCapacitor;

        model ThermalConductor
        "Lumped thermal element transporting heat without storing it"
          extends Interfaces.Element1D;
          parameter Modelica.SIunits.ThermalConductance G
          "Constant thermal conductance of material";

        equation
          Q_flow = G*dT;
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Rectangle(
                  extent={{-90,70},{90,-70}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillColor={192,192,192},
                  fillPattern=FillPattern.Backward),
                Line(
                  points={{-90,70},{-90,-70}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{90,70},{90,-70}},
                  color={0,0,0},
                  thickness=0.5),
                Text(
                  extent={{-150,115},{150,75}},
                  textString="%name",
                  lineColor={0,0,255}),
                Text(
                  extent={{-150,-75},{150,-105}},
                  lineColor={0,0,0},
                  textString="G=%G")}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={
                Line(
                  points={{-80,0},{80,0}},
                  color={255,0,0},
                  thickness=0.5,
                  arrow={Arrow.None,Arrow.Filled}),
                Text(
                  extent={{-100,-20},{100,-40}},
                  lineColor={255,0,0},
                  textString="Q_flow"),
                Text(
                  extent={{-100,40},{100,20}},
                  lineColor={0,0,0},
                  textString="dT = port_a.T - port_b.T")}),
            Documentation(info="<HTML>
<p>
This is a model for transport of heat without storing it; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">ThermalResistor</a>.
It may be used for complicated geometries where
the thermal conductance G (= inverse of thermal resistance)
is determined by measurements and is assumed to be constant
over the range of operations. If the component consists mainly of
one type of material and a regular geometry, it may be calculated,
e.g., with one of the following equations:
</p>
<ul>
<li><p>
    Conductance for a <b>box</b> geometry under the assumption
    that heat flows along the box length:</p>
    <pre>
    G = k*A/L
    k: Thermal conductivity (material constant)
    A: Area of box
    L: Length of box
    </pre>
    </li>
<li><p>
    Conductance for a <b>cylindrical</b> geometry under the assumption
    that heat flows from the inside to the outside radius
    of the cylinder:</p>
    <pre>
    G = 2*pi*k*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    k    : Thermal conductivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder
    </pre>
    </li>
</ul>
<pre>
    Typical values for k at 20 degC in W/(m.K):
      aluminium   220
      concrete      1
      copper      384
      iron         74
      silver      407
      steel        45 .. 15 (V2A)
      wood         0.1 ... 0.2
</pre>
</html>"));
        end ThermalConductor;
        annotation (Icon(coordinateSystem(preserveAspectRatio = true, extent = {{-100,-100},{100,100}}), graphics = {
          Rectangle(
            origin=  {12,40},
            fillColor=  {192,192,192},
            fillPattern=  FillPattern.Backward,
            extent=  {{-100,-100},{-70,18}}),
          Line(
            origin=  {12,40},
            points=  {{-44,16},{-44,-100}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{-4,16},{-4,-100}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{30,18},{30,-100}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{66,18},{66,-100}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{66,-100},{76,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{66,-100},{56,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{30,-100},{40,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{30,-100},{20,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{-4,-100},{6,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{-4,-100},{-14,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{-44,-100},{-34,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{-44,-100},{-54,-80}},
            color=  {0,127,255}),
          Line(
            origin=  {12,40},
            points=  {{-70,-60},{66,-60}},
            color=  {191,0,0}),
          Line(
            origin=  {12,40},
            points=  {{46,-70},{66,-60}},
            color=  {191,0,0}),
          Line(
            origin=  {12,40},
            points=  {{46,-50},{66,-60}},
            color=  {191,0,0}),
          Line(
            origin=  {12,40},
            points=  {{46,-30},{66,-20}},
            color=  {191,0,0}),
          Line(
            origin=  {12,40},
            points=  {{46,-10},{66,-20}},
            color=  {191,0,0}),
          Line(
            origin=  {12,40},
            points=  {{-70,-20},{66,-20}},
            color=  {191,0,0})}), Documentation(
              info="<html>

</html>"));
      end Components;

      package Sensors "Thermal sensors"
        extends Modelica.Icons.SensorsPackage;

        model TemperatureSensor "Absolute temperature sensor in Kelvin"

          Modelica.Blocks.Interfaces.RealOutput T(unit="K")
          "Absolute temperature as output signal"
            annotation (Placement(transformation(extent={{90,-10},{110,10}}, rotation=0)));
          Interfaces.HeatPort_a port annotation (Placement(transformation(extent={{
                    -110,-10},{-90,10}}, rotation=0)));
        equation
          T = port.T;
          port.Q_flow = 0;
          annotation (
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Ellipse(
                  extent={{-20,-98},{20,-60}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-12,40},{12,-68}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Line(points={{12,0},{90,0}}, color={0,0,255}),
                Line(points={{-94,0},{-14,0}}, color={191,0,0}),
                Polygon(
                  points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},{
                      12,80},{12,40},{-12,40}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Line(
                  points={{-12,40},{-12,-64}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{12,40},{12,-64}},
                  color={0,0,0},
                  thickness=0.5),
                Line(points={{-40,-20},{-12,-20}}, color={0,0,0}),
                Line(points={{-40,20},{-12,20}}, color={0,0,0}),
                Line(points={{-40,60},{-12,60}}, color={0,0,0}),
                Text(
                  extent={{102,-28},{60,-78}},
                  lineColor={0,0,0},
                  textString="K")}),
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Ellipse(
                  extent={{-20,-98},{20,-60}},
                  lineColor={0,0,0},
                  lineThickness=0.5,
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Rectangle(
                  extent={{-12,40},{12,-68}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid),
                Line(points={{12,0},{90,0}}, color={0,0,255}),
                Line(points={{-90,0},{-12,0}}, color={191,0,0}),
                Polygon(
                  points={{-12,40},{-12,80},{-10,86},{-6,88},{0,90},{6,88},{10,86},
                      {12,80},{12,40},{-12,40}},
                  lineColor={0,0,0},
                  lineThickness=0.5),
                Line(
                  points={{-12,40},{-12,-64}},
                  color={0,0,0},
                  thickness=0.5),
                Line(
                  points={{12,40},{12,-64}},
                  color={0,0,0},
                  thickness=0.5),
                Line(points={{-40,-20},{-12,-20}}, color={0,0,0}),
                Line(points={{-40,20},{-12,20}}, color={0,0,0}),
                Line(points={{-40,60},{-12,60}}, color={0,0,0}),
                Text(
                  extent={{126,-20},{26,-120}},
                  lineColor={0,0,0},
                  textString="K"),
                Text(
                  extent={{-150,130},{150,90}},
                  textString="%name",
                  lineColor={0,0,255})}),
            Documentation(info="<HTML>
<p>
This is an ideal absolute temperature sensor which returns
the temperature of the connected port in Kelvin as an output
signal.  The sensor itself has no thermal interaction with
whatever it is connected to.  Furthermore, no
thermocouple-like lags are associated with this
sensor model.
</p>
</html>"));
        end TemperatureSensor;

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

        model PrescribedTemperature
        "Variable temperature boundary condition in Kelvin"

          Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                    -10},{110,10}}, rotation=0)));
          Modelica.Blocks.Interfaces.RealInput T(unit="K") annotation (Placement(transformation(
                  extent={{-140,-20},{-100,20}}, rotation=0)));
        equation
          port.T = T;
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Rectangle(
                  extent={{-100,100},{100,-100}},
                  lineColor={0,0,0},
                  pattern=LinePattern.None,
                  fillColor={159,159,223},
                  fillPattern=FillPattern.Backward),
                Line(
                  points={{-102,0},{64,0}},
                  color={191,0,0},
                  thickness=0.5),
                Text(
                  extent={{0,0},{-100,-100}},
                  lineColor={0,0,0},
                  textString="K"),
                Text(
                  extent={{-150,150},{150,110}},
                  textString="%name",
                  lineColor={0,0,255}),
                Polygon(
                  points={{50,-20},{50,20},{90,0},{50,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<HTML>
<p>
This model represents a variable temperature boundary condition.
The temperature in [K] is given as input signal <b>T</b>
to the model. The effect is that an instance of this model acts as
an infinite reservoir able to absorb or generate as much energy
as required to keep the temperature at the specified value.
</p>
</html>"),         Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
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
                  points={{-102,0},{64,0}},
                  color={191,0,0},
                  thickness=0.5),
                Polygon(
                  points={{52,-20},{52,20},{90,0},{52,-20}},
                  lineColor={191,0,0},
                  fillColor={191,0,0},
                  fillPattern=FillPattern.Solid)}));
        end PrescribedTemperature;

        model FixedHeatFlow "Fixed heat flow boundary condition"
          parameter Modelica.SIunits.HeatFlowRate Q_flow
          "Fixed heat flow rate at port";
          parameter Modelica.SIunits.Temperature T_ref=293.15
          "Reference temperature";
          parameter Modelica.SIunits.LinearTemperatureCoefficient alpha=0
          "Temperature coefficient of heat flow rate";
          Interfaces.HeatPort_b port annotation (Placement(transformation(extent={{90,
                    -10},{110,10}}, rotation=0)));
        equation
          port.Q_flow = -Q_flow*(1 + alpha*(port.T - T_ref));
          annotation (
            Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                    100,100}}), graphics={
                Text(
                  extent={{-150,100},{150,60}},
                  textString="%name",
                  lineColor={0,0,255}),
                Text(
                  extent={{-150,-55},{150,-85}},
                  lineColor={0,0,0},
                  textString="Q_flow=%Q_flow"),
                Line(
                  points={{-100,-20},{48,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-100,20},{46,20}},
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
                  fillPattern=FillPattern.Solid)}),
            Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                    {100,100}}), graphics={
                Text(
                  extent={{-100,40},{0,-36}},
                  lineColor={0,0,0},
                  textString="Q_flow=const."),
                Line(
                  points={{-48,-20},{60,-20}},
                  color={191,0,0},
                  thickness=0.5),
                Line(
                  points={{-48,20},{60,20}},
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
                  fillPattern=FillPattern.Solid)}),
            Documentation(info="<HTML>
<p>
This model allows a specified amount of heat flow rate to be \"injected\"
into a thermal system at a given port.  The constant amount of heat
flow rate Q_flow is given as a parameter. The heat flows into the
component to which the component FixedHeatFlow is connected,
if parameter Q_flow is positive.
</p>
<p>
If parameter alpha is &lt;&gt; 0, the heat flow is multiplied by (1 + alpha*(port.T - T_ref))
in order to simulate temperature dependent losses (which are given with respect to reference temperature T_ref).
</p>
</html>"));
        end FixedHeatFlow;

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

        partial model Element1D
        "Partial heat transfer element with two HeatPort connectors that does not store energy"

          Modelica.SIunits.HeatFlowRate Q_flow
          "Heat flow rate from port_a -> port_b";
          Modelica.SIunits.TemperatureDifference dT "port_a.T - port_b.T";
      public
          HeatPort_a port_a annotation (Placement(transformation(extent={{-110,-10},
                    {-90,10}}, rotation=0)));
          HeatPort_b port_b annotation (Placement(transformation(extent={{90,-10},{
                    110,10}}, rotation=0)));
        equation
          dT = port_a.T - port_b.T;
          port_a.Q_flow = Q_flow;
          port_b.Q_flow = -Q_flow;
          annotation (Documentation(info="<HTML>
<p>
This partial model contains the basic connectors and variables to
allow heat transfer models to be created that <b>do not store energy</b>,
This model defines and includes equations for the temperature
drop across the element, <b>dT</b>, and the heat flow rate
through the element from port_a to port_b, <b>Q_flow</b>.
</p>
<p>
By extending this model, it is possible to write simple
constitutive equations for many types of heat transfer components.
</p>
</html>"));
        end Element1D;
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

  package Math
  "Library of mathematical functions (e.g., sin, cos) and of functions operating on vectors and matrices"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

  package Icons "Icons for Math"
    extends Modelica.Icons.IconsPackage;

    partial function AxisLeft
    "Basic icon for mathematical function with y-axis on left side"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{-80,-80},{-80,68}}, color={192,192,192}),
            Polygon(
              points={{-80,90},{-88,68},{-72,68},{-80,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                100,100}}), graphics={Line(points={{-80,80},{-88,80}}, color={95,
              95,95}),Line(points={{-80,-80},{-88,-80}}, color={95,95,95}),Line(
              points={{-80,-90},{-80,84}}, color={95,95,95}),Text(
                  extent={{-75,104},{-55,84}},
                  lineColor={95,95,95},
                  textString="y"),Polygon(
                  points={{-80,98},{-86,82},{-74,82},{-80,98}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis on the left side.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
    end AxisLeft;

    partial function AxisCenter
    "Basic icon for mathematical function with y-axis in the center"

      annotation (
        Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,
                100}}), graphics={
            Rectangle(
              extent={{-100,100},{100,-100}},
              lineColor={0,0,0},
              fillColor={255,255,255},
              fillPattern=FillPattern.Solid),
            Line(points={{0,-80},{0,68}}, color={192,192,192}),
            Polygon(
              points={{0,90},{-8,68},{8,68},{0,90}},
              lineColor={192,192,192},
              fillColor={192,192,192},
              fillPattern=FillPattern.Solid),
            Text(
              extent={{-150,150},{150,110}},
              textString="%name",
              lineColor={0,0,255})}),
        Diagram(graphics={Line(points={{0,80},{-8,80}}, color={95,95,95}),Line(
              points={{0,-80},{-8,-80}}, color={95,95,95}),Line(points={{0,-90},{
              0,84}}, color={95,95,95}),Text(
                  extent={{5,104},{25,84}},
                  lineColor={95,95,95},
                  textString="y"),Polygon(
                  points={{0,98},{-6,82},{6,82},{0,98}},
                  lineColor={95,95,95},
                  fillColor={95,95,95},
                  fillPattern=FillPattern.Solid)}),
        Documentation(info="<html>
<p>
Icon for a mathematical function, consisting of an y-axis in the middle.
It is expected, that an x-axis is added and a plot of the function.
</p>
</html>"));
    end AxisCenter;
  end Icons;

  function cos "Cosine"
    extends Modelica.Math.Icons.AxisLeft;
    input SI.Angle u;
    output Real y;

  external "builtin" y=  cos(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
                {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},
                {-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},
                {24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,
                73.4},{75.2,78.6},{80,80}}, color={0,0,0}),
          Text(
            extent={{-36,82},{36,34}},
            lineColor={192,192,192},
            textString="cos")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-103,72},{-83,88}},
              textString="1",
              lineColor={0,0,255}),Text(
              extent={{-103,-72},{-83,-88}},
              textString="-1",
              lineColor={0,0,255}),Text(
              extent={{70,25},{90,5}},
              textString="2*pi",
              lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={95,95,95}),
            Polygon(
              points={{98,0},{82,6},{82,-6},{98,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,80},{-74.4,78.1},{-68.7,72.3},{-63.1,63},{-56.7,48.7},
              {-48.6,26.6},{-29.3,-32.5},{-22.1,-51.7},{-15.7,-65.3},{-10.1,-73.8},
              {-4.42,-78.8},{1.21,-79.9},{6.83,-77.1},{12.5,-70.6},{18.1,-60.6},{
              24.5,-45.7},{32.6,-23},{50.3,31.3},{57.5,50.7},{63.9,64.6},{69.5,
              73.4},{75.2,78.6},{80,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{78,-6},{98,-26}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{-80,-80},{18,-80}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = cos(u), with -&infin; &lt; u &lt; &infin;:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/cos.png\">
</p>
</html>"));
  end cos;

  function asin "Inverse sine (-1 <= u <= 1)"
    extends Modelica.Math.Icons.AxisCenter;
    input Real u;
    output SI.Angle y;

  external "builtin" y=  asin(u);
    annotation (
      Icon(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={
          Line(points={{-90,0},{68,0}}, color={192,192,192}),
          Polygon(
            points={{90,0},{68,8},{68,-8},{90,0}},
            lineColor={192,192,192},
            fillColor={192,192,192},
            fillPattern=FillPattern.Solid),
          Line(points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
                -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
                52.7},{75.2,62.2},{77.6,67.5},{80,80}}, color={0,0,0}),
          Text(
            extent={{-88,78},{-16,30}},
            lineColor={192,192,192},
            textString="asin")}),
      Diagram(coordinateSystem(
          preserveAspectRatio=true,
          extent={{-100,-100},{100,100}}), graphics={Text(
              extent={{-40,-72},{-15,-88}},
              textString="-pi/2",
              lineColor={0,0,255}),Text(
              extent={{-38,88},{-13,72}},
              textString=" pi/2",
              lineColor={0,0,255}),Text(
              extent={{68,-9},{88,-29}},
              textString="+1",
              lineColor={0,0,255}),Text(
              extent={{-90,21},{-70,1}},
              textString="-1",
              lineColor={0,0,255}),Line(points={{-100,0},{84,0}}, color={95,95,95}),
            Polygon(
              points={{98,0},{82,6},{82,-6},{98,0}},
              lineColor={95,95,95},
              fillColor={95,95,95},
              fillPattern=FillPattern.Solid),Line(
              points={{-80,-80},{-79.2,-72.8},{-77.6,-67.5},{-73.6,-59.4},{-66.3,
              -49.8},{-53.5,-37.3},{-30.2,-19.7},{37.4,24.8},{57.5,40.8},{68.7,
              52.7},{75.2,62.2},{77.6,67.5},{80,80}},
              color={0,0,255},
              thickness=0.5),Text(
              extent={{82,24},{102,4}},
              lineColor={95,95,95},
              textString="u"),Line(
              points={{0,80},{86,80}},
              color={175,175,175},
              smooth=Smooth.None),Line(
              points={{80,86},{80,-10}},
              color={175,175,175},
              smooth=Smooth.None)}),
      Documentation(info="<html>
<p>
This function returns y = asin(u), with -1 &le; u &le; +1:
</p>

<p>
<img src=\"modelica://Modelica/Resources/Images/Math/asin.png\">
</p>
</html>"));
  end asin;
  annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
            {100,100}}), graphics={Line(points={{-80,0},{-68.7,34.2},{-61.5,53.1},
              {-55.1,66.4},{-49.4,74.6},{-43.8,79.1},{-38.2,79.8},{-32.6,76.6},{
              -26.9,69.7},{-21.3,59.4},{-14.9,44.1},{-6.83,21.2},{10.1,-30.8},{17.3,
              -50.2},{23.7,-64.2},{29.3,-73.1},{35,-78.4},{40.6,-80},{46.2,-77.6},
              {51.9,-71.5},{57.5,-61.9},{63.9,-47.2},{72,-24.8},{80,0}}, color={
              0,0,0}, smooth=Smooth.Bezier)}), Documentation(info="<HTML>
<p>
This package contains <b>basic mathematical functions</b> (such as sin(..)),
as well as functions operating on
<a href=\"modelica://Modelica.Math.Vectors\">vectors</a>,
<a href=\"modelica://Modelica.Math.Matrices\">matrices</a>,
<a href=\"modelica://Modelica.Math.Nonlinear\">nonlinear functions</a>, and
<a href=\"modelica://Modelica.Math.BooleanVectors\">Boolean vectors</a>.
</p>

<dl>
<dt><b>Main Authors:</b>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a> and
    Marcus Baur<br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e.V. (DLR)<br>
    Institut f&uuml;r Robotik und Mechatronik<br>
    Postfach 1116<br>
    D-82230 Wessling<br>
    Germany<br>
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
<li><i>October 21, 2002</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>
       and <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Function tempInterpol2 added.</li>
<li><i>Oct. 24, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Icons for icon and diagram level introduced.</li>
<li><i>June 30, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>

</html>"));
  end Math;

  package Utilities
  "Library of utility functions dedicated to scripting (operating on files, streams, strings, system)"
    extends Modelica.Icons.Package;

    package Strings "Operations on strings"
      extends Modelica.Icons.Package;

      function length "Returns length of string"
        extends Modelica.Icons.Function;
        input String string;
        output Integer result "Number of characters of string";
      external "C" result = ModelicaStrings_length(string) annotation(Library="ModelicaExternalC");
        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>length</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns the number of characters of \"string\".
</p>
</html>"));
      end length;

      function isEmpty
      "Return true if a string is empty (has only white space characters)"
        extends Modelica.Icons.Function;
        input String string;
        output Boolean result "True, if string is empty";
    protected
        Integer nextIndex;
        Integer len;
      algorithm
        nextIndex := Strings.Advanced.skipWhiteSpace(string);
        len := Strings.length(string);
        if len < 1 or nextIndex > len then
          result := true;
        else
          result := false;
        end if;

        annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
Strings.<b>isEmpty</b>(string);
</pre></blockquote>
<h4>Description</h4>
<p>
Returns true if the string has no characters or if the string consists
only of white space characters. Otherwise, false is returned.
</p>

<h4>Example</h4>
<blockquote><pre>
  isEmpty(\"\");       // returns true
  isEmpty(\"   \");    // returns true
  isEmpty(\"  abc\");  // returns false
  isEmpty(\"a\");      // returns false
</pre></blockquote>
</html>"));
      end isEmpty;

      package Advanced "Advanced scanning functions"
      extends Modelica.Icons.Package;

        function skipWhiteSpace "Scans white space"
          extends Modelica.Icons.Function;
          input String string;
          input Integer startIndex(min=1)=1;
          output Integer nextIndex;
          external "C" nextIndex = ModelicaStrings_skipWhiteSpace(string, startIndex) annotation(Library="ModelicaExternalC");
          annotation (Documentation(info="<html>
<h4>Syntax</h4>
<blockquote><pre>
nextIndex = <b>skipWhiteSpace</b>(string, startIndex);
</pre></blockquote>
<h4>Description</h4>
<p>
Starts scanning of \"string\" at position \"startIndex\" and
skips white space. The function returns nextIndex = index of character
of the first non white space character.
</p>
<h4>See also</h4>
<a href=\"modelica://Modelica.Utilities.Strings.Advanced\">Strings.Advanced</a>.
</html>"));
        end skipWhiteSpace;
        annotation (Documentation(info="<html>
<h4>Library content</h4>
<p>
Package <b>Strings.Advanced</b> contains basic scanning
functions. These functions should be <b>not called</b> directly, because
it is much simpler to utilize the higher level functions \"Strings.scanXXX\".
The functions of the \"Strings.Advanced\" library provide
the basic interface in order to implement the higher level
functions in package \"Strings\".
</p>
<p>
Library \"Advanced\" provides the following functions:
</p>
<pre>
  (nextIndex, realNumber)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>        (string, startIndex, unsigned=false);
  (nextIndex, integerNumber) = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>     (string, startIndex, unsigned=false);
  (nextIndex, string2)       = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>      (string, startIndex);
  (nextIndex, identifier)    = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>  (string, startIndex);
   nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipWhiteSpace\">skipWhiteSpace</a>  (string, startIndex);
   nextIndex                 = <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a>(string, startIndex);
</pre>
<p>
All functions perform the following actions:
</p>
<ol>
<li> Scanning starts at character position \"startIndex\" of
     \"string\" (startIndex has a default of 1).
<li> First, white space is skipped, such as blanks (\" \"), tabs (\"\\t\"), or newline (\"\\n\")</li>
<li> Afterwards, the required token is scanned.</li>
<li> If successful, on return nextIndex = index of character
     directly after the found token and the token value is returned
     as second output argument.<br>
     If not successful, on return nextIndex = startIndex.
     </li>
</ol>
<p>
The following additional rules apply for the scanning:
</p>
<ul>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanReal\">scanReal</a>:<br>
     Scans a full number including one optional leading \"+\" or \"-\" (if unsigned=false)
     according to the Modelica grammar. For example, \"+1.23e-5\", \"0.123\" are
     Real numbers, but \".1\" is not.
     Note, an Integer number, such as \"123\" is also treated as a Real number.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanInteger\">scanInteger</a>:<br>
     Scans an Integer number including one optional leading \"+\"
     or \"-\" (if unsigned=false) according to the Modelica (and C/C++) grammar.
     For example, \"+123\", \"20\" are Integer numbers.
     Note, a Real number, such as \"123.4\" is not an Integer and
     scanInteger returns nextIndex = startIndex.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanString\">scanString</a>:<br>
     Scans a String according to the Modelica (and C/C++) grammar, e.g.,
     \"This is a \"string\"\" is a valid string token.<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.scanIdentifier\">scanIdentifier</a>:<br>
     Scans a Modelica identifier, i.e., the identifier starts either
     with a letter, followed by letters, digits or \"_\".
     For example, \"w_rel\", \"T12\".<br>&nbsp;</li>
<li> Function <a href=\"modelica://Modelica.Utilities.Strings.Advanced.skipLineComments\">skipLineComments</a><br>
     Skips white space and Modelica (C/C++) line comments iteratively.
     A line comment starts with \"//\" and ends either with an
     end-of-line (\"\\n\") or the end of the \"string\". </li>
</ul>
</html>"));
      end Advanced;
      annotation (
        Documentation(info="<HTML>
<h4>Library content</h4>
<p>
Package <b>Strings</b> contains functions to manipulate strings.
</p>
<p>
In the table below an example
call to every function is given using the <b>default</b> options.
</p>
<table border=1 cellspacing=0 cellpadding=2>
  <tr><th><b><i>Function</i></b></th><th><b><i>Description</i></b></th></tr>
  <tr><td valign=\"top\">len = <a href=\"modelica://Modelica.Utilities.Strings.length\">length</a>(string)</td>
      <td valign=\"top\">Returns length of string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.substring\">substring</a>(string1,startIndex,endIndex)
       </td>
      <td valign=\"top\">Returns a substring defined by start and end index</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n)<br>
 result = <a href=\"modelica://Modelica.Utilities.Strings.repeat\">repeat</a>(n,string)</td>
      <td valign=\"top\">Repeat a blank or a string n times.</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.compare\">compare</a>(string1, string2)</td>
      <td valign=\"top\">Compares two substrings with regards to alphabetical order</td></tr>
  <tr><td valign=\"top\">identical =
<a href=\"modelica://Modelica.Utilities.Strings.isEqual\">isEqual</a>(string1,string2)</td>
      <td valign=\"top\">Determine whether two strings are identical</td></tr>
  <tr><td valign=\"top\">result = <a href=\"modelica://Modelica.Utilities.Strings.count\">count</a>(string,searchString)</td>
      <td valign=\"top\">Count the number of occurrences of a string</td></tr>
  <tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.find\">find</a>(string,searchString)</td>
      <td valign=\"top\">Find first occurrence of a string in another string</td></tr>
<tr>
<td valign=\"top\">index = <a href=\"modelica://Modelica.Utilities.Strings.findLast\">findLast</a>(string,searchString)</td>
      <td valign=\"top\">Find last occurrence of a string in another string</td></tr>
  <tr><td valign=\"top\">string2 = <a href=\"modelica://Modelica.Utilities.Strings.replace\">replace</a>(string,searchString,replaceString)</td>
      <td valign=\"top\">Replace one or all occurrences of a string</td></tr>
  <tr><td valign=\"top\">stringVector2 = <a href=\"modelica://Modelica.Utilities.Strings.sort\">sort</a>(stringVector1)</td>
      <td valign=\"top\">Sort vector of strings in alphabetic order</td></tr>
  <tr><td valign=\"top\">(token, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanToken\">scanToken</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a token (Real/Integer/Boolean/String/Identifier/Delimiter/NoToken)</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanReal\">scanReal</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Real constant</td></tr>
  <tr><td valign=\"top\">(number, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanInteger\">scanInteger</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an Integer constant</td></tr>
  <tr><td valign=\"top\">(boolean, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanBoolean\">scanBoolean</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a Boolean constant</td></tr>
  <tr><td valign=\"top\">(string2, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanString\">scanString</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for a String constant</td></tr>
  <tr><td valign=\"top\">(identifier, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanIdentifier\">scanIdentifier</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for an identifier</td></tr>
  <tr><td valign=\"top\">(delimiter, index) = <a href=\"modelica://Modelica.Utilities.Strings.scanDelimiter\">scanDelimiter</a>(string,startIndex)</td>
      <td valign=\"top\">Scan for delimiters</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.scanNoToken\">scanNoToken</a>(string,startIndex)</td>
      <td valign=\"top\">Check that remaining part of string consists solely of <br>
          white space or line comments (\"// ...\\n\").</td></tr>
  <tr><td valign=\"top\"><a href=\"modelica://Modelica.Utilities.Strings.syntaxError\">syntaxError</a>(string,index,message)</td>
      <td valign=\"top\"> Print a \"syntax error message\" as well as a string and the <br>
           index at which scanning detected an error</td></tr>
</table>
<p>
The functions \"compare\", \"isEqual\", \"count\", \"find\", \"findLast\", \"replace\", \"sort\"
have the optional
input argument <b>caseSensitive</b> with default <b>true</b>.
If <b>false</b>, the operation is carried out without taking
into account whether a character is upper or lower case.
</p>
</HTML>"));
    end Strings;
      annotation (
  Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
      Polygon(
        origin={1.3835,-4.1418},
        rotation=45.0,
        fillColor={64,64,64},
        pattern=LinePattern.None,
        fillPattern=FillPattern.Solid,
        points={{-15.0,93.333},{-15.0,68.333},{0.0,58.333},{15.0,68.333},{15.0,93.333},{20.0,93.333},{25.0,83.333},{25.0,58.333},{10.0,43.333},{10.0,-41.667},{25.0,-56.667},{25.0,-76.667},{10.0,-91.667},{0.0,-91.667},{0.0,-81.667},{5.0,-81.667},{15.0,-71.667},{15.0,-61.667},{5.0,-51.667},{-5.0,-51.667},{-15.0,-61.667},{-15.0,-71.667},{-5.0,-81.667},{0.0,-81.667},{0.0,-91.667},{-10.0,-91.667},{-25.0,-76.667},{-25.0,-56.667},{-10.0,-41.667},{-10.0,43.333},{-25.0,58.333},{-25.0,83.333},{-20.0,93.333}}),
      Polygon(
        origin={10.1018,5.218},
        rotation=-45.0,
        fillColor={255,255,255},
        fillPattern=FillPattern.Solid,
        points={{-15.0,87.273},{15.0,87.273},{20.0,82.273},{20.0,27.273},{10.0,17.273},{10.0,7.273},{20.0,2.273},{20.0,-2.727},{5.0,-2.727},{5.0,-77.727},{10.0,-87.727},{5.0,-112.727},{-5.0,-112.727},{-10.0,-87.727},{-5.0,-77.727},{-5.0,-2.727},{-20.0,-2.727},{-20.0,2.273},{-10.0,7.273},{-10.0,17.273},{-20.0,27.273},{-20.0,82.273}})}),
  Documentation(info="<html>
<p>
This package contains Modelica <b>functions</b> that are
especially suited for <b>scripting</b>. The functions might
be used to work with strings, read data from file, write data
to file or copy, move and remove files.
</p>
<p>
For an introduction, have especially a look at:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.UsersGuide\">Modelica.Utilities.User's Guide</a>
     discusses the most important aspects of this library.</li>
<li> <a href=\"modelica://Modelica.Utilities.Examples\">Modelica.Utilities.Examples</a>
     contains examples that demonstrate the usage of this library.</li>
</ul>
<p>
The following main sublibraries are available:
</p>
<ul>
<li> <a href=\"modelica://Modelica.Utilities.Files\">Files</a>
     provides functions to operate on files and directories, e.g.,
     to copy, move, remove files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Streams\">Streams</a>
     provides functions to read from files and write to files.</li>
<li> <a href=\"modelica://Modelica.Utilities.Strings\">Strings</a>
     provides functions to operate on strings. E.g.
     substring, find, replace, sort, scanToken.</li>
<li> <a href=\"modelica://Modelica.Utilities.System\">System</a>
     provides functions to interact with the environment.
     E.g., get or set the working directory or environment
     variables and to send a command to the default shell.</li>
</ul>

<p>
Copyright &copy; 1998-2015, Modelica Association, DLR, and Dassault Syst&egrave;mes AB.
</p>

<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>

</html>"));
  end Utilities;

  package Constants
  "Library of mathematical constants and constants of nature (e.g., pi, eps, R, sigma)"
    import SI = Modelica.SIunits;
    import NonSI = Modelica.SIunits.Conversions.NonSIunits;
    extends Modelica.Icons.Package;

    final constant Real pi=2*Modelica.Math.asin(1.0);

    final constant Real eps=ModelicaServices.Machine.eps
    "Biggest number such that 1.0 + eps = 1.0";

    final constant Real small=ModelicaServices.Machine.small
    "Smallest number such that small and -small are representable on the machine";
    annotation (
      Documentation(info="<html>
<p>
This package provides often needed constants from mathematics, machine
dependent constants and constants from nature. The latter constants
(name, value, description) are from the following source:
</p>

<dl>
<dt>Peter J. Mohr and Barry N. Taylor (1999):</dt>
<dd><b>CODATA Recommended Values of the Fundamental Physical Constants: 1998</b>.
    Journal of Physical and Chemical Reference Data, Vol. 28, No. 6, 1999 and
    Reviews of Modern Physics, Vol. 72, No. 2, 2000. See also <a href=
\"http://physics.nist.gov/cuu/Constants/\">http://physics.nist.gov/cuu/Constants/</a></dd>
</dl>

<p>CODATA is the Committee on Data for Science and Technology.</p>

<dl>
<dt><b>Main Author:</b></dt>
<dd><a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a><br>
    Deutsches Zentrum f&uuml;r Luft und Raumfahrt e. V. (DLR)<br>
    Oberpfaffenhofen<br>
    Postfach 11 16<br>
    D-82230 We&szlig;ling<br>
    email: <a href=\"mailto:Martin.Otter@dlr.de\">Martin.Otter@dlr.de</a></dd>
</dl>

<p>
Copyright &copy; 1998-2015, Modelica Association and DLR.
</p>
<p>
<i>This Modelica package is <u>free</u> software and the use is completely at <u>your own risk</u>; it can be redistributed and/or modified under the terms of the Modelica License 2. For license conditions (including the disclaimer of warranty) see <a href=\"modelica://Modelica.UsersGuide.ModelicaLicense2\">Modelica.UsersGuide.ModelicaLicense2</a> or visit <a href=\"https://www.modelica.org/licenses/ModelicaLicense2\"> https://www.modelica.org/licenses/ModelicaLicense2</a>.</i>
</p>
</html>",   revisions="<html>
<ul>
<li><i>Nov 8, 2004</i>
       by <a href=\"http://www.robotic.dlr.de/Christian.Schweiger/\">Christian Schweiger</a>:<br>
       Constants updated according to 2002 CODATA values.</li>
<li><i>Dec 9, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants updated according to 1998 CODATA values. Using names, values
       and description text from this source. Included magnetic and
       electric constant.</li>
<li><i>Sep 18, 1999</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Constants eps, inf, small introduced.</li>
<li><i>Nov 15, 1997</i>
       by <a href=\"http://www.robotic.dlr.de/Martin.Otter/\">Martin Otter</a>:<br>
       Realized.</li>
</ul>
</html>"),
      Icon(coordinateSystem(extent={{-100.0,-100.0},{100.0,100.0}}), graphics={
        Polygon(
          origin={-9.2597,25.6673},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{48.017,11.336},{48.017,11.336},{10.766,11.336},{-25.684,10.95},{-34.944,-15.111},{-34.944,-15.111},{-32.298,-15.244},{-32.298,-15.244},{-22.112,0.168},{11.292,0.234},{48.267,-0.097},{48.267,-0.097}},
          smooth=Smooth.Bezier),
        Polygon(
          origin={-19.9923,-8.3993},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{3.239,37.343},{3.305,37.343},{-0.399,2.683},{-16.936,-20.071},{-7.808,-28.604},{6.811,-22.519},{9.986,37.145},{9.986,37.145}},
          smooth=Smooth.Bezier),
        Polygon(
          origin={23.753,-11.5422},
          fillColor={102,102,102},
          pattern=LinePattern.None,
          fillPattern=FillPattern.Solid,
          points={{-10.873,41.478},{-10.873,41.478},{-14.048,-4.162},{-9.352,-24.8},{7.912,-24.469},{16.247,0.27},{16.247,0.27},{13.336,0.071},{13.336,0.071},{7.515,-9.983},{-3.134,-7.271},{-2.671,41.214},{-2.671,41.214}},
          smooth=Smooth.Bezier)}));
  end Constants;

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

    partial package MaterialPropertiesPackage
    "Icon for package containing property classes"
      extends Modelica.Icons.Package;
      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,
                -100},{100,100}}), graphics={
            Ellipse(
              lineColor={102,102,102},
              fillColor={204,204,204},
              pattern=LinePattern.None,
              fillPattern=FillPattern.Sphere,
              extent={{-60.0,-60.0},{60.0,60.0}})}),
                                Documentation(info="<html>
<p>This icon indicates a package that contains properties</p>
</html>"));
    end MaterialPropertiesPackage;

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

    partial function Function "Icon for functions"

      annotation (Icon(coordinateSystem(preserveAspectRatio=false, extent={{-100,-100},{100,100}}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-150,105},{150,145}},
              textString="%name"),
            Ellipse(
              lineColor=  {108,88,49},
              fillColor=  {255,215,136},
              fillPattern=  FillPattern.Solid,
              extent=  {{-100,-100},{100,100}}),
            Text(
              lineColor={108,88,49},
              extent={{-90.0,-90.0},{90.0,90.0}},
              textString="f")}),
    Documentation(info="<html>
<p>This icon indicates Modelica functions.</p>
</html>"));
    end Function;

    partial record Record "Icon for records"

      annotation (Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{100,100}}), graphics={
            Text(
              lineColor={0,0,255},
              extent={{-150,60},{150,100}},
              textString="%name"),
            Rectangle(
              origin={0.0,-25.0},
              lineColor={64,64,64},
              fillColor={255,215,136},
              fillPattern=FillPattern.Solid,
              extent={{-100.0,-75.0},{100.0,75.0}},
              radius=25.0),
            Line(
              points={{-100.0,0.0},{100.0,0.0}},
              color={64,64,64}),
            Line(
              origin={0.0,-50.0},
              points={{-100.0,0.0},{100.0,0.0}},
              color={64,64,64}),
            Line(
              origin={0.0,-25.0},
              points={{0.0,75.0},{0.0,-75.0}},
              color={64,64,64})}),                        Documentation(info="<html>
<p>
This icon is indicates a record.
</p>
</html>"));
    end Record;
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

    package Conversions
    "Conversion functions to/from non SI units and type definitions of non SI units"
      extends Modelica.Icons.Package;

      package NonSIunits "Type definitions of non SI units"
        extends Modelica.Icons.Package;
        annotation (Documentation(info="<HTML>
<p>
This package provides predefined types, such as <b>Angle_deg</b> (angle in
degree), <b>AngularVelocity_rpm</b> (angular velocity in revolutions per
minute) or <b>Temperature_degF</b> (temperature in degree Fahrenheit),
which are in common use but are not part of the international standard on
units according to ISO 31-1992 \"General principles concerning quantities,
units and symbols\" and ISO 1000-1992 \"SI units and recommendations for
the use of their multiples and of certain other units\".</p>
<p>If possible, the types in this package should not be used. Use instead
types of package Modelica.SIunits. For more information on units, see also
the book of Francois Cardarelli <b>Scientific Unit Conversion - A
Practical Guide to Metrication</b> (Springer 1997).</p>
<p>Some units, such as <b>Temperature_degC/Temp_C</b> are both defined in
Modelica.SIunits and in Modelica.Conversions.NonSIunits. The reason is that these
definitions have been placed erroneously in Modelica.SIunits although they
are not SIunits. For backward compatibility, these type definitions are
still kept in Modelica.SIunits.</p>
</html>"),   Icon(coordinateSystem(extent={{-100,-100},{100,100}}), graphics={
        Text(
          origin={15.0,51.8518},
          extent={{-105.0,-86.8518},{75.0,-16.8518}},
          lineColor={0,0,0},
          textString="[km/h]")}));
      end NonSIunits;
      annotation (                              Documentation(info="<HTML>
<p>This package provides conversion functions from the non SI Units
defined in package Modelica.SIunits.Conversions.NonSIunits to the
corresponding SI Units defined in package Modelica.SIunits and vice
versa. It is recommended to use these functions in the following
way (note, that all functions have one Real input and one Real output
argument):</p>
<pre>
  <b>import</b> SI = Modelica.SIunits;
  <b>import</b> Modelica.SIunits.Conversions.*;
     ...
  <b>parameter</b> SI.Temperature     T   = from_degC(25);   // convert 25 degree Celsius to Kelvin
  <b>parameter</b> SI.Angle           phi = from_deg(180);   // convert 180 degree to radian
  <b>parameter</b> SI.AngularVelocity w   = from_rpm(3600);  // convert 3600 revolutions per minutes
                                                      // to radian per seconds
</pre>

</html>"));
    end Conversions;

    type Angle = Real (
        final quantity="Angle",
        final unit="rad",
        displayUnit="deg");

    type Length = Real (final quantity="Length", final unit="m");

    type Height = Length(min=0);

    type Diameter = Length(min=0);

    type Area = Real (final quantity="Area", final unit="m2");

    type Volume = Real (final quantity="Volume", final unit="m3");

    type Time = Real (final quantity="Time", final unit="s");

    type Frequency = Real (final quantity="Frequency", final unit="Hz");

    type Density = Real (
        final quantity="Density",
        final unit="kg/m3",
        displayUnit="g/cm3",
        min=0.0);

    type KinematicViscosity = Real (
        final quantity="KinematicViscosity",
        final unit="m2/s",
        min=0);

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

    type TemperatureDifference = Real (
        final quantity="ThermodynamicTemperature",
        final unit="K") annotation(absoluteValue=false);

    type TemperatureSlope = Real (final quantity="TemperatureSlope",
        final unit="K/s");

    type LinearTemperatureCoefficient = Real(final quantity = "LinearTemperatureCoefficient", final unit="1/K");

    type Heat = Real (final quantity="Energy", final unit="J");

    type HeatFlowRate = Real (final quantity="Power", final unit="W");

    type ThermalConductivity = Real (final quantity="ThermalConductivity", final unit=
               "W/(m.K)");

    type CoefficientOfHeatTransfer = Real (final quantity=
            "CoefficientOfHeatTransfer", final unit="W/(m2.K)");

    type ThermalConductance = Real (final quantity="ThermalConductance", final unit=
               "W/K");

    type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");

    type SpecificHeatCapacity = Real (final quantity="SpecificHeatCapacity",
          final unit="J/(kg.K)");
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

      model BoilerInFinite
        "Heat source which can choose finite or infinite heat flow"
        //Source bitmap: https://pixabay.com/de/feuer-gelb-flamme-rot-brennen-30276/

      parameter Boolean limited_heat=false
          "Use limited heat flow of the boiler";
      parameter Modelica.SIunits.HeatFlowRate Qmax(start=1000, fixed=true)
          "maximal thermal heat flow rate of the boiler"
      annotation (Dialog(enable= limited_heat));
      Modelica.SIunits.HeatFlowRate HeatFlowRate;
      Modelica.SIunits.Heat Heat;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
        Modelica.Blocks.Interfaces.RealInput nominal_heat
          "specification of the heat flow"
          annotation (Placement(transformation(extent={{-124,-20},{-84,20}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b thermal_heat_flow
          "thermal heat flow output"
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Blocks.Continuous.Integrator heat_counter(y_start=0, k=1)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,-36})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={50,0})));
        Modelica.Blocks.Nonlinear.Limiter limiter(             uMin=0, uMax=Qmax)
          annotation (Placement(transformation(extent={{-72,34},{-52,54}})));
        Modelica.Blocks.Logical.Switch switch
          annotation (Placement(transformation(extent={{-34,-10},{-14,10}})));
        Modelica.Blocks.Sources.BooleanConstant limitedHeat(k=limited_heat)
          annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      equation

        HeatFlowRate=heatFlowSensor.Q_flow;
      Heat=heat_counter.y;

        connect(prescribedHeatFlow.port, heatFlowSensor.port_a)
          annotation (Line(points={{16,0},{16,0},{40,0}}, color={191,0,0}));
        connect(thermal_heat_flow, heatFlowSensor.port_b)
          annotation (Line(points={{100,0},{80,0},{60,0}}, color={191,0,0}));
        connect(prescribedHeatFlow.Q_flow, switch.y)
          annotation (Line(points={{-4,0},{-8,0},{-13,0}}, color={0,0,127}));
        connect(nominal_heat, limiter.u) annotation (Line(points={{-104,0},{-104,0},{-80,
                0},{-80,44},{-74,44}}, color={0,0,127}));
        connect(heatFlowSensor.Q_flow, heat_counter.u)
          annotation (Line(points={{50,-10},{50,-24},{50,-24}}, color={0,0,127}));
        connect(limiter.y, switch.u1) annotation (Line(points={{-51,44},{-46,44},{-46,
                8},{-36,8}}, color={0,0,127}));
        connect(switch.u2, limitedHeat.y)
          annotation (Line(points={{-36,0},{-44,0},{-51,0}}, color={255,0,255}));
        connect(switch.u3, limiter.u) annotation (Line(points={{-36,-8},{-46,-8},{-46,
                -24},{-80,-24},{-80,44},{-74,44}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Rectangle(
                extent={{-40,60},{40,-40}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Text(
                extent={{-50,-96},{52,-48}},
                lineColor={0,0,0},
                lineThickness=0.5,
                textString="boiler"),
              Bitmap(extent={{-50,-38},{54,44}}, fileName=
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
                extent={{-32,88},{36,78}},
                lineColor={0,0,0},
                lineThickness=0.5,
                fontSize=16,
                textString="heat flow counter"),
              Text(
                extent={{-94,-108},{106,-142}},
                lineColor={28,108,200},
                textString="%name")}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This model of a boiler needs a real input for his nomial heat. </p>
<p>The output is a heat flow.</p>
<p>If the Boolean parameter limited_heat is false, the boiler has infinite heat flow. </p>
<p>If the Boolean parameter limited_heat is true, the boiler has a maximal heat flow. Higher nominal inputs are limited at maximal heat flow. </p>
<p>Additionally the model has a counter for the heat flow (integrator). </p>
</html>"));
      end BoilerInFinite;

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

      annotation ();
    end Boiler;

    package Consumers

      model ConsumerTempDepend
        "linear dependence of the heat consumption by outside temperature"

          parameter Real temp[:,2]
          "temperature to heat (left column outside temperature in °C, right column heat flow in W";

        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_flow_consumer
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-36,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_flow "heat demand 
  of all households including net losses"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.RealInput outside_temperature
          "outside temperature in the area"                                                        annotation (
            Placement(transformation(
              extent={{-20,-20},{20,20}},
              rotation=180,
              origin={106,0})));
        Modelica.Blocks.Tables.CombiTable1D temperature_to_heat(
          tableOnFile=false,
          smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
          table=temp)                     annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={46,0})));
        Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={2,0})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heat_demand_sensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-72,0})));
        Modelica.Blocks.Interfaces.RealOutput heat_demand
          "positive heat demand"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-106,70})));
        Modelica.Blocks.Math.Gain invertor(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-72,38})));
      equation
        connect(gain.y, heat_flow_consumer.Q_flow)
          annotation (Line(points={{-9,0},{-26,0}}, color={0,0,127}));
        connect(heat_demand_sensor.port_b, heat_flow)
          annotation (Line(points={{-82,0},{-91,0},{-100,0}}, color={191,0,0}));
        connect(heat_demand_sensor.port_a, heat_flow_consumer.port)
          annotation (Line(points={{-62,0},{-54,0},{-46,0}}, color={191,0,0}));
        connect(heat_demand_sensor.Q_flow, invertor.u)
          annotation (Line(points={{-72,10},{-72,18},{-72,26}}, color={0,0,127}));
        connect(invertor.y, heat_demand) annotation (Line(points={{-72,49},{-72,49},{-72,
                56},{-72,70},{-106,70}}, color={0,0,127}));
        connect(temperature_to_heat.u[1], outside_temperature) annotation (Line(
              points={{58,0},{62,0},{106,0},{106,0}}, color={0,0,127}));
        connect(gain.u, temperature_to_heat.y[1])
          annotation (Line(points={{14,0},{35,0},{35,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Rectangle(
                extent={{-60,18},{60,-76}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,-76},{12,-38}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,-38},{-26,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,-38},{50,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,4},{50,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,4},{-26,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,4},{12,-16}},
                lineColor={0,0,0}),
              Line(
                points={{-60,18},{0,80},{60,18}},
                color={0,0,0}),
              Text(
                extent={{-98,-12},{-60,-24}},
                lineColor={238,46,47},
                lineThickness=0.5,
                textString="heat flow",
                fontSize=14),
              Text(
                extent={{60,-12},{98,-24}},
                lineColor={28,108,200},
                lineThickness=0.5,
                fontSize=14,
                textString="outside temperature"),
              Text(
                extent={{-94,76},{-40,64}},
                lineColor={28,108,200},
                lineThickness=0.5,
                fontSize=14,
                textString="heat demand"),
              Text(
                extent={{-68,-84},{74,-94}},
                lineColor={0,0,0},
                textString="temperature dependend"),
              Text(
                extent={{-58,-108},{60,-134}},
                lineColor={28,108,200},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This is the model of a consumer with temperature dependence. </p>
<p>The heat demand is a linear function of the outside temperature. </p>
<p>The parameter Qlow is the heat demand at the temperature tlow.</p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The parameter Qhigh is the heat demand at the temperature thigh.</span></p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/heat_demand_temperature.png\"/></p>
</html>"));
      end ConsumerTempDepend;

      model ConsumerTimeDepend
        "time dependence of the heat consumptionparameter time_to_heat; "

      parameter Real time_heat[:,:] "heat demand dependent to time";
      parameter Modelica.SIunits.Time tstart( start= 0) "start time of table";

      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_flow_consumer
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-36,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_flow "heat demand 
  of all households including net losses"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={2,0})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heat_demand_sensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-72,0})));
        Modelica.Blocks.Interfaces.RealOutput heat_demand
          "positive heat demand"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-106,70})));
        Modelica.Blocks.Math.Gain invertor(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-72,38})));
        Modelica.Blocks.Sources.TimeTable timeTable(table=time_heat, startTime=tstart)
                                                                     annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={44,0})));
      equation
        connect(gain.y, heat_flow_consumer.Q_flow)
          annotation (Line(points={{-9,0},{-26,0}}, color={0,0,127}));
        connect(heat_demand_sensor.port_b, heat_flow)
          annotation (Line(points={{-82,0},{-91,0},{-100,0}}, color={191,0,0}));
        connect(heat_demand_sensor.port_a, heat_flow_consumer.port)
          annotation (Line(points={{-62,0},{-54,0},{-46,0}}, color={191,0,0}));
        connect(heat_demand_sensor.Q_flow, invertor.u)
          annotation (Line(points={{-72,10},{-72,18},{-72,26}}, color={0,0,127}));
        connect(invertor.y, heat_demand) annotation (Line(points={{-72,49},{-72,49},{-72,
                56},{-72,70},{-106,70}}, color={0,0,127}));
        connect(gain.u, timeTable.y) annotation (Line(points={{14,-1.33227e-015},{24,-1.33227e-015},
                {24,0},{33,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Text(
                extent={{-98,-12},{-60,-24}},
                lineColor={238,46,47},
                lineThickness=0.5,
                textString="heat flow",
                fontSize=14),
              Text(
                extent={{-94,76},{-40,64}},
                lineColor={28,108,200},
                lineThickness=0.5,
                fontSize=14,
                textString="heat demand"),
              Line(points={{-10,70}}, color={0,0,0}),
              Rectangle(
                extent={{-60,18},{60,-76}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,-76},{12,-38}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,-38},{-26,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,-38},{50,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,4},{50,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,4},{-26,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,4},{12,-16}},
                lineColor={0,0,0}),
              Line(
                points={{-60,18},{0,80},{60,18}},
                color={0,0,0}),
              Text(
                extent={{-70,-84},{72,-94}},
                lineColor={0,0,0},
                textString="time dependend"),
              Text(
                extent={{-58,-112},{60,-134}},
                lineColor={28,108,200},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This is the model of a consumer with time dependent heat consumtption. </p>
<p>The table defines the heat demand over time. </p>
<p>The parameter tstart defines the start time. If tstart is unequal to zero, the heat demand during the time before tstart is zero. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/heat_demand_time.png\"/></p>
</html>",       revisions=""));
      end ConsumerTimeDepend;

      model ConsumerTimeDependData
        "time dependence of the heat consumptionparameter time_to_heat; "

      parameter Modelica.SIunits.Time tstart( start= 0) "start time of table";
        parameter String fileName="fileName" "File on which data is present"                                        annotation(Dialog(loadSelector(filter = "Text files (*.txt)", caption = "Choose Text File with Consumer Heat Demand")));
        parameter String tableName="tableName" "Table Name in the file";

      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_flow_consumer
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-36,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_flow "heat demand 
  of all households including net losses"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={2,0})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heat_demand_sensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-72,0})));
        Modelica.Blocks.Interfaces.RealOutput heat_demand
          "positive heat demand"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-106,70})));
        Modelica.Blocks.Math.Gain invertor(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-72,38})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(tableOnFile=true,
          tableName=tableName,
          fileName=fileName)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={44,0})));

      equation
        connect(gain.y, heat_flow_consumer.Q_flow)
          annotation (Line(points={{-9,0},{-26,0}}, color={0,0,127}));
        connect(heat_demand_sensor.port_b, heat_flow)
          annotation (Line(points={{-82,0},{-91,0},{-100,0}}, color={191,0,0}));
        connect(heat_demand_sensor.port_a, heat_flow_consumer.port)
          annotation (Line(points={{-62,0},{-54,0},{-46,0}}, color={191,0,0}));
        connect(heat_demand_sensor.Q_flow, invertor.u)
          annotation (Line(points={{-72,10},{-72,18},{-72,26}}, color={0,0,127}));
        connect(invertor.y, heat_demand) annotation (Line(points={{-72,49},{-72,49},{-72,
                56},{-72,70},{-106,70}}, color={0,0,127}));
        connect(combiTimeTable.y[1], gain.u)
          annotation (Line(points={{33,0},{23.5,0},{14,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Text(
                extent={{-98,-12},{-60,-24}},
                lineColor={238,46,47},
                lineThickness=0.5,
                textString="heat flow",
                fontSize=14),
              Text(
                extent={{-94,76},{-40,64}},
                lineColor={28,108,200},
                lineThickness=0.5,
                fontSize=14,
                textString="heat demand"),
              Line(points={{-10,70}}, color={0,0,0}),
              Rectangle(
                extent={{-60,18},{60,-76}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,-76},{12,-38}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,-38},{-26,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,-38},{50,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,4},{50,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,4},{-26,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,4},{12,-16}},
                lineColor={0,0,0}),
              Line(
                points={{-60,18},{0,80},{60,18}},
                color={0,0,0}),
              Text(
                extent={{-70,-84},{72,-94}},
                lineColor={0,0,0},
                textString="time dependend"),
              Text(
                extent={{-58,-112},{60,-134}},
                lineColor={28,108,200},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This is the model of a consumer with time dependent heat consumtption. </p>
<p>The model has an intern CombiTimeTable, which is defined by fileName and TableName. In the table the left column has to be a monoton increasing time, the second column has to be the heat flow demand in SIunit W.</p>
<p>The parameter tstart defines the start time. If tstart is unequal to zero, the heat demand during the time before tstart is zero. </p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/heat_demand_time.png\"/></p>
</html>",       revisions=""));
      end ConsumerTimeDependData;

      model ConsumerTimeDependExt
        "time dependence of the heat consumptionparameter time_to_heat; "

      Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_flow_consumer
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-36,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_flow "heat demand 
  of all households including net losses"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={2,0})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heat_demand_sensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-72,0})));
        Modelica.Blocks.Interfaces.RealOutput heat_demand
          "positive heat demand"
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-106,70})));
        Modelica.Blocks.Math.Gain invertor(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-72,38})));
        Modelica.Blocks.Interfaces.RealInput positive_heat_flow annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=180,
              origin={106,0})));
      equation
        connect(gain.y, heat_flow_consumer.Q_flow)
          annotation (Line(points={{-9,0},{-26,0}}, color={0,0,127}));
        connect(heat_demand_sensor.port_b, heat_flow)
          annotation (Line(points={{-82,0},{-91,0},{-100,0}}, color={191,0,0}));
        connect(heat_demand_sensor.port_a, heat_flow_consumer.port)
          annotation (Line(points={{-62,0},{-54,0},{-46,0}}, color={191,0,0}));
        connect(heat_demand_sensor.Q_flow, invertor.u)
          annotation (Line(points={{-72,10},{-72,18},{-72,26}}, color={0,0,127}));
        connect(invertor.y, heat_demand) annotation (Line(points={{-72,49},{-72,49},{-72,
                56},{-72,70},{-106,70}}, color={0,0,127}));
        connect(gain.u, positive_heat_flow)
          annotation (Line(points={{14,0},{106,0},{106,0}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-100,100},{100,-100}},
                lineColor={0,0,0},
                lineThickness=0.5),
              Text(
                extent={{-98,-12},{-60,-24}},
                lineColor={238,46,47},
                lineThickness=0.5,
                textString="heat flow",
                fontSize=14),
              Text(
                extent={{-94,76},{-40,64}},
                lineColor={28,108,200},
                lineThickness=0.5,
                fontSize=14,
                textString="heat demand"),
              Line(points={{-10,70}}, color={0,0,0}),
              Rectangle(
                extent={{-60,18},{60,-76}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,-76},{12,-38}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,-38},{-26,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,-38},{50,-58}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{26,4},{50,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-50,4},{-26,-16}},
                lineColor={0,0,0}),
              Rectangle(
                extent={{-12,4},{12,-16}},
                lineColor={0,0,0}),
              Line(
                points={{-60,18},{0,80},{60,18}},
                color={0,0,0}),
              Text(
                extent={{-70,-84},{72,-94}},
                lineColor={0,0,0},
                textString="time dependend"),
              Text(
                extent={{-58,-112},{60,-134}},
                lineColor={28,108,200},
                textString="%name")}),
                                Diagram(coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This is the model of a consumer with time dependent heat consumtption. </p>
<p>The heat flow of the model is defined by a external source, for example TimeTable or CombiTimeTable.</p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/heat_demand_time.png\"/></p>
</html>",       revisions=""));
      end ConsumerTimeDependExt;
    end Consumers;

    package Storage

      model StorageInfinite "Storage Model with infinite Energy Storage"

      parameter Modelica.SIunits.HeatCapacity C(start=1)
          "Heat capacity of the storage (cp*m)";
      parameter Modelica.SIunits.ThermalConductance G( start=0)
          "Constant thermal conductance of the storage (G=A*U)" annotation(Dialog(group="Storage losses"));
        parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
          "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
        parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
          "Referencetemperature of the storage";
        parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
          "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
          Modelica.SIunits.Temperature T_actual "current storage temperature";
          Modelica.SIunits.Heat Stored_Heat
          "Stored heat refered to Referencetemperature";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
          der_T(start=der_T),
          T(start=Tstart, fixed=true))
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-104})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-68})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor coat_losses(G=G)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-14})));
        Modelica.Blocks.Interfaces.RealOutput store_temp annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,104})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Heat_Losses annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-42})));
      equation

      T_actual=Store.T;
      T_actual=store_temp;
      Stored_Heat=Store.C*(T_actual-Tref);
        connect(heat_input, heat_output)
          annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));
        connect(Store.port, heat_output)
          annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
        connect(outside_temp, outside_temperature.T)
          annotation (Line(points={{0,-104},{0,-80}}, color={0,0,127}));
        connect(coat_losses.port_b, heat_output)
          annotation (Line(points={{0,-4},{0,0},{100,0}},  color={191,0,0}));
        connect(coat_losses.port_a, Heat_Losses.port_a) annotation (Line(points={{-5.55112e-016,
                -24},{0,-24},{0,-32},{1.77636e-015,-32}}, color={191,0,0}));
        connect(outside_temperature.port, Heat_Losses.port_b) annotation (Line(points=
               {{5.55112e-016,-58},{0,-58},{0,-52},{-1.77636e-015,-52}}, color={191,0,
                0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
              Rectangle(
                extent={{-100,100},{100,0}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,0},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-74,10},{74,-10}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid,
                textString="Storage

infinite"),   Text(
                extent={{-62,130},{66,106}},
                lineColor={28,108,200},
                textString="%name")}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This storage model has infinite energy storage capacitiy. </p>
<p>Thermal storage losses are considered by using the thermal conductance G. </p>
<p>The conductance G is calculated by:</p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/G-Formula.png\"/></p>
<p>with Ai...partial area of the storage surface [m&sup2;]</p>
<p>        Ui...heat transition coefficient of the partial area [W/(m&sup2;*K)]</p>
<p>If thermal losses are not considered then G=0</p>
</html>"));
      end StorageInfinite;

      model StorageFinite

      //Durchdenken: wie max. Kapazität festlegen;

      parameter Modelica.SIunits.HeatCapacity C
          "Heat capacity of the storage (cp*m)";
      parameter Modelica.SIunits.ThermalConductance G
          "Constant thermal conductance of the storage (G=A*U)" annotation(Dialog(group="Storage losses"));
        parameter Modelica.SIunits.Temperature T_min( start=313.15, displayUnit="degC")
          "minimum allowed temperature of the storage" annotation(Dialog(group="Temperatures"));
        parameter Modelica.SIunits.Temperature T_max(start=383.15, displayUnit="degC")
          "maximum allowed temperature of the storage" annotation(Dialog(group="Temperatures"));
        parameter Modelica.SIunits.Temperature T_ref( start=273.15, displayUnit="degC")
          "Referencetemperature of the storage" annotation(Dialog(group="Temperatures"));
        parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
          "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
        parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
          "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
            Real fill_level "fill level of the storage";
          Modelica.SIunits.Temperature T_act( displayUnit="degC")
          "actual storage temp";
          Modelica.SIunits.Heat Stored_Energy
          "Stored Heat (revered to Reference Temperature)";
          Boolean Store_filled "true, if store is filled";
          Boolean Store_empty "true, if store is empty";
          Modelica.SIunits.HeatFlowRate Store_un_load
          "Heat Flow Difference between load Heat and unload Heat";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
          der_T(start=der_T),
          T(start=Tstart, fixed=true))
          annotation (Placement(transformation(extent={{-10,38},{10,58}})));
        Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-104})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-68})));
        Modelica.Thermal.HeatTransfer.Components.ThermalConductor coat_losses(G=G)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-14})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor storein annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-82,18})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow storeheatin
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Modelica.Blocks.Interfaces.RealOutput fill annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,106})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow storeheatout
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={22,0})));

        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature ambient(T=273.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-82,74})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow storeout
          annotation (Placement(transformation(extent={{66,-24},{86,-4}})));
        Modelica.Blocks.Interfaces.RealInput demand annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=180,
              origin={104,60})));
        Modelica.Blocks.Math.Gain sign2(k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={58,4})));
        Modelica.Blocks.Logical.Switch switch_empty annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={42,40})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor storage_losses
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-44})));
        Modelica.Blocks.Math.Feedback max_heat_out
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-66,42})));
        Modelica.Blocks.Math.Gain sign1(
                                       k=-1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-36,54})));
        Modelica.Blocks.Logical.Switch switch_filled annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,-14})));
        Modelica.Blocks.Math.Add max_heat_in(k1=1, k2=1) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={64,-46})));
        Modelica.Blocks.Math.Feedback surplus_heat_flow
          annotation (Placement(transformation(extent={{-58,4},{-38,24}})));
        Modelica.Blocks.Nonlinear.VariableLimiter unload_limiter annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={4,76})));
        Modelica.Blocks.Sources.Constant empty_zero(k=0) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={-36,84})));
        Modelica.Blocks.Nonlinear.VariableLimiter load_limiter annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={50,-82})));
        Modelica.Blocks.Sources.Constant filled_zero(k=0) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={34,-46})));
        Modelica.Thermal.HeatTransfer.Sensors.TemperatureSensor Store_temp
          annotation (Placement(transformation(extent={{4,10},{24,30}})));
        Modelica.Blocks.Sources.Constant Tmin(k=T_min)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
              origin={86,82})));
        Modelica.Blocks.Logical.Less less
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=180,
              origin={56,82})));
        Modelica.Blocks.Logical.Greater greater
          annotation (Placement(transformation(extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,-52})));
        Modelica.Blocks.Sources.Constant Tmax(k=T_max) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-60,-84})));
      equation

      fill_level=fill;
      fill=(T_act-T_min)/(T_max-T_min);
      Store.T=T_act;
      Stored_Energy=Store.C*(T_act-T_ref);
      Store_empty=less.y;
      Store_filled=greater.y;

      -Store_un_load=storeheatin.port.Q_flow+storeheatout.port.Q_flow+storage_losses.Q_flow;
        connect(Store.port, coat_losses.port_b) annotation (Line(points={{0,38},{6.66134e-016,
                38},{6.66134e-016,-4}},               color={191,0,0}));
        connect(storeheatin.port, coat_losses.port_b) annotation (Line(points={{-22,0},
                {6.66134e-016,0},{6.66134e-016,-4}},     color={191,0,0}));
        connect(storeheatout.port, coat_losses.port_b) annotation (Line(points={{12,1.33227e-015},
                {6.66134e-016,1.33227e-015},{6.66134e-016,-4}},
              color={191,0,0}));
        connect(outside_temp, outside_temperature.T) annotation (Line(points={{0,-104},
                {0,-90},{0,-80},{-6.66134e-016,-80}}, color={0,0,127}));
        connect(storein.port_b, ambient.port)
          annotation (Line(points={{-82,28},{-82,64}},          color={191,0,0}));
        connect(heat_output, storeout.port)
          annotation (Line(points={{100,0},{86,0},{86,-14}},
                                                           color={191,0,0}));
        connect(switch_empty.u1, demand) annotation (Line(points={{50,52},{50,60},{80,
                60},{104,60}},         color={0,0,127}));
        connect(switch_empty.y, sign2.u) annotation (Line(points={{42,29},{42,22},{58,
                22},{58,16}}, color={0,0,127}));
        connect(coat_losses.port_a, storage_losses.port_a) annotation (Line(
              points={{-5.55112e-016,-24},{0,-24},{0,-34}}, color={191,0,0}));
        connect(outside_temperature.port, storage_losses.port_b) annotation (Line(
              points={{5.55112e-016,-58},{0,-58},{0,-54}}, color={191,0,0}));
        connect(storein.Q_flow, max_heat_out.u1) annotation (Line(points={{-72,18},{-66,
                18},{-66,34}},          color={0,0,127}));
        connect(switch_filled.y, storeheatin.Q_flow)
          annotation (Line(points={{-60,-3},{-60,0},{-42,0}},  color={0,0,127}));
        connect(switch_filled.u1, max_heat_out.u1) annotation (Line(points={{-68,-26},
                {-68,-32},{-78,-32},{-78,6},{-66,6},{-66,34}},            color={0,0,127}));
        connect(surplus_heat_flow.u1, max_heat_out.u1) annotation (Line(points={{-56,14},
                {-66,14},{-66,34}},                  color={0,0,127}));
        connect(surplus_heat_flow.u2, storeheatin.Q_flow)
          annotation (Line(points={{-48,6},{-48,0},{-42,0}},  color={0,0,127}));
        connect(storein.port_a, heat_input) annotation (Line(points={{-82,8},{-82,0},{
                -100,0}},         color={191,0,0}));
        connect(storeheatout.Q_flow, sign2.u) annotation (Line(points={{32,-1.33227e-015},
                {42,-1.33227e-015},{42,22},{58,22},{58,16}},
              color={0,0,127}));
        connect(storeout.Q_flow, sign2.y) annotation (Line(points={{66,-14},{58,
                -14},{58,-7}}, color={0,0,127}));
        connect(greater.y, switch_filled.u2) annotation (Line(points={{-60,-41},{-60,-41},
                {-60,-26}}, color={255,0,255}));
        connect(max_heat_out.u2, storage_losses.Q_flow) annotation (Line(points={{-58,
                42},{-54,42},{-54,26},{-18,26},{-18,-44},{-10,-44}}, color={0,0,127}));
        connect(max_heat_out.y, sign1.u)
          annotation (Line(points={{-66,51},{-66,54},{-48,54}}, color={0,0,127}));
        connect(unload_limiter.limit1, empty_zero.y)
          annotation (Line(points={{-8,84},{-14,84},{-25,84}}, color={0,0,127}));
        connect(unload_limiter.limit2, sign1.y) annotation (Line(points={{-8,68},{-12,
                68},{-12,54},{-25,54}}, color={0,0,127}));
        connect(unload_limiter.u, demand) annotation (Line(points={{-8,76},{-20,76},{-20,
                60},{104,60}}, color={0,0,127}));
        connect(switch_empty.u3, unload_limiter.y)
          annotation (Line(points={{34,52},{34,76},{15,76}}, color={0,0,127}));
        connect(switch_empty.u2, less.y) annotation (Line(points={{42,52},{42,52},{42,
                66},{42,82},{45,82}}, color={255,0,255}));
        connect(less.u1, Tmin.y)
          annotation (Line(points={{68,82},{75,82}}, color={0,0,127}));
        connect(Store_temp.port, coat_losses.port_b) annotation (Line(points={{4,20},{
                0,20},{0,-4},{5.55112e-016,-4}}, color={191,0,0}));
        connect(Store_temp.T, less.u2) annotation (Line(points={{24,20},{28,20},{28,96},
                {72,96},{72,90},{68,90}}, color={0,0,127}));
        connect(max_heat_in.u2, storage_losses.Q_flow) annotation (Line(points={{58,-34},
                {58,-26},{-18,-26},{-18,-44},{-10,-44}}, color={0,0,127}));
        connect(max_heat_in.u1, sign2.y) annotation (Line(points={{70,-34},{70,-22},{58,
                -22},{58,-7}}, color={0,0,127}));
        connect(load_limiter.limit1, max_heat_in.y) annotation (Line(points={{58,-70},
                {58,-66},{64,-66},{64,-57}}, color={0,0,127}));
        connect(load_limiter.limit2, filled_zero.y) annotation (Line(points={{42,-70},
                {42,-66},{34,-66},{34,-57}}, color={0,0,127}));
        connect(load_limiter.u, max_heat_out.u1) annotation (Line(points={{50,-70},{50,
                -32},{-78,-32},{-78,6},{-66,6},{-66,34}}, color={0,0,127}));
        connect(Tmax.y, greater.u1)
          annotation (Line(points={{-60,-73},{-60,-64}}, color={0,0,127}));
        connect(load_limiter.y, switch_filled.u3) annotation (Line(points={{50,-93},{50,
                -96},{22,-96},{22,-84},{-26,-84},{-26,-36},{-52,-36},{-52,-26}},
              color={0,0,127}));
        connect(greater.u2, less.u2) annotation (Line(points={{-52,-64},{-52,-68},{-32,
                -68},{-32,34},{28,34},{28,96},{72,96},{72,90},{68,90}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(
                extent={{-50,74},{50,0}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
              Rectangle(
                extent={{-50,0},{50,-74}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-72,8},{76,-12}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid,
                textString="Storage

finite")}),                                                            Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This storage model has finite energy storage capacitiy. </span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The upper and lower limit of the storage is definded by temperature limits. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The fill level of the storage is between 0 (empty) and 1 (filled).</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the fill level is higher than 0 and lower than 1 the heat flow input and the heat flow output are infinite.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the storage is empty, the output heat flow ist limited to the input heat flow reduced with the lossed heat flow .</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If the storage is filled, the input heat flow is limited to the output heat flow and additionaly the lossed heat flow. </span></p>
<p><br><span style=\"font-family: MS Shell Dlg 2;\">The stored heat is calculated by the heat capacity multiplied by the temperature difference between the storage temperature and the reference temperature.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Thermal storage losses are considered by using the thermal conductance G. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The conductance G is calculated by:</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\"><img src=\"modelica://DistrictHeating/Resources/Images/G-Formula.png\"/></span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">with Ai...partial area of the storage surface [m&sup2;]</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Ui...heat transition coefficient of the partial area [W/(m&sup2;*K)]</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If thermal losses are not considered then G=0</span></p>
</html>"));
      end StorageFinite;

      model StorageTwoLayer "Storage Model with infinite Energy Storage"

         parameter Modelica.SIunits.Volume V(start=137)
          "Net-Volume of the store";
         parameter Modelica.SIunits.Height H(start=22)
          "Net-Height of the store";
         parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
          "Referencetemperature of the storage";
         parameter Modelica.SIunits.Temperature Tup(start=363.15, displayUnit="degC")
          "Temperature in the upper part of the store" annotation(Dialog(group="Storage losses"));
         parameter Modelica.SIunits.Temperature Tdown(start=313.15, displayUnit="degC")
          "Temperature in the lower part of the store" annotation(Dialog(group="Storage losses"));
         parameter Modelica.SIunits.CoefficientOfHeatTransfer U( start=0.2)
          "U-Value of the Storage Wall" annotation(Dialog(group="Storage losses"));
         parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
          "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
         parameter Modelica.SIunits.TemperatureSlope der_T( start=0)
          "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
         parameter Modelica.SIunits.Density Rho=995.6
          "Desity of the Store Fluid";
         parameter Modelica.SIunits.SpecificHeatCapacity Cp=4177
          "Specific Heat Capacity of the Store Fluid";

         Modelica.SIunits.Temperature T_actual "current storage temperature";
         Modelica.SIunits.Heat Stored_Heat
          "Stored heat refered to Referencetemperature";
         Modelica.SIunits.ThermalConductance G
          "Thermal conductance of the storage";
         Modelica.SIunits.Height Hboard
          "Height of the border between hot and cold parts of the store";
         Modelica.SIunits.Area Adown "Surface of the cold part of the store";
         Modelica.SIunits.Area Aup "Surface of the hot part of the store";
         Modelica.SIunits.Diameter D "Net-Diameter of the store";
         Modelica.SIunits.Temperature Tout=outside_temp
          "Outside Temperature from extern";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(
          T(start=Tstart, fixed=true),
          der_T(start=der_T),
          C=V*Rho*Cp)
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-104})));
        Modelica.Blocks.Interfaces.RealOutput store_temp annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,104})));

        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-68})));
        Others.VariableThermalConductor                           coat_losses
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-14})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Heat_Losses annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-42})));

      equation
      T_actual=Store.T;
      T_actual=store_temp;
      Stored_Heat=Store.C*(T_actual-Tref);

      D=sqrt((4*V)/(Modelica.Constants.pi*H));
      H*(T_actual-Tref)=Hboard*(Tdown-Tref)+(H-Hboard)*(Tup-Tref);
      Adown=D*D*Modelica.Constants.pi/4+D*Modelica.Constants.pi*Hboard;
      Aup=D*D*Modelica.Constants.pi/4+D*Modelica.Constants.pi*(H-Hboard);
      G=(U/(T_actual-Tout))*(Aup*(Tup-Tout)+Adown*(Tdown-Tout));
      G=coat_losses.Thermal_conduct;

      connect(heat_input, heat_output)
          annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));

        connect(Store.port, heat_output)
          annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
        connect(coat_losses.port_a,Heat_Losses. port_a) annotation (Line(points={{0,-24},
                {0,-24},{0,-32}},                         color={191,0,0}));
        connect(outside_temperature.port,Heat_Losses. port_b) annotation (Line(points={{0,-58},
                {0,-58},{0,-52}},                                        color={191,0,
                0}));
        connect(outside_temperature.T, outside_temp) annotation (Line(points={{-6.66134e-016,
                -80},{0,-80},{0,-104}}, color={0,0,127}));
        connect(coat_losses.port_b, heat_output)
          annotation (Line(points={{0,-4},{0,0},{100,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
              Rectangle(
                extent={{-100,100},{100,0}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,0},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-74,10},{74,-10}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid,
                textString="Two Layer

Storage"),    Text(
                extent={{-62,130},{66,106}},
                lineColor={28,108,200},
                textString="%name")}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This storage model has finite energy storage capacitiy, given by the volume of the storage. </p>
<p>Thermal storage losses are considered by using the thermal U-value of the storage wall. </p>
<p>The model has two water layers (these physically don&apos;t exist, only by equations), a high temperature layer (Tup) at the top and a low temperature layer (Tdown) at the bottom. Between these two layers there is a boarder. </p>
<p>Dependent to the store temperature, the boarder rises or falls. With the boarder height the thermal conductance of the store wall is calculated, so that the heat flow loss of the single heat capacity equals to the two layer storage model. </p>
</html>"));
      end StorageTwoLayer;

      model StorageInfiniteLossesExt
        "Storage Model with infinite Energy Storage"

        parameter Modelica.SIunits.HeatCapacity C(start=1)
          "Heat capacity of the storage (cp*m)";
        parameter Modelica.SIunits.ThermalConductance G
          "Average Thermal conductance of the storage" annotation(Dialog(group="Only for calculation, no influence to the model"));
        parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
          "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
        parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
          "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
        parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
          "Referencetemperature of the storage";
          Modelica.SIunits.Temperature T_actual "current storage temperature";
          Modelica.SIunits.Heat Stored_Heat
          "Stored heat refered to Referencetemperature";
          Modelica.SIunits.HeatFlowRate Q "Store Losses by average G";
          Modelica.SIunits.ThermalConductance Gvar
          "Thermal conductance of the storage (calculated)";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
          der_T(start=der_T),
          T(start=Tstart, fixed=true))
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-104})));
        Modelica.Blocks.Interfaces.RealOutput store_temp annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,104})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
          prescribedHeatFlow annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-30})));
        Modelica.Blocks.Interfaces.RealInput Store_losses annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-66,-104})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{-46,-72},{-26,-52}})));
      equation

      T_actual=Store.T;
      T_actual=store_temp;
      Stored_Heat=Store.C*(T_actual-Tref);
      Q=G*(T_actual-outside_temp);
      Gvar= prescribedHeatFlow.port.Q_flow/(T_actual-outside_temp);

        connect(heat_input, heat_output)
          annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));
        connect(Store.port, heat_output)
          annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
        connect(prescribedHeatFlow.port, heat_output)
          annotation (Line(points={{0,-20},{0,0},{100,0}}, color={191,0,0}));
        connect(gain.y, prescribedHeatFlow.Q_flow) annotation (Line(points={{
                -25,-62},{0,-62},{0,-40}}, color={0,0,127}));
        connect(gain.u, Store_losses) annotation (Line(points={{-48,-62},{-66,
                -62},{-66,-104}}, color={0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
              Rectangle(
                extent={{-100,100},{100,0}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,0},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-74,10},{74,-10}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid,
                textString="Storage

infinite"),   Text(
                extent={{-62,130},{66,106}},
                lineColor={28,108,200},
                textString="%name")}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This storage model has infinite energy storage capacitiy. </p>
<p>Thermal storage losses are considered by Real Input. </p>
<p>If thermal losses are not considered then the Real Input has to equal to zero. </p>
</html>"));
      end StorageInfiniteLossesExt;

      model StorageInfiniteGvar "Storage Model with infinite Energy Storage"

      parameter Modelica.SIunits.HeatCapacity C(start=1)
          "Heat capacity of the storage (cp*m)";
        parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
          "Starttemperature of the storage" annotation(Dialog(group="Initialization"));
        parameter Modelica.SIunits.Temperature Tref(start=293.15, displayUnit="degC")
          "Referencetemperature of the storage";
        parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
          "Time derivative of temperature (= der(T))" annotation(Dialog(group="Initialization"));
          Modelica.SIunits.Temperature T_actual "current storage temperature";
          Modelica.SIunits.Heat Stored_Heat
          "Stored heat refered to Referencetemperature";
      Modelica.SIunits.ThermalConductance G
          "Thermal conductance of the storage";
      Modelica.SIunits.HeatFlowRate Qloss "Store Heat Flow Losses";

        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_input
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_b heat_output
          annotation (Placement(transformation(extent={{90,-10},{110,10}})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor Store(C=C,
          der_T(start=der_T),
          T(start=Tstart, fixed=true))
          annotation (Placement(transformation(extent={{-10,30},{10,50}})));
        Modelica.Blocks.Interfaces.RealInput outside_temp annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={0,-104})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedTemperature outside_temperature
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-68})));
        Modelica.Blocks.Interfaces.RealOutput store_temp annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,104})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Heat_Losses annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-42})));
        Modelica.Blocks.Interfaces.RealInput Thermal_conduct annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=90,
              origin={-60,-104})));
        Others.VariableThermalConductor variableThermalConductor annotation (
            Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-16})));
      equation

      T_actual=Store.T;
      T_actual=store_temp;
      Stored_Heat=Store.C*(T_actual-Tref);
      G=Thermal_conduct;
      Qloss=G*(T_actual-outside_temp);

        connect(heat_input, heat_output)
          annotation (Line(points={{-100,0},{0,0},{100,0}}, color={191,0,0}));
        connect(Store.port, heat_output)
          annotation (Line(points={{0,30},{0,0},{100,0}}, color={191,0,0}));
        connect(outside_temp, outside_temperature.T)
          annotation (Line(points={{0,-104},{0,-80}}, color={0,0,127}));
        connect(outside_temperature.port, Heat_Losses.port_b) annotation (Line(points=
               {{5.55112e-016,-58},{0,-58},{0,-52},{-1.77636e-015,-52}}, color={191,0,
                0}));
        connect(Heat_Losses.port_a, variableThermalConductor.port_a)
          annotation (Line(points={{0,-32},{0,-29},{0,-26}}, color={191,0,0}));
        connect(variableThermalConductor.port_b, heat_output)
          annotation (Line(points={{0,-6},{0,0},{100,0}}, color={191,0,0}));
        connect(variableThermalConductor.Thermal_conduct, Thermal_conduct)
          annotation (Line(points={{-10.4,-16},{-20,-16},{-60,-16},{-60,-104}}, color=
               {0,0,127}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
              Rectangle(extent={{-100,100},{100,-100}}, lineColor={0,0,0}),
              Rectangle(
                extent={{-100,100},{100,0}},
                lineColor={0,0,0},
                fillColor={255,0,0},
                fillPattern=FillPattern.Solid),
              Rectangle(
                extent={{-100,0},{100,-100}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid),
              Text(
                extent={{-74,10},{74,-10}},
                lineColor={0,0,0},
                fillColor={0,0,255},
                fillPattern=FillPattern.Solid,
                textString="Storage

infinite"),   Text(
                extent={{-62,130},{66,106}},
                lineColor={28,108,200},
                textString="%name")}),                                 Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          Documentation(info="<html>
<p>This storage model has infinite energy storage capacitiy. </p>
<p>Thermal storage losses are considered by using the thermal conductance G. </p>
<p>The conductance G is calculated by:</p>
<p><img src=\"modelica://DistrictHeating/Resources/Images/G-Formula.png\"/></p>
<p>with Ai...partial area of the storage surface [m&sup2;]</p>
<p>        Ui...heat transition coefficient of the partial area [W/(m&sup2;*K)]</p>
<p>If thermal losses are not considered then G=0</p>
</html>"));
      end StorageInfiniteGvar;
    end Storage;

    package Others

      model VariableThermalConductor
        "Lumped thermal element transporting heat without storing it"
        extends Modelica.Thermal.HeatTransfer.Interfaces.Element1D;
       Modelica.SIunits.ThermalConductance G=Thermal_conduct
          "Constant thermal conductance of material";

        Modelica.Blocks.Interfaces.RealInput Thermal_conduct annotation (Placement(
              transformation(
              extent={{-20,-20},{20,20}},
              rotation=270,
              origin={0,104})));
      equation
        Q_flow = G*dT;
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},{
                  100,100}}), graphics={
              Rectangle(
                extent={{-90,70},{90,-70}},
                lineColor={0,0,0},
                pattern=LinePattern.None,
                fillColor={192,192,192},
                fillPattern=FillPattern.Backward),
              Line(
                points={{-90,70},{-90,-70}},
                color={0,0,0},
                thickness=0.5),
              Line(
                points={{90,70},{90,-70}},
                color={0,0,0},
                thickness=0.5),
              Text(
                extent={{-150,115},{150,75}},
                textString="%name",
                lineColor={0,0,255}),
              Text(
                extent={{-150,-75},{150,-105}},
                lineColor={0,0,0},
                textString="G=%G")}),
          Diagram(coordinateSystem(preserveAspectRatio=true, extent={{-100,-100},
                  {100,100}}), graphics={
              Line(
                points={{-80,0},{80,0}},
                color={255,0,0},
                thickness=0.5,
                arrow={Arrow.None,Arrow.Filled}),
              Text(
                extent={{-100,-20},{100,-40}},
                lineColor={255,0,0},
                textString="Q_flow"),
              Text(
                extent={{-100,40},{100,20}},
                lineColor={0,0,0},
                textString="dT = port_a.T - port_b.T")}),
          Documentation(info="<HTML>
<p>
This is a model for transport of heat without storing it; see also:
<a href=\"modelica://Modelica.Thermal.HeatTransfer.Components.ThermalResistor\">ThermalResistor</a>.
It may be used for complicated geometries where
the thermal conductance G (= inverse of thermal resistance)
is determined by measurements and is assumed to be constant
over the range of operations. If the component consists mainly of
one type of material and a regular geometry, it may be calculated,
e.g., with one of the following equations:
</p>
<ul>
<li><p>
    Conductance for a <b>box</b> geometry under the assumption
    that heat flows along the box length:</p>
    <pre>
    G = k*A/L
    k: Thermal conductivity (material constant)
    A: Area of box
    L: Length of box
    </pre>
    </li>
<li><p>
    Conductance for a <b>cylindrical</b> geometry under the assumption
    that heat flows from the inside to the outside radius
    of the cylinder:</p>
    <pre>
    G = 2*pi*k*L/log(r_out/r_in)
    pi   : Modelica.Constants.pi
    k    : Thermal conductivity (material constant)
    L    : Length of cylinder
    log  : Modelica.Math.log;
    r_out: Outer radius of cylinder
    r_in : Inner radius of cylinder
    </pre>
    </li>
</ul>
<pre>
    Typical values for k at 20 degC in W/(m.K):
      aluminium   220
      concrete      1
      copper      384
      iron         74
      silver      407
      steel        45 .. 15 (V2A)
      wood         0.1 ... 0.2
</pre>
</html>"));
      end VariableThermalConductor;
    end Others;
  end Components;

  package Examples
    extends Modelica.Icons.ExamplesPackage;
    package Boiler
        extends Modelica.Icons.ExamplesPackage;
      model BoilerInFinite

        extends Modelica.Icons.Example;

        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=0,
              origin={2,0})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={40,0})));
        Modelica.Blocks.Math.Feedback feedback
          annotation (Placement(transformation(extent={{10,58},{30,78}})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=2000,
          duration=2,
          offset=0,
          startTime=1)
          annotation (Placement(transformation(extent={{-84,-10},{-64,10}})));
        Components.Boiler.BoilerInFinite boilerInFinite(limited_heat=true, Qmax=
             1000)
          annotation (Placement(transformation(extent={{-44,-10},{-24,10}})));
      equation
        connect(heatFlowSensor.Q_flow, feedback.u2) annotation (Line(points={{2,-10},
                {2,-10},{2,-16},{2,-18},{20,-18},{20,60}}, color={0,0,127}));
        connect(ramp.y, boilerInFinite.nominal_heat) annotation (Line(points={{
                -63,0},{-54,0},{-44.4,0}}, color={0,0,127}));
        connect(heatFlowSensor.port_a, boilerInFinite.thermal_heat_flow)
          annotation (Line(points={{-8,0},{-24,0}}, color={191,0,0}));
        connect(feedback.u1, boilerInFinite.nominal_heat) annotation (Line(
              points={{12,68},{-54,68},{-54,0},{-44.4,0}},color={0,0,127}));
        connect(heatFlowSensor.port_b, fixedTemperature.port)
          annotation (Line(points={{12,0},{21,0},{30,0}}, color={191,0,0}));
        annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
              coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=5),
          __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<p>This example shows that the Real input of the Model is directly converted into a heat flow output.</p>
<p>With the limited heat flow the Real input rises above the limit but the heat flow output stays at its maximum.</p>
</html>"));
      end BoilerInFinite;

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

    package Consumers
      extends Modelica.Icons.ExamplesPackage;
      model ConsumerTempDepend
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Cosine cosine(
          amplitude=10,
          freqHz=0.1,
          offset=-5,
          startTime=0,
          phase=3.1415926535898) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={48,0})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-62,-10},{-42,10}})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={-24,-28})));
        Components.Consumers.ConsumerTempDepend consumerTempDepend(
             temp=[-10,2000; 15,500])
          annotation (Placement(transformation(extent={{-4,-10},{16,10}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
            T=273.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-24,-68})));
      equation
        connect(heatFlowSensor.port_a,prescribedHeatFlow. port)
          annotation (Line(points={{-24,-18},{-24,0},{-42,0}}, color={191,0,0}));
        connect(cosine.y, consumerTempDepend.outside_temperature)
          annotation (Line(points={{37,0},{16.6,0}}, color={0,0,127}));
        connect(consumerTempDepend.heat_flow, prescribedHeatFlow.port)
          annotation (Line(points={{-4,0},{-42,0}}, color={191,0,0}));
        connect(prescribedHeatFlow.Q_flow, consumerTempDepend.heat_demand)
          annotation (Line(points={{-62,0},{-68,0},{-74,0},{-74,18},{-34,18},{
                -34,7},{-4.6,7}}, color={0,0,127}));
        connect(fixedTemperature.port, heatFlowSensor.port_b) annotation (Line(
              points={{-24,-58},{-24,-48},{-24,-38}}, color={191,0,0}));
        annotation (experiment(StopTime=10), __Dymola_experimentSetupOutput,
          Documentation(info="<html>
<p>This example shows the use of the temperature dependend consumer. </p>
<p>With the sinusoidal temperature trend a heat demand (heat flow) is generated. </p>
<p>With the Real output of the model the heat flow demand is used to produce the needed heat flow. </p>
<p>The heat flow sensor shows that the real output and the heat flow are equal (except the unit).</p>
</html>"));
      end ConsumerTempDepend;

      model ConsumerTimeDepend
        extends Modelica.Icons.Example;
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-38,-10},{-18,10}})));
        Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,-28})));
        Modelica.Thermal.HeatTransfer.Components.HeatCapacitor heatCapacitor(C=1)
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={0,-64})));
        Components.Consumers.ConsumerTimeDepend consumerTimeDepend(time_heat=[0,
              0; 1,0; 3,2000; 4,1500; 5,1700; 7,1300; 10,0], tstart=0)
          annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      equation
        connect(heatCapacitor.port,heatFlowSensor. port_b) annotation (Line(points={{0,-54},
                {0,-46},{0,-38}},                color={191,0,0}));
        connect(heatFlowSensor.port_a,prescribedHeatFlow. port)
          annotation (Line(points={{0,-18},{0,0},{-18,0}},     color={191,0,0}));
        connect(consumerTimeDepend.heat_flow, prescribedHeatFlow.port)
          annotation (Line(points={{20,0},{-18,0}}, color={191,0,0}));
        connect(prescribedHeatFlow.Q_flow, consumerTimeDepend.heat_demand)
          annotation (Line(points={{-38,0},{-52,0},{-52,16},{-8,16},{-8,7},{
                19.4,7}}, color={0,0,127}));
        annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">This example shows the use of the time dependend consumer. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">With the intern definded time table the heat demand is given.</span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">With the Real output of the model the heat flow demand is used to produce the needed heat flow. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The heat flow sensor shows that the real output and the heat flow are equal (except the unit).</span></p>
</html>"));
      end ConsumerTimeDepend;

      model ConsumerTimeDependData
        extends Modelica.Icons.Example;
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
              273.15)
          annotation (Placement(transformation(extent={{-32,-10},{-12,10}})));
        DistrictHeating.Components.Consumers.ConsumerTimeDependData
          consumerTimeDependExt(
          tstart=0,
          tableName="Strohleistung",
          fileName=
              "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_example1.txt")
          annotation (Placement(transformation(extent={{12,-10},{32,10}})));
      equation
        connect(fixedTemperature.port, consumerTimeDependExt.heat_flow)
          annotation (Line(points={{-12,0},{0,0},{12,0}}, color={191,0,0}));
        annotation (experiment(StopTime=10),
            __Dymola_experimentSetupOutput);
      end ConsumerTimeDependData;

      model ConsumerTimeDependExt
        extends Modelica.Icons.Example;
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=273.15)
          annotation (Placement(transformation(extent={{-46,-10},{-26,10}})));
        DistrictHeating.Components.Consumers.ConsumerTimeDependExt
          consumerTimeDependExt
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.CombiTimeTable combiTimeTable(
          tableOnFile=true,
          tableName="Strohleistung",
          columns={2,3,4,5,6,7},
          fileName="C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_Example2.txt")
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={36,0})));
      equation
        connect(fixedTemperature.port, consumerTimeDependExt.heat_flow)
          annotation (Line(points={{-26,0},{-10,0}}, color={191,0,0}));
        connect(consumerTimeDependExt.positive_heat_flow, combiTimeTable.y[6])
          annotation (Line(points={{10.6,0},{25,0},{25,0}}, color={0,0,127}));
        annotation (experiment(StopTime=10),
            __Dymola_experimentSetupOutput);
      end ConsumerTimeDependExt;
    end Consumers;

    package Storage
      extends Modelica.Icons.ExamplesPackage;
      model StorageInfinite
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Cosine cosine(
          freqHz=0.1,
          startTime=0,
          offset=0,
          amplitude=5,
          phase=3.1415926535898) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-44})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
          prescribedHeatFlow1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={40,0})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=500,
          duration=2,
          offset=0,
          startTime=2) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,66})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{26,20},{46,40}})));
        Components.Storage.StorageInfinite storageInfinite(
          C=1,
          G=0.1,
          der_T=0,
          Tstart=313.15)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(prescribedHeatFlow.Q_flow,ramp. y) annotation (Line(points={{-42,0},
                {-54,0},{-62,0},{-62,30},{0,30},{0,55}}, color={0,0,127}));
        connect(prescribedHeatFlow1.Q_flow,gain. y) annotation (Line(points={{50,0},{
                60,0},{72,0},{72,30},{47,30}},  color={0,0,127}));
        connect(gain.u,ramp. y) annotation (Line(points={{24,30},{0,30},{0,55}},
                                   color={0,0,127}));
        connect(prescribedHeatFlow.port, storageInfinite.heat_input)
          annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
        connect(prescribedHeatFlow1.port, storageInfinite.heat_output)
          annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
                10,0}}, color={191,0,0}));
        connect(cosine.y, storageInfinite.outside_temp)
          annotation (Line(points={{0,-33},{0,-10.4}}, color={0,0,127}));
        annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded and unloaded in the same amount. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Through the thermal losses of the storage the temperature in the storage decreases. </span></p>
</html>"));
      end StorageInfinite;

      model StorageFinite
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Cosine cosine(
          freqHz=0.1,
          startTime=0,
          amplitude=5,
          phase=3.1415926535898,
          offset=273.15)         annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-44})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Components.Storage.StorageFinite storageFinite(
          C=10,
          G=0.1,
          der_T=0,
          T_min=313.15,
          T_max=373.15,
          T_ref=313.15,
          Tstart=323.15)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.TimeTable Boiler(
          table=[0,0; 1,0; 2,500; 3,1500; 4,2000; 5,1000; 6,500; 7,500; 8,500;
              9,200; 10,0],
          offset=0,
          startTime=0)
          annotation (Placement(transformation(extent={{-82,-10},{-62,10}})));
        Modelica.Blocks.Sources.TimeTable Consumer(
          offset=0,
          startTime=0,
          table=[0,0; 1,0; 2,200; 3,500; 4,500; 5,500; 6,1500; 7,2000; 8,2000;
              9,1500; 10,1500]) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={58,32})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
            T=273.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={58,0})));
        Modelica.Blocks.Math.Gain gain(k=-1) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={28,32})));
      equation
        connect(prescribedHeatFlow.Q_flow, Boiler.y)
          annotation (Line(points={{-42,0},{-61,0}}, color={0,0,127}));
        connect(prescribedHeatFlow.port, storageFinite.heat_input)
          annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
        connect(storageFinite.heat_output, fixedTemperature.port) annotation (
            Line(points={{10,0},{48,0},{48,1.33227e-015}}, color={191,0,0}));
        connect(cosine.y, storageFinite.outside_temp) annotation (Line(points={
                {0,-33},{0,-33},{0,-10.4}}, color={0,0,127}));
        connect(Consumer.y, gain.u)
          annotation (Line(points={{47,32},{40,32}}, color={0,0,127}));
        connect(gain.y, storageFinite.demand) annotation (Line(points={{17,32},
                {14,32},{14,6},{10.4,6}}, color={0,0,127}));
        annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded and unloaded by two time tabels.</span></p>
<p>During the simulation the storage gets fully loaded and fully unloaded.</p>
</html>"),experiment(StopTime=10),
          __Dymola_experimentSetupOutput);
      end StorageFinite;

      model StorageTwoLayer
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Cosine cosine(
          freqHz=0.1,
          startTime=0,
          offset=0,
          amplitude=5,
          phase=3.1415926535898) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-44})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
          prescribedHeatFlow1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={40,0})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=500,
          duration=2,
          offset=0,
          startTime=2) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,66})));
        Modelica.Blocks.Math.Gain gain(k=-1)
          annotation (Placement(transformation(extent={{26,20},{46,40}})));
        Components.Storage.StorageTwoLayer storageInfinite(
          der_T=0,
          U=0.01,
          V=0.01,
          H=0.1,
          Tref=313.15,
          Tup=363.15,
          Tdown=313.15,
          Tstart=323.15)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(prescribedHeatFlow.Q_flow,ramp. y) annotation (Line(points={{-42,0},
                {-54,0},{-62,0},{-62,30},{0,30},{0,55}}, color={0,0,127}));
        connect(prescribedHeatFlow1.Q_flow,gain. y) annotation (Line(points={{50,0},{
                60,0},{72,0},{72,30},{47,30}},  color={0,0,127}));
        connect(gain.u,ramp. y) annotation (Line(points={{24,30},{0,30},{0,55}},
                                   color={0,0,127}));
        connect(prescribedHeatFlow.port, storageInfinite.heat_input)
          annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
        connect(prescribedHeatFlow1.port, storageInfinite.heat_output)
          annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
                10,0}}, color={191,0,0}));
        connect(cosine.y, storageInfinite.outside_temp)
          annotation (Line(points={{0,-33},{0,-10.4}}, color={0,0,127}));
        annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded and unloaded in the same amount. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Through the thermal losses of the storage the temperature in the storage decreases. </span></p>
</html>"),experiment(StopTime=10, __Dymola_NumberOfIntervals=5000),
          __Dymola_experimentSetupOutput);
      end StorageTwoLayer;

      model StorageInfiniteLossesExt
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Cosine cosine(
          freqHz=0.1,
          startTime=0,
          offset=0,
          amplitude=5,
          phase=3.1415926535898) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-44})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
          prescribedHeatFlow1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={40,0})));
        Components.Storage.StorageInfiniteLossesExt storageInfiniteLossesExt(
          C=1,
          der_T=0,
          G=0.0682344,
          Tstart=293.15,
          Tref=293.15)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Blocks.Sources.Constant Source(k=500)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Blocks.Sources.Constant Sink(k=-480) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,0})));
        Modelica.Blocks.Sources.Constant Losses(k=20) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-36,-44})));
      equation
        connect(prescribedHeatFlow.port, storageInfiniteLossesExt.heat_input)
          annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
        connect(prescribedHeatFlow1.port, storageInfiniteLossesExt.heat_output)
          annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
                10,0}}, color={191,0,0}));
        connect(cosine.y, storageInfiniteLossesExt.outside_temp) annotation (
            Line(points={{7.21645e-016,-33},{0,-33},{0,-10.4}}, color={0,0,127}));
        connect(prescribedHeatFlow.Q_flow, Source.y)
          annotation (Line(points={{-42,0},{-50,0},{-59,0}}, color={0,0,127}));
        connect(prescribedHeatFlow1.Q_flow, Sink.y) annotation (Line(points={{
                50,-1.11022e-015},{54,-1.11022e-015},{54,0},{59,0}}, color={0,0,
                127}));
        connect(storageInfiniteLossesExt.Store_losses, Losses.y) annotation (
            Line(points={{-6.6,-10.4},{-6.6,-14},{-36,-14},{-36,-33}}, color={0,
                0,127}));
        annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded with 500W and unloaded with 480W. The store losses are 20W. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The sum of the used heat flow and the store losses are equal to the loading heat flow. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">So the store temperature stays constant. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">The parameter G of the storage is set to the arithmetic mean of the variable gvar from the simulation. So, over time the average store losses equal to aproximately 20W.</span></p>
</html>"),experiment(StopTime=10, __Dymola_NumberOfIntervals=5000),
          __Dymola_experimentSetupOutput);
      end StorageInfiniteLossesExt;

      model StorageInfiniteGvar
        extends Modelica.Icons.Example;
        Modelica.Blocks.Sources.Cosine cosine(
          freqHz=0.1,
          startTime=0,
          offset=0,
          amplitude=5,
          phase=3.1415926535898) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={0,-44})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow prescribedHeatFlow
          annotation (Placement(transformation(extent={{-42,-10},{-22,10}})));
        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow
          prescribedHeatFlow1 annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={40,0})));
        Modelica.Blocks.Sources.Constant Source(k=500)
          annotation (Placement(transformation(extent={{-80,-10},{-60,10}})));
        Modelica.Blocks.Sources.Constant Sink(k=-470) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={70,0})));
        Modelica.Blocks.Sources.Constant Losses(k=0.1) annotation (Placement(
              transformation(
              extent={{-10,-10},{10,10}},
              rotation=90,
              origin={-36,-44})));
        Components.Storage.StorageInfiniteGvar storageInfiniteGvar(
          C=1,
          der_T=0,
          Tstart=293.15,
          Tref=293.15)
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      equation
        connect(prescribedHeatFlow.Q_flow, Source.y)
          annotation (Line(points={{-42,0},{-50,0},{-59,0}}, color={0,0,127}));
        connect(prescribedHeatFlow1.Q_flow, Sink.y) annotation (Line(points={{
                50,-1.11022e-015},{54,-1.11022e-015},{54,0},{59,0}}, color={0,0,
                127}));
        connect(prescribedHeatFlow.port, storageInfiniteGvar.heat_input)
          annotation (Line(points={{-22,0},{-16,0},{-10,0}}, color={191,0,0}));
        connect(prescribedHeatFlow1.port, storageInfiniteGvar.heat_output)
          annotation (Line(points={{30,1.22125e-015},{20,1.22125e-015},{20,0},{
                10,0}}, color={191,0,0}));
        connect(cosine.y, storageInfiniteGvar.outside_temp) annotation (Line(
              points={{7.21645e-016,-33},{0,-33},{0,-10.4}}, color={0,0,127}));
        connect(Losses.y, storageInfiniteGvar.Thermal_conduct) annotation (Line(
              points={{-36,-33},{-36,-24},{-6,-24},{-6,-10.4}}, color={0,0,127}));
        annotation (Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The storage is loaded with 500W and unloaded with 780W. The store losses are calculated by extern thermal conductivity. </span></p>
<p>This model is used for calibration model. In real, this model can`t be used because normally the thermal conductivity of the storage is constant. </p>
</html>"),experiment(StopTime=10, __Dymola_NumberOfIntervals=5000),
          __Dymola_experimentSetupOutput);
      end StorageInfiniteGvar;
    end Storage;

    package Others
        extends Modelica.Icons.ExamplesPackage;
      model VariableThermalConductor
        "Thermal conductor which has an input of thermal conductance"
        extends Modelica.Icons.Example;
        Modelica.Thermal.HeatTransfer.Sources.FixedHeatFlow fixedHeatFlow(
            Q_flow=100)
          annotation (Placement(transformation(extent={{-50,-10},{-30,10}})));
        DistrictHeating.Components.Others.VariableThermalConductor
          variableThermalConductor
          annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
        Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(
            T=273.15) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={42,0})));
        Modelica.Blocks.Sources.Ramp ramp(
          height=100,
          duration=5,
          startTime=2,
          offset=0.1) annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=270,
              origin={0,38})));
      equation
        connect(fixedHeatFlow.port, variableThermalConductor.port_a)
          annotation (Line(points={{-30,0},{-20,0},{-10,0}}, color={191,0,0}));
        connect(variableThermalConductor.port_b, fixedTemperature.port)
          annotation (Line(points={{10,0},{22,0},{32,0}}, color={191,0,0}));
        connect(variableThermalConductor.Thermal_conduct, ramp.y) annotation (
            Line(points={{0,10.4},{0,10.4},{0,27},{-1.9984e-015,27}}, color={0,
                0,127}));
        annotation (
          Icon(coordinateSystem(preserveAspectRatio=false)),
          Diagram(coordinateSystem(preserveAspectRatio=false)),
          experiment(StopTime=10),
          __Dymola_experimentSetupOutput);
      end VariableThermalConductor;
    end Others;

    model DistrictHeatWithoutStore
      extends Modelica.Icons.Example;
      Components.Consumers.ConsumerTimeDepend consumerTimeDepend(time_heat=[0,0;
            3,2000; 4,1700; 6,1500; 7,1300; 10,0], tstart=0)
        annotation (Placement(transformation(extent={{20,-10},{40,10}})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor heatFlowSensor
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-22})));
      Modelica.Thermal.HeatTransfer.Sources.FixedTemperature fixedTemperature(T=
           273.15) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-56})));
      Components.Boiler.BoilerBasicPeak boilerBasicPeak(Qbase=1500, Qpeak=500)
        annotation (Placement(transformation(extent={{-40,-10},{-20,10}})));
    equation
      connect(heatFlowSensor.port_a, fixedTemperature.port)
        annotation (Line(points={{0,-32},{0,-40},{0,-46},{4.44089e-016,-46}},
                                                   color={191,0,0}));
      connect(boilerBasicPeak.thermal_heat_flow, consumerTimeDepend.heat_flow)
        annotation (Line(points={{-20,0},{0,0},{20,0}}, color={191,0,0}));
      connect(heatFlowSensor.port_b, consumerTimeDepend.heat_flow) annotation (
          Line(points={{6.66134e-016,-12},{6.66134e-016,0},{20,0}}, color={191,
              0,0}));
      connect(consumerTimeDepend.heat_demand, boilerBasicPeak.nominal_heat)
        annotation (Line(points={{19.4,7},{-8,7},{-8,14},{-8,16},{-54,16},{-54,
              0},{-40.4,0}}, color={0,0,127}));
      annotation (experiment(StopTime=10), __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p><span style=\"font-family: MS Shell Dlg 2;\">The consumer defines a heat demand, which is produced by the boiler. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">During times with low heat flow, only the basic load boiler is in use. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">During times with high heat flow, the basic and the peak load boiler are in use. </span></p>
</html>"));
    end DistrictHeatWithoutStore;
  end Examples;

  package Calibration

    model From_Scalar_To_Heat

    Modelica.SIunits.Heat Unit_Heat=1 "Unit Conversion";
    Modelica.SIunits.Heat Store_Heat_real "Stored heat in real Storage";

      Modelica.Blocks.Interfaces.RealInput u
        annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
      Modelica.Blocks.Interfaces.RealOutput y
        annotation (Placement(transformation(extent={{94,-10},{114,10}})));

    equation
    u*Unit_Heat=Store_Heat_real;
    Store_Heat_real=y;

      annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
            Rectangle(extent={{-100,100},{100,-100}}, lineColor={28,108,200}),
            Line(
              points={{-76,0},{80,0}},
              color={255,0,0},
              thickness=0.5),
            Line(
              points={{80,0},{20,-60},{20,60},{80,0}},
              color={255,0,0},
              thickness=0.5),
            Text(
              extent={{-76,130},{74,106}},
              lineColor={28,108,200},
              textString="%name"),
            Text(
              extent={{-84,84},{16,8}},
              lineColor={28,108,200},
              textString="J")}),                                     Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        Documentation(info="<html>
<p>Converts a Real Input signal into a Real Output Signal with unit Joule.</p>
</html>"));
    end From_Scalar_To_Heat;

    model Calibration_original

      DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
          Qmax=2300000)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=false,
          Qmax=1600000)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=false, Qmax=
           1300000)
        annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
      DistrictHeating.Components.Consumers.ConsumerTimeDependExt
        consumerTimeDependExt
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));
      Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
        tableOnFile=true,
        tableName="Aussentemperatur",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Outsidetemperature_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-30})));

      Modelica.Thermal.FluidHeatFlow.Media.Water water
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      DistrictHeating.Components.Storage.StorageInfinite Store(
        C=137*water.rho*water.cp,
        der_T=0,
        G=1800,
        Tstart(displayUnit="degC") = 300,
        Tref(displayUnit="degC") = 295)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.CombiTimeTable Net_source(
        tableOnFile=true,
        tableName="Netzleistung",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Net_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,0})));

      Modelica.Blocks.Sources.CombiTimeTable Oil_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Oelleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Oil_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,-30})));
      Modelica.Blocks.Sources.CombiTimeTable Wood_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Hackgutleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Wood_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,0})));
      Modelica.Blocks.Sources.CombiTimeTable Straw_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Strohleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,30})));
      Modelica.Blocks.Sources.CombiTimeTable Store_source(
        tableOnFile=true,
        tableName="Speicherenergie",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Store.txt",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,70})));

      From_Scalar_To_Heat Original_heat
        annotation (Placement(transformation(extent={{30,60},{50,80}})));
      Modelica.Blocks.Continuous.Integrator Int_Original_Data(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState)
        annotation (Placement(transformation(extent={{60,60},{80,80}})));
      Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-70})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,0})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={30,0})));
      Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-70})));
      Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,70})));
    equation

    Store.Heat_Losses.Q_flow=Int_Store_Losses.u;

      connect(Outside_Temp_source.y[6], Store.outside_temp) annotation (Line(points={{
              7.21645e-016,-19},{0,-19},{0,-10.4}},  color={0,0,127}));
      connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
        annotation (Line(points={{70.6,0},{79,0}},        color={0,0,127}));
      connect(Oil.nominal_heat, Oil_source.y[6])
        annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
      connect(Wood.nominal_heat, Wood_source.y[6])
        annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                             color={0,0,127}));
      connect(Straw.nominal_heat, Straw_source.y[6])
        annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
      connect(Store_source.y[6], Original_heat.u)
        annotation (Line(points={{21,70},{29.4,70}}, color={0,0,127}));
      connect(Original_heat.y, Int_Original_Data.u)
        annotation (Line(points={{50.4,70},{50.4,70},{58,70}}, color={0,0,127}));
      connect(Used_Heat.Q_flow, Int_Used_Heat.u)
        annotation (Line(points={{30,-10},{30,-58}},         color={0,0,127}));
      connect(Produced_heat.port_b, Store.heat_input)
        annotation (Line(points={{-20,0},{-15,0},{-10,0}}, color={191,0,0}));
      connect(Wood.thermal_heat_flow, Produced_heat.port_a)
        annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
      connect(Oil.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
            points={{-52,-30},{-46,-30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Straw.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
            points={{-52,30},{-46,30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Store.heat_output, Used_Heat.port_a)
        annotation (Line(points={{10,0},{16,0},{20,0}}, color={191,0,0}));
      connect(Used_Heat.port_b, consumerTimeDependExt.heat_flow)
        annotation (Line(points={{40,0},{50,0}}, color={191,0,0}));
      connect(Produced_heat.Q_flow, Int_Prod_Heat.u)
        annotation (Line(points={{-30,-10},{-30,-58}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=4.134e+006,
          StopTime=2.274e+007,
          Interval=60),
        __Dymola_experimentSetupOutput);
    end Calibration_original;

    model CalibrationOriginalFirstTryShort

    extends Modelica.Icons.Example;
      DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
          Qmax=2300000)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=false,
          Qmax=1600000)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=false, Qmax=
           1300000)
        annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
      DistrictHeating.Components.Consumers.ConsumerTimeDependExt
        consumerTimeDependExt
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));

      Modelica.Thermal.FluidHeatFlow.Media.Water water
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      DistrictHeating.Components.Storage.StorageInfinite Store(
        C=137*water.rho*water.cp,
        der_T=0,
        G=1800,
        Tstart(displayUnit="degC") = 300,
        Tref(displayUnit="degC") = 295)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.CombiTimeTable Net_source(
        tableOnFile=true,
        tableName="Netzleistung",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Net_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,0})));

      Modelica.Blocks.Sources.CombiTimeTable Oil_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Oelleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Oil_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,-30})));
      Modelica.Blocks.Sources.CombiTimeTable Wood_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Hackgutleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Wood_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,0})));
      Modelica.Blocks.Sources.CombiTimeTable Straw_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Strohleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,30})));
      Modelica.Blocks.Sources.CombiTimeTable Store_source(
        tableOnFile=true,
        tableName="Speicherenergie",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Store.txt",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,70})));

      From_Scalar_To_Heat Original_heat
        annotation (Placement(transformation(extent={{30,60},{50,80}})));
      Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-70})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,0})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={30,0})));
      Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-70})));
      Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,70})));
      Modelica.Blocks.Math.Feedback Absolute_Difference_Actual_Target
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={70,70})));
      Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
        tableOnFile=true,
        tableName="Aussentemperatur",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Outsidetemperature_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-40})));
    equation

    Store.Heat_Losses.Q_flow=Int_Store_Losses.u;
    Store.Stored_Heat=Absolute_Difference_Actual_Target.u2;

      connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
        annotation (Line(points={{70.6,0},{79,0}},        color={0,0,127}));
      connect(Oil.nominal_heat, Oil_source.y[6])
        annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
      connect(Wood.nominal_heat, Wood_source.y[6])
        annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                             color={0,0,127}));
      connect(Straw.nominal_heat, Straw_source.y[6])
        annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
      connect(Store_source.y[6], Original_heat.u)
        annotation (Line(points={{21,70},{29.4,70}}, color={0,0,127}));
      connect(Used_Heat.Q_flow, Int_Used_Heat.u)
        annotation (Line(points={{30,-10},{30,-58}},         color={0,0,127}));
      connect(Produced_heat.port_b, Store.heat_input)
        annotation (Line(points={{-20,0},{-15,0},{-10,0}}, color={191,0,0}));
      connect(Wood.thermal_heat_flow, Produced_heat.port_a)
        annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
      connect(Oil.thermal_heat_flow, Produced_heat.port_a) annotation (Line(points={
              {-52,-30},{-46,-30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Straw.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
            points={{-52,30},{-46,30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Store.heat_output, Used_Heat.port_a)
        annotation (Line(points={{10,0},{16,0},{20,0}}, color={191,0,0}));
      connect(Used_Heat.port_b, consumerTimeDependExt.heat_flow)
        annotation (Line(points={{40,0},{50,0}}, color={191,0,0}));
      connect(Produced_heat.Q_flow, Int_Prod_Heat.u)
        annotation (Line(points={{-30,-10},{-30,-58}}, color={0,0,127}));
      connect(Store.outside_temp, Outside_Temp_source.y[6]) annotation (Line(
            points={{0,-10.4},{0,-10.4},{0,-29}},         color={0,0,127}));
      connect(Original_heat.y, Absolute_Difference_Actual_Target.u1)
        annotation (Line(points={{50.4,70},{56,70},{62,70}}, color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=4.134e+006,
          StopTime=2.274e+007,
          Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p>The first calibration model tries to optimize the parameters: </p>
<p>Store.G</p>
<p>Store.Tref</p>
<p>The simulation time starts at 4,134,000s an ends at 22,740,000s. Measurements outside this intervall are not considered, the measurements almost equal zero.</p>
</html>"));
    end CalibrationOriginalFirstTryShort;

    model CalibrationOriginalFirstTryLong

    extends Modelica.Icons.Example;
    Modelica.SIunits.Heat StoreLossesOrig
        "Difference between int produced heat and int used heat (messured)";
        Real EtaStore "Store Energy Efficiency";

      DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
          Qmax=2300000)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=false,
          Qmax=1600000)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=false, Qmax=
           1300000)
        annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
      DistrictHeating.Components.Consumers.ConsumerTimeDependExt
        consumerTimeDependExt
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));

      Modelica.Thermal.FluidHeatFlow.Media.Water water
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      DistrictHeating.Components.Storage.StorageInfinite Store(
        der_T=0,
        G=2300.0,
        C=137*water.rho*water.cp,
        Tstart(displayUnit="degC") = 285,
        Tref=285)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.CombiTimeTable Net_source(
        tableOnFile=true,
        tableName="Netzleistung",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Net_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,0})));

      Modelica.Blocks.Sources.CombiTimeTable Oil_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Oelleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Oil_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,-30})));
      Modelica.Blocks.Sources.CombiTimeTable Wood_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Hackgutleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Wood_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,0})));
      Modelica.Blocks.Sources.CombiTimeTable Straw_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Strohleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,30})));
      Modelica.Blocks.Sources.CombiTimeTable Store_source(
        tableOnFile=true,
        tableName="Speicherenergie",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Store.txt",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,70})));

      From_Scalar_To_Heat Original_heat
        annotation (Placement(transformation(extent={{30,60},{50,80}})));
      Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0.0001)                                   annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-70})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,0})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={30,0})));
      Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-70})));
      Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,70})));
      Modelica.Blocks.Math.Feedback Absolute_Difference_Actual_Target
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={70,70})));
      Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
        tableOnFile=true,
        tableName="Aussentemperatur",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Outsidetemperature_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-40})));

    equation
      Store.Heat_Losses.Q_flow=Int_Store_Losses.u
        "Connection between Store Losses and its Integrator";
      Store.Stored_Heat=Absolute_Difference_Actual_Target.u2
        "Connection for calculation of the difference between Meassurement and Simulation";
        StoreLossesOrig=Int_Prod_Heat.y-Int_Used_Heat.y
        "for calculation of StoreLossesOrig";
        EtaStore=Int_Used_Heat.y/Int_Prod_Heat.y "fo calculation of EtaStore";

      connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
        annotation (Line(points={{70.6,0},{79,0}},        color={0,0,127}));
      connect(Oil.nominal_heat, Oil_source.y[6])
        annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
      connect(Wood.nominal_heat, Wood_source.y[6])
        annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                             color={0,0,127}));
      connect(Straw.nominal_heat, Straw_source.y[6])
        annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
      connect(Store_source.y[6], Original_heat.u)
        annotation (Line(points={{21,70},{29.4,70}}, color={0,0,127}));
      connect(Used_Heat.Q_flow, Int_Used_Heat.u)
        annotation (Line(points={{30,-10},{30,-58}},         color={0,0,127}));
      connect(Produced_heat.port_b, Store.heat_input)
        annotation (Line(points={{-20,0},{-15,0},{-10,0}}, color={191,0,0}));
      connect(Wood.thermal_heat_flow, Produced_heat.port_a)
        annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
      connect(Oil.thermal_heat_flow, Produced_heat.port_a) annotation (Line(points={
              {-52,-30},{-46,-30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Straw.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
            points={{-52,30},{-46,30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Store.heat_output, Used_Heat.port_a)
        annotation (Line(points={{10,0},{16,0},{20,0}}, color={191,0,0}));
      connect(Used_Heat.port_b, consumerTimeDependExt.heat_flow)
        annotation (Line(points={{40,0},{50,0}}, color={191,0,0}));
      connect(Produced_heat.Q_flow, Int_Prod_Heat.u)
        annotation (Line(points={{-30,-10},{-30,-58}}, color={0,0,127}));
      connect(Store.outside_temp, Outside_Temp_source.y[6]) annotation (Line(
            points={{0,-10.4},{0,-10.4},{0,-29}},         color={0,0,127}));
      connect(Original_heat.y, Absolute_Difference_Actual_Target.u1)
        annotation (Line(points={{50.4,70},{62,70}},         color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=2.4886e+007, Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p>The first calibration model tries to optimize the parameters: </p>
<p>Store.G</p>
<p>Store.Tref</p>
<p>The simulation time concludes all measurements-data. Simulation time from 0 to 24,886,020s.</p>
</html>"));
    end CalibrationOriginalFirstTryLong;

    model StoreHeatFlowLosses
    extends Modelica.Icons.Example;
    Modelica.SIunits.HeatFlowRate AvStoreLoss
        "Average Store Heat Flow Losses calculated by StoreLossEnergy divided by time";

      Modelica.Blocks.Sources.CombiTimeTable Store_source(
        tableOnFile=true,
        tableName="Speicherenergie",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Store.txt",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,-78})));
      From_Scalar_To_Heat Original_heat
        annotation (Placement(transformation(extent={{-70,-88},{-50,-68}})));
      Modelica.Blocks.Continuous.Derivative derivative(
        initType=Modelica.Blocks.Types.Init.InitialState,
        x_start=0,
        T=60,
        k=1)  annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=90,
            origin={-8,-38})));
      DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=true, Qmax=
            3000000)
        annotation (Placement(transformation(extent={{-72,74},{-52,94}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=true,
          Qmax=2200000)
        annotation (Placement(transformation(extent={{-72,44},{-52,64}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=true, Qmax(
            displayUnit="kW") = 1950000)
        annotation (Placement(transformation(extent={{-72,14},{-52,34}})));
      DistrictHeating.Components.Consumers.ConsumerTimeDependExt
        consumerTimeDependExt
        annotation (Placement(transformation(extent={{50,44},{70,64}})));
      Modelica.Blocks.Sources.CombiTimeTable Net_source(
        tableOnFile=true,
        tableName="Netzleistung",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Net_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,54})));
      Modelica.Blocks.Sources.CombiTimeTable Oil_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Oelleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Oil_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,24})));
      Modelica.Blocks.Sources.CombiTimeTable Wood_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Hackgutleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Wood_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,54})));
      Modelica.Blocks.Sources.CombiTimeTable Straw_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Strohleistung",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,84})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,54})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={26,54})));
      DistrictHeating.Components.Storage.StorageInfiniteLossesExt Store(
        der_T=0,
        C=137*water.rho*water.cp,
        Tref(displayUnit="degC") = 313.15,
        Tstart=313.15,
        G=1157.91)
        annotation (Placement(transformation(extent={{-12,44},{8,64}})));
      Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
        tableOnFile=true,
        tableName="Aussentemperatur",
        columns={2,3,4,5,6,7},
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Outsidetemperature_original.txt",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={10,14})));
      Modelica.Thermal.FluidHeatFlow.Media.Water water
        annotation (Placement(transformation(extent={{80,0},{100,20}})));
      Modelica.Blocks.Continuous.Integrator Int_Prod(
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-10})));
      Modelica.Blocks.Continuous.Integrator Int_Used(
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0) annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={26,-10})));

      Modelica.Blocks.Math.MultiSum multiSum(nu=3, k={1,-1,-1}) annotation (
          Placement(transformation(
            extent={{-6,-6},{6,6}},
            rotation=90,
            origin={-8,-64})));
    equation

    if time<0.00001 then
    AvStoreLoss=0;
    else
      AvStoreLoss=(Int_Prod.y-Int_Used.y)/time;
    end if;

      connect(Store_source.y[6],Original_heat. u)
        annotation (Line(points={{-79,-78},{-74,-78},{-70.6,-78}},
                                                     color={0,0,127}));

      connect(consumerTimeDependExt.positive_heat_flow,Net_source. y[6])
        annotation (Line(points={{70.6,54},{79,54}},      color={0,0,127}));
      connect(Oil.nominal_heat,Oil_source. y[6])
        annotation (Line(points={{-72.4,24},{-79,24}},   color={0,0,127}));
      connect(Wood.nominal_heat,Wood_source. y[6])
        annotation (Line(points={{-72.4,54},{-72.4,54},{-79,54}},
                                                             color={0,0,127}));
      connect(Wood.thermal_heat_flow,Produced_heat. port_a)
        annotation (Line(points={{-52,54},{-40,54}},
                                                   color={191,0,0}));
      connect(Oil.thermal_heat_flow,Produced_heat. port_a) annotation (Line(points={{-52,24},
              {-46,24},{-46,54},{-40,54}},          color={191,0,0}));
      connect(Straw.thermal_heat_flow,Produced_heat. port_a) annotation (Line(
            points={{-52,84},{-46,84},{-46,54},{-40,54}},
                                                        color={191,0,0}));
      connect(Used_Heat.port_b,consumerTimeDependExt. heat_flow)
        annotation (Line(points={{36,54},{50,54}},
                                                 color={191,0,0}));
      connect(Straw.nominal_heat, Straw_source.y[6])
        annotation (Line(points={{-72.4,84},{-79,84}}, color={0,0,127}));
      connect(Produced_heat.port_b, Store.heat_input)
        annotation (Line(points={{-20,54},{-16,54},{-12,54}}, color={191,0,0}));
      connect(Used_Heat.port_a, Store.heat_output)
        annotation (Line(points={{16,54},{12,54},{8,54}}, color={191,0,0}));
      connect(Outside_Temp_source.y[6], Store.outside_temp) annotation (Line(
            points={{10,25},{10,25},{10,32},{-2,32},{-2,43.6}}, color={0,0,127}));
      connect(Used_Heat.Q_flow, Int_Used.u)
        annotation (Line(points={{26,44},{26,2}},         color={0,0,127}));
      connect(Produced_heat.Q_flow, Int_Prod.u)
        annotation (Line(points={{-30,44},{-30,2}},          color={0,0,127}));
      connect(Int_Prod.y, multiSum.u[1]) annotation (Line(points={{-30,-21},{-30,-21},
              {-30,-68},{-30,-72},{-30,-74},{-10.8,-74},{-10.8,-70}}, color={0,0,127}));
      connect(Original_heat.y, multiSum.u[2]) annotation (Line(points={{-49.6,-78},{
              -44,-78},{-8,-78},{-8,-70}}, color={0,0,127}));
      connect(Int_Used.y, multiSum.u[3]) annotation (Line(points={{26,-21},{26,-78},
              {-5.2,-78},{-5.2,-70}}, color={0,0,127}));
      connect(Store.Store_losses, derivative.y) annotation (Line(points={{-8.6,43.6},
              {-8.6,-27},{-8,-27}}, color={0,0,127}));
      connect(multiSum.y, derivative.u) annotation (Line(points={{-8,-56.98},{-8,-56.98},
              {-8,-50}}, color={0,0,127}));
      annotation (
        Icon(coordinateSystem(preserveAspectRatio=false)),
        Diagram(coordinateSystem(preserveAspectRatio=false)),
        experiment(
          StartTime=2.0028e+006,
          StopTime=2.41596e+007,
          Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p>Differentiation of the original data of the stored heat leads to a heat flow, which tells if the store is loaded or unloaded. </p>
<p>Take this heat flow and use additionally the heat flow input and the heat flow output the difference heat flow that results equals to the store losses. </p>
<p>The Model of the store contains the variable &QUOT;Q&QUOT;. This is an calculated heat flow loss of the storage to the environment, with an average &QUOT;G&QUOT; as parameter. The temperature difference equals to the store temperature minus outside temperature. </p>
<p>The parameter average G equals the arithmetic mean of the variable Gvar from the store. </p>
</html>"));
    end StoreHeatFlowLosses;

    model average_data

    extends Modelica.Icons.Example;
    Modelica.SIunits.Heat StoreLossesOrig
        "Difference between int produced heat and int used heat (messured)";
        Real EtaStore "Store Energy Efficiency";

      DistrictHeating.Components.Boiler.BoilerInFinite Straw(limited_heat=false,
          Qmax=2300000)
        annotation (Placement(transformation(extent={{-72,20},{-52,40}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Wood(limited_heat=false,
          Qmax=1600000)
        annotation (Placement(transformation(extent={{-72,-10},{-52,10}})));
      DistrictHeating.Components.Boiler.BoilerInFinite Oil(limited_heat=false, Qmax=
           1300000)
        annotation (Placement(transformation(extent={{-72,-40},{-52,-20}})));
      DistrictHeating.Components.Consumers.ConsumerTimeDependExt
        consumerTimeDependExt
        annotation (Placement(transformation(extent={{50,-10},{70,10}})));

      Modelica.Thermal.FluidHeatFlow.Media.Water water
        annotation (Placement(transformation(extent={{60,-60},{80,-40}})));
      DistrictHeating.Components.Storage.StorageInfinite Store(
        der_T=0,
        G=2300.0,
        C=137*water.rho*water.cp,
        Tstart(displayUnit="degC") = 285,
        Tref=285)
        annotation (Placement(transformation(extent={{-10,-10},{10,10}})));
      Modelica.Blocks.Sources.CombiTimeTable Net_source(
        tableOnFile=true,
        tableName="Netzleistung",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Net_average.txt")
                                                                    annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=180,
            origin={90,0})));

      Modelica.Blocks.Sources.CombiTimeTable Oil_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Oelleistung",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Oil_average.txt")
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,-30})));
      Modelica.Blocks.Sources.CombiTimeTable Wood_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Hackgutleistung",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Wood_average.txt")
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,0})));
      Modelica.Blocks.Sources.CombiTimeTable Straw_source(
        tableOnFile=true,
        columns={2,3,4,5,6,7},
        tableName="Strohleistung",
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Straw_average.txt")
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-90,30})));
      Modelica.Blocks.Sources.CombiTimeTable Store_source(
        tableOnFile=true,
        tableName="Speicherenergie",
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Store.txt",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments) annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={10,70})));

      From_Scalar_To_Heat Original_heat
        annotation (Placement(transformation(extent={{30,60},{50,80}})));
      Modelica.Blocks.Continuous.Integrator Int_Prod_Heat(
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState,
        y_start=0.0001)                                   annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={-30,-70})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Produced_heat
        annotation (Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-30,0})));
      Modelica.Thermal.HeatTransfer.Sensors.HeatFlowSensor Used_Heat annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={30,0})));
      Modelica.Blocks.Continuous.Integrator Int_Used_Heat(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=270,
            origin={30,-70})));
      Modelica.Blocks.Continuous.Integrator Int_Store_Losses(
        y_start=0,
        k=1,
        initType=Modelica.Blocks.Types.Init.InitialState) annotation (Placement(
            transformation(
            extent={{-10,-10},{10,10}},
            rotation=0,
            origin={-70,70})));
      Modelica.Blocks.Math.Feedback Absolute_Difference_Actual_Target
        annotation (Placement(transformation(extent={{-10,-10},{10,10}},
            rotation=0,
            origin={70,70})));
      Modelica.Blocks.Sources.CombiTimeTable Outside_Temp_source(
        tableOnFile=true,
        tableName="Aussentemperatur",
        columns={2,3,4,5,6,7},
        smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments,
        fileName=
            "C:/Users/Philipp/Desktop/Masterthese/Dymola/District_Heating/Resources/Data/Outsidetemperature_average.txt")
                                                                    annotation (
          Placement(transformation(
            extent={{-10,-10},{10,10}},
            rotation=90,
            origin={0,-40})));

    equation
      Store.Heat_Losses.Q_flow=Int_Store_Losses.u
        "Connection between Store Losses and its Integrator";
      Store.Stored_Heat=Absolute_Difference_Actual_Target.u2
        "Connection for calculation of the difference between Meassurement and Simulation";
        StoreLossesOrig=Int_Prod_Heat.y-Int_Used_Heat.y
        "for calculation of StoreLossesOrig";
        EtaStore=Int_Used_Heat.y/Int_Prod_Heat.y "fo calculation of EtaStore";

      connect(consumerTimeDependExt.positive_heat_flow, Net_source.y[6])
        annotation (Line(points={{70.6,0},{79,0}},        color={0,0,127}));
      connect(Oil.nominal_heat, Oil_source.y[6])
        annotation (Line(points={{-72.4,-30},{-79,-30}}, color={0,0,127}));
      connect(Wood.nominal_heat, Wood_source.y[6])
        annotation (Line(points={{-72.4,0},{-72.4,0},{-79,0}},
                                                             color={0,0,127}));
      connect(Straw.nominal_heat, Straw_source.y[6])
        annotation (Line(points={{-72.4,30},{-79,30}}, color={0,0,127}));
      connect(Store_source.y[6], Original_heat.u)
        annotation (Line(points={{21,70},{29.4,70}}, color={0,0,127}));
      connect(Used_Heat.Q_flow, Int_Used_Heat.u)
        annotation (Line(points={{30,-10},{30,-58}},         color={0,0,127}));
      connect(Produced_heat.port_b, Store.heat_input)
        annotation (Line(points={{-20,0},{-15,0},{-10,0}}, color={191,0,0}));
      connect(Wood.thermal_heat_flow, Produced_heat.port_a)
        annotation (Line(points={{-52,0},{-40,0}}, color={191,0,0}));
      connect(Oil.thermal_heat_flow, Produced_heat.port_a) annotation (Line(points={
              {-52,-30},{-46,-30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Straw.thermal_heat_flow, Produced_heat.port_a) annotation (Line(
            points={{-52,30},{-46,30},{-46,0},{-40,0}}, color={191,0,0}));
      connect(Store.heat_output, Used_Heat.port_a)
        annotation (Line(points={{10,0},{16,0},{20,0}}, color={191,0,0}));
      connect(Used_Heat.port_b, consumerTimeDependExt.heat_flow)
        annotation (Line(points={{40,0},{50,0}}, color={191,0,0}));
      connect(Produced_heat.Q_flow, Int_Prod_Heat.u)
        annotation (Line(points={{-30,-10},{-30,-58}}, color={0,0,127}));
      connect(Store.outside_temp, Outside_Temp_source.y[6]) annotation (Line(
            points={{0,-10.4},{0,-10.4},{0,-29}},         color={0,0,127}));
      connect(Original_heat.y, Absolute_Difference_Actual_Target.u1)
        annotation (Line(points={{50.4,70},{62,70}},         color={0,0,127}));
      annotation (Icon(coordinateSystem(preserveAspectRatio=false)), Diagram(
            coordinateSystem(preserveAspectRatio=false)),
        experiment(StopTime=2.4886e+007, Interval=60),
        __Dymola_experimentSetupOutput,
        Documentation(info="<html>
<p>This model is used to produce diagramms. With the average data, which are used for this model the graphs appear smoother. </p>
</html>"));
    end average_data;
    annotation ();
  end Calibration;
  annotation (uses(Modelica(version="3.2.1")),
           version = "0.6.0");
end DistrictHeating;
