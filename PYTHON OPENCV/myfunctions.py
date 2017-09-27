import cv2
import numpy as np

## returns collections of all functions
class eagle(object) :

    def __init__(self) :
        self.NAME = '<eagle instance>'

    def __init__(self,name) :
        self.NAME = name

    def __str__(self) :
        return self.NAME

    def __dir__(self) :
        return ['NAME','captureVideo(self | self,width,height)','lookKeys()','captureImage(),transform(image),']

    ## OPTIONAL ARGUMENTS : width(int), height(int), save(bool)
    def captureVideo(self,**optional_args) :
        ## check whether width/height params are provided
        try :
            camera = cv2.VideoCapture(0)
        except :
            print "Error loading the camera; Check it or change x for VideoCapture(x)"

        if 'width' in optional_args and 'height' in optional_args :
            camera.set(cv2.cv.CV_CAP_PROP_FRAME_WIDTH,optional_args['width'])
            camera.set(cv2.cv.CV_CAP_PROP_FRAME_HEIGHT,optional_args['height'])
        if 'save' in optional_args :
            fourcc = cv2.cv.CV_FOURCC(*'mp4v')
            out = cv2.VideoWriter('output.mp4', fourcc , 20.0, (optional_args['width'],optional_args['height']))
        photo_index = 1

        while True :

            ret,frame = camera.read()
            cv2.imshow('Camera',frame)
            if 'save' in optional_args :
                out.write(frame)

            k = cv2.waitKey(200)
            if k == 27 :
                break
            elif k == 32 : ## space clicked
                filename = "photo" + str(photo_index) + ".jpg"
                photo_index = photo_index + 1
                cv2.imwrite(str(filename),frame)
                cv2.waitKey(1000)
                print str(filename)," written"

        camera.release()
        cv2.destroyAllWindows()
        cv2.waitKey(1000)
        print "bye"


## morphology methods---------------------------------------------



    ## to check the key code.
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

    def take_mouse_coordinates(event,x,y,flags,param) :

        if event == cv2.EVENT_LBUTTONUP:
            input_image_coordinates.append([x,y])
            print "COORDINATE ",str(len(input_image_coordinates)),": X:",str(x)," Y:",str(y)

            def transform(ImageName) :
                image = cv2.imread(str(ImageName),0)

        cv2.imshow('W',image)
        cv2.setMouseCallback('W',take_mouse_coordinates)
        #output_image_coordinates = [[0,0],[image.shape[0],0],[0,image.shape[1]],[image.shape[0],image.shape[1]]]

        print "opened"
        while (1) :
            k = cv2.waitKey(1)
            if k == 27 :
                break
            if len(input_image_coordinates) == 4 :
                try :
                    print input_image_coordinates
                    pts1 = np.float32(input_image_coordinates)
                    pts2 = np.float32([[0,0],[0,image.shape[1]],[image.shape[0],image.shape[1]],[image.shape[0],0]])
                    M = cv2.getPerspectiveTransform(pts1,pts2)
                    dst = cv2.warpPerspective(image,M,image.shape)
                    cv2.imshow('Transformed Image',dst)
                    k = cv2.waitKey(0)
                    print "before error"
                    #print dst
                except Exception as inst :
                    print "Error : ",str(inst)
                    break
                break
        cv2.destroyAllWindows()
        cv2.waitKey(1000)
        print "bye"

    def laplace_derivative(image,kernel):
        return cv2.Laplacian(img,cv2.CV_64F) ## derivative matrix
    def sobelx(image,kernel) :
        return cv2.Sobel(img,cv2.CV_64F,1,0,ksize=5)
    def sobely(image,kernel) :
        return cv2.Sobel(img,cv2.CV_64F,0,1,ksize=5)


if __name__ == "__main__" :
    main()
