## Introduction

TDAutocompletionTextfield makes the auto-completion easy. Developer don't need to install cocoapod for place auto-completion. Simple assign the class to required UITextField and init it.

## WORKING

#### Step 1 :

Assign the TDAutocompletionTextfield to the UITextField class from the storyboard or use this below code.
```
var mySearchTF : TDAutocompletionTextfield = TDAutocompletionTextfield()
```

#### Step 2 :

Init the TDAutocompletionTextfield as mentioned below,

```
mySearchTF.initWith(self, apiKey: apiKey, forCountryCode: nil) { (result) in
     // code to handle the result
 }
```
##### Note : Pass your google places API key in apiKey parameter. If you want country specific output then pass country code in countryCode paramter otherwise pass nil. 

For country code take reference from [here](https://github.com/lukes/ISO-3166-Countries-with-Regional-Codes/blob/master/all/all.csv) and use two digit country code (i.e. alpha-2).

## Output

####  

1. Get output what user entered in the UITextField.
2. On selecting any place, place is automatically filled in the UItextFiled.

![Alt text](https://github.com/thedahiyaboy/TDAutocompletionTextfield/blob/master/TDAutocompletePlace/record1.gif "Optional title")

#### 

3. It is automatically orientation supported, so no extra take care about the places suggestion box.
4. Automated UITextField clear on clicking the single cancel button.

![Alt text](https://github.com/thedahiyaboy/TDAutocompletionTextfield/blob/master/TDAutocompletePlace/record2.gif "Optional title")
