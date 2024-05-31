import cv2
import numpy as np
import requests
from matplotlib import pyplot as plt

# 이미지 URL
# url = "https://marketplace.canva.com/EAD1VGcQX1w/1/0/1236w/canva-%EC%A7%99%EC%9D%80-%EA%B0%88%EC%83%89-%EC%BB%A4%ED%94%BC-%EC%B9%B4%ED%8E%98-%EB%A9%94%EB%89%B4-5Edm1LHJ4-s.jpg"
url = "https://marketplace.canva.com/EAFre3dKvSk/1/0/1131w/canva-%EB%B0%9D%EC%9D%80%ED%9A%8C%EC%83%89-%EC%A0%84%ED%86%B5-%EB%AC%B8%EC%96%91-%EA%B0%9C%EB%B3%84-%EC%82%AC%EC%A7%84%EC%9D%B4-%EC%9E%88%EB%8A%94-%ED%95%9C%EC%8B%9D-%EB%A9%94%EB%89%B4%ED%8C%90-xGW68vFZQNw.jpg"


# 이미지 다운로드
response = requests.get(url)
image_array = np.asarray(bytearray(response.content), dtype=np.uint8)
image = cv2.imdecode(image_array, cv2.IMREAD_COLOR)
image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)  # OpenCV는 BGR 형식을 사용하므로 RGB로 변환합니다.



height, width, _ = image.shape

# 바운딩 박스 좌표 (비율로 주어진 좌표를 픽셀 단위로 변환)
boxes = [
      [(0.275, 0.318), (0.368, 0.345)],
    [(0.574, 0.318), (0.648, 0.345)],
    [(0.827, 0.318), (0.881, 0.345)],
    [(0.119, 0.557), (0.209, 0.581)],
    [(0.442, 0.557), (0.528, 0.581)],
    [(0.750, 0.557), (0.868, 0.581)],
    [(0.118, 0.799), (0.228, 0.822)],
    [(0.434, 0.799), (0.513, 0.822)],
    [(0.757, 0.799), (0.849, 0.822)]
  ]




# 박스 색상과 두께 설정
color = (255, 0, 0)  # 박스 색상 (RGB): 빨간색
thickness = 2  # 박스 두께

# 바운딩 박스 그리기
image_with_boxes = image.copy()
for box in boxes:
    x_min, y_min = box[0]
    x_max, y_max = box[1]
    start_point = (int(x_min * width), int(y_min * height))
    end_point = (int(x_max * width), int(y_max * height))


    image_with_boxes = cv2.rectangle(image_with_boxes, start_point, end_point, color, thickness)





# 이미지 표시
plt.imshow(image_with_boxes)
plt.axis('off')
plt.show()



print(height, width)