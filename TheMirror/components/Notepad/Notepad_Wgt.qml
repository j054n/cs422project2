// import QtQuick 1.0 // to target S60 5th Edition or Maemo 5
import QtQuick 1.1
import "../../common"

Rectangle {
    color: "#FCF0AD"

    property int numNotes: settings.getSetting("numNotes", "notes")
    property int current: 0

    Component.onCompleted: {
        back.enabled = false
        if(numNotes == 0)
            forward.enabled = false
        else
        {
            var unformatted = settings.getSetting("note0", "notes")
            thetext.text = "<b>"+unformatted.split(":")[0]+":</b>\n" + unformatted.split(":")[1]
        }
    }

    Button {
        id: back
        height: 50
        width: 50
        anchors.top: parent.top
        anchors.left: parent.left
        anchors.margins: 10
        label: "<"

        onClicked: {
            if(current > 0)
            {
                current--
                var unformatted = settings.getSetting("note"+current, "notes")
                thetext.text = "<b>"+unformatted.split(":")[0]+":</b>\n" + unformatted.split(":")[1]
                if(current == 0)
                    back.enabled = false
                if(current < numNotes-1)
                    forward.enabled = true
            }
        }
    }

    Button{
        id: forward
        height: 50
        width: 50
        anchors.top: parent.top
        anchors.right: parent.right
        anchors.margins: 10
        label: ">"

        onClicked: {
            if(current < numNotes-1)
            {
                current++
                var unformatted = settings.getSetting("note"+current, "notes")
                thetext.text = "<b>"+unformatted.split(":")[0]+":</b>\n" + unformatted.split(":")[1]
                if(current == numNotes-1)
                    forward.enabled = false
                if(current > 0)
                    back.enabled = true
            }
        }
    }

    Text {
        id: thetext
        anchors.left: back.left
        anchors.right: forward.right
        anchors.top: back.bottom
        anchors.bottom: parent.bottom
        anchors.margins: 10
        font.pointSize: 20

        text: ""
    }
}