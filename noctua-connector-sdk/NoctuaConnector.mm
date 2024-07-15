
//
#define VERSION_CODE @"3"
#import "NoctuaConnector.h"
#import <Foundation/Foundation.h>

#define TargetObject "Hypercasual"  /*自行设置需要通知的对象（U3D）*/
#define TargetMethod "changeString" /*通知对象的具体方法*/

#ifndef TargetObject
#error 需要设置发送对象
#endif
#ifndef TargetMethod
#error 需要设置处理方法
#endif

#define Send_Message(methodName,msg)     UnitySendMessage(TargetObject, methodName, msg) /*向U3D发送消息*/

#if defined(__cplusplus)
extern "C" {
extern NSString* CreateNSString (const char* string);
extern NSDictionary* CreateDictionaryFromJsonStr(const char* string);
extern void QKAlertView(const char* title,const char* message);
extern void UnitySendMessage(const char *, const char *, const char *);
#endif

#pragma mark - SDK 平台接口调用

void init() {
    
    //设置回调
    [REDeLoginKit setFunctionLoginCallback:[NoctuaConnector shareInstance]];
    [REDeLoginKit setFunctionBuyCallback:[NoctuaConnector shareInstance]];
    [REDeLoginKit restoreNonConsumptionProducts:[NoctuaConnector shareInstance]];
    
}
//MARK: Unified Track
void trackEvent(const char* eventName, const char* extraParams) {
    [REDeLoginKit trackEvent:CreateNSString(eventName) andWithParam:CreateDictionaryFromJsonStr(extraParams)];
}

void trackPurchaseEvent(const char* orderId, float money, const char* currency, const char* extraParams) {
    [REDeLoginKit trackPurchaseEvent:CreateNSString(orderId) purchaseAmount:money currency:CreateNSString(currency) andWithParam:CreateDictionaryFromJsonStr(extraParams)];
}

//MARK: Firebase SDK
void logEventWithName(const char* eventName, const char* paramDict) {
    [REDeLoginKit logEventWithName:CreateNSString(eventName) andWithParam:CreateDictionaryFromJsonStr(paramDict)];
}

void logGetVirualCurrencyWithCurrencyName(const char* currencyName, const char* value) {
    [REDeLoginKit logGetVirualCurrencyWithCurrencyName:CreateNSString(currencyName) andWithValue:CreateNSString(value)];
}

void logJoinGroupWithGroupId(const char* groudID) {
    [REDeLoginKit logJoinGroupWithGroupId:CreateNSString(groudID)];
}

void logLevelUpWithLevel(const char* level, const char* character) {
    [REDeLoginKit logLevelUpWithLevel:CreateNSString(level) andWithCharacter:CreateNSString(character)];
}

void logSpendVirtualCurrencyWithItemName(const char* itemName, const char* currencyName, const char* value) {
    [REDeLoginKit logSpendVirtualCurrencyWithItemName:CreateNSString(itemName) andWithVirtualCurrencyName:CreateNSString(currencyName) andWithValue:CreateNSString(value)];
}

void logTutorialBegin() {
    [REDeLoginKit logTutorialBegin];
}

void logTurorialComplete() {
    [REDeLoginKit logTurorialComplete];
}

//MARK: Facebook SDK
void shareWith(const char* serverID, const char* roleID) {
    [REDeLoginKit shareWith:CreateNSString(serverID) roleId:CreateNSString(roleID)];
}

void fbSharePhoto(UIImage* image, const char* caption, const char* tag) {
    [REDeLoginKit fbSharePhoto:image caption:CreateNSString(caption) tag:CreateNSString(tag) completeWithResults:^(NSError *error, NSInteger status) {
        if (status == 0) {
            Send_Message("onFBSharePhoto","Success");
        }else if(status == 1) {
            Send_Message("onFBSharePhoto", "Error FB Share Photo");
        }else{
            Send_Message("onFBSharePhoto","Cancel");
        }
    }];
}

void fbShareUrlPhoto(const char* imageUrl, const char* caption, const char* tag) {
    [REDeLoginKit fbShareUrlPhoto:CreateNSString(imageUrl) caption:CreateNSString(caption) tag:CreateNSString(tag) completeWithResults:^(NSError *error, NSInteger status) {
        if (status == 0) {
            Send_Message("onFBSharePhoto","Success");
        }else if(status == 1) {
            Send_Message("onFBSharePhoto", "Error FB Share Photo");
        }else{
            Send_Message("onFBSharePhoto","Cancel");
        }
    }];
}

void fbShareUrl(const char* urlString, const char* quote, const char* tag) {
    [REDeLoginKit fbShareUrl:CreateNSString(urlString) quote:CreateNSString(quote) tag:CreateNSString(tag) completeWithResults:^(NSError *error, NSInteger status) {
        if (status == 0) {
            Send_Message("onFBSharePhoto","Success");
        }else if(status == 1) {
            Send_Message("onFBSharePhoto", "Error FB Share Photo");
        }else{
            Send_Message("onFBSharePhoto","Cancel");
        }
    }];
}

void fblogCompleteTutorialEvent(const char* contentData, const char* contentId, bool success) {
    [REDeLoginKit logCompleteTutorialEvent:CreateNSString(contentData) contentId:CreateNSString(contentId) success:success];
}

void fbLogAchieveLevelEvent(const char* level) {
    [REDeLoginKit logAchieveLevelEvent:CreateNSString(level)];
}

void fbLogPurchase(double purchaseAmount, const char* currency, const char *parameters) {
    [REDeLoginKit logPurchase:purchaseAmount currency:CreateNSString(currency) parameters:CreateDictionaryFromJsonStr(parameters)];
}

void fbLogUnlockAchievementEvent(const char* description, const char* type) {
    [REDeLoginKit logUnlockAchievementEvent:CreateNSString(description) type:CreateNSString(type)];
}

void fbLogInitiateCheckoutEvent(const char* contentData, const char* contentId, const char* contentType, NSInteger numItems, BOOL paymentInfoAvailable, const char* currency, double totalPrice) {
    [REDeLoginKit logInitiateCheckoutEvent:CreateNSString(contentData) contentId:CreateNSString(contentId) contentType:CreateNSString(contentType) numItems:numItems paymentInfoAvailable:paymentInfoAvailable currency:CreateNSString(currency) valueToSum:totalPrice];
}

void fbLogEvent(const char* eventName, double valueToSum, const char* parameters) {
    [REDeLoginKit logEvent:CreateNSString(eventName) valueToSum:valueToSum parameters:CreateDictionaryFromJsonStr(parameters)];
}

//MARK: Adjust SDK
void adjustRegisterCompleted(const char* token) {
    [REDeLoginKit adjustRegisterCompleted:CreateNSString(token)];
}

void adjLoginSuccess(const char* token) {
    [REDeLoginKit adjLoginSuccess:CreateNSString(token)];
}

void adjFinishBeginnerGuide(const char* token) {
    [REDeLoginKit adjFinishBeginnerGuide:CreateNSString(token)];
}

void adjCreateRoleDone(const char* token) {
    [REDeLoginKit adjCreateRoleDone:CreateNSString(token)];
}

void adjPurchaseFinish(const char* token, float money, const char* currency, const char* extraParam) {
    [REDeLoginKit adjPurchaseFinish:CreateNSString(token) revenue:money currency:CreateNSString(currency) extraParameters:CreateDictionaryFromJsonStr(extraParam)];
}

void adjTrackEventWithToken(const char* token) {
    [REDeLoginKit adjTrackEventWithToken:CreateNSString(token)];
}

//In Game Pop Up
void showGameTaskCenterAccountID(const char* accountId, const char* serverID, const char* redirectType) {
//    [REDeLoginKit showGameTaskCenterAccountID:CreateNSString(accountId) serverID:CreateNSString(serverID) redirectType:CreateNSString(redirectType)];
}

//Submit task event (Quest System)
void logTaskEvent(const char* eventName, const char* eventValue) {
    [REDeLoginKit logTaskEvent:CreateNSString(eventName) eventValue:CreateNSString(eventValue) completeResults: ^(NSString * msg, NSInteger status) {
        if (status == 0) {
            Send_Message("onLogTaskEvent","Success");
        }else{
            Send_Message("onLogTaskEvent","Failed");
        }
    }];
}

//显示登陆界面
void login(BOOL isShowMenu){
    [REDeLoginKit loginWithMenuShow:isShowMenu];
}
//静默登录不显示登陆界面
void fastStartGame(){
    [REDeLoginKit fastlyStartGame];
}
//注销登陆
void logout(){
    [REDeLoginKit logout];
}

//显示个人中心
void userCenter(){
    [REDeLoginKit enterUserCenter];
}
//获取三方绑定信息
void getUserBindInfo(){
    NSDictionary * resultDict = [REDeLoginKit getUserBindInfo];
    NSError *parseError = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:resultDict options:NSJSONWritingPrettyPrinted error:&parseError];
    NSString *jsonStr = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    Send_Message("getUserBindInfo",jsonStr.UTF8String);
}
//进入三方绑定界面
void bindAccount(){
    [REDeLoginKit bandAccount];
}
//绑定三方账号
void bindAccountWithType(USERCENTER_TYPE type) {
    [REDeLoginKit bindAccountType:type];
}
//解绑三方账号
void unnbindAccountWithType(USERCENTER_TYPE type){
    [REDeLoginKit unbindAccount:type];
}
//删除当前登录账号，游客登录没有此功能
void accountDeletion(){
    [REDeLoginKit accountDeletion];
}
//显示悬浮窗
void showMenu(){
    [REDeLoginKit showFloatButtonIsLeft:(true) buttonOriginalY:(50)];
}
//隐藏悬浮窗
void dismissMenu(){
    [REDeLoginKit dismissMenu];
}

