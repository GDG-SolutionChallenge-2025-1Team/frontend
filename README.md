# GDG 솔루션 챌린지 1팀 Flutter DOCS

## Main Structure
- state 처리로 인해서 추후 provider 추가 가능성이 있다.
```
lib/
├── core/
│   ├── constants/ : 고정 변수를 정의 (사진 경로와 같은 것)
│   └── theme/ : 디자인 정의 
├── models/ : 필요한 구조체 정의
├── screens/ : 필요한 화면 구현
├── services/ : API 연동
├── utils/ : flutter내 비지니스 로직 구현
├── widgets/ : 공통 컴포넌트 구현
├── main.dart : flutter 진입점
└── routes.dart : 화면 분기
```

## File
- 파일명은 언더바표시법(단어 사이를 언더바로 표현)으로 작성한다.
- 각 컴포넌트의 이름은 파스칼 표기법(단어는 첫 시작은 무조건 대문자)으로 작성한다.

## Color
- `lib/core/theme/app_colors.dart` 파일에서 색상 확인 가능 및 추가 가능하다.
- 각자 컴포넌트에 맞는 위치에 색상 추가한다. (만약 새로운 컴포넌트의 색상이라고 한다면 `컴포넌트이름색상이름`으로 변수명을 정의 후 사용하며 카멜 케이스를 적용한다.)

## Icon / Image
1. 사용하고자 하는 아이콘 혹은 이미지를 최상단 assets/icons or images 폴더에 추가한다.
2. `lib/core/constants/app_assets.dart` 파일에 아래와 같이 추가한다. (아래 String은 고정 경로로 작성하며, 파일 이름은 확장자를 포함해서 작성한다.)
```
static const String IconCalendar = 'assets/icons/파일 이름';
```

## Font
1. 최상단 fonts 폴더에 ttf 파일을 넣어둔다.
2. 최상단 pubspec.yaml 파일에서 사용하고자 하는 파일을 flutter: 아래에 설정해준다. (작성 방법은 아래 참고)
```
fonts:
    - family: Modak
      fonts:
        - asset: fonts/Modak-Regular.ttf
```

## Common Widget
- 기본적으로 `lib/widgets` 폴더에 구현되어 있다.

    #### 현재 구현되어있는 Common Widget
    - wave_painter