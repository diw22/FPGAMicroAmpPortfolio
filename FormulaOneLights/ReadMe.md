**FormulaOneLights**

The specification of this circuit is:

The circuit is triggered (or started) by pressing KEY[1];

The 10 LEDs (above the slide switches) will then start lighting up from left to right at 0.5 second interval, until all LEDs are ON;

The circuit then waits for a random period of time between 0.25 and 16 seconds before all LEDs turn OFF;

The random delay period is displayed in milliseconds on five 7-segment displays. (The code was then altered to display the reaction time of the user, how long it took for them to press a button once all lights turned off.)

In this project, there are various modules used for different purposes. These include:

An LFSR module which produces a pseudo-random binary sequence (PRBS), which is used to determine the random delay required. The enable signal to the LFSR allows this to cycle through many clock cycles before it is stopped at a random value.
A delay module which is triggered after all 10 LEDs are lid, and then provides a delay of N clock cycles (at 1ms period) before asserting the time_out signal (for 1ms). The delay value N is fed to a binary to BCD converter, which then drives the 7-segment displays.
