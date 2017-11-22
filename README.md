# Drawing robot image processing algorithm

#### Brief

This projects comes from my participation in the Rembrandt Robotics 2017 \[1\] where the goal was to print a given image onto a paper. This repository contains the Software aspect of the information that is passed to the printer which is heavily based on MATLAB Image processing library.

#### Inventory

This repository contains the image processing logic and GUI written in MATLAB to assist with doing the intermediate steps in the real-time.

### 

### Main Aspects

##### Feature Reduction

This refers to the elimination of the feature so that robot should draw on the major big portions of details. One more reason to overlook the small details is credited to the physical limitation of our drawing pen nib’s thickness that can attain only so much precision. Examples of features to reduce include color variation \(averaging color of neighboring pixels\) , fine details of objects or high light intensity variations within small. But not all times it’s about the reduction. Maybe depending upon the image, some small features are the ones needs to be highlighted so that they stand out in the out image. So we use techniques such as color/intensity segmentation of image into region and deciding what details to keep or not\(sometimes logic, sometimes manually through GUI\)

##### Automation

Right now, our image processing workflow consists of the number of steps that generalizes our approach. However each case of image poses different challenges to overcome. In Computer Vision, large number of these problems are unsolved and would hence require human intervention to provide input for operations.

Some cases where we have to make conscious decision is to select best color scheme for output image, choosing big features to reduce \(because algorithms not perform good in every case \) or emphasizing the depthness, overlapping, temperature, or surface orientation through the using specific color schemes/ Intensity values.

We are still finding ways to reduce human interference with this problem. One plausible approach is to use MATLAB builtin machine learning tactics to for example identify objects and then separate them from background. Other could be writing hard-wired logic\(traditional approach\).

##### Robot Performance

As we the robot would product images after going through image-processing workflow, we would come to know about the areas to work more upon. For instance, should we do black & white/ colored and within black & white how do we emphasise physical relations\(depth etc.\), maybe with dot or hatch technique as real artists do.

### Project Workflow

![](/assets/rembrandt robotics.png)

## GUI

### Selecting a digital Image or Click from Camera

![](/assets/fig1.png)

### Obtain the L\*a\*b Segmentation

This Segmentation works by using k-means clustering where each element implies three different color values L \(Luminosity\), a and b \(White scales\). The L represents absolute colors and other two values helps achieve different variation in that absolute color. For instance Red with some values of a and b would result in Dark-red, Dark-yellow red and so on.

For this particular picture with specific color-representation, lab segmentation is giving us the best results. So I would go with this to our next step of Colo-scheme selection.

![](/assets/lab_segment.png)

### Intensity based Segmentation

![](/assets/intensite_segment.png)

In this type of intensity, we does not relies on the color information from the pixels. Rather our yardstick to categorize the image into region is their brightness or Intensity. In contrast to L\*a\*b based segmentation, we only have one information about a pixels which is its brightness on the scale of 0 \(Pure Black\) to 255\(Pure White\). So depending upon this brightness value of pixels, I can categorize them into different categories defined by ranges. For instance for Region 1 I say, pixels with intensity in range 0 - 150 are first region, 150- .. and .. - 255 are in their respective regions. I am independent to choose number of regions I want to divide in and that way the spectrum of 0-255 would be divided too.

Here the intensity is not doing good as fifth region has majority of the pixels. So L\*a\*b is our best guess

### Manual Segmentation

If none of the above method does good, manually segmenting the image on the basis of common feature. For example here eyes, nose , lips and rest of the region makes sense because color-representation would be different for them.

![](/assets/manual_segment.png)

### Color Averaging

For each acquired region by doing combination of above stated segmentation, now is the time to figure out what color would I choose If I were to represent each region with that only. The simple approach could be obtain the average color for all pixels in one region and repeat the same of all regions \(we have six here\). The last row visually represents the averaged colors

![](/assets/colorscheme_images.png)

### Color distance

After obtaining average colors, now our task is to answer "Which color in my palette \| color-set best represent each of these six averaged colors". The matched color would then be used by the Drawing Printer to put colored dots on the specified region or coordinates. 

The solution is to compare the HSV values of the two color sets mathematically through finding their Euclidean distance calculated by : 

```
square_root ( square(H2 - H2) + square(S2 - S1) + square(V2 - V1))  
```

HSV is another color standard similar to L\*a\*b same in that first symbol for absolute color but different in value conventions. So Here for each given average color, find distance to each of the 49 colors HSV values and select the minimum. This means total number of computation comes around 6\(max-regions\) \* 49 ~ 254 steps.





![](/assets/mathching.png)

Below is not an up to date picture which has slightly better results. As you can see, we have received same color-pen colors for more than on regions. This is not good because If you were to use same colors for different regions, the output picture is not good. The right hand side is the final image. So my next strategy was to compute next nearest \(smallest distance\) color if same color found in the calculations. 

![](/assets/final_image.png)

However, If I am not satisfied with the matching colors calculated using euclidean distance, I can also choose them manually .

![](/assets/manual_color.PNG)![](/assets/manual_color_2.PNG)Which results in the Image on the right hand side. Much better as compared to green color. 



### Matrix

In the end, the GUI sends the matrix that has information about where each regions pixels are sent out to the  robot with the associated color supposed to be built. 



### References

\[1\]. [https://www.sfu.ca/fas/current-student/advising/FAS-competition.html](https://www.sfu.ca/fas/current-student/advising/FAS-competition.html "Rembrandt Robotics Competition 2017")





