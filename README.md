NavigationContentSlider
=======================

NavigationContentSlider is a small, lightweight class which allows you to have "tabbed" style content for your views. that you can switch between by swiping on the UINavigationBar, see the screenshots section below for a better representation of what I'm trying to say!


How to Use
----------

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

You can style the NavigationContentSlider using the same methods you would to style a UINavigationBar (since iOS5, using ```[[UINavigationBar appearance] setTitleTextAttributes:...]```)


Screenshots
-----------
![iPhone Screenshot 1](http://i.imgur.com/GF942.png)  
![iPhone Screenshot 2](http://i.imgur.com/1hjAe.png)

![iPad Screenshot 1](http://i.imgur.com/u1XiI.png)
![iPad Screenshot 2](http://i.imgur.com/1RFxj.png)

License
-------
This program is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, either version 3 of the License, or (at your option) any later version.

This program is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for more details.

You should have received a copy of the GNU General Public License along with this program.  If not, see <http://www.gnu.org/licenses/>.