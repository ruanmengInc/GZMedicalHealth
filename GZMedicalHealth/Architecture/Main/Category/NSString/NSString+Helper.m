//
//  NSString+Helper.m
//  02.用户登录&注册
//
//  Created by 刘凡 on 13-11-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "NSString+Helper.h"
#import <sys/utsname.h>

@implementation NSString (Helper)
/**
 *将对象转成json
 */
+(NSString *)JsonStringForObject:(id)object{
    if (!object) {
        return nil;
    }
    NSData *dataStr = [NSJSONSerialization dataWithJSONObject:object options:NSJSONWritingPrettyPrinted error:nil];
    NSString *st = [[NSString alloc]initWithData:dataStr encoding:NSUTF8StringEncoding];
    return st;
}
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds
{
    if (seconds<=0) {
        return @"00:00:00";
    }
    //format of hour
    NSString *str_hour = [NSString stringWithFormat:@"%02ld",(long)seconds/3600];
    //format of minute
    NSString *str_minute = [NSString stringWithFormat:@"%02ld",(long)(seconds%3600)/60];
    //format of second
    NSString *str_second = [NSString stringWithFormat:@"%02ld",(long)seconds%60];
    //format of time
    NSString *format_time = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_minute,str_second];
    
    if ([str_hour integerValue]>24) {
       
        format_time = [NSString stringWithFormat:@"%@天%02ld:%@:%@", [NSNumber numberWithInteger:[str_hour integerValue] /24],(long)[str_hour integerValue]%24,str_minute,str_second];
    }

    return format_time;
}
-(NSString *)EmptyStringByWhitespace{
    NSString *str=@"";
    if (self && self.length>0) {
        str=[self stringByReplacingOccurrencesOfString:@"<null>" withString:@""];
        str=[str stringByReplacingOccurrencesOfString:@"(null)" withString:@""];
    }
    return [str trimString];
}
#pragma mark - Get请求转换
-(NSString *)getRequestString{
    if ([self isEmptyString])
    {
        return [@"" stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    }

    return [self stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLPathAllowedCharacterSet]];
    //[self stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
}
#pragma mark 清空字符串中的空白字符
- (NSString *)trimString
{
    NSString *trim=[self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return [trim stringByReplacingOccurrencesOfString:@" " withString:@""];
}
#pragma mark 段前空两格
-(NSString *)emptyBeforeParagraph
{
    NSString *content=[NSString stringWithFormat:@"\t%@",self];
    content=[content stringByReplacingOccurrencesOfString:@"\r\n" withString:@""];
    return [content stringByReplacingOccurrencesOfString:@"\n" withString:@"\n\t"];
}
#pragma mark 是否空字符串
- (BOOL)isEmptyString
{
    return (!self || self.length <1  || [self isEqualToString:@"(null)"] || [self isEqualToString:@"<null>"]);
}

#pragma mark 返回沙盒中的文件路径
- (NSString *)documentsPath
{
    NSString *path = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    return [path stringByAppendingString:self];
}

#pragma mark 写入系统偏好
- (void)saveToNSDefaultsWithKey:(NSString *)key
{
    [[NSUserDefaults standardUserDefaults] setObject:self forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
#pragma mark 读出系统偏好
+ (NSString *)readToNSDefaultsWithKey:(NSString *)key
{
   return  [[NSUserDefaults standardUserDefaults] objectForKey:key];
}
#pragma mark 邮箱验证 MODIFIED BY HELENSONG
-(BOOL)isValidateEmail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}
#pragma mark  银行账号判断
-(BOOL)isValidateBank
{
    NSString *bankNo=@"^\\d{16}|\\d{19}+$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",bankNo];
    //    NSLog(@"phoneTest is %@",phoneTest);
    return [phoneTest evaluateWithObject:self];
}
#pragma mark 手机号码验证 MODIFIED BY HELENSONG
-(BOOL) isValidateMobile
{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((1[3578][0-9])|(14[57])|(17[0678]))\\d{8}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark- 判断是否是手机号或固话
-(BOOL) isValidateMobileAndTel{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((\\d{7,8})|(0\\d{2,3}\\d{7,8})|(1[34578]\\d{9}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark-  判断是否是手机号或固话或400

-(BOOL) isValidateMobileAndTelAnd400{
    if ([self isEmptyString]) {
        return NO;
    }
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^((\\d{7,8})|(0\\d{2,3}\\d{7,8})|(1[34578]\\d{9})|(400\\d{7}))$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    
    return [phoneTest evaluateWithObject:self];
}
#pragma mark 身份证号
+ (BOOL)judgeIdentityStringValid:(NSString *)identityString {
    
    if (identityString.length != 18) return NO;
    // 正则表达式判断基本 身份证号是否满足格式
    NSString *regex = @"^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$";
    //  NSString *regex = @"^(^[1-9]\\d{7}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}$)|(^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])((\\d{4})|\\d{3}[Xx])$)$";
    NSPredicate *identityStringPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    //如果通过该验证，说明身份证格式正确，但准确性还需计算
    if(![identityStringPredicate evaluateWithObject:identityString]) return NO;
    
    //** 开始进行校验 *//
    
    //将前17位加权因子保存在数组里
    NSArray *idCardWiArray = @[@"7", @"9", @"10", @"5", @"8", @"4", @"2", @"1", @"6", @"3", @"7", @"9", @"10", @"5", @"8", @"4", @"2"];
    
    //这是除以11后，可能产生的11位余数、验证码，也保存成数组
    NSArray *idCardYArray = @[@"1", @"0", @"10", @"9", @"8", @"7", @"6", @"5", @"4", @"3", @"2"];
    
    //用来保存前17位各自乖以加权因子后的总和
    NSInteger idCardWiSum = 0;
    for(int i = 0;i < 17;i++) {
        NSInteger subStrIndex = [[identityString substringWithRange:NSMakeRange(i, 1)] integerValue];
        NSInteger idCardWiIndex = [[idCardWiArray objectAtIndex:i] integerValue];
        idCardWiSum+= subStrIndex * idCardWiIndex;
    }
    
    //计算出校验码所在数组的位置
    NSInteger idCardMod=idCardWiSum%11;
    //得到最后一位身份证号码
    NSString *idCardLast= [identityString substringWithRange:NSMakeRange(17, 1)];
    //如果等于2，则说明校验码是10，身份证号码最后一位应该是X
    if(idCardMod==2) {
        if(![idCardLast isEqualToString:@"X"]||[idCardLast isEqualToString:@"x"]) {
            return NO;
        }
    }
    else{
        //用计算出的验证码与最后一位身份证号码匹配，如果一致，说明通过，否则是无效的身份证号码
        if(![idCardLast isEqualToString: [idCardYArray objectAtIndex:idCardMod]]) {
            return NO;
        }
    }
    return YES;
}

#pragma mark 车牌号验证 MODIFIED BY HELENSONG
-(BOOL) isValidateCarNo
{
    NSString *carRegex = @"^[A-Za-z]{1}[A-Za-z_0-9]{5}+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",carRegex];
    NSLog(@"carTest is %@",carTest);
    return [carTest evaluateWithObject:self];
}

#pragma mark 车型号
- (BOOL) isValidateCarType
{
    NSString *CarTypeRegex = @"^[\u4E00-\u9FFF]+$";
    NSPredicate *carTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",CarTypeRegex];
    return [carTest evaluateWithObject:self];
}
#pragma mark 用户名
- (BOOL) isValidateUserName
{
    NSString *userNameRegex = @"^[A-Za-z0-9]{3,20}+$";
    NSPredicate *userNamePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",userNameRegex];
    return [userNamePredicate evaluateWithObject:self];
}
#pragma mark 密码
-(BOOL) isValidatePassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9~!@#$%^&*.]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark - 支付密码
-(BOOL)isPayPassword{
    NSString *passWordRegex = @"^[0-9]{6}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark 昵称
- (BOOL) isValidateNickname
{
    NSString *nicknameRegex = @"^[a-zA-Z0-9\u4e00-\u9fa5]{1,6}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",nicknameRegex];
    return [passWordPredicate evaluateWithObject:self];
}
#pragma mark - 判断汉子
-(BOOL)isChinese{
    NSString *match=@"(^[\u4e00-\u9fa5]+$)";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
/**
 *正整数
 */
-(BOOL)isNSInteger{
    NSString *match=@"^[1-9]/d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
/**
 *正小数
 */
-(BOOL)isDouble{
   NSString *match=@"^[1-9]/d*/./d*|0/./d*[1-9]/d*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF matches %@", match];
    return [predicate evaluateWithObject:self];
}
#pragma mark - 字符串转日期
- (NSDate *)dateFromString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
      [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    //[dateFormatter setDateFormat: @"MM/dd/yyyy HH:mm:ss"];
   // NSTimeZone * timeZone = [NSTimeZone timeZoneWithName: @"Asia/Shanghai"];
   // [dateFormatter setTimeZone: timeZone];
    NSDate *destDate= [dateFormatter dateFromString:self];
    if (!destDate) {
          [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm"];
        destDate= [dateFormatter dateFromString:self];
    }
    return destDate;
}
#pragma mark - 日期转字符串
+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;
}
#pragma mark - 手机号加密
/**
 *手机号加密
 */
-(NSString *)EncodeTel{
    NSString *Tel=self;
    if (Tel.length>7) {
         Tel=[Tel stringByReplacingCharactersInRange:NSMakeRange(3,Tel.length-7) withString:@"****"];
    }
   
    return Tel;
}
#pragma mark - 银行卡号加密
/**
 *银行卡号加密
 *
 */
-(NSString *)EncodeBank{
    NSString *Bank=self;
    if (Bank.length>4) {
         Bank=[Bank stringByReplacingCharactersInRange:NSMakeRange(0,Bank.length-4) withString:@"**** **** **** "];
    }
    return Bank;
}
#pragma mark - code 转 msg
/**
 *code 转 msg
 */
+(NSString *)GetMsgByCode:(NSString *)code{
    return [code isEqualToString:@"0"]?@"修改成功":@"修改失败";
}

#pragma mark - 汉字转拼音
/**
 汉字转拼音
 */
+ (NSString *)transform:(NSString *)chinese{
    
    NSMutableString *str = [chinese mutableCopy];
    
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformMandarinLatin,NO);
    
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)str,NULL, kCFStringTransformStripDiacritics,NO);
    
    NSString *Uppter=[NSString stringWithFormat:@"%@",[str uppercaseString]];
    return  [Uppter stringByReplacingOccurrencesOfString:@" " withString:@""];
}

#pragma mark - 获取某个字符串或者汉字的首字母
/**
 获取某个字符串或者汉字的首字母.
 */
+ (NSString *)firstCharactorWithString:(NSString *)string
{
    NSMutableString *str = [NSMutableString stringWithString:string];
    CFStringTransform((CFMutableStringRef) str, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((CFMutableStringRef)str, NULL, kCFStringTransformStripDiacritics, NO);
    NSString *pinYin = [str capitalizedString];
    return [pinYin substringToIndex:1];
}

#pragma mark - 判断字符串为@"" 和 为 nil
/**
 判断字符串为@"" 和 为 nil
 */
+ (BOOL)judgeEmptyAndSpaces:(NSString *)string
{
    if([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]length]==0) {
        
        return YES;
    }else
    {
        return NO;
    }
}

/**
 获取当前时间戳
 */
+ (NSString *)getNowTimeTimestamp{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]];
    
    return timeSp;
    
}

