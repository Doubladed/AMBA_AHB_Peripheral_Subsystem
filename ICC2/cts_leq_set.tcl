# References enabled for CTS:

# References already available for CTS:
#set_lib_cell_purpose -include cts {saed32hvt_base_frame_timing/DFFARX1_HVT}
#set_lib_cell_purpose -include cts {saed32lvt_base_frame_timing/DFFARX1_LVT}
#set_lib_cell_purpose -include cts {saed32rvt_base_frame_timing/DFFARX1_RVT}
#set_lib_cell_purpose -include cts {saed32hvt_base_frame_timing/DFFARX2_HVT}
#set_lib_cell_purpose -include cts {saed32lvt_base_frame_timing/DFFARX2_LVT}
#set_lib_cell_purpose -include cts {saed32rvt_base_frame_timing/DFFARX2_RVT}
#set_lib_cell_purpose -include cts {saed32hvt_base_frame_timing/DFFASX1_HVT}
#set_lib_cell_purpose -include cts {saed32lvt_base_frame_timing/DFFASX1_LVT}
#set_lib_cell_purpose -include cts {saed32rvt_base_frame_timing/DFFASX1_RVT}
#set_lib_cell_purpose -include cts {saed32hvt_base_frame_timing/DFFASX2_HVT}
#set_lib_cell_purpose -include cts {saed32lvt_base_frame_timing/DFFASX2_LVT}
#set_lib_cell_purpose -include cts {saed32rvt_base_frame_timing/DFFASX2_RVT}
#set_lib_cell_purpose -include cts {gtech/GTECH_FD2}
#set_lib_cell_purpose -include cts {gtech/GTECH_FD4}


# Disabled references in CTS
# 1. List of references disabled due to dont_touch set on them:

# 2. List of references disabled due to user driven exclude set for CTS purpose:
#    set_lib_cell_purpose -include cts [get_lib_cell saed32hvt_base_frame_timing/AODFFARX1_HVT]
#    set_lib_cell_purpose -include cts [get_lib_cell saed32lvt_base_frame_timing/AODFFARX1_LVT]
#    set_lib_cell_purpose -include cts [get_lib_cell saed32rvt_base_frame_timing/AODFFARX1_RVT]
#    set_lib_cell_purpose -include cts [get_lib_cell saed32hvt_base_frame_timing/AODFFARX2_HVT]
#    set_lib_cell_purpose -include cts [get_lib_cell saed32lvt_base_frame_timing/AODFFARX2_LVT]
#    set_lib_cell_purpose -include cts [get_lib_cell saed32rvt_base_frame_timing/AODFFARX2_RVT]

# 3. List of references disabled due to dont_use set in the libraries:

