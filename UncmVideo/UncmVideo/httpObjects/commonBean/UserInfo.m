//
// Created by xinyingtiyu on 13-3-22.
//
// To change the template use AppCode | Preferences | File Templates.
//


#import "UserInfo.h"
#import "JSON.h"


@implementation UserInfo
@synthesize UUID,username,phone,email,passwd,addtime,regtype,operatorid,paytype,ispay,paytime;

-(NSString *)getJsonStr{
    NSString *jsonStr = [[[NSString alloc] initWithFormat:
            @"{\n"
                    " \"userInfo\":{\n"
                    "\t\"UUID\":\"%@\",\n"
                    "\t\"username\":\"%@\",\n"
                    "\t\"phone\":\"%@\",\n"
                    "\t\"email\":\"%@\",\n"
                    "\t\"passwd\":\"%@\",\n"
                    "\t\"addtime\":\"%@\",\n"
                    "\t\"regtype\":\"%@\"\n"
                    "\t\"operatorid\":\"%@\",\n"
                    "    \"paytype\":\"%@\",\n"
                    "    \"ispay\":\"%@\",\n"
                    "    \"paytime\":\"%@\"\n"
                    " }\n"
                    "}",UUID,username,phone,email,passwd,
            addtime,regtype,operatorid,paytype,ispay,
            paytime

    ] autorelease];
    return jsonStr;
}
-(UserInfo *)initWithJsonStr:(NSString *)jsonStr{
    [super init];
    NSDictionary *dictionary = [jsonStr JSONValue];
    UUID = [dictionary objectForKey:@"UUID"];
    username = [dictionary objectForKey:@"username"];
    phone = [dictionary objectForKey:@"phone"];
    email = [dictionary objectForKey:@"email"];
    passwd = [dictionary objectForKey:@"passwd"];

    addtime = [dictionary objectForKey:@"addtime"];
    regtype = [dictionary objectForKey:@"regtype"];
    operatorid = [dictionary objectForKey:@"operatorid"];
    paytype = [dictionary objectForKey:@"paytype"];
    ispay = [dictionary objectForKey:@"ispay"];

    paytime = [dictionary objectForKey:@"paytime"];

    return self;
}

- (void)dealloc {
    [UUID release];
    [username release];
    [phone release];
    [email release];
    [passwd release];
    [addtime release];
    [regtype release];
    [operatorid release];
    [paytype release];
    [ispay release];
    [paytime release];
    [super dealloc];
}


@end