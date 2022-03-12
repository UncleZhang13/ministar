onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -expand -group runber /tb_runber/runber_test/clk
add wave -noupdate -expand -group runber /tb_runber/runber_test/sys_clk
add wave -noupdate -expand -group runber -radix hexadecimal /tb_runber/runber_test/key
add wave -noupdate -expand -group runber -radix hexadecimal /tb_runber/runber_test/sw
add wave -noupdate -expand -group runber -color Magenta -radix hexadecimal /tb_runber/runber_test/led
add wave -noupdate -expand -group runber -color Gold /tb_runber/runber_test/ld1
add wave -noupdate -expand -group runber -color Red /tb_runber/runber_test/ld2
add wave -noupdate -expand -group runber /tb_runber/runber_test/ld3
add wave -noupdate -expand -group runber /tb_runber/runber_test/ld4
add wave -noupdate -expand -group runber -color Blue /tb_runber/runber_test/dig
add wave -noupdate -expand -group runber /tb_runber/runber_test/smg
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/clk
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/key
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/enter
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/init
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/sw
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/smg
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/dig
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/enter_trig
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/init_trig
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/ctrl
add wave -noupdate -group lock /tb_runber/runber_test/lock_top/com_result
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/clk
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/key
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/enter
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/init
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/enter_trig
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/init_trig
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/ctrl
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/btn_deb
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/key1_push_cnt
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/key2_push_cnt
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/key3_push_cnt
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/key4_push_cnt
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/btn1_deb_1d
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/btn2_deb_1d
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/btn3_deb_1d
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/btn4_deb_1d
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/enter_deb_1d
add wave -noupdate -group lock_key /tb_runber/runber_test/lock_top/key_ctl/init_deb_1d
add wave -noupdate -group lock_com /tb_runber/runber_test/lock_top/compare/clk
add wave -noupdate -group lock_com /tb_runber/runber_test/lock_top/compare/sw
add wave -noupdate -group lock_com /tb_runber/runber_test/lock_top/compare/ctrl
add wave -noupdate -group lock_com /tb_runber/runber_test/lock_top/compare/enter_trig
add wave -noupdate -group lock_com /tb_runber/runber_test/lock_top/compare/com_result
add wave -noupdate -group lock_com /tb_runber/runber_test/lock_top/compare/ctrl_1d
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/clk
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/enter_trig
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/init_trig
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/com_result
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/ctrl
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/smg
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/dig
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/seq_status
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/key0_cnt
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/key1_cnt
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/key2_cnt
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/key3_cnt
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/clk_100khz
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/sel
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/dig0
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/smg0
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/dig1
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/smg1
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/dig2
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/smg2
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/dig3
add wave -noupdate -group lock_seq /tb_runber/runber_test/lock_top/seq_display/smg3
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/clk
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/ld1
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/ld2
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/ld3
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/ld4
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/led
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/led_light_cnt
add wave -noupdate -expand -group water_led /tb_runber/runber_test/water_led/led_status
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {87782000 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 362
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {0 ps} {1050 us}