//获取当前时间戳 13位 （以毫秒为单位）
+(NSString *)getNowTimeTimestamp13{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    
    [formatter setDateStyle:NSDateFormatterMediumStyle];
    
    [formatter setTimeStyle:NSDateFormatterShortStyle];
    
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss SSS"]; // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    //设置时区,这个对于时间的处理有时很重要
    
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"UTC"];
    
    [formatter setTimeZone:timeZone];
    
    NSDate *datenow = [NSDate date];//现在时间,你可以输出来看下是什么格式
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[datenow timeIntervalSince1970]*1000];
    
    return timeSp;
    
}

+ (NSString *)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSASCIIStringEncoding];

    if ([platform isEqualToString:@"iPhone6,1"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone6,2"]) return @"iPhone 5s";
    
    if ([platform isEqualToString:@"iPhone7,1"]) return @"iPhone 6 Plus";
    
    if ([platform isEqualToString:@"iPhone7,2"]) return @"iPhone 6";
    
    if ([platform isEqualToString:@"iPhone8,1"]) return @"iPhone 6s";
    
    if ([platform isEqualToString:@"iPhone8,2"]) return @"iPhone 6s Plus";
    
    if ([platform isEqualToString:@"iPhone8,4"]) return @"iPhone SE";
    
    if ([platform isEqualToString:@"iPhone9,1"]) return @"iPhone 7";
    
    if ([platform isEqualToString:@"iPhone9,2"] || [platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus";
    
    if ([platform isEqualToString:@"iPhone10,1"] || [platform isEqualToString:@"iPhone10,4"])    return @"iPhone 8";
    
    if ([platform isEqualToString:@"iPhone10,2"] || [platform isEqualToString:@"iPhone10,5"])    return @"iPhone 8 Plus";
    
    if ([platform isEqualToString:@"iPhone10,3"] || [platform isEqualToString:@"iPhone10,6"])    return @"iPhone X";
    
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

+(NSString*) removeLastOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringToIndex:([origin length]-1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    return cutted;
}

+(NSString*) removeFirstOneChar:(NSString*)origin
{
    NSString* cutted;
    if([origin length] > 0){
        cutted = [origin substringFromIndex:(1)];// 去掉最后一个","
    }else{
        cutted = origin;
    }
    
    return cutted;
}

#pragma mark - 将时间戳转化为 秒s
+ (NSString *)updateTimeForRow:(NSString *)createTimeString {
    // 获取当前时时间戳 1466386762.345715 十位整数 6位小数
    NSTimeInterval currentTime = [[NSDate date] timeIntervalSince1970];
    
    // 创建后台反的时间戳(后台返回的时间 一般是13位数字)
    NSTimeInterval createTime = [createTimeString longLongValue]/1000;
    
    // 时间差
    NSTimeInterval time = currentTime - createTime;
    
    NSInteger sec = time/60/60;
    
    return [NSString stringWithFormat:@"%ld",sec];
}

#pragma mark - 获取当前年
+(NSString*)getCurrentTimesYear{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    // ----------设置你想要的格式,hh与HH的区别:分别表示12小时制,24小时制
    
    [formatter setDateFormat:@"YYYY"];
    
    //现在时间,你可以输出来看下是什么格式
    
    NSDate *datenow = [NSDate date];
    
    //----------将nsdate按formatter格式转成nsstring
    
    NSString *currentTimeString = [formatter stringFromDate:datenow];
    
    return currentTimeString;
}

#pragma mark - 数组转Json,去掉\n
+ (NSString *)jsonFromArray:(NSArray *)aArray
{
    
    NSData *data=[NSJSONSerialization dataWithJSONObject:aArray
                                                 options:NSJSONWritingPrettyPrinted
                                                   error:nil];
    
    if (data == nil) {
        
        return nil;
    }
    
    NSString *str=[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    str = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]]; //去除掉首尾的空白字符和换行字符
    
    str = [str stringByReplacingOccurrencesOfString:@"\t" withString:@""];
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    return str;
    
}

+ (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
