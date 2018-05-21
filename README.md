# JSAlertView
 custom AlertView based on table view
 
 
 JSAlertView *alert = [[JSAlertView alloc] initTitleWithMessages:@"" message:@[@"LargeMessage1", @"MiddleMessage2"] buttons:@[@"Cancel", @"OK"]];</p>

 [alert setOnButtonAction:^(JSAlertView *alertView, NSInteger index) {</p>
   if (index == 0) {
      NSLog(@"Cancel");
    }
    else {
      NSLog(@"ok");
    }
 }];
 
 [alert show];
