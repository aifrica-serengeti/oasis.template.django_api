# 베이스 이미지로 Python 3.11 사용
FROM python:3.11-slim

# 컨테이너 내에서 작업할 디렉토리 생성 및 설정
WORKDIR /app

# 프로젝트의 requirements.txt를 먼저 복사
COPY . .

# Python 패키지 설치를 위해 pip 업그레이드
RUN pip install --upgrade pip

# requirements.txt 파일을 사용해 Python 패키지 설치
RUN pip install -r requirements.txt

# 애플리케이션에서 사용할 포트 번호 노출
EXPOSE 8080

# Django 서버 실행을 위해 template 폴더로 이동
WORKDIR /app/template

# Django 서버 실행 명령
CMD ["python", "manage.py", "runserver", "0.0.0.0:8080"]