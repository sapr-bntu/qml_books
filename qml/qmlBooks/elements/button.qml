import QtQuick 1.0

Rectangle {
    id: button

    property alias text: textItem.text
    property alias font: textItem.font
    property string buttonsize:"middle"
    property string type:"default"
    property bool  enabled:  true

    property string colortop:"#ffffff"
    property string color2:"#e6e6e6"
    property string color3:"#d0d0d0"
    property string fontcolor:"#333333"
    property string bordercolor:"#cccccc"


    signal clicked

    height : textItem.height + 4
    width: textItem.width + 20;
    border.width: 1
    border.color: bordercolor
    radius: 4
    smooth: true

    Gradient { id :gradient1
        GradientStop {id:gr1;position: 0.0; color: colortop }
        GradientStop { position: 1.0; color: color2 }
    }
    gradient: gradient1

    Text {
        id: textItem
        x: parent.width/2 - width/2; y: parent.height/2 - height/2
        font.pixelSize: 13
        font.family: "Helvetica Neue"
        color:fontcolor
      }

    MouseArea {
        id: mouseArea
        anchors.fill: parent
        hoverEnabled: true//без этого не работает наведение
        onEntered: button.state = "entered"
        onExited: button.state = "exited"
        onClicked: button.clicked()
    }



    states: [
        State {
            name: "pressed"; when: mouseArea.pressed && mouseArea.containsMouse
            PropertyChanges { target: gr1; color:color3 }

        },
        State {
            name: "entered";
            PropertyChanges { target: gr1; color: color2 }

        },
        State {
            name: "exited";
            PropertyChanges { target: button; gradient: gradient1 }

        },

        State {
            name: "disabled";when: !button.enabled
            PropertyChanges { target: button; gradient: null }
            PropertyChanges { target: button; opacity: 0.65 }
            PropertyChanges { target: button; color:color2 }
            PropertyChanges { target: mouseArea; enabled: false }
        }
    ]
    onTypeChanged: {
        if (type == "default"){
            colortop = "#ffffff";
            color2 ="#e6e6e6";
            color3 ="#d0d0d0";
            fontcolor= "#333333";
            bordercolor ="#cccccc"
        }
        if (type == "primary"){
            colortop = "#0088cc";
            color2 ="#0055cc";
            color3 ="#0033cc";
            fontcolor= "#ffffff";
            bordercolor ="#0055cc"
        }
        if (type == "warning"){
            colortop = "#fbb450";
            color2 ="#f89406";
            color3 ="#fbb450";
            fontcolor= "#ffffff";
            bordercolor ="#f89406"
        }
        if (type == "danger"){
            colortop = "#ee5f5b";
            color2 ="#bd362f";
            color3 ="#ee5f5b";
            fontcolor= "#ffffff";
            bordercolor ="#bd362f"
        }
        if (type == "success"){
            colortop = "#62c462";
            color2 ="#51a351";
            color3 ="#51a351";
            fontcolor= "#ffffff";
            bordercolor ="#51a351"
        }
        if (type == "info"){
            colortop = "#5bc0de";
            color2 ="#2f96b4";
            color3 ="#2f96b4";
            fontcolor= "#ffffff";
            bordercolor ="#2f96b4"
        }
        if (type == "inverse"){
            colortop = "#555555";
            color2 ="#222222";
            color3 ="#222222";
            fontcolor= "#ffffff";
            bordercolor ="#222222"
        }
    }
    onButtonsizeChanged: {
//        console.log(buttonsize);
        if (buttonsize == "large")
        {
            //            padding: 9px 14px;
            textItem.font.pixelSize = 15
            button.radius = 5
            button.height = 29;

        }
        if (buttonsize == "middle")
        {
            textItem.font.pixelSize = 13
            button.radius = 4
            button.height = 18;

        }
        if (buttonsize == "small")
        {
            textItem.font.pixelSize = 11;
            button.radius = 3;
            button.height = 17;

        }
        if (buttonsize == "mini")
        {
            textItem.font.pixelSize = 11
            button.radius = 2
            button.height = 13;

        }
    }

}



