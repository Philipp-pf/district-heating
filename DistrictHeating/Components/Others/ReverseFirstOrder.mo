within DistrictHeating.Components.Others;
block ReverseFirstOrder
  "First order reverse transfer function block (= 1 pole)"
  import Modelica.Blocks.Types.Init;
  parameter Real k(unit="1")=1 "Gain";
  parameter Modelica.SIunits.Time T(start=1) "Time Constant";
  parameter Modelica.Blocks.Types.Init initType=Modelica.Blocks.Types.Init.NoInit
    "Type of initialization (1: no init, 2: steady state, 3/4: initial output)"
                                                                                    annotation(Evaluate=true,
      Dialog(group="Initialization"));
  parameter Real u_start=0 "Initial or guess value of output (= state)"
    annotation (Dialog(group="Initialization"));
    parameter Real yMax "max output value";
    parameter Real yMin "min output value";
    Real First "first order output";
    Modelica.SIunits.HeatFlowRate UnitHeatFlow=1 "for unit addition";

  extends Modelica.Blocks.Interfaces.SISO;

initial equation
  if initType == Init.SteadyState then
    der(u) = 0;
  elseif initType == Init.InitialState or initType == Init.InitialOutput then
    u = u_start;
  end if;
equation
  der(u) = (k*First - u)/T;

if u<=1 then
  y=0;
  else
y=max(yMin*UnitHeatFlow,min(yMax*UnitHeatFlow,First));
end if;

  annotation (
    Documentation(info="<HTML>
<p>
This blocks defines the transfer function between the input u
and the output y (element-wise) as <i>first order</i> system:
</p>
<pre>
               k
     y = ------------ * u
            T * s + 1
</pre>
<p>
If you would like to be able to change easily between different
transfer functions (FirstOrder, SecondOrder, ... ) by changing
parameters, use the general block <b>TransferFunction</b> instead
and model a first order SISO system with parameters<br>
b = {k}, a = {T, 1}.
</p>
<pre>
Example:
   parameter: k = 0.3, T = 0.4
   results in:
             0.3
      y = ----------- * u
          0.4 s + 1.0
</pre>

</html>"), Icon(
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
      origin = {-26.667,6.667},
      points = {{106.667,43.333},{-13.333,29.333},{-53.333,-86.667}},
      color = {0,0,127},
      smooth = Smooth.Bezier),
  Text(
    lineColor={192,192,192},
    extent={{-2,-72},{74,22}},
          textString="rev
PT1"),
  Text(visible=true,
    extent={{-150.0,-150.0},{150.0,-110.0}},
    textString="T=%T")}),
    Diagram(coordinateSystem(
        preserveAspectRatio=true,
        extent={{-100,-100},{100,100}}), graphics={
        Text(
          extent={{-48,52},{50,8}},
          lineColor={0,0,0},
          textString="k"),
        Text(
          extent={{-54,-6},{56,-56}},
          lineColor={0,0,0},
          textString="T s + 1"),
        Line(points={{-50,0},{50,0}}, color={0,0,0}),
        Rectangle(extent={{-60,60},{60,-60}}, lineColor={0,0,255}),
        Line(points={{-100,0},{-60,0}}, color={0,0,255}),
        Line(points={{60,0},{100,0}}, color={0,0,255})}));
end ReverseFirstOrder;
