webtalk_init -webtalk_dir /home/xarez/Documents/CR/tutorial/tutorial.sim/sim_1/behav/xsim/xsim.dir/tutorial_tb_behav/webtalk/
webtalk_register_client -client project
webtalk_add_data -client project -key date_generated -value "Thu Feb 22 10:23:15 2018" -context "software_version_and_target_device"
webtalk_add_data -client project -key product_version -value "XSIM v2017.4 (64-bit)" -context "software_version_and_target_device"
webtalk_add_data -client project -key build_version -value "2086221" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_platform -value "LIN64" -context "software_version_and_target_device"
webtalk_add_data -client project -key registration_id -value "174914471_178259212_210646180_906" -context "software_version_and_target_device"
webtalk_add_data -client project -key tool_flow -value "xsim_vivado" -context "software_version_and_target_device"
webtalk_add_data -client project -key beta -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key route_design -value "FALSE" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_family -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_device -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_package -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key target_speed -value "not_applicable" -context "software_version_and_target_device"
webtalk_add_data -client project -key random_id -value "b923fcd4-0dc3-440c-81cc-188c5a0f64a2" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_id -value "cc507f4a34dc492f9f2ff098daad374d" -context "software_version_and_target_device"
webtalk_add_data -client project -key project_iteration -value "3" -context "software_version_and_target_device"
webtalk_add_data -client project -key os_name -value "elementary" -context "user_environment"
webtalk_add_data -client project -key os_release -value "elementary OS 0.4.1 Loki" -context "user_environment"
webtalk_add_data -client project -key cpu_name -value "Intel(R) Core(TM) i7-6500U CPU @ 2.50GHz" -context "user_environment"
webtalk_add_data -client project -key cpu_speed -value "2600.000 MHz" -context "user_environment"
webtalk_add_data -client project -key total_processors -value "1" -context "user_environment"
webtalk_add_data -client project -key system_ram -value "8.000 GB" -context "user_environment"
webtalk_register_client -client xsim
webtalk_add_data -client xsim -key Command -value "xsim" -context "xsim\\command_line_options"
webtalk_add_data -client xsim -key trace_waveform -value "true" -context "xsim\\usage"
webtalk_add_data -client xsim -key runtime -value "1500 ns" -context "xsim\\usage"
webtalk_add_data -client xsim -key iteration -value "2" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Time -value "0.01_sec" -context "xsim\\usage"
webtalk_add_data -client xsim -key Simulation_Memory -value "136936_KB" -context "xsim\\usage"
webtalk_transmit -clientid 1259665310 -regid "174914471_178259212_210646180_906" -xml /home/xarez/Documents/CR/tutorial/tutorial.sim/sim_1/behav/xsim/xsim.dir/tutorial_tb_behav/webtalk/usage_statistics_ext_xsim.xml -html /home/xarez/Documents/CR/tutorial/tutorial.sim/sim_1/behav/xsim/xsim.dir/tutorial_tb_behav/webtalk/usage_statistics_ext_xsim.html -wdm /home/xarez/Documents/CR/tutorial/tutorial.sim/sim_1/behav/xsim/xsim.dir/tutorial_tb_behav/webtalk/usage_statistics_ext_xsim.wdm -intro "<H3>XSIM Usage Report</H3><BR>"
webtalk_terminate