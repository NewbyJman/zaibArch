import QtQuick 2.12
import QtQuick.Controls 2.12

Column {
    spacing: 0
    
    Text {
        id: dateLabel

        anchors.right: parent.right
        opacity: config.DateOpacity

        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.DateSize
        font.bold: config.DateIsBold == "true" ? true : false
        color: config.DateColor
                
	function updateDate() {
	    var now = new Date()
	    var offsetMinutes = now.getTimezoneOffset() // negative if ahead of UTC
	    var local = new Date(now.getTime() - offsetMinutes * 60 * 1000)
	    dateLabel.text = local.toLocaleDateString(Qt.locale(), config.DateFormat)
	}
    }

    Text {
        id: timeLabel

        anchors.right: parent.right
        opacity: config.TimeOpacity

        renderType: Text.NativeRendering
        font.family: config.Font
        font.pointSize: config.TimeSize
        font.bold: config.TimeIsBold == "true" ? true : false
        color: config.TimeColor

	function updateTime() {
	    var now = new Date()
	    var offsetMinutes = now.getTimezoneOffset()
	    var local = new Date(now.getTime() - offsetMinutes * 60 * 1000)
	    timeLabel.text = local.toLocaleTimeString(Qt.locale(), config.TimeFormat)
	}
    }

    Timer {
        interval: 1000
        repeat: true
        running: true
        onTriggered: {
            timeLabel.updateTime()
            dateLabel.updateDate()
        }
    }

    Component.onCompleted: {
        timeLabel.updateTime()
        dateLabel.updateDate()
    }
}
