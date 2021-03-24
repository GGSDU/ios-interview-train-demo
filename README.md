# ios-interview-train-demo

### 父类、子类、Category类都实现了load方法，那么load的加载顺序是如何呢？

#### 1.结论:

* `+load`方法是在加载类和分类时系统调用，一般不手动调用，如果想要在类或分类加载时做一些事情，可以重写类或者分类的+load方法方法。
* 每个类、分类的+load，在程序运行过程中只调用一次。

#### 2.调用顺序:

* 类要优先于分类调用+load方法；
* 子类调用+load方法时，要先要调用父类的+load方法；(父类优先与子类，与继承不同)；
* 不同的类按照编译先后顺序调用+load方法（先编译，先调用）；
* 分类的按照编译先后顺序调用+load方法（先编译，先调用）。

#### 3.原因分析:

那么是什么原因导致所有的父类，子类的load执行顺序会先与Category中的load呢？带着这个疑问，进入到runtime底层去找找

![将要加载load方法时调用](https://upload-images.jianshu.io/upload_images/10517766-a6b1645e24358654.png?imageMogr2/auto-orient/strip|imageView2/2/w/1036/format/webp)

图6:将要加载load方法时调用

runtime会调用prepare_load_methods方法准备好要被调用的+(void)load方法，具体方法实现见图6；

其中：

```objective-c
classref_t *classlist = _getObjc2NonlazyClassList(mhdr, &count); //类列表

category_t **categorylist = _getObjc2NonlazyCategoryList(mhdr, &count); //分类列表
```

![调度类的load方法](https://upload-images.jianshu.io/upload_images/10517766-cb05b7fd63bf19c7.png?imageMogr2/auto-orient/strip|imageView2/2/w/1040/format/webp)

图7：调度类的load方法

其中：

 **schedule_class_load(cls->superclass); //在调度类的load方法前，要先跳用父类的load方法（递归），决定了父类优先于子类调用**

add_class_to_loadable_list(cls); //添加到能够加载的类的列表中

当prepare_load_methods函数执行完之后，所有满足+load方法调用条件的类和分类就被分别保持在全局变量中；

![call_lod_methods](https://upload-images.jianshu.io/upload_images/10517766-8b2b9996738757be.png?imageMogr2/auto-orient/strip|imageView2/2/w/1042/format/webp)

图8：call_lod_methods

当prepare_load_methods执行完，准备好类和分类后，就该调用他们的+load方法啦，在call_load_methods中进行调用；注意图中红色圈内部分，两个关键函数：call_class_loads()，call_category_loads() ；看到这两个函数想到了什么呢？

对，就是这两个函数决定了类优先与分类调用+load方法；

说明：+load方法是系统根据方法地址直接调用，并不是objc_msgSend函数调用（isa，superClass）；这就决定了如果子类没有实现+load方法，那么当它被加载时runtime是不会调用父类的+load方法的，除非父类也实现了+load方法；