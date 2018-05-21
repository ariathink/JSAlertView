# JSAlertView
 custom AlertView based on table view
 
 
 **Objective-C**
 
 JSAlertView *alert = [[JSAlertView alloc] initTitleWithMessages:@"" message:@[@"LargeMessage1", @"MiddleMessage2"] buttons:@[@"Cancel", @"OK"]];</p>

 [alert setOnButtonAction:^(JSAlertView *alertView, NSInteger index) {</p>
   if (index == 0) {</p>
        NSLog(@"Cancel");</p>
    }</p>
    else {</p>
        NSLog(@"ok");</p>
    }</p>
 }];</p>
 </p>
 [alert show];
