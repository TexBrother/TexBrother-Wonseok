<img width=100% src=https://user-images.githubusercontent.com/42789819/128718146-768d676a-913a-443e-9424-ddea0dd04ca8.png>

### ⚠️ Note

* `Node의 생명주기`
  
  1. init -> Background
  2. didLoad -> Main
  3.  layoutSpecThatFits -> Background / 순수하게 Texture에서 제공해주는 LayoutSpec 및 Layout Elements Properties 만 사용할 것
  4. layout -> Main
  
  
  
* `Node의 SubClassing`
  
  * ViewController에서 부모노드에 들어갈 자식 노드들을 같이 작성하게 된다면 비즈니스 로직이나 명세에 따라서 복잡도가 증가할수록 Massive 해질 수도 있다.
  
  * ASViewController는 제네릭형태로 ASDisplayNode의 모든 Subclass를 받아서 사용할 수 있기 때문에 ViewController에 들어갈 화면 구성요소들을 모듈화 시킨 뒤 ASViewController<T>에서 제네릭형태로 SubClassing 시킴으로써 **ViewController가 Massive**해지는 것을 피할 수 있다. 
  
    

* `ASButtonNode에 addTarget하기`

  * addTarget메서드는 didLoad() 내부에 작성해주어야 한다.

    ```swift
    // MARK: Initializing
    init(_ profileImgName: String, _ userName: String) {
      //...
      self.node.onDidLoad({ [weak self] _ in
                           self?.dismissBtn.addTarget(self,
                                                      action: #selector(self?.dismissAction),
                                                      forControlEvents: .touchUpInside)
                          })
    }
    ```



* `노드의 layoutSpec 작성 위치`

  * init() 내부 layoutSpecBlock 활용

    ```swift
    override init() {
        // ...
        self.layoutSpecBlock = { (_ , _) -> ASLayoutSpec in
            return ASRatioLayoutSpec(ratio: 1.0, child: self.profileImgNode).styled {
                $0.flexShrink = 1.0
            }
        }
    }
    ```

  * layoutSpecThatFits 활용

    ```swift
    // MARK: Layout
    private func layoutSpecThatFits(_ constraintedSize: ASSizeRange) -> ASLayoutSpec {    
        return ASInsetLayoutSpec (
            insets: self.node.safeAreaInsets,
            child: contentLayoutSpec()
        )
    }
    ```



* `Layout Element Properties`
  * flextGrow, flexShirink가 일단 기초적으로 가장 먼저 중요한 것 같다.
  * [나머지](https://texture-kr.gitbook.io/wiki/layout-api/layout-element-properties)도 꼭 살펴보자



* `Cell에 Data 매칭`

  * 기존 UITableView나 UICollectionView의 cellForRowAt 메서드 내부에서 직접 cell에 접근하여 데이터를 매칭하던 것과 다르게

    ```swift
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: testCVCell.reuseIdentifier, for: indexPath) as? testCVCell else { return UICollectionViewCell() }
        
      	let data = activityData[indexPath.row]
        cell.dataBind(imageName: nil, title: data.title, subTitle: data.subTitle, day: data.day)
        return cell
    }
    ```

    

    Texture는 CellNode의 initializer를 활용하여 데이터 매칭이 이루어진다.

    ```swift
    // MARK: init() of CellNode
    init(model: FreindsList) {
        super.init()
        self.automaticallyManagesSubnodes = true
        self.automaticallyRelayoutOnSafeAreaChanges = true
    
      	// Data Bind
    	  profileImageNode.image = UIImage(named: model.imageName)
        nameNode.attributedText = NSAttributedString(
              string: model.userName,
              attributes: [
                .font: UIFont.systemFont(ofSize: 16.0, weight: .semibold), 
                .foregroundColor: UIColor.black
              ]
        )
    }
    ```

    tabldNode에서는 어떻게 하는지 바로 아래 코드 참고

    

* `Cell 재사용`

  * Texture는 Cell을 재사용하지 않는다. 따라서 Texture가 Cell을 모두 준비하고 보여줄 수 있도록 `nodeForRowAt`보다 `nodeBlockForRowAt` 을 사용하는 것이 좋다. nodeBlock 은 모든 SubNode 의 생성자를 백그라운드에서 실행할 수 있게한다.

    ```swift
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        return {
            guard FreindsListData.count > indexPath.row else { return ASCellNode() }
    	      let freindModel = FreindsListData[indexPath.row]
          	// CellNode init()호출로 데이터 바인딩
      	    return ProfileCellNode(model: myInfo, category: section)
        }
    }
    ```



* `UITableView(ASTableView) 의 속성 변경하기`

  * ASTableView의 속성들은 ASTableNode의  `.view` 프로퍼티로 직접 사용할 수 있는데. 이 때, 노드의 뷰 또는 레이어 프로퍼티의 -viewDidLoad 또는 -didLoad가 호출된 후에 그 내부에서만 접근해야 한다.

    

* `Cell 크기`
  * 노드는 `layoutSpecThatFits(:)` 메서드에서 반환된 layoutSpec 을 통해 크기를 정의하기 때문에 `ASTableNode` 가 `UITableView` 의 `tableView(:heightForRowAt:)` 와 같은 기능을 제공하지 않는다.