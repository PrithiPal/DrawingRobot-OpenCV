#SAMPLE THRESHOLDING CODE

import cv2

camera = cv2.VideoCapture(0)
k=1
while(True) : 

    ret,frame = camera.read()
    gray_frame = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)

    #cv2.imshow('frame',frame)
    #cv2.namedWindow('frame',cv2.WINDOW_NORMAL)
    #cv2.resizeWindow('frame',500,800)

    cv2.imshow('gray_Frame',gray_frame)
    cv2.namedWindow('gray_Frame',cv2.WINDOW_NORMAL)
    cv2.resizeWindow('gray_Frame',600,600)

    threshold_arr = [10,30,50,70,100,130,200,250]
    thresh=[0,0,0,0,0,0,0,0]
    #for i in range(8) :
    #    ret,thresh[i] = cv2.threshold(gray_frame,threshold_arr[i],255,cv2.THRESH_BINARY)
    #   cv2.imshow('thresh' + str(i) ,thresh[i])
    #    cv2.namedWindow('thresh' + str(i),cv2.WINDOW_NORMAL)
    #    cv2.resizeWindow('thresh' + str(i),300,300)

        #k = cv2.waitKey(27) # PRESS ESCAPE TO FINISH

    thresh_neighbor_values = [11,11,11,11,11,11,11,11,11,11,11,11,11]
    adapt_thresh = [0,0,0,0,0,0,0,0,0,0,0,0,0]

    for i in range(13) :


        adapt_thresh[i] = cv2.adaptiveThreshold(gray_frame,255,cv2.ADAPTIVE_THRESH_GAUSSIAN_C,cv2.THRESH_BINARY,thresh_neighbor_values[i],2)
        cv2.imshow('gaussian adaptive thresholding' + str(i),adapt_thresh[i])
        cv2.namedWindow('gaussian adaptive thresholding' + str(i),cv2.WINDOW_NORMAL)
        cv2.resizeWindow('gaussian adaptive thresholding' + str(i),600,600)

        k = cv2.waitKey(27) # PRESS ESCAPE TO FINISH

    print k
    if k==27 : # IF ESCAPE THEN EXIT
        break



camera.release()
cv2.destroyAllWindows()
cv2.waitKey(delay=1)