void setRoleInfo(const char *serverName,const char *serverId,const char *roleId,const char *roleName,const char *roleLevel,const char *roleVipLevel){
    REDeRoleInfo * role = [[REDeRoleInfo alloc]init];
    role.server_name = CreateNSString(serverName);
    role.server_id = CreateNSString(serverId);
    role.game_role_name = CreateNSString(roleName);
    role.game_role_id = CreateNSString(roleId);
    role.game_role_level = CreateNSString(roleLevel);
    role.vip_level = CreateNSString(roleVipLevel);
    [REDeLoginKit setGameRoleInfo:role];
}

void congzi(const char *productId,const char *productName,NSString* amount,const char *orderNo,const char *callBackUrl,const char *extrasParams){
    
    REDeOrderInfo *param = [[REDeOrderInfo alloc] init];
    param.productId = CreateNSString(productId);    ///设置商品ID，苹果后台对应的productID
    param.subject = CreateNSString(productName);    ///商品名称 必填
    param.total = amount;                       ///商品总价 必填
    param.product_order_no = CreateNSString(orderNo);       ///游戏方订单号 string[64] 接入QuickAd时必填、必须唯一
    param.callback_url = CreateNSString(callBackUrl);       ///回调通知地址 string[200] 可选  客户端配置优先;  可传nil
    param.extras_params = CreateNSString(extrasParams);     ///透传参数  可选
    [REDeLoginKit IAPWithParameter:param];
}

