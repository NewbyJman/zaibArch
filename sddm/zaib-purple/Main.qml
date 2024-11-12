import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import "components"

Item {
    id: root

    height: Screen.height
    width: Screen.width

    Image {
        id: background

        anchors.fill: parent
        height: parent.height
        width: parent.width
        fillMode: Image.PreserveAspectCrop

        source: config.Background

        asynchronous: false
        cache: true
        mipmap: true
        clip: true
    }

    Item {
        id: contentPanel

        anchors {
            fill: parent
            topMargin: config.Padding
            rightMargin: config.Padding
            bottomMargin:config.Padding
            leftMargin: config.Padding
        }

        DateTimePanel {
            id: dateTimePanel

            anchors {
                top: parent.top
                right: parent.right
            }
        }
	Rectangle {
		height: parent.height / 2
		width: parent.width / 3
		// anchors.fill: loginPanel
		anchors.centerIn: loginPanel
		radius: 30
		color: "#282a36"
		opacity: 0.9
		z: 1
		visible: true
	}
	
        LoginPanel {
            id: loginPanel

            anchors.fill: parent
	    z: 2
        }
    }
}
