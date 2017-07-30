> 注意：本文中很多都是 iOS 11 才有的新特性，所以使用的时候一定要记得用 `responseToSelector` 做判断。

# 各种 Bar 的新特性

## UINavigationBar 的大标题模式

WWDC17 苹果发布了 iOS 11 系统，这一次，苹果在 UI 上又做了大调整，其中就包含了大标题。

观察下面两张图，一张是 iOS 11，一张是 iOS 10。你会发现，iOS 11 在导航栏上有了一个非常明显的改变，它标题位置下移，而且字体变大。

![](TODO)

### iOS 11 中的使用姿势

当然，苹果也把这个特性开放给了开发者，所以现在我们就来看一下在 iOS 11 上如何拥有这个效果，其实很简单，将下面的属性设置为 true 即可开启导航栏的大标题模式：

```
UINavigationBar.prefersLargeTitles
```

> 注意：因为 `UINavigationController` 只有一个 `UINavigationBar`，这也就意味着，如果将其 `UINavigationBar` 的 `prefersLargeTitles` 属性设置为 `true`，那么属于这个 `UINavigationController` 下的所有 `UIViewController` 都显示大标题。

既然 `prefersLargeTitles` 是控制某个 `UINavigationController` 下的所有 `UIViewController` 是否显示大标题的属性，苹果当然也会提供单独控制的属性，也就是 `UINavigationItem` 上的 `largeTitleDisplayMode`，我们知道，每个 `UIViewController` 都有独立的 `UINavigationItem`，这样我们就可以控制单个 `UIViewController` 的大标题模式了。

这个属性包含三种模式：

- Automatic：默认值。表示不做任何操作，保持之前的模式。
- Always：使用大标题。当我们进入这个页面时，显示的是大标题。
- Never：不使用大标题模式。当我们进入这个页面时，显示的是正常的标题。

### 旧版本的兼容

既然 iOS 11 已经有了大标题模式，我们是否可以考虑在 iOS 11 之前也支持大标题模式呢？观察其效果，笔者分析出了几个关键变化点：

- 正常的小标题被隐藏了。
- 导航栏的高度由 64 变成了。
- 大标题的标题字体为。

也就是说我们只要在 UI 上做这几点改动即可。另外考虑到这两个属性是 iOS 11 特有的，我们可以考虑用 **Extension** 的方式扩展出这两个属性。

## UITabBar 的横屏模式

在 Landscape 模式和 iPad 下，UITabBar 也发生了一些改变，图标和标题是水平排列的，这样有两个好处：一方面可以让每个 Item 的图标和标题更大；另外一方面也节省了 Landscape 模式下垂直方向的空间。

另外，当你长按某个 Item 的时候，会在屏幕中央出现这个 Item 图标和标题的放大版，界面上其他元素的字体也会放大，类似放大镜的效果。如下图：

![](TODO)

现在我们来看如何在 iOS 11 上实现这两个功能：

```
UIBarItem.landscapeImagePhone
```

```
UIBarItem.largeContentSizeImage
```

通过这个属性可以指定长按时显示在屏幕中央的图片，如果你提供的图片是 .xcasset 文件中的 pdf 文件，你可以直接勾选 Preserve Vector Data 这个选项，系统会自动帮你设置 `largeContentSizeImage`，如下图：

![](TODO)

> 这个效果其实是  内新增的特性，如果感兴趣的话可以观看

## UIToolBar

## 导航上的 UISearchController

先看一下 iOS 11 之前我们的做法：

TODO:

然后来看看 iOS 11：

```
// 构建一个 UISearchController 对象

// 设置

navigationItem.searchController = 
```

不能再简单了！

另外，iOS 11 还提供了下面的属性，设置为 true 的时候就可以在滑动的时候隐藏 UISearchBar

```
navgationItem.hidesSearchBarWhenScrolling
```

## UINavigationController 上的滚动操作

### Refresh Control

### Rubber banding

## 终于可以在各种 Bar 上使用 AutoLayout 了

重磅消息！我们终于可以在 UIToolBar 和 UINavigationBar 上使用 AutoLayout 了。（PS：此处应该有掌声）

这里有几个点需要我们注意：

