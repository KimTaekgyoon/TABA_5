'''
    GPT-Vision API와 다른 서버간 연결을 위한 Flask 서버입니다.

    주요 기능으로는 다음과 같습니다.
        0. 메뉴판 이미지 ULR을 받아 OCR 결과를 반환합니다.
        1. 음식 이름을 받아 음식에 대한 설명과 재료를 반환합니다.

    GPT API 요청 관련 endpoint는 인증키를 요구합니다.

    json 형식은 각 endpoint의 설명을 참고하세요.
'''




import json
from flask import Flask, request, jsonify
import requests
from PIL import Image
from io import BytesIO
import re
import os
import openai
import base64


this_dir = "C:\\Users\\jeong\\Desktop\\개발\\Python\\Python_Project\\TABA_WIT"


# GPT_API
OPENAI_API_KEY = ""
client = openai.OpenAI(api_key=OPENAI_API_KEY)
model = "gpt-4o"
url = "image url"


# 바운딩 박스가 아니라 인식한 텍스트의 정확한 중앙 좌표
# adjust them correctly.
# adjust all of them to be as accurate as possible.
# accurately contain the size of the detected food names.
# adjust all of them until the conditions are met.
# query_OCR = ("Please perform OCR on image. "
#              "Extract names of the foods along with their extract bounding box coordinates that match the text through OCR. "
#              "Condition 1: All coordinates should be very accurate, detailed and each coordinate must contains all text of the matching food name detected in the image. "
#              "Condition 2: The coordinates should be normalized in 0-1 space and provided in the format (x_min, y_min, x_max, y_max). "
#              "Make sure the coordinates are accurate before returning them. "
#              "If not, modify them to be highly accurate. "
#              "Only return this format, nothing else. ")
# query_OCR = ("Please perform OCR on image which is about menu. "
#              "Extract specific food names in a menu image along with their bounding boxs coordinates that match the text through OCR. "
#              "The coordinates for the bounding boxes should be provided in normalized values in 0-1 space (relative to the image size) and very accurate. "
#              "The coordinate formate is (x_min, y_min, x_max, y_max). "
#              "Make sure the coordinates are accurate before returning them. "
#              "If not, modify them to be highly accurate. "
#              "Only return this format, nothing else. ")
query_OCR = ("Please perform OCR on image which is about menu. "
             "Extract specific food names in a menu image along with their bounding boxs coordinates that match the text through OCR. "
             "The coordinates for the bounding boxes should be provided in normalized values in 0-1 space (relative to the image size) and very accurate. "
             "The coordinate formate is (x_min, y_min, x_max, y_max). "
             "Only return this format, nothing else. ")

format_OCR = '''Format: {"food": ["food_1", "food_2"], "position": [[(x_min, y_min), (x_max, y_max)]]}'''
messages_OCR = [
    { "role": "user",
      "content": [
        {"type": "text", "text": query_OCR + format_OCR},
        { "type": "image_url",
          "image_url": {
              "url": ""
          },
        },
      ],
    }
  ]


format_CHAT = "Format: {'Description': [Brief description of the food], 'Ingredient': [Brief description of the main ingredients]}"
messages_CHAT = [{"role": "user", "content": ""}]




# Flask server
connector_server = Flask(__name__)
# connector_server.secret_key = "mySecretKey1234"
valid_tokens = {"appServer": "myToken1234"}




# content_type
# content_type = ["image/jpeg", "image/png", "image/gif", "image/webp", "image/svg+xml", "image/bmp", "image/tiff", "image/x-icon"]




# 인증 데코레이터는 여러개 사용할 경우 충돌, 따라서 각 라우터 별 구현
def isValid(token) :
    return token in valid_tokens.values()


# def is_valid_url(url):
#     # URL 형식을 정의한 정규 표현식
#     url_pattern = re.compile(
#         r'^(?:http|https)://'  # 프로토콜(http:// 또는 https://)
#         r'(?:[A-Z0-9-]+\.)+[A-Z]{2,6}'  # 도메인 이름
#         r'(?::\d+)?'  # 포트번호 (:포트번호)
#         r'(?:/?|[/?]\S+)$', re.IGNORECASE)  # 경로 및 쿼리 문자열
#
#     return bool(re.match(url_pattern, url))


# errorHandling
@connector_server.errorhandler(400)
def bad_request(error) :
    return jsonify({"error": str(error)}), 400

@connector_server.errorhandler(401)
def unauthorized(error) :
    return jsonify({"error": str(error)}), 401

@connector_server.errorhandler(404)
def not_found(error) :
    return jsonify({"error": "Not Found"}), 404

@connector_server.errorhandler(405)
def method_not_allowed(error) :
    return jsonify({"error": "Method Not Allowed"}), 405

@connector_server.errorhandler(500)
def internal_server_error(error) :
    return jsonify({"error": "Internal Server Error"}), 500




@connector_server.route("/", methods=["GET"])
def home() :
    message = "Hello! I'm GPT_API_Connector. How can i help you?"
    return jsonify({"response": message})


