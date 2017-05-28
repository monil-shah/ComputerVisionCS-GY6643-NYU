-----------
README
-----------

Description: This project detects the green ball and iteratively uses kalman filter to predict next position. It saves the list of detections and predictions into detections.txt and predictions.txt

Requirements:
- C++
- cmake
- OpenCV

Project Structure:

FinalProjectKalman
|____CmakeLists.txt - cmake file
|____vidfinal.mov - test video 1
|____Sample.mov - test video 2
|____source
	  |____opencv-kalman.cpp - source code
|____Plot
	|_____kal-sample.py - code for plotting results 

To compile the project:
1) In the terminal: $ cmake .
2) In the terminal: $ make
3) In the terminal: $ open kalman-ball-tracker


Constraints:

- Specify the path of the video in opencv-kalman.cpp  
	Line:87 cv::VideoCapture cap(PATH)


