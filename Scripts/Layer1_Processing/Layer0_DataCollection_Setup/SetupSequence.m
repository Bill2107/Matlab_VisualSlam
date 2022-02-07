%% SetupSequence.m

% In this script we will
% 1. Load the Path for the camera Data
% 2. Load in the Camera Parameters (intrinsic matrix)
% 3. Initialise the robot frame
% 4. setup key parameters {ImageSequenceLength}

warning('off', 'MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId');

%1. Load Path
PATH = '../../../data_odometry_gray/dataset/sequences';