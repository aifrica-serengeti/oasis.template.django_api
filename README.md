# Django To-Do Project

이 프로젝트는 Django와 Django REST framework를 사용하여 간단한 To-Do 관리 REST API를 구현한 예제입니다.

## 프로젝트 구조

# 프로젝트 디렉토리 구조

```plaintext
template/
├── myproject/               # Django 프로젝트 디렉토리
│   ├── __init__.py          # 프로젝트 패키지 초기화 파일
│   ├── asgi.py              # 비동기 서버 게이트웨이 인터페이스 (ASGI) 설정
│   ├── settings.py          # Django 프로젝트 설정 파일
│   ├── urls.py              # 프로젝트 전체 URL 설정
│   ├── wsgi.py              # 웹 서버 게이트웨이 인터페이스 (WSGI) 설정
│   ├── static/              # 정적 파일 디렉토리 (CSS, JS, 이미지 등)
│   └── templates/           # HTML 템플릿 파일 디렉토리
│       └── base.html        # 공통 템플릿 파일 (header, footer 포함)
│
├── todo/                    # Django 앱 디렉토리 (To-Do 앱)
│   ├── __init__.py          # 앱 패키지 초기화 파일
│   ├── admin.py             # 관리자 페이지에서 To-Do 모델 등록 설정
│   ├── apps.py              # To-Do 앱 설정 클래스 정의
│   ├── migrations/          # 데이터베이스 마이그레이션 디렉토리
│   │   ├── __init__.py      # 마이그레이션 패키지 초기화 파일
│   │   └── 0001_initial.py  # 초기 마이그레이션 파일 (예시)
│   ├── models.py            # To-Do 모델 정의
│   ├── serializers.py       # To-Do 시리얼라이저 정의 (DRF 사용시)
│   ├── forms.py             # To-Do 폼 정의 (폼을 사용할 경우)
│   ├── signals.py           # 신호(signal) 처리 함수 정의 (옵션)
│   ├── tests.py             # To-Do 앱의 테스트 코드
│   ├── urls.py              # To-Do 관련 URL 라우터 정의
│   ├── views.py             # To-Do 앱의 뷰 정의
│   └── templates/           # To-Do 관련 HTML 템플릿 디렉토리
│       └── todo_list.html   # 예. To-Do 리스트 화면용 템플릿 파일
│
├── db.sqlite3               # 기본 SQLite 데이터베이스 파일
├── manage.py                # Django 프로젝트 관리 스크립트
├── .gitlab-ci.yml           # GitLab CI/CD 설정 파일
├── Dockerfile               # Docker 이미지 빌드를 위한 설정 파일
├── README.md                # 프로젝트 설명 파일 (Markdown 형식)
├── requirements.txt         # 프로젝트에 필요한 패키지 목록 파일
└── .env                     # 환경 변수 파일 (예: 비밀키, DB 정보 설정)


### 주요 파일 설명
- `myproject/settings.py`: Django 프로젝트의 기본 설정을 포함하고 있습니다.
- `myproject/urls.py`: 프로젝트 전반의 URL을 설정하며, todo 앱의 API 엔드포인트를 /api/ 경로로 지정합니다.
- `myproject/asgi.py와 myproject/wsgi.py`: ASGI와 WSGI 서버 인터페이스 설정 파일로, 각각 비동기 및 동기 서버 연결을 지원합니다.
- `todo/admin.py`: 관리자 페이지에서 ToDo 모델을 관리할 수 있도록 설정합니다.
- `todo/models.py`: ToDo 모델을 정의한 파일로, 할 일의 제목(title)과 완료 여부(completed) 필드를 포함합니다.
- `todo/serializers.py`: ToDo 모델을 JSON 형식으로 직렬화하기 위한 시리얼라이저가 정의되어 있습니다.
- `todo/views.py`: To-Do 리스트를 가져오거나 새 할 일을 생성하는 ToDoListCreate 뷰와 특정 할 일을 조회, 수정, 삭제할 수 있는 ToDoRetrieveUpdateDestroy 뷰를 포함합니다.
- `todo/urls.py`: 할 일 목록 및 개별 할 일에 대한 API 엔드포인트를 정의합니다.
- `todo/tests.py`: To-Do 앱의 테스트 코드를 포함하며, 기본적인 API 테스트를 작성할 수 있습니다.
- `db.sqlite3`: SQLite 데이터베이스 파일로, 개발 환경에서 간단하게 데이터베이스를 관리하기 위해 사용됩니다.
- `.gitlab-ci.yml`: GitLab에서 자동화된 테스트 및 배포 파이프라인을 구성하는 CI/CD 설정 파일입니다.
- `Dockerfile`: 프로젝트를 Docker 컨테이너에서 실행할 수 있도록 필요한 환경과 패키지를 정의합니다.
- `requirements.txt`: Django 및 프로젝트에 필요한 외부 패키지들이 명시되어 있어, 빠르게 환경을 셋업할 수 있습니다.
- `README.md`: 프로젝트의 설명, 설치 방법, 사용법 등이 포함되어 있습니다.

## 주요 기능

이 프로젝트는 To-Do 앱을 위한 REST API를 제공합니다. 아래와 같은 엔드포인트가 포함되어 있습니다:

- `GET /api/todos/` - 할 일 목록 조회
- `POST /api/todos/` - 새로운 할 일 생성
- `GET /api/todos/<id>/` - 특정 할 일 조회
- `PUT /api/todos/<id>/` - 특정 할 일 수정
- `DELETE /api/todos/<id>/` - 특정 할 일 삭제

### 데이터 모델

To-Do 앱에서는 `ToDo`라는 단일 모델을 사용하며, 주요 필드는 다음과 같습니다:

- `title` (문자열): 할 일의 제목, 최대 100자
- `completed` (불리언): 완료 여부를 나타내며, 기본값은 `False`입니다.

## 설치 및 실행

### 요구 사항

이 프로젝트를 실행하려면 다음 도구가 필요합니다:

- Python 3.9 이상
- Django 및 Django REST framework

### Functions 환경에서 실행하기

1. 필요한 패키지를 설치합니다.
```bash
pip install -r requirements.txt
```

3. template 폴더로 이동합니다.
```bash
cd template
```

3. 마이그레이션 파일을 생성합니다.
```bash
python manage.py makemigrations
```

4. 마이그레이션을 수행하여 데이터베이스를 설정합니다.
```bash
python manage.py migrate
```

5. 로컬 서버를 실행합니다. 
```bash
python manage.py runserver
```

## 환경 설정

- `myproject/settings.py`에 있는 `CORS_ALLOW_ALL_ORIGINS` 옵션은 모든 도메인에서 API 호출이 가능하도록 설정되어 있습니다. 배포 환경에서는 보안을 위해 특정 도메인만 허용하도록 설정하는 것이 좋습니다.
