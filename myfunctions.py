import cv2
import numpy as np

## returns collections of all functions
class eagle() :

    def __init__(self) :
        self.NAME = '<eagle instance>'

    def __init__(self,name) :
        self.NAME = name

    def __str__(self) :
        return self.NAME

    def __dir__(self) :
        return ['NAME','captureVideo()','lookKeys()','captureImage()']

    def captureVideo(self) :
        camera = cv2.VideoCapture(1)

        while True :
            ret,frame = camera.read()
            cv2.imshow('Camera',frame)
            k = cv2.waitKey(1)
            if k == 27 :
                break
        camera.release()
        cv2.destroyAllWindows()
        cv2.waitKey(1000)
        print "bye"


    def captureImage(self,filename): ## filename = file to save

        camera = cv2.VideoCapture(1)
        ret,frame = camera.read()
        cv2.imshow('Camera Image',frame)
        k = cv2.waitKey(0)
        if k == 27 :
            camera.release()
            cv2.destroyAllWindows()
            cv2.waitKey(1000)

        elif k == 119 : # 'w'
            if str(filename) != '' or filename is not null :
                format_list = ['.jpg','.png']
                if str(filename[-4:]) in format_list :
                    cv2.imwrite(str(filename),frame)
                    print "Image written to ",str(filename)
                else :
                    print "Incorrect fileformat"
            else :
                print "No filename provided"
        camera.release()
        cv2.destroyAllWindows()
        cv2.waitKey(1000)
        print "bye"
        return 1

    def lookKeys(self) :
        window = cv2.namedWindow('LookKeysWindow')
        while True :
            k = cv2.waitKey(0)
            if k ==27 :
                break
            else :
                print "Key : ",str(k)
        cv2.destroyAllWindows()
        cv2.waitKey(1000)
        print "bye"
        return 1
