# 1120

## cv2 함수~

> 카메라 연결, 동영상 녹화, 저장, 캡처 ,동영상 재생  출력
>
> 이미지 대칭, 확대, 축소, 회전, 배율, 이진화, 반전, 흑백, 흐림, 가장자리, 색상, 채도, 명도, 분리, 색깔 추출, 윤곽선, 외곽 검출



### 노트북 카메라 동작

- cv2.VideoCapture()

```python
import cv2

capture = cv2.VideoCapture(0)
capture.set(cv2.CAP_PROP_FRAME_WIDTH, 640)
capture.set(cv2.CAP_PROP_FRAME_HEOGHT, 480)

while True:
	re, frame = capture.read()
	cv2.imshow('VedeoFrame',frame)
	if cv2.waitKey(1) >0; breadk
	# 종료 조건

capture.release() # 메모리 해제
cv2.destroyAllWindows() # 윈도우 창 닫기
```



### 동영상 녹화

- VideoCapture() , VideoWrite_fourcc()

> - In Fedora: DIVX, XVID, MJPG, X264, WMV1, WMV2. (XVID is more preferable. MJPG results in high size video. X264 gives very small size video)
> - In Windows: DIVX (More to be tested and added)
> - In OSX: MJPG (.mp4), DIVX (.avi), X264 (.mkv).



```python
import datetime
import cv2

capture = cv2.VideoCapture('image/earth.mp4')
fourcc = cv2.VideoWrite_fourcc(*'XVID')
record = False

while True:
    it (capture.get(cv2.CAP_PROP_POS_FRAMES)== capture.get(cv2.CAP_PROP_FRAMES_COUNT)):
        capture.open('image/earth.mp4')
       
    ret, frame = capture.read()
    cv2.imshow('VideoFrame',frame)
    
    now = datetime.datetime.now().strftime("%d_%H-%M-%S")
    key = cv2.waitKey(33)
    
    
    if key = 27:
        break:
    elif key == 26:
        print('캡처')
        cv2.imwrite('C:/Users/i/Downloads/image/'+str(now)+'.png',frame)
    elif key == 25:
        print('녹화시작')
        record = True
        video = cv2.VideoWriter('C:/Users/i/Downloads/image/'+str(now)+'.avi',fourcc,20.0,(frame.shape[1],frame.shape[0]))
    elif key == 3:
        print('녹화중지')
        record = False
        video.release()
    if record == True:
        print('녹화 중')
        video.write(frame)
capture.release()
cv2.destroyAllWindows()
        
        
```



### 동영상 파일 재생

- cv2.VideoCapture('경로')

```python
import cv2

capture = cv2.VideoCapture('Image/earth.mp4')
print(capture.isOpend) # 파일 열림 여부 => True, False

while True:
    if (capture.get(cv2.CAP_PROP_POS_FRAMES) == capture.get(cv2.CAP_PROP_FRAME_COUNT)):
        # 현재 프레임이 마지막 프레임이 될 경우 실행
        capture.open("Image/earth.mp4")
        # 다시 동영상 재생
        
        ret, frame = capture.read()
        cv2.imshow('VideoFrame',frame)
        
        if cv2.waitKey(33) >0 : break
          
capture.release()
cv2.destroyAllWindows()


```



### 사진 출력

- cv2.imread()

```python
import cv2

image = cv2.imread('Image/dog1.jpg',cv2.IMREAD_ANYCOLOR)
print(image.shape)
cv2.imshow('dog',image)
cv2.waitKey(0) # 종료 조건
cv2.destroyAllWindows()
```



### 이미지 대칭

```python
import cv2

src = cv2.imread("Image/dog2.jpg", cv2.IMREAD_COLOR)
dst = cv2.flip(src, 0) # 대칭

cv2.imshow("src", src)
cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()

```



### 이미지 확대 축소

```python
import cv2

src = cv2.imread("Image/dog1.jpg", cv2.IMREAD_COLOR)

height, width, channel = src.shape # 높이 너비 채널의 개수 저장
dst = cv2.pyrUp(src, dstsize=(width*2, height*2), borderType=cv2.BORDER_DEFAULT);#이미지 크기 확대 : pyrUp
dst2 = cv2.pyrDown(src); # 원본 이미지 축소 : pyrDown

cv2.imshow("src", src)
cv2.imshow("dst", dst)
cv2.imshow("dst2", dst2)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 회전

```python
import cv2

src = cv2.imread("Image/dog3.jpg", cv2.IMREAD_COLOR)

