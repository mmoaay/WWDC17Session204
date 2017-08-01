> 注意：本文涉及的内容基本都是 iOS 11 才有的新特性，所以使用的时候一定要记得做版本判断，当然这只是对于使用 Objective-C 开发的应用，因为 Swift 在编译期间就会各种提醒你。

# 各种 Bar 的新特性

## `UINavigationBar`

### 新特性

#### 大标题模式

WWDC17 苹果发布了 iOS 11 系统，这一次，苹果在 UI 上又做了大调整，其中就包含了大标题。

下面是来自官方的两张截图，这里有两个点需要注意：

- 截图中 `UITableView` 中的文本也比 iOS 10 的要大，但这并不是因为 `UINavigationBar` 的大标题模式而变大的，而是苹果根据大标题模式给出的 UI 设计规范。
- 横屏模式下并不会出现大标题，主要考虑横屏模式下垂直方向的显示区域太小。

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_large_title.png)

当然，苹果也把这个特性开放给了开发者，所以现在我们就来看一下在 iOS 11 上如何开启这个效果，其实很简单，代码中将下面的属性设置为 `true` 即可开启导航栏的大标题模式：

```
navigationBar.prefersLargeTitles
```

当然，也可以在 StoryBoard 中设置，开启方式如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_large_title_set_by_storyboard.png)

> 注意：因为每个 `UINavigationController` 只有一个 `UINavigationBar`，这也就意味着，如果将其 `UINavigationBar` 的 `prefersLargeTitles` 属性设置为 `true`，那么属于这个 `UINavigationController` 下的所有 `UIViewController` 都显示大标题。

既然 `prefersLargeTitles` 是控制某个 `UINavigationController` 下的所有 `UIViewController` 是否显示大标题的属性，苹果当然也会提供单独控制的属性，也就是 `UINavigationItem` 上的 `largeTitleDisplayMode`，我们知道，每个 `UIViewController` 都有独立的 `UINavigationItem`，这样我们就可以控制单个 `UIViewController` 的大标题模式了。

这个属性包含三种模式：

- .automatic：默认值。表示不做任何操作，保持 `UINavigationBar` 中上一个 `UINavigationItem` 的模式。
- .always：使用大标题。当我们进入这个页面时，显示的是大标题。
- .never：不使用大标题模式。当我们进入这个页面时，显示的是正常的标题。

同样，这个属性也可以在 Storyboard 中设置：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_large_title_mode_set_by_storyboard.png)

#### 在`UINavigationItem` 上添加 `UISearchController`

大家先在脑海中过一下在 iOS 11 之前我们是怎么实现这个功能的。

是不是已经不想过了……好，我们来看看 iOS 11：

```
// 构建一个 UISearchController 对象
lazy var searchController = UISearchController()

// 设置

navigationItem.searchController = searchController
```

So easy！！！

另外，iOS 11 的 `UINavigationItem` 还提供了 `hidesSearchBarWhenScrolling` 属性，设置为 true 的时候就可以在滑动的时候隐藏 `UISearchBar`。

#### `UIRefreshControl` 的变化

在 iOS 11 之前，`UIRefreshControl` 会被添加到相应的控件上，如 `UITableView`：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_10_refresh_layer.png)

而 iOS 11 之后，`UIRefreshControl` 被直接添加到了 `UINavigationBar` 上，如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_large_title_refresh_layer.png)

#### Rubber bending 效果

首先我们了解一下什么是 Rubber bending，通俗来说：就是当你在 `UIScrollView` 上下拉，然后放开时 `UIScrollView` 的回弹效果。

iOS 11 之后，因为大量的内容都被添加到 `UINavigationBar` 上，如：`UIRefreshControl`、`UISearchController` 和大标题等，所以苹果在 `UINavigationBar` 上也引入了 Rubber banding 效果。

### 旧版本的兼容

既然 iOS 11 已经有了这些新特性，我们是否可以考虑在 iOS 11 之前也支持它们呢？通过实验，笔者分析出了几个关键变化点：