@connector_server.route("/user/<name>", methods=["GET"])
def user(name) :
    if not isValid(request.headers.get("Authorization")) :
        return unauthorized("Unauthorized")

    return jsonify({"response": f"Hello, {name}!"})


@connector_server.route("/upload", methods=["POST"])
def upload() :
    if not isValid(request.headers.get("Authorization")) :
        return unauthorized("Unauthorized")

    if "file" not in request.files :
        return bad_request("No file part")
    file = request.files["file"]
    if file.filename == "" :
        return bad_request("No selected file")
    if file :
        file_path = os.path.join(this_dir, "copy_" + file.filename)
        file.save(file_path)
    return jsonify({"response": "success!"})
        


@connector_server.route("/API_GPT_OCR", methods=["POST"])
def API_GPT_OCR() :
    '''
    GPT-Vision에게 OCR을 요청하는 API입니다.
    메뉴판 사진의 url을 입력받고, 인식한 음식 이름을 return합니다.

    인증키의 형식은 다음과 같습니다.
        Format: {"Authorization": "your secret key"}

    query 형식은 다음과 같습니다.
        Format: {"query": "image url"}

    return 형식은 다음과 같습니다.
        - status code 200
        Format: {"response": {"food": ["food_1", "food_2"],
                              "position": [[(x_min, y_min), (x_max, y_max)], [(x_min, y_min), (x_max, y_max)]]
                              }
                }, 200
        - error
        Format: {"error": "error message"}, error code
    '''


    # 인증
    if not isValid(request.headers.get("Authorization")) :
        return unauthorized("Unauthorized")

    # 유요한 url 판단
    # url = request.get_json()["query"] # url
    # if not is_valid_url(url) :
    #     return bad_request("This is not URL")
    # try :
    #     response = requests.head(url) # 본문 내용이 아닌 header 정보만 받아옴
    #     if response.status_code != 200 :
    #         return bad_request("This URL is not valid")
    #     if response.headers.get("Content-Type") not in content_type :
    #         return bad_request("This is not a image")
    #     # 유효한 이미지 판단
    #     # 이미지를 읽기
    #     # response = requests.get(url)
    #     # image_data = BytesIO(response.content).read()
    # except Exception as e :
    #     return bad_request("This image is not valid")



    response = request.get_json()
    url = response["query"]
    try :
        img = requests.get(url)
        img.raise_for_status()

        image_data = img.content
        encoded_image = base64.b64encode(image_data).decode('utf-8')
    except Exception as e :
        return bad_request("URL is not valid")


    # GPT API 요청
    try :
        messages_OCR[0]["content"][1]["image_url"]["url"] = f"data:image/jpg;base64,{encoded_image}"
        response = client.chat.completions.create(model=model, messages=messages_OCR)
        data = response.choices[0].message.content
        return jsonify({"response": data})
    except requests.exceptions.RequestException as e :
        error_message = str(e)
        try : # json 응답이 가능할 경우
            error_content = e.response.json()
        except ValueError : # json 응답이 아닌경우
            error_content = e.response.text
        return jsonify({"error": error_message, "details": error_content}), e.response.status_code if e.response else 500




    # return jsonify({"response": "Image transfer complete!"})


@connector_server.route("/API_GPT_CHAT", methods=["POST"])
def API_GPT_CHAT() :
    '''
        GPT-Chat에게 한식 설명을 요청하는 API입니다.
        한식 이름을 입력받고, 그에 대한 설명을 return합니다.

        인증키의 형식은 다음과 같습니다.
            Format: {"Authorization": "your secret key"}

        query 형식은 다음과 같습니다.
            Format: {"query": "food name"}

        return 형식은 다음과 같습니다.
            - status code 200
            Format: {"response": {"Description": [Brief description of the food],
                                  "Ingredient": [Brief description of the main ingredients]}
                    }, 200
            - error
            Format: {"error": "error message"}, error code
        '''


    # 인증
    if not isValid(request.headers.get("Authorization")) :
        return unauthorized("Unauthorized")

    # GPT API 요청
    try :
        response = request.get_json()["query"] # input_string
        query_CHAT = f"Please describe the dish {response} in dictionary format. "
        messages_CHAT[0]["content"] = query_CHAT + format_CHAT
        response = client.chat.completions.create(model=model, messages= messages_CHAT)
        data = response.choices[0].message.content
        return jsonify({"response": data})
    except requests.exceptions.RequestException as e :
        error_message = str(e)
        try:
            error_content = e.response.json()
        except ValueError :
            error_content = e.response.text
        return jsonify({"error": error_message, "details": error_content}), e.response.status_code if e.response else 500


    # response = request.get_json()
    # return jsonify({"response": str(response.text)})


@connector_server.route("/status", methods=["GET"])
def status() :
    return jsonify({"response": "Server is running"})


if __name__ == "__main__" :
    connector_server.run(debug=True, host="0.0.0.0", port=9999)







