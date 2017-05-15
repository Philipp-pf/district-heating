package Modelica "Modelica Standard Library - Version 3.2.1 (Build 4)"
extends Modelica.Icons.Package;

  package Blocks
  "Library of basic input/output control blocks (continuous, discrete, logical, table blocks)"
  import SI = Modelica.SIunits;
  extends Modelica.Icons.Package;

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

  package Icons "Library of icons"
    extends Icons.Package;

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

    type ThermalConductance = Real (final quantity="ThermalConductance", final unit=
               "W/K");

    type HeatCapacity = Real (final quantity="HeatCapacity", final unit="J/K");
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

    package Storage

      model StorageFinite

      //Durchdenken: wie max. Kapazität festlegen;

      parameter Modelica.SIunits.HeatCapacity C
        "Heat capacity of the storage (cp*m)";
      parameter Modelica.SIunits.ThermalConductance G
        "Constant thermal conductance of the storage (G=A*U)"   annotation(Dialog(group="Storage losses"));
        parameter Modelica.SIunits.Temperature T_min( start=313.15, displayUnit="degC")
        "minimum allowed temperature of the storage"   annotation(Dialog(group="Temperatures"));
        parameter Modelica.SIunits.Temperature T_max(start=383.15, displayUnit="degC")
        "maximum allowed temperature of the storage"   annotation(Dialog(group="Temperatures"));
        parameter Modelica.SIunits.Temperature T_ref( start=273.15, displayUnit="degC")
        "Referencetemperature of the storage"   annotation(Dialog(group="Temperatures"));
        parameter Modelica.SIunits.Temperature Tstart(start=293.15, displayUnit="degC")
        "Starttemperature of the storage"   annotation(Dialog(group="Initialization"));
        parameter Modelica.SIunits.TemperatureSlope der_T(start=0)
        "Time derivative of temperature (= der(T))"   annotation(Dialog(group="Initialization"));
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
    end Storage;
  end Components;
  annotation (uses(Modelica(version="3.2.1")),
           version = "0.6.0");
end DistrictHeating;
model DistrictHeating_Components_Storage_StorageFinite
 extends DistrictHeating.Components.Storage.StorageFinite;
  annotation(uses(DistrictHeating(version="0.6.0")));
end DistrictHeating_Components_Storage_StorageFinite;
