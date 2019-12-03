# STJMuteSwitch
This tool is to onitoring iPhone System vibration mode.The "RBDMuteSwitch" library can not work because it get wrong file path,so i create a new library base on it.And i will ongoing maintenance.

#### Include "STJMuteSwitch.h", "STJMuteSwitch.m" and "detection.aiff" to your app.

#### Add the following to the header file where you wish to detect the mute switch.

    #import "STJMuteSwitch.h"

#### To your interface declaration add the STJMuteSwitchDelegate.

    @interface MainViewController : UIViewController <STJMuteSwitchDelegate>

#### To your implementation you can call the detection routine.
```
    [[STJMuteSwitch sharedInstance] setDelegate:self];
    [[STJMuteSwitch sharedInstance] detectMuteSwitch];
```
#### Then add the isMuted: delegate method.

  ```
  - (void)isMuted:(BOOL)muted
    {
        if (muted) {
            NSLog("Muted");
        }
        else {
            NSLog("Not Muted");
        }
    }
    ```
