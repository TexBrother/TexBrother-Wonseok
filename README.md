<img width=100% src=https://user-images.githubusercontent.com/42789819/128718146-768d676a-913a-443e-9424-ddea0dd04ca8.png>

### ⚠️ Note

* Node의 생명주기
  1. init -> Background
  2. didLoad -> Main
  3.  layoutSpecThatFits -> Background / 순수하게 Texture에서 제공해주는 LayoutSpec 및 Layout Elements Properties 만 사용할 것
  4. layout -> Main
* Node의 SubClassing
  * ViewController에서 부모노드에 들어갈 자식 노드들을 같이 작성하게 된다면 비즈니스 로직이나 명세에 따라서 복잡도가 증가할수록 Massive 해질 수도 있다.
  * ASViewController는 제네릭형태로 ASDisplayNode의 모든 Subclass를 받아서 사용할 수 있기 때문에 ViewController에 들어갈 화면 구성요소들을 모듈화 시킨 뒤 ASViewController<T>에서 제네릭형태로 SubClassing 시킴으로써 **ViewController가 Massive**해지는 것을 피할 수 있다. 