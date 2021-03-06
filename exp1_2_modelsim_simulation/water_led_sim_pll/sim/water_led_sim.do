#不需要新建modelsim工程，直接运行.do文件就可以仿真
quit -sim
#新建work库
vlib work  

#将work库映射到当前工作目录
vmap work work 

#添加源文件并编译
#-novopt            Do not run the "vopt" compiler before simulation
#-incr              Enable incremental compilation
vlog -novopt -incr -work work  "../src/*.v"
vlog -novopt -incr -work work  "../tb/tb_water_led_top.v"
vlog -novopt -incr -work work  "../src/gowin_pll/sys_pll.v"

vlog -novopt -incr -work work  "D:/Gowin/Gowin_V1.9.7.03Beta/IDE/simlib/gw1n/prim_sim.v"

#启动仿真顶层文件
#-L <libname>                     Search library for design units instantiated from Verilog and for VHDL default component binding
#+nowarn<CODE | Number>           Disable specified warning message  (Example: +nowarnTFMPC)                      
#-t [1|10|100]fs|ps|ns|us|ms|sec  Time resolution limit VHDL default: resolution setting from .ini file) 
#                                 (Verilog default: minimum time_precision in the design)
#-novopt                          Force incremental mode (pre-6.0 behavior)
#-gui                             Open the GUI without loading a design
#vsim -L C:/modeltech64_10.1c/gowin/gw1n/prim_sim -gui -novopt work.tb_runber
vsim -gui -novopt work.tb_water_led_top 

#打开wave窗口
view wave

add wave -noupdate -group tb /tb_water_led_top/*
add wave -noupdate -group water_led_top /tb_water_led_top/water_led_top/*
add wave -noupdate -group water_led /tb_water_led_top/water_led_top/water_led/*
#存为任意名字的.do文件，该文件包含了加载哪些信号及其显示格式的命令
#运行后可保存波形文件直接调用
#do wave.do

#设置运行时间 -all
run  1ms




