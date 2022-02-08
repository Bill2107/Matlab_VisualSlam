%% SetupSequence.m

% In this script we will
% 1. Load the Path for the camera Data
% 2. Load in the Camera Parameters (intrinsic matrix)
% 3. Initialise the robot frame
% 4. Clear Unecassary Variables

warning('off', 'MATLAB:scatteredInterpolant:DupPtsAvValuesWarnId');
clear
clc
clf

k=1;
sequenceNumber = 0;
ScalingValue = 1;
LengthScaling = 100;

%% 1. Load Path
PATH = '../../../../data_odometry_gray/dataset/sequences';
v = VideoWriter(sprintf("../../Results/STEREO_SLAM_%d.mp4", sequenceNumber), 'MPEG-4');
open(v)

%% 2. Load Camera Parameters
SEQ_PATH = sprintf('%s/%02.2d',PATH, sequenceNumber);
P = importdata(sprintf('%s/calib.txt', SEQ_PATH));
TimeStamps = importdata(sprintf('%s/times.txt', SEQ_PATH));
kBig = length(TimeStamps);

%These are projection matricies for the various matrix
%
P0 = [P.data(1,1:4); P.data(1,5:8); P.data(1,9:12)];
P1 = [P.data(2,1:4); P.data(1,5:8); P.data(2,9:12)];
P2 = [P.data(3,1:4); P.data(1,5:8); P.data(3,9:12)];
P3 = [P.data(4,1:4); P.data(1,5:8); P.data(4,9:12)];
ProjMats = {P0, P1};
% Note that since the R matrix is initially the identity 
%and T is initially [bx, by, 0], then k is not modified
%under transformation. 
% That is k*[R|t] = P with R = eye(3) -> k = P(1:3,1:3)
K{1} = P0(1:3, 1:3);
K{2} = P1(1:3, 1:3);
cameraParams{1} = cameraParameters('IntrinsicMatrix',K{1}); 
cameraParams{2} = cameraParameters('IntrinsicMatrix',K{2}); 

%% 3. Initialise Robot Frame
Robot{1,1}(:,:) = 0;
Robot{1,2}(1,:) = [0, 0, 0];

%% 4. Clear out unnecassary variables
clear P0 P1 P2 P3 ProjMats P sequenceNumber PATH K