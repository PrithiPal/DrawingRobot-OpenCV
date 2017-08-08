##SAMPLE ADAPTIVE THRESHOLD CODE

import cv2
import time
import numpy as np

def main() :
    k = 1
    camera = cv2.VideoCapture(0)

    while(True) :
	        #variable declaration
            thresh_val = [9,11,25,49]
            adaptive_frame= [0,0,0,0]
	        # declare frames-----------
            ret,frame = camera.read()

            gray_frame = cv2.cvtColor(frame,cv2.COLOR_BGR2GRAY)
	        # show adaptive thresholded frames-----------

            for i in range(4) :
    	           adaptive_frame[i] = cv2.adaptiveThreshold(gray_frame,255,cv2.ADAPTIVE_THRESH_MEAN_C,cv2.THRESH_BINARY,thresh_val[i],2)
    	            #cv2.bilateralFilter(img,9,75,75)
    	            show_window('adaptive_bilateral'+str(i),cv2.bilateralFilter(adaptive_frame[i],9,75,75),300)
    	            show_window('adaptive'+str(i),adaptive_frame[i],300)
    	            cv2.waitKey(delay=1)
    	        # show frames-----------

        	        show_window('original',frame,700)
        	        show_window('gray',gray_frame,700)
        	        k = cv2.waitKey(27)
        	        if k==27 : # EXIT IF ESCAPE
        	            break
            camera.release()
            cv2.destroyAllWindows()
            cv2.waitKey(delay=1)
            print("done")

	def show_window(frame_name,image,size) :
	    cv2.imshow(frame_name,image)
	    cv2.namedWindow(frame_name,cv2.WINDOW_NORMAL)
	    cv2.resizeWindow(frame_name,size,size)

	if __name__ == "__main__" :
	    main()
