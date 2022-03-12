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
vlog -novopt -incr -work work  "../tb/tb_key_led_top.v"


#启动仿真顶层文件
#-L <libname>                     Search library for design units instantiated from Verilog and for VHDL default component binding
#+nowarn<CODE | Number>           Disable specified warning message  (Example: +nowarnTFMPC)                      
#-t [1|10|100]fs|ps|ns|us|ms|sec  Time resolution limit VHDL default: resolution setting from .ini file) 
#                                 (Verilog default: minimum time_precision in the design)
#-novopt                          Force incremental mode (pre-6.0 behavior)
#-gui                             Open the GUI without loading a design
#vsim -L C:/modeltech64_10.1c/gowin/gw1n/prim_sim -gui -novopt work.tb_runber
vsim -gui -novopt work.tb_key_led_top 

#由于仿真器中btn_in一直处于高阻状态，因此无法进行按键的仿真，只能通过force btn_in的值从而进行测试
#如果要进行仿真，源文件中的时间参数必须要修改，否则仿真时可能会出现卡机甚至死机状况
#同时使用Questasim进行仿真，其LED的初始状态都是80，即ctrl = 2时的状态
#将led.v 中的led_light_cnt修改为25'd1349

add wave -position end  sim:/tb_key_led_top/led
add wave -position end  sim:/tb_key_led_top/key_led_top/ctrl

#运行仿真
run 2us
force -freeze sim:/tb_key_led_top/key_led_top/ctrl 2'h1 0
run 32us
force -freeze sim:/tb_key_led_top/key_led_top/ctrl 2'h2 0
run 32us
force -freeze sim:/tb_key_led_top/key_led_top/ctrl 2'h0 0
run 32us

#打开wave窗口
view wave



