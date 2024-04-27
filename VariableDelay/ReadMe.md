# VariableDelay
This project consists of several modules:
- RAM Delay Bock: In place of the FIFO to implement the delay block, it uses a 2-port RAM
block (8192 x 9-bit) – one write port (to store the ADC samples) and one read port. Due to the
configuration of the embedded RAM block inside the MAX10 FPGA architecture, I used 9-bit width.
- In order that the 8192 word RAM is sufficient to store enough samples for a 0.8sec delay, sampling rate of 10kHz was used, so that each stored sample corresponds to a sampling period of 100us. Since there is an anti-aliasing filter with a corner frequency of 1kHz, 10kHz sampling rate is acceptable.
- Address Generator - An address counter is used to generate the read address to the RAM. The counter value is incremented on the negative edge of the data_valid signal at a frequency of 10KHz. In this way, the address generator circuit computes the addresses used for the next read and write cycle ahead of the rden and wren pulses. The write address is generated from the read address by adding the value taken from SW[9:0]. Since the address is 13-bits wide, the 10-bit delay value is zero padded in its lower 3 bits. Therefore, the delay between the read and write samples is: SW[9:0] x 8 x 0.1 msec.
- The read and write enable signals are generated from the data_valid signal with the pulse_gen module to produce a read and write pulse at a rate of 10kHz.
- The write data value y[9:1] is 9-bit instead of 10-bit wide. This is because the embedded
memory in the MAX10 FPGA is configurable as 9-bit in data width, but not 10-bit. Therefore
the output data value is truncated to 9-bit before storing in the delay RAM.
- The read data value is of course also 9-bit wide. Therefore the x0.5 can easily be implemented
by sign-extending the 9-bit value to 10-bit: {q[8],q[8:0]}.
- Using a feedback loop, an delayed echo is heard.
- To display the delay value in milliseconds, the value of SW[8:0] is first multiplied by 819 with a
constant multiplier. This gives a 20-bit product, the most significant 10-bits of which is the
delay in milliseconds. This is then converted from binary to BCD and decoded for
display on the 7-segment displays.
