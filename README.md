#Changes

##The idea (in German)
Wir möchten die zeitlichen Veränderungen an einem Ort durch unterschiedliche Daten darstellen. Wie sah meine Straße vor 100 Jahren aus? Haben hier verfolgte Menschen, durch den NS, gewohnt? Mit unserer Platform wollen wir diese Fragen beantworten! Wir bündeln unterschiedliche Datenquellen, Stolpersteine, historische Fotografien und Webcams, um einen möglichst genauen Einblick in die Vergangenheit und die Entwicklung eines Raumes zu bekommen.

Wir zeigen euch die **Changes** deiner Umgebung!!!

![Screenshot](https://gitlab.com/changes/iOS/raw/master/Screenshots/img_1.png)
![Screenshot](https://gitlab.com/changes/iOS/raw/master/Screenshots/img_2.png)


##Implementation
[![Platform](http://img.shields.io/badge/platform-ios-blue.svg?style=flat
)](https://developer.apple.com/iphone/index.action)
[![Language](http://img.shields.io/badge/language-swift-brightgreen.svg?style=flat
)](https://developer.apple.com/swift)

This is the iOS app for this project, developed in **Swift**. It uses the MVC architecture for structuring the code. The data is fetched and prepared by a seperated framework, because this allows to integrade the API and models in every other project as easy as possible. So the fronted with the views and view controllers only need to access this data and to dispay them.

We use the default Apple Map where we add all the generallized data from our API. This also gives the app this special feeling that is typical for iOS apps.

##Contribution
To contribute to have to `clone` this repository. After this run `pod install` in the root directory to install all dependencies. After this you can easiely open the workspace, edit something and commit it. If you have any question feel free to contact me: <info@alexsteiner.de>

##License
Changes is released under the MIT license. See LICENSE for details.
We would like to know where and who our project is used.