- 开发者只需要设置自定义 View 内部的约束即可。
- UIToolBar 和 UINavigationBar 负责控制位置。
- 开发者负责控制大小。控制大小的方式有三种：
  - 指定高度和宽度约束。
  - 实现 `intrinsicContentSize`。
  - 通过子视图把自定义 View 撑开。

### 什么是 `intrinsicContentSize` ？

## Demo

# Margin 和 Inset 的新特性

## 什么是 Margin

首先我们需要了解一下什么是 Margin？Margin 是 Apple 在 AutoLayout 中引入的一个概念，也就是所谓的边距，官方对于 Margin 的解释其实挺拗口，所以我们在 layoutMargins 上直接举例解释一下。

## 原有的 Margin

我们先来看一下 iOS 11 之前就有的属性。

### layoutMargins

这是 UIView 上的一个属性，类型是 UIEdgeInsets，UIEdgeInsets 这个类型大家应该就比较熟悉了，所以 layoutMargins 代表的就是 UIView 所有 subview 和 view 本身的边距了，当然前提是这些 subview 是和 layoutMarginsGuide 做约束的。

### layoutMarginsGuide

在 Autolayout 中作为依赖的一个标示，如果一个 view 的所有 subview 都是和 layoutMarginsGuide 做约束的话，当调节 layoutMargins 的值的时候，所有的 subview 都会受到影响。这里就有一个应用场景：如果你所有的 subview 都是基于 layoutMarginsGuide 来做约束的，当 UI 设计告诉你说他想把默认边距从 16 调整到 8。只需要一行简单的代码就可以搞定，如果没有的话，你就得一个一个约束去改了。What the fuck！！！

## 新增的 Margin

### directionalLayoutMargins 

iOS 11 引入了 directionalLayoutMargins，其实目的是为了多语言支持，对于大部分语言来说，都是从左到右的顺序，但是某些语言是从右到左的…… directionalLayoutMargins 其实就是用来解决这个问题的，当语言显示顺序是从左到右时，它的 .leading 和 .trailing 表示的是正常的左右，如果语言显示顺序是从右到左时，表示的就是右左了。不过这个属性对于国内的大部分开发者来说，意义不大，除非是做一些阅读类的 App。

### systemMinimumLayoutMargins

在 iOS 11 之前，UIViewController 的 view 有一个被锁定的 Margin，边距均为 16。而 iOS 11 之后，这个 Margin 被替换成了 systemMinimumLayoutMargins，也就是说这个边距也可以被修改了。另外，Apple 还新增了一个  viewRespectsSystemMinimumLayoutMargins 属性，如果将其设置为 false，你甚至可以将这个边距修改为 0，然后充满整个屏幕。

### 安全区域

在 iOS 11 之前，有两个属性是我们特别熟知的：topLayoutGuide 和 bottomLayoutGuide。主要在 UINavigationBar、UIToolBar 和 UITabBar 处于 translucent 的情况下使用，因为这个时候，如果你直接跟 UIViewController 的 view 做约束，你的内容是会被这些 Bar 遮住的，所以如果你不想你的内容被遮住，就需要用到 topLayoutGuide 和 bottomLayoutGuide，而 iOS 11 之后，这两个属性被 Safe area 所代替，包含了 `safeAreaInsets` 和 `safeAreaLayoutGuide`。

additionalSafeAreaInsets

safeAreaDidChange
viewSafeAreaDidChange

# UIScrollView

contentInset.top

adjustedContentInset.top

# frameLayoutGuide

# contentLayoutGuide

# UITableView

iOS 11以后，UITableView 的 Header、Footer 和 Cell 默认都使用 self-sizing，这也就意味着，我们不需要再关心 UITableView 中任何元素的高度，使用 Autolayout 的情况下，UITableView 会自动计算所有元素的高度。

如果想禁用这个功能，使用下面的代码：

```
tableView.estimatedRowHeight = 0;
tableView.estimatedSectionHeaderHeight = 0;
tableView.estimatedSectionFooterHeight = 0;
```

## seperatorInset

在 iOS 11 之前，seperatorInset 是根据 readable content guide 来改变的，而 iOS 11 之后，seperatorInset 则是根据 UITableView 本身 Cell 的边缘来改变了。

```
tableview.seperatorInsetReference
```

.fromCell 和 .fromAutomaticInsets

## Swipe 操作

iOS 11 新增了如下几个特性：

- 