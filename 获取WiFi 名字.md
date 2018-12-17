# 获取WiFi 名字
比如 WiFi 的 SSID（即 WiFi 的名称），WiFi 的 BSSID（即 WiFi 的路由器的 Mac 地址）
//引用头文件<SystemConfiguration/CaptiveNetwork.h>

```
- (NSDictionary*)requestWiFiinfo {
    CFArrayRef wifis = CNCopySupportedInterfaces();
    if (!wifis || CFArrayGetCount(wifis) == 0) {
        return nil;
    }
    NSArray *interfaces = (__bridge_transfer NSArray *)wifis;
    NSDictionary *info = nil;
    for (NSString *name in interfaces) {
        info = (__bridge_transfer NSDictionary *)CNCopyCurrentNetworkInfo((__bridge CFStringRef)name);
    }
    if (info == nil) {
        return nil;
    }
    NSString *ssid = info[@"SSID"];
    NSString *bssid = info[@"BSSID"];
    NSLog(@"WiFi Name : %@, WiFi Nac Address : %@",ssid,bssid);
    return info;
}

```
在 Xcode 10（iOS 12）之前，上述代码可以正常运行取到结果，但当升级到 Xcode 10 后编译工程在 iOS 12 上运行时，同样的代码却无法取得 WiFi 的信息。通过断点调试发现 CNCopyCurrentNetworkInfo(...) 函数总是返回 nil，查阅官方 API 文档，发现该函数的描述多了一条重要提示，
大致意思是说：在 iOS 12 及以上系统调用该方法时，需要先在 Xcode 工程中授权获取 WiFi 信息的能力，开启路径为：Xcode -> [Project Name] -> Targets -> [Target Name] -> Capabilities -> Access WiFi Information -> ON，设置完毕后，我们可以发现在工程的 .entitlements 文件会多了一对键值：

Access WiFi Information => YES

至此，我们就可以正常在 iOS 12+ 中获取 WiFi 的信息了。
# SecRandomCopyBytes 生成伪随机数

在iOS中，生成伪随机数可以使用这么几个函数：rand()、random()、arc4random()。另外我们知道随机数是密码技术的核心部分，所以 Apple 也为我们提供了相应的生成随机数的方法，即 SecRandomCopyBytes，这个方法位于 Security.framework 中，所以使用时需要先导入这个库，使用的方法如下：

`
```
+ (NSString *)generateRandom {

    static int size = 8;
    uint8_t randomBytes[size];
    int result = SecRandomCopyBytes(kSecRandomDefault, size, randomBytes);
    if (result == errSecSuccess) {
        NSMutableString *randomString = [[NSMutableString alloc] initWithCapacity:size * 2];
        for (int i = 0; i < size; i++) {
            [randomString appendFormat:@"%02x", randomBytes[i]];
        }

        return randomString;
    } else {
        return nil;
    }
}


````
这里我们生成一个 8 字节长的uint8_t数组，然后将其转换成 hex 字符串得到一个长度16的随机字条串。另外这个函数也可以作为生成 UUID 的辅助操作，如下代码所示：


```
+ (NSString*)generateCryptoSecureUUID
{
    unsigned char bytes[16];
    int result = SecRandomCopyBytes(kSecRandomDefault, 16, bytes);
    if (result != noErr) {
        return nil;
    }
    return [[NSUUID alloc] initWithUUIDBytes:bytes].UUIDString;
}


```

