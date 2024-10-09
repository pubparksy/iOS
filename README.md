:coffee: [git markdown official doc](https://docs.github.com/ko/get-started/writing-on-github/getting-started-with-writing-and-formatting-on-github/basic-writing-and-formatting-syntax) :coffee:
   
# :apple:  iOS
   
파일 설명
   
1. IDETemplateMacros.plist
    1. Xcode / New File from Template / 상단에 표시해줄 Text macros
    2. 적용 경로 : Finder / Project / .xcodeproj 파일 < 우클릭 ‘패키지 내용 보기’ / xcuserdata / .xcuserdatad 경로
   
2. API Output 불필요 문자열 정규식 정리 코드.swift
    1. API 결과로 다양한 종류의 문자가 들어왔을 때 걸러내는 정규식

   
# :open_file_folder: git

.DS_Store 삭제 방법  

저장소 상위 디렉토리에서 현재 디렉토리 아래의 모든 .DS_Store 파일을 제거
```
$ find . -name .DS_Store -print0 | xargs -0 git rm -f --ignore-unmatch
$ git add --all
$ git commit -m '.DS_Store removed'
$ git push origin main
```
[참고 블로그](https://wooono.tistory.com/251)


   
# :christmas_tree: how to write tree
   
➜  Sample
```
├── Project1
│   ├── Assets.xcassets
│   │   ├── AccentColor.colorset
│   │   └── Sources
│   │       └── Contents.json
│   ├── Base.lproj
│   │   └── Main.storyboard
│   ├── DetailViewController.swift
│   └── Info.plist
│ 
├── Project2
│   ├── package.json
│   ├── public
│   │   └── login.js
│   └── node_modules
│       └── express
│           ├── package.json
│           └── lib
└── Assets
```