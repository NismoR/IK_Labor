% dk_col
%
%  This script file contains the USER DEFINED VARIABLES for the
%	mutools DKIT script file. The user MUST define the 5 variables
%	below.
%
%----------------------------------------------%
% 	REQUIRED USER DEFINED VARIABLES        %
%----------------------------------------------%
% Nominal plant interconnection structure
NOMINAL_DK = sys_ic;

% Number of measurements
NMEAS_DK = 4;

% Number of control inputs
NCONT_DK = 2;

% Block structure for mu calculation
BLK_DK = [1 1;1 1;4 4];

% Frequency response range
OMEGA_DK = logspace(-3,3,100);

AUTOINFO_DK = [1 4 1 4*ones(1,size(BLK_DK,1))];

NAME_DK = 'col';
%-------------------- end of dk_col -------------------------------%