void restoreNonConsumptionProducts(){
    [REDeLoginKit restoreNonConsumptionProducts:[NoctuaConnector shareInstance]];
}

void findProductInfo(const char *productIds){
    NSString * productIdStr = CreateNSString(productIds);
    NSArray * productIdArr = nil;
    
    NSData *jsonData = [productIdStr dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON: %@", error.localizedDescription);
        productIdArr = nil;
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        productIdArr = (NSArray *)jsonObject;
    }
    
    if (productIdArr.count) {
        [REDeLoginKit findProductInfoWithProductIds:productIdArr delegate:[NoctuaConnector shareInstance]];
    } else {
        Send_Message("findProductInfo","productids is not json string");
    }
}
void QKAlertView(const char* title,const char* message)
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"\n%@\n",CreateNSString(title)] message:[NSString stringWithFormat:@"\n%@\n",CreateNSString(message)] delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
    [alertView show];
}

NSString* CreateNSString (const char* string)
{
    if (string)
        return [NSString stringWithUTF8String: string];
    else
        return [NSString stringWithUTF8String: ""];
}

NSDictionary* CreateDictionaryFromJsonStr (const char* string)
{
    NSString* jsonString = CreateNSString(string);
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dataDictionary = [NSJSONSerialization JSONObjectWithData:jsonData options:kNilOptions error:&error];
    if (error != nil) {
        NSLog(@"Error parsing JSON: %@", error.localizedDescription);
        return nil;
    }
    
    if ([dataDictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"JSON represent an dictionary.");
        return (NSDictionary *)dataDictionary;
    }
    
    NSLog(@"JSON does not represent an dictionary.");
    return  nil;
}

