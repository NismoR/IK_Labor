%   FILES FOR ANALYSIS AND DESIGN OF DISTILLATION COLUMN SYSTEM
%
%
% Construction of the open-loop system
%
% olp_col.m	     Creates the model of the uncertain open loop system
%
% Controllers design
%
% hin_col.m      Design of Hinf controller
% lsh_col.m	     Design of Hinf loop shaping controller
% ms_col.m	     Design of mu-controller
%
% Controller order reduction
%
% red_col.m	     Obtains controller of 22nd order
%
% Analysis of the continuous time closed loop system
%
% mu_col.m	     Analysis of robust stability, nominal and robust performance
% frs_col.m	     Frequency responses of the closed loop system
% clp_col.m	     Transient responses of the closed loop system
% pfr_col.m      Perturbed frequency responses of the closed loop system
% prt_col.m      Perturbed transient responses and control actions
%                of the closed loop system
%
% Simulation of the nonlinear closed loop system
%
% init_col.m     Sets the initial parameters for simulation of the
%                continuous time system
% nls_col.mdl    Simulink model of the continuous time system
%
% Auxiliary files
%
% cola_lin.m     Linearizes the nonlinear model
% cola_lv.m      Simulates the nonlinear system with LV configuration
% cola_lv_lin.m  Creates a linear model of the LV-distillation column
% colamod.m      Creates a nonlinear model of the distillation column
% colas.m        Simulink interface to colamod.m 
% mod_col.m	     Creates the uncertainty system model
% unc_col.m      Approximates uncertain time delay by unstructured
%                multiplicative perturbation
% wfit.m         Fits a stable and minimum phase transfer function
%                to a frequency response
% wts_col.m	     Sets the performance weighting  functions
% dk_col.m	     Sets the DK-iterations parameters in the mu-synthesis
% sim_col.m	     Creates the simulation model of the closed loop system
%
% The files cola_lin.m, cola_lv.m, cola_lv_lin.m, colamod.m and colas.m 
% are provided by kind permission of the author, Sigurd Skogestad
