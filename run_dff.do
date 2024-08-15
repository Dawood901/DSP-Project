vlib work
vlog DSP_tb.v DSP48A1.v reg_mux.v
vsim -voptargs=+acc work.DSP_tb
add wave *
run -all
#quit -sim