# JSAlertView
 custom AlertView based on table view
 
 
 JSAlertView *alert = [[JSAlertView alloc] initTitleWithMessages:@"" message:@[@"LargeMessage1", @"MiddleMessage2"] buttons:@[@"Cancel", @"OK"]];
 \n
 [alert setOnButtonAction:^(JSAlertView *alertView, NSInteger index) {\n
   if (index == 0) {\n
      NSLog(@"Cancel");\n
    }\n
    else {\n
      NSLog(@"ok");\n
    }\n
 }];\n
 \n
 [alert show];
