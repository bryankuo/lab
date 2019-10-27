// How to set common property value in QML?
// you can use "Style Object" method
// to set the properties and use them in all your QML files.
// @see https://tinyurl.com/y24w9atf

import QtQml 2.2

// Styles.qml
QtObject {
    property int resolutionWidth: 1024
    property int resolutionHeight: 768
    property int backWidth: 80
    property int backHeight: 80
    property string colorAlert: "red"
    property string colorWarning: "orange"
    property string colorNormal: "#ffffff"
    property int msgBarWidth: resolutionWidth
    property int msgBarHeight: 40
}