height, width, channel = src.shape
matrix = cv2.getRotationMatrix2D((width/2, height/2), 90, 1) # 중심점 x좌표 y좌표 기준 회전 // 90 부분을 지정 각도 // 확대 비율
dst = cv2.warpAffine(src, matrix, (width, height))

cv2.imshow("src", src)
cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()


```



### 이미지 배율

```python
import cv2

src = cv2.imread("Image/dog3.jpg", cv2.IMREAD_COLOR)

dst = cv2.resize(src, dsize=(640, 480), interpolation=cv2.INTER_AREA) # 이미지 픽셀값 변경 영역 보간법으로 이미지 변경
dst2 = cv2.resize(src, dsize=(0, 0), fx=0.3, fy=0.7, interpolation=cv2.INTER_LINEAR)
# 이미지 비율 x는 0.3배 y는 0.7배 비율로 바꾼다. 

cv2.imshow("src", src)
cv2.imshow("dst", dst)
cv2.imshow("dst2", dst2)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 이진화

```python
import cv2

src = cv2.imread("Image/dog1.jpg", cv2.IMREAD_COLOR)

gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)
ret, dst = cv2.threshold(gray, 100, 255, cv2.THRESH_BINARY)

cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 반전 

```python
import cv2

src = cv2.imread("Image/dog3.jpg", cv2.IMREAD_COLOR)

dst = cv2.bitwise_not(src)

cv2.imshow("src", src)
cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 흑백

```python
import cv2

src = cv2.imread("Image/dog3.jpg", cv2.IMREAD_COLOR)

dst = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)

cv2.imshow("src", src)
cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 블러

```python
import cv2

src = cv2.imread("Image/dog2.jpg", cv2.IMREAD_COLOR)

dst = cv2.blur(src, (9, 9), anchor=(-1, -1), borderType=cv2.BORDER_DEFAULT) #( 9.9 )커널의 크기 

cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 가장자리 검출

```python
import cv2

src = cv2.imread("Image/dog1.jpg", cv2.IMREAD_COLOR)
gray = cv2.cvtColor(src, cv2.COLOR_BGR2GRAY)

canny = cv2.Canny(src, 100, 255) 
# 100 (임계값) 이하에 해당되는 가장자리는 제외하겠다.
# 255 이상에 포함된 가장자리는 가장자리로 포함 
sobel = cv2.Sobel(gray, cv2.CV_8U, 1, 0, 3) # CV 정밀도 
laplacian = cv2.Laplacian(gray, cv2.CV_8U, ksize=3)# 많이 쓰이진 않음

cv2.imshow("canny", canny)
cv2.imshow("sobel", sobel)
cv2.imshow("laplacian", laplacian)
cv2.waitKey(0)
cv2.destroyAllWindows()
```



### 이미지 색상, 채도, 명도

```python
import cv2

src = cv2.imread("Image/fruits.jpg", cv2.IMREAD_COLOR)
hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)
h, s, v = cv2.split(hsv)

cv2.imshow("h", h) # 색상 : 색의 질
cv2.imshow("s", s) # 채도 : 색의 선명도
cv2.imshow("v", v) # 명도 : 밝기 
cv2.waitKey(0)
cv2.destroyAllWindows()
# 원하는 특정 색상만 뽑을 수 있다.
```



```python
# 빨간색

import cv2

src = cv2.imread("Image/fruits.jpg", cv2.IMREAD_COLOR)
hsv = cv2.cvtColor(src, cv2.COLOR_BGR2HSV)
h, s, v = cv2.split(hsv)

lower_red = cv2.inRange(hsv, (0, 100, 100), (5, 255, 255)) # 최소 최대값 범위 지정
upper_red = cv2.inRange(hsv, (170, 100, 100), (180, 255, 255)) 
added_red = cv2.addWeighted(lower_red, 1.0, upper_red, 1.0, 0.0) 

red = cv2.bitwise_and(hsv, hsv, mask = added_red)
red = cv2.cvtColor(red, cv2.COLOR_HSV2BGR)

cv2.imshow("red", red)
cv2.waitKey(0)
cv2.destroyAllWindows()

```



```python
h = cv2.inRange(h, 8, 20) # 단일 채널 이미지, 최소값 최대값 =>범위 설정 ( 8 ~ 20 ) 주황색
orange = cv2.bitwise_and(hsv, hsv, mask = h) # hsv and hsv // mask = h 추출하고 싶은 부분 
orange = cv2.cvtColor(orange, cv2.COLOR_HSV2BGR) # 색상 변환 HSV -> BGR

cv2.imshow("orange", orange)
cv2.waitKey(0)
cv2.destroyAllWindows()

```



