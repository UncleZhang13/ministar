#����Ҫ�½�modelsim���̣�ֱ������.do�ļ��Ϳ��Է���
quit -sim
#�½�work��
vlib work  

#��work��ӳ�䵽��ǰ����Ŀ¼
vmap work work 

#����Դ�ļ�������
#-novopt            Do not run the "vopt" compiler before simulation
#-incr              Enable incremental compilation
vlog -novopt -incr -work work  "../src/*.v"
vlog -novopt -incr -work work  "../tb/tb_water_led_top.v"
vlog -novopt -incr -work work  "../src/gowin_pll/sys_pll.v"

#vlog -novopt -incr -work work  "D:/Gowin/Gowin_V1.9.7.03Beta/IDE/simlib/gw1n/prim_sim.v"
vlog -novopt -incr -work work  "D:/FPGA/Gowin/Gowin_V1.9.8.03/IDE/simlib/gw1n/prim_sim.v"

#�������涥���ļ�
#-L <libname>                     Search library for design units instantiated from Verilog and for VHDL default component binding
#+nowarn<CODE | Number>           Disable specified warning message  (Example: +nowarnTFMPC)                      
#-t [1|10|100]fs|ps|ns|us|ms|sec  Time resolution limit VHDL default: resolution setting from .ini file) 
#                                 (Verilog default: minimum time_precision in the design)
#-novopt                          Force incremental mode (pre-6.0 behavior)
#-gui                             Open the GUI without loading a design
#vsim -L C:/modeltech64_10.1c/gowin/gw1n/prim_sim -gui -novopt work.tb_runber
vsim -gui -novopt work.tb_water_led_top 

#��wave����
view wave

add wave -noupdate -group tb /tb_water_led_top/*
add wave -noupdate -group water_led_top /tb_water_led_top/water_led_top/*
add wave -noupdate -group water_led /tb_water_led_top/water_led_top/water_led/*
#��Ϊ�������ֵ�.do�ļ������ļ������˼�����Щ�źż�����ʾ��ʽ������
#���к�ɱ��沨���ļ�ֱ�ӵ���
#do wave.do

#��������ʱ�� -all
run  1ms



