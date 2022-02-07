# Matlab_VisualSlam

##Introduction

The purpose of this project is to implement a simple Mapping and Localisation algorithm for the KITTI Dataset using primarily matlab functions, in order to gain an understanding of the necassary steps to develop a functional SLAM algorithm.

## Algorithm
The Proposed algorithm for this project is shown below.
![alt text](https://github.com/Bill2107/Matlab_VisualSlam/blob/main/Planning/Algo.png?raw=true)
The algorithm is split between 5 main stages,
1. **Data Collection**: we just get all the data from the data set or the cameras and bring them into the workspace (the Left and Right images for T and T-1).
2. **Processing**: We transform the Camera data into a depth map for T and T-1, and we track the features for the main camera (the Left Camera) between T and T-1.
3. **Point Cloud Generation**: by mapping the features from the feature tracking onto their respective depth maps we can determine a 3d position for each feature, giving a point cloud at T and T-1.
4. **Camera Transform:** We can determine what rotation and translation of the camera is required such that the difference between the points in Point cloud 1 and Point cloud 2 are minimised (recalling that each point in the 2 clouds are matched and so determining the difference between 2 points is simple)
5. **Robot Update:** Finally we can update the position of the robot using this camera transform
