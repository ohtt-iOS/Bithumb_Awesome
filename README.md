<div align="center">

  # Bithumb_Awesome

  ### 빗썸 - 어썸 ✨

  
 <img src="https://user-images.githubusercontent.com/68267763/158004776-677c418e-ed26-44db-af07-a61e3d98888d.png" width="300" />

📆  ` 2022.02.21 ~ 2022.03.13 `

  </br>

 ##  Awesome 멤버
  
  </br>
  
| <img src="https://user-images.githubusercontent.com/68267763/158005075-12c8e4f4-c73a-4dbe-b9c4-c71dbbb61644.jpg" height="300" /> | <img src="https://user-images.githubusercontent.com/68267763/158005113-9733d4cd-d1f3-4ef5-9f7e-41d0fea71200.png" height="300" /> | 
| :----------------------------------------------------------: | :----------------------------------------------------------: 
|                            **오뜨 (이소영)**               |                            **강경 (강경훈)**                            |
[@ohtt-iOS](https://github.com/ohtt-iOS) |   [@KangKyung](https://github.com/KangKyung)    |  

</br>


</div>

</br>
</br>

## Notion
[노션 주소](https://truth-aerosteon-d09.notion.site/81f08cd8bf224d929ca3fc904806e53e)

> 저희의 프로젝트 진행을 기록해둔 Notion입니다.

</br>
</br>

## 🛠 Technologies Used
<!-- PROJECT SHIELDS -->
<p align="left"> 
<a href="https://swift.org">
<img src="https://img.shields.io/badge/Swift-5.6-orange" alt="Swift Version 5.1" /></a>
<a href="https://developer.apple.com/ios/">
<img src="https://img.shields.io/badge/iOS-14.0%2B-success" alt="iOS Version 14.0"/></a>
<a href="https://developer.apple.com/xcode/swiftui/">
<img src="https://img.shields.io/badge/SwiftUI-3.0-ff69b4" alt="SwiftUI 3.0" /></a>
<a href="https://developer.apple.com/documentation/combine/">
<img src="https://img.shields.io/badge/reactive-combine-blue" alt="Combine" /></a>
<a href="https://github.com/pointfreeco/swift-composable-architecture/">
<img src="https://img.shields.io/badge/architecture-TCA-ff0000" alt="Architecture" /></a>
</p>



</br>
</br>


## 💪🏻 Cooperation



![이미지](https://user-images.githubusercontent.com/68267763/158018902-e601e757-10f1-43af-82ec-12167feb2b1a.png)

</br>
</br>


> 디자인은 피그마를 활용하였습니다. </br>
사용될 폰트와 이미지, 컬러등을 정해두고 적용하여 컬러나 폰트가 수정되더라도 </br>
한번에 변경할 수 있도록 구현하였습니다.



</br>
</br>

## ✉️ Commit Convention

```
#   feat    : 기능 (새로운 기능)
#   add     : 파일추가 (Asset이나 기본세팅)
#   fix     : 버그 (버그 수정)
#   refactor: 리팩토링 (비즈니스 로직에 변경 없음)
#   style   : 스타일 (코드 형식, 세미콜론 추가: 비즈니스 로직에 변경 없음)
#   docs    : 문서 (문서 추가, 수정, 삭제)
#   test    : 테스트 (테스트 코드 추가, 수정, 삭제: 비즈니스 로직에 변경 없음)
#   chore   : 기타 변경사항 (빌드 스크립트 수정 등)
```

</br>
</br>
</br>

## 📱 기능구현

</br>
</br>


Home        |  입출금 내역
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/68267763/158003928-f1c15efc-23b5-452b-b326-05bbe73f22ef.gif" width="300" />  | <img src="https://user-images.githubusercontent.com/68267763/158004294-67820bde-cfbe-484f-8ce5-9f1fdc557918.gif" width="300" />


차트        |  호가
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/68267763/158004299-8a88d0d1-13cd-4dde-bca9-ea1dc2eefb24.gif" width="300" />  | <img src="https://user-images.githubusercontent.com/68267763/158016921-4b06215f-df7e-4d85-94f5-5a1562670cf1.gif" width="300" />


체결  | 관심종목 삭제     
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/68267763/158004301-9ec1e934-c33b-4d41-8d2e-701fbce2325e.gif" width="300" />  | <img src="https://user-images.githubusercontent.com/68267763/158004556-b28b181e-05d9-4ef8-ba97-1629dc770012.gif" width="300" />  


검색        |  검색 후 이동
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/68267763/158004342-b9a9c585-f5ba-4417-b15c-0e06c7f4d9ff.gif" width="300" />  | <img src="https://user-images.githubusercontent.com/68267763/158004345-817de1a0-bbad-4f71-b45e-3655217aecee.gif" width="300" />

라이센스 명시        |  웹페이지 이동
:-------------------------:|:-------------------------:
<img src="https://user-images.githubusercontent.com/38858863/158047791-c2aad0b7-f02e-47d4-b53a-9d56e6fb62f2.gif" width="300" />  | <img src="https://user-images.githubusercontent.com/38858863/158047797-90e2faee-6519-4faf-a928-4c8699f0c91c.gif" width="300" />


</br>
</br>


## 🤔 고민과 해결


<details>
<summary>API 주소 관리</summary>
<div markdown="1">

```
API 주소를 관리하는 enum을 생성해주었습니다.
struct 대신 enum을 사용한 이유는, 생성자가 제공되지 않는 자료형을 사용하기 위해서입니다.
일반적으로 API를 관리하는 파일은 .gitignore에 담지만 프로젝트 특성상 git에 함께 올려두었습니다
```

</div>
</details>


<details>
<summary>Combine - 같은 API를 여러번 호출하여 하나의 배열 형태로 응답받기</summary>
<div markdown="1">
  
```
하나의 API를 여러번 호출하여야 하는 구현 사항이 있었습니다
아래의 방법을 통해 여러번을 호출한 후 하나의 Array로 응답받을 수 있도록 구현하였습니다.
```
  
```swift
func fetchData() -> AnyPublisher<Model, Error> {
// api 호출
}
```
  
```swift
let result: AnyPublisher<[Model], Failure> =
Publishers
  .MergeMany(
    array.map { _ in
      fetchData()
    }
  )
  .collect()
  .eraseToAnyPublisher()
```  
 

</div>
</details>
    
  
<details>
<summary>HomeView - Socket</summary>
<div markdown="1">
  
  ```
  Home쪽에 Socket을 붙이는 과정에서
  TCA에 대한 이해도가 부족하여 다른 뷰와 연결했을 때 앱이 버벅이는 현상이 발생하였습니다.
  해당 부분에 대한 기능은 별도로 분리된 HomeSocket Branch에
  연결을 해두었습니다.
  ```

</div>
</details>

  
<details>
<summary>여러 Effect 연결</summary>
<div markdown="1">
  
```
여러 Effect를 하나의 return으로 내보내줘야하는 경우가 있었습니다.
.merge를 이용하여 여러 Effect를 묶어 내보내주었습니다.
```
  
```swift
return .merge(
  Effect(value: .webSocket(.socketOnOff)),
  Effect(value: .chartAction(.radioButtonAction(.buttonTap(.hour_24)))),
  Effect(value: .conclusionAction(.onAppear)),
  Effect(value: .quoteAction(.onAppear))
  )
  ```

</div>
</details>

<details>
<summary>Navigation Link 깜빡임 해결</summary>
<div markdown="1">
  
```
Navigation Link를 통해 이동할 때 해당 View가 깜빡이는 현상이 있었습니다.
아래처럼 ButtonStyle을 만들어주어 해당 뷰에 적용해주었습니다.
```
  
```swift
struct FlatLinkStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
    }
}
```
  
```swift
NavigationLink(destination: DetailView()){
        HStack{
            Text("title")
            Spacer()
            Image(systemName: "chevron.right")
        }
        .padding()
    }.buttonStyle(FlatLinkStyle())     // << here !!
  ```
</div>
</details>
  
<details>
<summary>SwiftUI 백스와이프 제스처를이용한 뒤로가기액션(PopGesture)구현</summary>
<div markdown="1">
  
```
커스텀 네비게이션바를 사용하게되면 백스와이프 제스처를이용한 뒤로가기액션(PopGesture)이되지않아 이를 해결하고싶었습니다.
> NavigationBar를 가리게되면(hidden) interactivePopGestureRecognizer의역할이 비활성화되기때문에 일어난 현상이었습니다.
  다시 활성화하기 위해 delegate를 연결하고, Gesture인식이 가능하도록 만들었습니다.
```

```swift
extension UINavigationController: ObservableObject, UIGestureRecognizerDelegate {
  override open func viewDidLoad() {
    super.viewDidLoad()
    navigationBar.isHidden = true // `.navigationBarHidden(true)`일괄적용
    interactivePopGestureRecognizer?.delegate = self
  }
  
  public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
    return viewControllers.count > 1 // Stack에 쌓인View가 1개를 초과할 때 Gesture 인식을 시작하도록 설정
  }
}
```
</div>
</details>
  
<details>
<summary>enum 중복코드 재사용성 증대를위한 고민</summary>
<div markdown="1">
  
```
같은 액션(라디오버튼액션)을 가지며, 같은 모양의 View를가지는 enum타입에 있어서
한꺼번에 사용하여 재사용성을 증가시키는게 좋을지, 분리하는게 좋을지 고민하였습니다.
> 함께사용하게되면 필요없는 기능을 가지게되는 문제가생기며, 분리하면 동일한 코드의 재사용성이 줄어들게 됩니다.
  처음에는 공통부분에 해당하는 protocol을 채택하여 중복을 줄이려고 하였으나, enum타입의 특성탓에 구현이 힘들었습니다.
> 가장 베스트는 각 타입별의 모듈화를 진행하는 것이나, 시간적 여유가 부족하여 일단 함께사용하게 되었습니다.
```

```swift
enum AwesomeButtonType {
  case koreanWon, bitcoin, interest, popularity
  case chart, quote, conclusion
}
```
</div>
</details>
  
<details>
<summary>클로저를 탭제스처로 만들어주기위한 고민</summary>
<div markdown="1">
  
```
가독성 향상을 위해 뒤로가기버튼의 클릭이벤트를 상수로 넣고싶었습니다.
하지만 그렇게 이용하는 경우, 다음뷰로 네비게이션 되자마자 struct가 init되는시점에서 실행이 되어버려서
클릭이벤트가 바로 실행되어버렸습니다. (다음뷰로 이동하자마자 바로 이전뷰로 이동되었습니다.)
> 탭제스처를 버튼View로 만들고, 해당액션을 코어액션에 넣고 처리해주는 방법을 고안했습니다.

```

```swift
struct DetailView: View {
  let store: Store<DetailState, DetailAction>
  @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
  
  var body: some View {
    VStack {
//    NavigationBarView(presentationMode: self.presentationMode)
      NavigationBarView(comeBackAction: self.presentationMode.wrappedValue.dismiss())

//    ...
  }
}

struct NavigationBarView: View {
//let presentationMode: Binding<PresentationMode>
  let comeBackAction: ()
  
  var body: some View {
    HStack(spacing: 25) {
      Image.backButton
        .onTapGesture {
//        self.presentationMode.wrappedValue.dismiss()
          self.comeBackAction
        }
      
//      ...
    }
  }
}
```
</div>
</details>

<details>
<summary>SwiftUI View생성 방식에대한 고민</summary>
<div markdown="1">
  
```
View를 생성하는 방식으로 별도의 struct를 만들지, 해당 struct안에 computed property로 구현할지 고민하였습니다.
struct안에 만드는 경우 자원공유에 이점이 있고 
작은 뷰를 만드는데 굳이 struct까지 만들어야하나하는 생각이들었기 때문입니다.
> computed는 값을 메모리에 저장해놓지 않고 필요할때마다 로직을 계산하여 get set을 진행합니다.
> struct는 처음부터 인스턴스를 stored property처럼 만들어놓고 필요할때마다 호출합니다.
> 따라서 생성과 해제에서의 성능차이로부터 오는 퍼포먼스차이에따라 struct로 구현하는 방법을 선택하였습니다.
```

```swift
// 별도의 struct를 만드는 경우
struct MainView: View {
	var body: some View {
    List(1..<30) { _ in
      MainViewListRowView()
    }
}

struct MainViewListRowView: View { ... }
```

```swift
// struct안에 computed property로 구현하는 경우
struct MainView: View {
  var body: some View {
    List(1..<30) { _ in
      self.rowView
    }
    
  private var rowView: some View { ... }
}
```
</div>
</details>
  
</br>
</br>

  
## 마무리하며

- 오뜨
 
> 길고도 짧았던 3주가 끝이 났습니다. 글을 쓰다보니 지난 3주가 스쳐지나가네요. </br>
> 3주간 저와 함께 으쌰으쌰해준 강경에게 감사인사를 전합니다 😄  </br>
> 첫주차에 `다음에도 함께하고 싶은 개발자`가 되고 싶다고 말씀드렸었는데 그게 이루어졌나 모르겠어요  </br>
> 처음 접하는 SwiftUI + Combine + Composable Architecture 를 공부하며  </br>
> 아쉬운 부분도 물론 있었지만 뿌듯한 마음이 훨씬 큰 3주였습니다.  </br>
> 너무 수고하셨습니다 ! 감사해요 

- 강경
 
> 처음엔 SwiftUI를 경험한 사람이 저뿐이고, 팀원도 한분 나가셔서 걱정이 많았습니다. </br>
> 직장을 병행하며 저도 처음이었던 TCA를 공부하면서 과연 해낼 수 있을까 했지요.. </br>
> 오뜨의 폭발적인 러닝커브가 아니었다면 여기까지올 수 있었을까 싶어요! </br>
> 그런 멋진 점을 배우고자, 페어프로그래밍을 통해 오뜨의 암묵지를 많이꺼내먹었습니다😋  </br>
> 오뜨는 그럼에도 여전히 배울점이많은, `계속 함께하고 싶은 개발자`에요 ㅎㅎ </br>
> 한 프로젝트에 쭉 늘어져서 고생많으셨고, 짤막해서 아쉬운 3주였습니다. </br>
> 각자의 자리에서 폭풍성장해서 다음에 만나는 곳에서 더 멋진 인연으로 만났으면 좋겠습니다! </br>
