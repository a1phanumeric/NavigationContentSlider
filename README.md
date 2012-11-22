NavigationContentSlider
=======================

NavigationContentSlider is a small, lightweight class which allows you to have "tabbed" style content for your views that you can switch between by swiping on the UINavigationBar (see the screenshots section below for a better representation of what I'm trying to say!).

![NavigationContentSlider Example](http://i.imgur.com/uydZt.gif)

How to Use
----------

NavigationContentSlider uses ARC, and is compatible with all iOS mobile devices (iPhone, iPod, iPad, iPhone 5, iPad Mini) running iOS 5.0+ (it may well work on lower iOS versions, but I haven't tested this). It can be used in both portrait and landscape mode.

Any view controller that uses this class **MUST** be part of a UINavigationController stack.

* Import the NavigationContentSlider.h/.m files into your project
* Create (or update) a UIViewController .h file so that it's derived from the NavigationContentSlider class, for example: ```@interface RootViewController : NavigationContentSlider```
* Implement the four required dataSource methods (explained below)

### DataSource Methods

```- (NSInteger)numberOfSectionsInNavigationContentSlider:(NavigationContentSlider *)navigationContentSlider```

Return the number of sections you wish to have

```- (NSInteger)widthOfSectionTitlesInNavigationContentSlider:(NavigationContentSlider *)navigationContentSlider```

Return the width of the title for each section. In the demo example, you'll see that I increase this for iPads (as it looks better)

```- (NSString *)navigationContentSlider:(NavigationContentSlider *)navigationContentSlider titleForSectionAtIndex:(NSInteger)index```

Return the title for the section index

```- (UIView *)navigationContentSlider:(NavigationContentSlider *)navigationContentSlider viewForSectionAtIndex:(NSInteger)index```

Return the UIView for the section at the index


### Styling

You can style the NavigationContentSlider using the same methods you would to style a UINavigationBar (since iOS5, using ```[[UINavigationBar appearance] setTitleTextAttributes:...]``` and ```[[UINavigationBar appearance] setBackgroundImage:...]``` etc...)


Screenshots
-----------
![iPhone Screenshot 1](http://i.imgur.com/GF942.png)  
![iPhone Screenshot 2](http://i.imgur.com/1hjAe.png)

![iPad Screenshot 1](http://i.imgur.com/u1XiI.png)
![iPad Screenshot 2](http://i.imgur.com/1RFxj.png)

License
-------
The MIT License (MIT)
Copyright (c) 2012 edrackham.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.