### 채널 분리

```python
import cv2

src = cv2.imread("Image/ham.jpg", cv2.IMREAD_COLOR)
b, g, r = cv2.split(src) # cv2 -> bgr 기본
inversebgr = cv2.merge((r, g, b))

cv2.imshow("b", b)
cv2.imshow("g", g)
cv2.imshow("r", r)
cv2.imshow("inverse", inversebgr)
cv2.waitKey(0)
cv2.destroyAllWindows()


```



```python
print(src[:,:,0]) # b채널
print(src[:,:,1]) # g채널
print(src[:,:,2]) # r채널
b = src[:,:,0]
g= src[:,:,1]
r = src[:,:,2]
```



```python
h,w,c = src.shape
import numpy as np
zeros = np.zeros((h,w,1),dtype=np.uint8)
bgz = cv2.merge((b,g,zeros)) # red 채널 영역이 모두 흑백 이미지 변경
```



### 이미지 도형, 글자 생성

```python
import numpy as np
import cv2

src = np.zeros((768, 1366, 3), dtype = np.uint8)

cv2.line(src, (100, 100), (1200, 100), (0, 0, 255), 3, cv2.LINE_AA)
cv2.circle(src, (300, 300), 50, (0, 255, 0), cv2.FILLED, cv2.LINE_4)
cv2.rectangle(src, (500, 200), (1000, 400), (255, 0, 0), 5, cv2.LINE_8)
cv2.ellipse(src, (1200, 300), (100, 50), 0, 90, 180, (255, 255, 0), 2)

pts1 = np.array([[100, 500], [300, 500], [200, 600]])
pts2 = np.array([[600, 500], [800, 500], [700, 600]])
cv2.polylines(src, [pts1], True, (0, 255, 255), 2)
cv2.fillPoly(src, [pts2], (255, 0, 255), cv2.LINE_AA)

cv2.putText(src, "TEST", (900, 600), cv2.FONT_HERSHEY_COMPLEX, 2, (255, 255, 255), 3)

cv2.imshow("src", src)
cv2.waitKey(0)
cv2.destroyAllWindows()

```



### 이미지 윤곽선

```python
import cv2

src = cv2.imread("Image/contours.png", cv2.IMREAD_COLOR)

gray = cv2.cvtColor(src, cv2.COLOR_RGB2GRAY)
ret, binary = cv2.threshold(gray, 127, 255, cv2.THRESH_BINARY)
binary = cv2.bitwise_not(binary)

contours, hierarchy = cv2.findContours(binary, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)
# 검색 알고리즘 cv2.RETR_CCOMP // 근사화 방법 cv2.CHAIN_APPROX_NONE

for i in range(len(contours)):
    cv2.drawContours(src, [contours[i]], 0, (0, 0, 255), 2)
    cv2.putText(src, str(i), tuple(contours[i][0][0]), cv2.FONT_HERSHEY_COMPLEX, 0.8, (0, 255, 0), 1)
    print(i, hierarchy[0][i])
    cv2.imshow("src", src)
    cv2.waitKey(0)

cv2.destroyAllWindows()

```



```
import cv2

src = cv2.imread("cup.jpg")
dst = src.copy()

gray = cv2.cvtColor(src, cv2.COLOR_RGB2GRAY)

corners = cv2.goodFeaturesToTrack(gray, 100, 0.01, 5, blockSize=3, useHarrisDetector=True, k=0.03)
# 코너 품질 ( 0 ~ 1, 일반적으로는 0.01 ~ 0.1  ) // 100과 0.01 만 잘 바꾸면된다.
for i in corners:
    cv2.circle(dst, tuple(i[0]), 3, (0, 0, 255), 2)

cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()

```





### 외곽선 검출



```python
import cv2

src = cv2.imread("convex.png")
dst = src.copy()

gray = cv2.cvtColor(src, cv2.COLOR_RGB2GRAY)
ret, binary = cv2.threshold(gray, 150, 255, cv2.THRESH_BINARY_INV)

contours, hierarchy = cv2.findContours(binary, cv2.RETR_CCOMP, cv2.CHAIN_APPROX_NONE)

for i in contours:
    hull = cv2.convexHull(i, clockwise=True)
    cv2.drawContours(dst, [hull], 0, (0, 0, 255), 2)

cv2.imshow("dst", dst)
cv2.waitKey(0)
cv2.destroyAllWindows()

```

