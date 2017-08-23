These .txt files contain measurement data of an district heating plant.

The measurement data looks at season 2015/16.

The following variables are available:

Efficiency... contains approximated data of boiler efficiency dependent to actual boiler heat flow
Net... contains measurement data of the district heating net (includes all customers and net losses
Oil... contains measurement data of the oil boiler
Outsidetemperature... contains measurement data of the outsidetemperature
Store... contains measurement data of the storage loading
Straw...contains measurement data of the straw boiler
Wood...contains measurement data of the wood boiler

The following extends are possible:

original... not changed measurement data (includes measure failure)
average... each value is a average of the 20 previous and the 20 following values of original data. This leads to reduced amplitudes of the measurement data.
original_changed...contains original measurement data. Measure failure are replaced by estimated values.