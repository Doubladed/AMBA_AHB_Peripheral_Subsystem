/*
#######################################################################
####                                                               ####
####  The data contained in the file is created for educational    #### 
####  and training purposes only and are not recommended           ####
####  for fabrication                                              ####
####                                                               ####
#######################################################################
####                                                               ####
####  Copyright (C) 2013 Synopsys, Inc.                            ####
####                                                               ####
#######################################################################
####                                                               ####
####  The 32/28nm Generic Library ("Library") is unsupported       ####    
####  Confidential Information of Synopsys, Inc. ("Synopsys")      ####    
####  provided to you as Documentation under the terms of the      ####    
####  End User Software License Agreement between you or your      ####    
####  employer and Synopsys ("License Agreement") and you agree    ####    
####  not to distribute or disclose the Library without the        ####    
####  prior written consent of Synopsys. The Library IS NOT an     ####    
####  item of Licensed Software or Licensed Product under the      ####    
####  License Agreement.  Synopsys and/or its licensors own        ####    
####  and shall retain all right, title and interest in and        ####    
####  to the Library and all modifications thereto, including      ####    
####  all intellectual property rights embodied therein. All       ####    
####  rights in and to any Library modifications you make are      ####    
####  hereby assigned to Synopsys. If you do not agree with        ####    
####  this notice, including the disclaimer below, then you        ####    
####  are not authorized to use the Library.                       ####    
####                                                               ####  
####                                                               ####      
####  THIS LIBRARY IS BEING DISTRIBUTED BY SYNOPSYS SOLELY ON AN   ####
####  "AS IS" BASIS, WITH NO INTELLECUTAL PROPERTY                 ####
####  INDEMNIFICATION AND NO SUPPORT. ANY EXPRESS OR IMPLIED       ####
####  WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED       ####
####  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR   ####
####  PURPOSE ARE HEREBY DISCLAIMED. IN NO EVENT SHALL SYNOPSYS    ####
####  BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,     ####
####  EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT      ####
####  LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;     ####
####  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION)     ####
####  HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN    ####
####  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE    ####
####  OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS      ####
####  DOCUMENTATION, EVEN IF ADVISED OF THE POSSIBILITY OF         ####
####  SUCH DAMAGE.                                                 #### 
####                                                               ####  
#######################################################################

*/

fillOutput1_m7  = fill_pattern( fill_candidates_M7,
                           fill_function = my_func1,
                          output_aref = {output_aref = true}

);


fillOutput1_1_m7 = size (fillOutput1_m7 , 0.2);
fill_candidates_s_m7 = fill_candidates_M7 not fillOutput1_1_m7;


fillOutput2_m7  = fill_pattern( fill_candidates_s_m7,
                           fill_function = my_func2,
                          output_aref = {output_aref = true}

);

fillOutput2_1_m7 = size (fillOutput2_m7 , 0.2);
fill_candidates_s_1_m7 = fill_candidates_s_m7 not fillOutput2_1_m7;

fillOutput3_m7  = fill_pattern( fill_candidates_s_1_m7,
                           fill_function = my_func3,
                          output_aref = {output_aref = true}

);

fillOutput_m7 = fillOutput2_m7 or fillOutput1_m7 or fillOutput3_m7;
////////////////////////////////////////

ME7D = fillOutput_m7 or M7;

ME7D_extent = layer_extent(ME7D);

sf7_global_end = density_statistics_file ("ME7.global.end");

densityEQ_single_ME7D : function(void) returning void

{
   areaL : double = den_polygon_area("layer1");
   areaW : double = den_window_area();
   RATIO : double = areaL / areaW;
   if (RATIO > 0.71)
   den_save_window (error_names = { "RATIO", "area" },
                            values = { RATIO, areaL });
}
