# Matlab_VisualSlam

## Introduction

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

## Processing
### Depth Map
Depth maps or more accuratley Disparity maps, give a number for each point it finds in an image, for how far that point moves left or right between the left and right cameras.
Largely speaking this can be achieved through Feature Tracking, however the matlab function `disparitySGM`, achieves this quite well.
To get a depth for all points (not at just some points), this disparity map can be smoothed or 'Interpolated' such that there is an approximate depth for all pixels in a scene.
![alt text](https://github.com/Bill2107/Matlab_VisualSlam/blob/main/Results/Interpolation/Interpolation_1.png?raw=true)
Full interpolation can take a significant about of time (~3.5s for each frame) as such I've implemented an algorithm than Im calling Fast-Interpolation, this is basically just pooling the data set before interpolating and then smoothing at the end, this obviously heavily relys on the image being everywhere continous, which obviously its not. However this does make things alot faster (Fast Interpolation at 20% was ~0.35s each frame a 10X increase in speed!).

notes:
1. It's also worth noting that features very close to the camera (see car on the right) can be very unreliable, as of yet I have not figured out a way to avoid this issue other than ignoring points very close to the edge of the image, or using data sets that dont have this problem.
### Feature Tracking
The basic idea behind feature tracking is that we generate a uniform distribution of points and see how they move in time.
![alt text](https://github.com/Bill2107/Matlab_VisualSlam/blob/main/Planning/FeatureTracking.png?raw=true)
There are 2 different scripts that Ive used to implement this, feature matching simply uses the matlab feature matching algorithm between 2 images to compute the visual flow, and the other uses the point tracker, the second seems to yield superior results in that more valid points are detected. I'm not totally sure what they do to make it better.
One thing I would like to implement here is something similar to the disparity map, in that I pool the image to get a smoother visual flow map between T and T-1.
Things to keep in mind:
1. For bigger jumps in time youll be able to measure rotations and movements easier (which can reduce overall noise), but this can make tracking points hard especially as the matching radius R increases
2. There are a number of detectors other than ORB available such as FAST, SIFT, SURF etc. luckily matlab makes switching between these detectors pretty simple.
 
### Camera Transform
The Camera transform section is simple, at this point we have 2 ordered lists of points in R3. The algorithm simply optimises for variables `ω` and `dZ`, to minimise the difference between the set of points at T and the set of points at T-1 with a rotation and translation operation applied to them. Since the vehicle is always moving at a standard pace, its pretty simple to start the optimation off close to its zero, and equally the operations in the optimisation are quite simple, so solving for the camera transform never takes much more than 0.1s.

## Results
Below are some of the results for the Stereo Slam algorithm, clearly its pretty ok at determining forwards and backwards movements of the car, but it struggles with getting the angles of turns exact, I feel like it would be really quite difficult to overcome this by just detecting more points or something along those lines. Really the only way I can think of to overcome this is writing a loop closure script for this project, or fusing the angular estimate with data from an IMU or a magnetometer.

The Algorithm results are in red and the ground truth is in green.
![alt text](https://github.com/Bill2107/Matlab_VisualSlam/blob/main/Results/Pictures/Seq5_Results.png)

## Other Notes
### Functions vs Scripts
Its basically my opinion that scripts > functions on account of not needing to pass the entirety of a workspace through to a function as parameters. This becomes especially annoying when you are trying to use gpu arrays since your effectively doubling the amount of (very limited) memory being used up, as such I use scripts in this project because they arent annoying.
### Acknowledgements 
I used the [KITTI Odometry Dataset](http://www.cvlibs.net/datasets/kitti/eval_odometry.php) to generate my results,

@INPROCEEDINGS{Geiger2012CVPR,

  author = {Andreas Geiger and Philip Lenz and Raquel Urtasun},
  
  title = {Are we ready for Autonomous Driving? The KITTI Vision Benchmark Suite},
  
  booktitle = {Conference on Computer Vision and Pattern Recognition (CVPR)},
  
  year = {2012}
  
}

 
