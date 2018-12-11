# iOS textField限制字符串长度
最近在开发的时候遇到一个问题，就是需要限制TextField中输入的字符串的长度，但是不是直接根据长度限制，而是根据字符数限制，一个汉字为两个字节，数字字母为一个字符。超过字符限制则不允许继续输入并弹出toast提示。
这个问题有三个关键点：判断字符串是否超出长度，超出长度不可输入，判断字符串的字符数。

判断字符串是否超出长度

[self.txfUsername addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
 - (void)textFieldDidChange:(id)sender
{
    if (self.textField.text.length > MAXLENGTH)  // MAXLENGTH为最大字数
    {
        //超出限制字数时所要做的事
    }
}

为什么在这里要自己监听textField中文字的变化，而不直接使用textField的代理方法-(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{？
因为这个方法在中文书输入法下，只能输入一个词的情况，如果联想词是两个词，也可以输入。所以会出现误差。直接监听UIControlEventEditingChanged 是最靠谱的。

超出长度不可输入

if (self.textField.text.length > MAXLENGTH)  // MAXLENGTH为最大字数
    {
        self.textField.text = [self.txfUsername.text substringToIndex: MAXLENGTH]; // MAXLENGTH为最大字数
    }

如果超出长度，永远把前MAXLENGTH的子字符串赋给textField的text，即textField永远只显示前MAXLENGTH个字，视觉效果就是无法继续输入。

前面所有用到的MAXLENGTH均为字符串长度，不论数字字母还是汉字，最后要解决的问题就是判断字符数。

//按照中文两个字符，英文数字一个字符计算字符数
-(NSUInteger) unicodeLengthOfString: (NSString *) text {
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < text.length; i++) {
        unichar uc = [text characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

NSUInteger lenOfBytes = [text lengthOfBytesUsingEncoding:NSUTF8StringEncoding];也试过，lengthOfBytesUsingEncoding就是按照编码返回字节数，但是NSUTF8StringEncoding是按照英文一个字符，中文三个字符来编码的，NSUnicodeStringEncoding是按照英文数字汉字都是两个字符编码的，目前iOS中的编码方法都和需求不符，所以需要另外做计算。
因为自己对字符编码不了解，所以没有想到正确的办法。这个方法是在网上找了好久才找到。来源ymonke。但是在使用过程中发现返回值有问题，于是做了修改，结果如上代码。

