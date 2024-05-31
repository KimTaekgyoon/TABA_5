import sys
sys.path.append("C:\\Users\\jeong\\Desktop\\개발\\Python\\Python_Project\\TABA_WIT\\venv\\Lib\\site-packages")
import requests
import base64



url = "http://192.168.0.14:9999"
header = {"Authorization": "myToken1234"}

error_code = [400, 401, 404, 500]


def printResponse(code, response) :
    if code in error_code :
        print(response["error"])
    else :
        data = response["response"]
        print(data["food"])
        print("\n")
        print(data["position"])



stop = False
while not stop :
    print("1. user<name>\n"
          "2. API/GPT_OCR\n"
          "3. API/GPT_CHAT\n"
          "4. raiseError\n"
          "5. Upload\n"
          "q. quit")
    entry = int(input("input>> "))

    if entry == 1 :
        response = requests.get(f"{url}/user/parkdanyong", headers=header)
        if response.status_code == 200 :
            print(response.json())
    elif entry == 2 :
        message = input("query>> ")
        data = {"query": str(message)}
        response = requests.post(f"{url}/API_GPT_OCR", headers=header, json=data)
        print(response.json())
    elif entry == 3 :
        message = input("query>> ")
        data = {"query": str(message)}
        response = requests.post(f"{url}/API_GPT_CHAT", headers=header, json=data)
        data = response.json()
        if response.status_code == 200 :
            print(data)
    elif entry == 4 :
        response = requests.get(f"{url}/raiseError")
        printResponse(response.status_code, response.json())
    elif entry == 5 :
        file_path = "C:\\Users\\jeong\\Desktop\\멍멍이_초근접.jpeg"
        files = {"file": open(file_path, "rb")}

        response = requests.post(f"{url}/upload", headers=header, files=files)
        print(response.json())
    elif entry == "q" :
        stop = not stop
    else :
        print("Bad request")

    print("\n")





