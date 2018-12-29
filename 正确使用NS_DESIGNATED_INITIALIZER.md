# 正确使用NS_DESIGNATED_INITIALIZER

Objective-C 中主要通过 **NS_DESIGNATED_INITIALIZER** 宏来实现指定构造器的。这里之所以要用这个宏，往往是想告诉调用者要用这个方法去初始化（构造）类对象。
怎样避免使用NS_DESIGNATED_INITIALIZER产生的警告

如果子类指定了新的初始化器，那么在这个初始化器内部必须调用父类的 Designated Initializer。并且需要重写父类的 Designated Initializer，将其指向子类新的初始化器。

如下：

```
// .h
- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;
  
// .m
- (instancetype)init
{
    return [self initWithName:@""];
}
 
- (instancetype)initWithName:(NSString *)name
{
    self = [super init];
    if (self) {
        // do something
    }
    return self;
}
```
更好的做法

如果定义NS_DESIGNATED_INITIALIZER，大多是不想让调用者调用父类的初始化函数，只希望通过该类指定的初始化进行初始化，这时候就可以用NS_UNAVAILABLE宏。

如下：
// .h
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithName:(NSString *)name NS_DESIGNATED_INITIALIZER;

如果调用者使用init 初始化，编译器就会给出一个编译错误 ‘init is unvailable’。使用NS_UNAVAILABLE后，就不需要在.m中重写父类初始化函数了。如果要允许调用者使用init,.h文件里去掉方法~~- (instancetype)init NS_UNAVAILABLE;~~，同时.m文件中重写父类的初始化函数，否则就会报警告。


