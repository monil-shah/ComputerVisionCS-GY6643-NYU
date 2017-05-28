#!/usr/bin/env python


import cv2
import numpy as np

import time
import math
import optparse

from optical_flow import OpticalFlowCalculator

if __name__=="__main__":

    parser = optparse.OptionParser()

    parser.add_option("-f", "--file",  dest="filename", help="Read from video file", metavar="FILE")
    parser.add_option("-s", "--scaledown", dest="scaledown", help="Fractional image scaling", metavar="SCALEDOWN")
    parser.add_option("-c", "--camera", dest="camera", help="Camera number", metavar="CAMERA")
    parser.add_option("-m", "--movestep", dest="movestep", help="Move step (pixels)", metavar="MOVESTEP")

    (options, _) = parser.parse_args()

    camno = int(options.camera) if options.camera else 0

    cap = cv2.VideoCapture(camno if not options.filename else options.filename)

    width    = int(720)
    height   = int(800)
    #cap.get(cv2.CAP_PROP_FRAME_WIDTH
    scaledown = int(options.scaledown) if options.scaledown else 1

    movestep = int(options.movestep) if options.movestep else 16

    flow = OpticalFlowCalculator(width, height, window_name='Optical Flow', scaledown=scaledown, move_step=movestep) 

    start_sec = time.time()
    count = 0
    while True:

        success, frame = cap.read()

        count += 1
            
        if not success:
            break

        result = flow.processFrame(frame)

        if not result:
            break

    elapsed_sec = time.time() - start_sec

    print('%dx%d image: %d frames in %3.3f sec = %3.3f frames / sec' % 
             (width/scaledown, height/scaledown, count, elapsed_sec, count/elapsed_sec))
