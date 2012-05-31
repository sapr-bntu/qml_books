// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1


Rectangle {
    id: mtinput
    x: 308
    y: 321
    width: 225
    height: 33
    color: "#ffffff"
    opacity: 0.420
    property alias text: tinput.text
    signal textChanged
    TextInput {
        id: tinput
        text: qsTr("")
        anchors.fill: parent
        rotation: 0
        color: "black"
        selectedTextColor: "#600600"
        selectionColor: "#196f2e"
        z: 0
        clip: false
        font.bold: false
        opacity: 1
        smooth: false
        font.pixelSize: 16
        transformOrigin: Item.Center
        onTextChanged: mtinput.textChanged()
    }
}

