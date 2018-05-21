# JSAlertView
 custom AlertView based on table view
 
 </p></p></p>
**ObjectiveC** </p></p>
 
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
</p></p></p>


**Swift** </p></p>
let alert = JSAlertView.init(titleWithMessages: "", messages: ["LargeMessage", "MiddleMessage"], buttons:["OK"]) </p>
alert?.delegate = self</p>
alert?.show()</p>
</p></p>
*JSAlertViewDelegate*

func didSelectButtonIndex(_ alert:JSAlertView!, index: Int) {</p>

}
