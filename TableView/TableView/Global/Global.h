//
//  Global.h
//  TableView
//
//  Created by shadow on 2015/1/6.
//  Copyright (c) 2015年 shadow. All rights reserved.
//

#ifndef TableView_Global_h
#define TableView_Global_h

#define UIAppDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate)

/* check mainScreenHeightIS_H568 */
#define IS_H568 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

/* Check iOSVersion */
#define IS_IOS7_And_Later ([[[[UIDevice currentDevice].systemVersion componentsSeparatedByString:@"."] objectAtIndex:0] intValue] > 6)




#endif