- 正常的小标题被隐藏了。
- 导航栏的高度由 64 变为 96。
- 大标题的标题字体为 34 。
- `UIRefreshControl` 和 `UISearchController` 都被添加到了 `UINavigationBar` 上。
- 当 `UINavigationBar` 下方的 View 为 `UIScrollView` 等可以滚动的控件时，如果对控件做下拉操作， `UINavigationBar` 上的大标题也会随之下拉，过程中文字海会又一个稍微放大的效果，当然还会有 `UIScrollView` 的 Rubber bending 效果。

也就是说我们只要在 UI 上做这几点改动即可。另外考虑到这些特性是 iOS 11 特有的，我们可以考虑用 **Extension** 的方式扩展出这些特性。

## `UITabBar` 的横屏模式

在 Landscape 模式和 iPad 下，`UITabBar` 也发生了一些改变，图标和标题是水平排列的，而且在 iPhone 上的图标还会更小，从而节省了 Landscape 模式下垂直方向的空间。同时我们还可以通过 `landscapeImagePhone` 这个属性来设置 iPhone Landscape 模式下 `UIBarItem` 的图标。

另外，如果设置了 `UIBarItem` 的 `largeContentSizeImage`，当你开启 large text 模式并长按这个 `UIBarItem` 的时候，会在屏幕中央出现它图标和标题的放大版。如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_uibaritem_large_content.png)

当然两个属性也可以在 Storyboard 中设置，如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_uibaritem.png)

最后，如果你设置的图片是 .xcasset 文件中的 PDF 文件，你可以直接勾选 Preserve Vector Data 这个选项，系统会自动帮你设置 `largeContentSizeImage`，如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_uibaritem_xcassets.png)

> 这个效果其实是 Accessibility 内新增的特性，如果感兴趣的话可以观看 [What’s New in Accessibility](https://developer.apple.com/wwdc17/215)

## 终于可以使用 AutoLayout 了

重磅消息！我们终于可以在 `UIToolBar` 和 `UINavigationBar` 上使用 AutoLayout 了。

这里有几个点需要我们注意：

- 开发者只需要设置自定义 View 内部的约束即可。
- `UINavigationBar` 会负责自定义 View 显示位置的控制。
- 开发者负责控制大小。控制大小的方式有三种：
  - 指定高度和宽度约束。
  - 实现 `intrinsicContentSize`。
  - 通过子视图把自定义 View 撑开。

### 什么是 `intrinsicContentSize` ？

Intrinsic Content Size：固有大小。是苹果在 AutoLayout 中引入的一个概念，意思就是说我知道自己的大小，如果你没有为我指定大小，我就按照这个大小来。比如：大家都知道在使用 AutoLayout 的时候，`UILabel` 就不用指定尺寸大小，只需指定位置即可，就是因为，只要确定了文字内容，字体等信息，它自己就能计算出大小来。

> `UILabel`，`UIImageView`，`UIButton` 等组件及某些包含它们的系统组件都有 Intrinsic Content Size 属性。

# 新的 Margin 和 Inset

## 什么是 Margin

首先我们需要了解一下什么是 Margin？Margin 是苹果在 AutoLayout 中引入的一个概念，也就是所谓的边距。官方对于 Margin 的解释其实挺拗口，所以我们在 `layoutMargins` 上直接举例解释一下。

## 原有的 Margin

我们先来看一下 iOS 11 之前就有的属性。

### `layoutMargins`

这是 `UIView` 上的一个属性，类型是 `UIEdgeInsets`，`UIEdgeInsets` 这个类型大家应该就比较熟悉了，所以 `layoutMargins` 代表的就是 `UIView` 所有 subview 和 view 本身的边距了。如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_10_layout_margins.png)

当然前提是这些 subview 是和 `layoutMarginsGuide` 做约束的。

### `layoutMarginsGuide`

在 Autolayout 中作为约束的一个参考，如下图：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_10_layout_margins_guide.png)

如果一个 view 的所有 subview 都是和 `layoutMarginsGuide` 做约束的话，当调节 `layoutMargins` 的值的时候，所有的 subview 都会受到影响。这里就有一个应用场景：如果你所有的 subview 都是基于 `layoutMarginsGuide` 来做约束的，当 UI 设计告诉你说他想把默认边距从 16 调整到 8。只需要一行简单的代码就可以搞定，如果没有的话，你就得一个一个约束去改了。What the fuck！！！

## 新增的 Margin

### `directionalLayoutMargins`

