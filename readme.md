## ACSJSONPath

An easy way to get data from JSON


## Installing

	Drag ACSJSONPath.swift into your project. 
	
    
## Usage

```swift

var jsonPath = ACSJSONPath.sharedInstance
var jsonData : AnyObject? = jsonPath.getDataFromJSONObject(responseJSON, by: "template.test[1][0].one[0][0].te")

```

#### Requirements

* Xcode 6 or higher


#### License

#####WTFPL 

```
            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2004 Sam Hocevar <sam@hocevar.net>

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.

```


