
# PlanAhead Launch Script for Post-Synthesis pin planning, created by Project Navigator

create_project -name Ultra -dir "C:/Projects_SistDigAv/Ultra/planAhead_run_1" -part xc6slx16csg324-3
set_property design_mode GateLvl [get_property srcset [current_run -impl]]
set_property edif_top_file "C:/Projects_SistDigAv/Ultra/Top.ngc" [ get_property srcset [ current_run ] ]
add_files -norecurse { {C:/Projects_SistDigAv/Ultra} }
set_param project.pinAheadLayout  yes
set_property target_constrs_file "Top.ucf" [current_fileset -constrset]
add_files [list {Top.ucf}] -fileset [get_property constrset [current_run]]
link_design
