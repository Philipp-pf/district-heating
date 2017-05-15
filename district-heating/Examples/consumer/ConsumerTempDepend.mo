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

    package Sources
    "Library of signal source blocks generating Real and Boolean signals"
      import Modelica.Blocks.Interfaces;
      import Modelica.SIunits;
      extends Modelica.Icons.SourcesPackage;

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

    type Time = Real (final quantity="Time", final unit="s");

    type Frequency = Real (final quantity="Frequency", final unit="Hz");

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

    package Consumers

      model ConsumerTempDepend
      "linear dependence of the heat consumption by outside temperature"

          parameter Real temp[:,2]
        "temperature to heat (left column outside temperature in �C, right column heat flow in W";

        Modelica.Thermal.HeatTransfer.Sources.PrescribedHeatFlow heat_flow_consumer
          annotation (Placement(transformation(
              extent={{-10,-10},{10,10}},
              rotation=180,
              origin={-36,0})));
        Modelica.Thermal.HeatTransfer.Interfaces.HeatPort_a heat_flow "heat demand 
  of all households including net losses"
          annotation (Placement(transformation(extent={{-110,-10},{-90,10}})));
        Modelica.Blocks.Interfaces.RealInput outside_temperature
        "outside temperature in the area"                                                          annotation (
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
    end Consumers;
  end Components;

  package Examples
    extends Modelica.Icons.ExamplesPackage;

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
    end Consumers;
  end Examples;
  annotation (uses(Modelica(version="3.2.1")),
           version = "0.6.0");
end DistrictHeating;
model DistrictHeating_Examples_Consumers_ConsumerTempDepend
 extends DistrictHeating.Examples.Consumers.ConsumerTempDepend;
  annotation(experiment(StopTime=10),uses(DistrictHeating(version="0.6.0")));
end DistrictHeating_Examples_Consumers_ConsumerTempDepend;