#if defined(__cplusplus)
}
#endif

@implementation NoctuaConnector

+(NoctuaConnector *)shareInstance{
    
    static NoctuaConnector *shareInstance = nil;
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        shareInstance = [[NoctuaConnector alloc] init];
    });
    return shareInstance;
}
//MARK: - 回调
// 初始化结果回调
- (void)qgSDKInitDone{
    // 初始化成功
    Send_Message("onInitSuccess","Init:Init Success");
}
// 登录回调
- (void)loginUid:(NSString *)uid userToken:(NSString *)token{
    NSLog(@"登录成功:\n用户ID:%@,验证码:%@",uid,token);
    NSString *param = [NSString stringWithFormat:@"%@_%@",uid,token];
    Send_Message("onLoginSuccess",param.UTF8String);
}
//绑定回调
- (void)bindUid:(NSString *)uid userToken:(NSString *)token type:(USERCENTER_TYPE)type
{
    NSString *param = [NSString stringWithFormat:@"%@_%@_%ld",uid,token,type];
    Send_Message("onBindSuccess",param.UTF8String);
}
//解绑回调
- (void)unBindUid:(NSString *)uid userToken:(NSString *)token type:(USERCENTER_TYPE)type
{
    NSString *param = [NSString stringWithFormat:@"%@_%@_%ld",uid,token,type];
    Send_Message("onUnBindSuccess",param.UTF8String);
}
//在SDK的个人中心主动退出登录
- (void)userLogout{
    NSLog(@"用户从个人中心手动登出。");
    Send_Message("onLogOut","Log out");
}
//支付结果的回调
//购买完成 内购商品Id SDK订单号
- (void)purchaseDoneProductId:(NSString *)productId orderNo:(NSString *)orderNo{
    Send_Message("onPurchaseSuc",productId.UTF8String);
}
//购买失败
- (void)purchaseFail{
    Send_Message("onPurchaseFail","");
}
//恢复非消耗商品成功，返回商品id信息
- (void)restoreSuccess:(NSArray *)products
{
    NSString *jsonStr = [self jsonStrFromArr:products];
    Send_Message("onRestoreSuccess",jsonStr.UTF8String);
}
//恢复失败
- (void)restoreFail:(NSString *)msg
{
    Send_Message("onRestoreFail",msg.UTF8String);
}
//查找商品信息成功数组元素为REDeOrderInfo实例
- (void)findProductInfoSuccess:(NSArray *)products {
    NSMutableArray * arr = [[NSMutableArray alloc]init];
    for (REDeOrderInfo * info in products) {
        //        NSLog(@"查询商品信息成功结果：商品id=%@,商品名称=%@，商品描述=%@，商品价格=%@，商品总价=%@，透传参数=%@",info.productId, info.subject, info.desc, info.price, info.total, info.extras_params);
        [arr addObject:@{@"productId":info.productId, @"productName":info.subject, @"productDesc":info.desc, @"price":info.price, @"total":info.total, @"extras_params":info.extras_params}];
    }
    NSString *jsonStr = [self jsonStrFromArr:arr];
    Send_Message("findProductInfo",jsonStr.UTF8String);
}
//查找商品信息失败
- (void)findProductInfoFail:(NSString *)msg {
    Send_Message("findProductInfo",msg.UTF8String);
}
- (NSString *)jsonStrFromArr:(NSArray *)arr {
    NSError *error = nil;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:arr options:0 error:&error];
    if ([error code]) {
        return @"";
    }
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
}

- (NSArray *)arrFromJsonStr:(NSString *)jsonString {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    
    id jsonObject = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    if (error != nil) {
        NSLog(@"Error parsing JSON: %@", error.localizedDescription);
        return nil;
    }
    
    if ([jsonObject isKindOfClass:[NSArray class]]) {
        return (NSArray *)jsonObject;
    }
    
    NSLog(@"JSON does not represent an array.");
    return nil;
}
@end
