import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtGraphicalEffects 1.12
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
	    id: glassPanel
	    height: parent.height / 2
	    width: parent.width / 3
	    anchors.centerIn: loginPanel
	    radius: 30                 
	    color: "#282a36"
	    opacity: 0.6               
	    z: 1
	    clip: true
	    layer.enabled: true
	    layer.smooth: true
	    layer.effect: FastBlur {
	        source: ShaderEffectSource {
	            sourceItem: background
	            hideSource: false
	            live: true
	            smooth: true
	            visible: true
	        }
	    }
	    border.color: "#d250ff"
	    border.width: 2

	    SequentialAnimation {
	        loops: Animation.Infinite
	        running: true
	        NumberAnimation { target: glassPanel; property: "opacity"; from: 0.55; to: 0.65; duration: 2000; easing.type: Easing.InOutQuad }
	        NumberAnimation { target: glassPanel; property: "opacity"; from: 0.65; to: 0.55; duration: 2000; easing.type: Easing.InOutQuad }
	    }
	}

        LoginPanel {
            id: loginPanel
            anchors.fill: parent
	    z: 2
	    clip: true
       }
    }
}