iOS 11 引入了 `directionalLayoutMargins`，其实目的是为了多语言支持，对于大部分语言来说，都是从左到右的顺序，但是某些语言是从右到左的…… `directionalLayoutMargins` 其实就是用来解决这个问题的，当语言显示顺序是从左到右时，它的 .leading 和 .trailing 表示的是正常的左右，如果语言显示顺序是从右到左时，表示的就是右左了。另外要注意的是 `directionalLayoutMargins` 的类型是 `NSDirectionalEdgeInsets`。不过这个属性对于国内的大部分开发者来说，意义不大，除非是做一些阅读类的 App。

下面是从左到右和从右到左两种阅读顺序时设置 `directionalLayoutMargins.trailing` 为 30 的效果：

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_direct_layout_margin_left_right.png)
![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_direct_layout_margin_right_left.png)

### `systemMinimumLayoutMargins`

在 iOS 11 之前，`UIViewController` 的 view 默认有一个被锁定的 Margin，边距均为 16，而且我们无法对这个 Margin 做任何操作。iOS 11 之后，这个 Margin 终于被放出来了，即 `systemMinimumLayoutMargins`。当然，这个属性仍然是只读的，我们并不能直接修改这个属性，但是，苹果还新增了另外一个属性：`viewRespectsSystemMinimumLayoutMargins`。如果将其设置为 false，我们的和屏幕的边距就只由 `directionalLayoutMargins` 来控制了，这样一来，我们甚至可以将边距修改为 0，从而让我们的内容充满整个屏幕。

![](https://github.com/mmoaay/WWDC17Session204/blob/master/images/ios_11_layout_margin_view_respects.png)

### 安全区域

在 iOS 11 之前，有两个约束参考是我们特别熟知的：`topLayoutGuide` 和 `bottomLayoutGuide`。其实这主要在 `UINavigationBar`、`UIToolBar` 和 `UITabBar` 处于 translucent 的情况下使用。而 iOS 11 之后，这两个属性被 Safe area 所代替，包含了 `safeAreaInsets` 和 `safeAreaLayoutGuide`。

### additionalSafeAreaInsets



### Safe area 变化的回调

Safe area 发生变化的时候，iOS 11 提供了两个回调来通知 `UIView` 和 `UIViewController`。

- safeAreaDidChange
- viewSafeAreaDidChange

## UIScrollView 的变化

contentInset.top

adjustedContentInset.top

### frameLayoutGuide

### contentLayoutGuide


## UITableView 的变化

### AutoLayout 的支持

iOS 11以后，UITableView 的 Header、Footer 和 Cell 默认都使用 self-sizing，这也就意味着，我们不需要再关心 UITableView 中任何元素的高度，使用 Autolayout 的情况下，UITableView 会自动计算所有元素的高度。

如果想禁用这个功能，使用下面的代码：

```
tableView.estimatedRowHeight = 0;
tableView.estimatedSectionHeaderHeight = 0;
tableView.estimatedSectionFooterHeight = 0;
```

### Margin 和 Inset 的变化

#### seperatorInset

在 iOS 11 之前，seperatorInset 是根据 readable content guide 来改变的，这样在 iPad Landscape 模式下的时候，`UITableView` 的 Cell 就只能显示在一块固定的区域之内，并不能扩展到整个屏幕，而 iOS 11 之后，seperatorInset 则是根据 UITableView 本身 Cell 的边缘来改变了。

```
tableview.seperatorInsetReference
```

.fromCell 和 .fromAutomaticInsets

### Swipe 操作

iOS 11 新增了如下几个特性：

- 支持滑动直接删除 Cell。
- 全新的 Swipe 样式和操作体验。
- Swipe 操作支持自定义图片。
- 左侧和右侧都支持 Swipe 操作。
- 提供回调方法可以让开发者取消 Swipe 操作。


总的来说，iOS 11 新增的这些特性还是给开发者提供了极大的便利的。但是考虑到兼容旧版本的问题，能利用上的点并不是特别多，但是如果作为个人开发者，只考虑做一个单纯支持 iOS 11 的 App，这篇文章还是有一些帮助的。

另外，笔者把写文章时候的一些实践做了一个项目，开源在了 Github 上，配合项目看这篇文章效果会更好：[https://github.com/mmoaay/WWDC17Session204](https://github.com/mmoaay/WWDC17Session204)。