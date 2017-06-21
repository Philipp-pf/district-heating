within DistrictHeating.Components.Control;
model OutsideTempControl
  "Control keeps boiler heat flow dependend to outside temperature"

Modelica.SIunits.HeatFlowRate HeatFlow "Heat Flow Rate";
Real StoreLoad "Storage loading (boarder height or heat)";
Modelica.SIunits.Temperature OutsideTemp "Outside Temperature";
parameter Modelica.SIunits.HeatFlowRate Table[:,:] "first row has to contain Boarder height in m, first column has to contain 
outsidetemperature in K; take care to SI-prefix: when choosing KW, then fill in km and kK";

  Modelica.Blocks.Interfaces.RealInput u "outside temperature"
    annotation (Placement(transformation(extent={{-132,-20},{-92,20}})));
  Modelica.Blocks.Interfaces.RealOutput y "boiler heat flow"
    annotation (Placement(transformation(extent={{98,-10},{118,10}})));
  Modelica.Blocks.Interfaces.RealInput u1
    "storage loading (boarder height or heat)"                annotation (
      Placement(transformation(
        extent={{-20,-20},{20,20}},
        rotation=270,
        origin={0,104})));

  Modelica.Blocks.Tables.CombiTable2D combiTable2D(table=Table,
    tableOnFile=false,
    smoothness=Modelica.Blocks.Types.Smoothness.LinearSegments)
    annotation (Placement(transformation(extent={{20,-16},{40,4}})));
  Modelica.Blocks.Math.Max max
    annotation (Placement(transformation(extent={{60,-10},{80,10}})));
  Modelica.Blocks.Sources.Constant ZeroHeat(k=0)
    annotation (Placement(transformation(extent={{20,20},{40,40}})));
equation
u=OutsideTemp;
u1=StoreLoad;
y=HeatFlow;
  connect(combiTable2D.u2, u1)
    annotation (Line(points={{18,-12},{0,-12},{0,104}},
                                                      color={0,0,127}));
  connect(combiTable2D.u1, u)
    annotation (Line(points={{18,0},{-112,0}},          color={0,0,127}));
  connect(max.u1, ZeroHeat.y) annotation (Line(points={{58,6},{54,6},{50,6},{50,
          30},{41,30}}, color={0,0,127}));
  connect(y, max.y)
    annotation (Line(points={{108,0},{94,0},{81,0}}, color={0,0,127}));
  connect(combiTable2D.y, max.u2)
    annotation (Line(points={{41,-6},{41,-6},{58,-6}}, color={0,0,127}));
  annotation (Icon(coordinateSystem(preserveAspectRatio=false), graphics={
        Rectangle(
          extent={{-100,-100},{100,100}},
          lineColor={0,0,127},
          fillColor={255,255,255},
          fillPattern=FillPattern.Solid),
        Line(
          visible=true,
          points={{-80,78},{-80,-90}},
          color={192,192,192}),
        Polygon(
          visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{-80,90},{-88,68},{-72,68},{-80,90}}),
        Line(
          visible=true,
          points={{-90,-80},{82,-80}},
          color={192,192,192}),
        Polygon(
          visible=true,
          lineColor={192,192,192},
          fillColor={192,192,192},
          fillPattern=FillPattern.Solid,
          points={{90,-80},{68,-72},{68,-88},{90,-80}}),
        Text(
          lineColor={192,192,192},
          extent={{-52,8},{48,48}},
          textString="control"),
        Text(
          lineColor={192,192,192},
          extent={{-52,42},{48,82}},
          textString="Temp"),
        Text(
          extent={{-92,-102},{88,-140}},
          lineColor={28,108,200},
          textString="%name"),
        Polygon(points={{-72,2},{-72,-16},{-56,-28},{-24,-46},{8,-60},{38,-68},{
              62,-70},{38,-58},{4,-46},{-24,-30},{-48,-14},{-72,2}}, lineColor={
              28,108,200}),
        Line(points={{-74,-6},{-52,-22},{-14,-44},{12,-54},{68,-72}}, color={255,
              0,0})}),           Diagram(coordinateSystem(preserveAspectRatio=
            false)),
    Documentation(info="<html>
<p>This object is used to control boiler heat flow depending to outside temperature. </p>
<p>Therefore, a table is used. Outside temperatures are put in the first (left) column. All other columns contain heat flow rate depending to temperature. </p>
<p>Normally, the higher the outside temperature, the lower the needed heat flow rate. </p>
<p>Additionally, it is possible to choose the boiler heat dependent to the store loading. Therefore, the first row is used. Fill in boarder height or heat. </p>
<p><br>Example to fill in table:</p>
<p>0| 2 | 11 | 20 | first row storage boarder height in m or heat in J</p>
<p>265|1500000|1400000|1300000|</p>
<p>275|1200000|1100000|1000000| </p>
<p>285| 900000 | 800000 | 700000 | heat flow rate in W</p>
<p>first column: outside temperature in K</p>
<p><br>low boarder height means storage has a high loading. </p>
<p>If outside temperature is 275 K and store boarder height is 11m then the heat flow rate equals to 1100000 W or 1100 kW. </p>
<p><span style=\"font-family: MS Shell Dlg 2;\">Both dependencies, outside temperature and store loading are linearly interpolated. </span></p>
<p><span style=\"font-family: MS Shell Dlg 2;\">If temperature is 280 K and store boarder height is 15.5 m then heat flow rate equals 900000 W or 900 kW.</span></p>
<p><br>Give attention to SI unit prefixes: If you choose Kilo Watt, for example, you have to fill in Kilo Kelvin as temperature and Kilo meter or Kilo joule for storage loading!</p>
</html>"));
end OutsideTempControl;
