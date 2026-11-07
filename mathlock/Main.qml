import QtQuick
import QtQuick.Controls
import QtQuick.Layouts
import QtQuick.Window

ApplicationWindow {
    id: window

    visible: true
    visibility: Window.FullScreen
    title: "Poop Math Practice!"
    color: "#202733"

    Image {
    anchors.left: parent.left
    anchors.top: parent.top
    anchors.margins: 24
    width: 120
    height: 80
    source: Qt.resolvedUrl("poop.png")
    fillMode: Image.PreserveAspectFit
    smooth: true
}

Image {
    anchors.right: parent.right
    anchors.top: parent.top
    anchors.margins: 24
    width: 120
    height: 80
    source: Qt.resolvedUrl("poop.png")
    fillMode: Image.PreserveAspectFit
    smooth: true
}
    
    property int answer: 0
    property string questionText: ""
    property string feedback: ""
    property int maxMultiplier: 10

    function generateQuestion() {

	const x = Math.floor(Math.random() * (maxMultiplier - 1)) + 2
	const y = Math.floor(Math.random() * (maxMultiplier - 1)) + 2
	const z = x * y
	const blank = Math.floor(Math.random() * 3)

	if (Math.random() < 0.5) {
	    // Multiplication: x × y = z
	    if (blank === 0) {
		questionText = "? × " + y + " = " + z
		answer = x
	    } else if (blank === 1) {
		questionText = x + " × ? = " + z
		answer = y
	    } else {
		questionText = x + " × " + y + " = ?"
		answer = z
	    }
	} else {
	    // Division: z ÷ y = x
	    if (blank === 0) {
		questionText = "? ÷ " + y + " = " + x
		answer = z
	    } else if (blank === 1) {
		questionText = z + " ÷ ? = " + x
		answer = y
	    } else {
		questionText = z + " ÷ " + y + " = ?"
		answer = x
	    }
	}

	feedback = ""
    }

    function checkAnswer() {
	if (answerField.text.trim() === String(answer)) {
	    feedback = "Correct!"
	    answerField.enabled = false
	    closeTimer.start()
	} else {
	    feedback = "Try again"
	    answerField.selectAll()
	    answerField.forceActiveFocus()
	}
    }

    Component.onCompleted: {
	generateQuestion()
	answerField.forceActiveFocus()
    }

    Timer {
	id: closeTimer
	interval: 600
	repeat: false
	onTriggered: window.close()
    }

    ColumnLayout {
	anchors.centerIn: parent
	width: Math.min(parent.width * 0.8, 560)
	spacing: 24

	Label {
	    Layout.alignment: Qt.AlignHCenter
	    Layout.topMargin: 16
	    Layout.bottomMargin: 40 
	    text: "Poop math practice!"
	    color: "white"
	    font.pixelSize: 30
	}

	Label {
	    Layout.alignment: Qt.AlignHCenter
	    Layout.fillWidth: true
	    text: questionText
	    color: "white"
	    font.pixelSize: 52
	    horizontalAlignment: Text.AlignHCenter
	}

	TextField {
	    id: answerField
	    Layout.fillWidth: true
	    placeholderText: "Your answer"
	    horizontalAlignment: TextInput.AlignHCenter
	    inputMethodHints: Qt.ImhDigitsOnly
	    font.pixelSize: 28
	    onAccepted: window.checkAnswer()
	}

	Button {
	    Layout.alignment: Qt.AlignHCenter
	    text: "Check"
	    onClicked: window.checkAnswer()
	}

	Label {
	    Layout.alignment: Qt.AlignHCenter
	    text: feedback
	    color: feedback === "Correct!" ? "#8fe3a1" : "#ffd27d"
	    font.pixelSize: 22
	}
    }

    Button {
	anchors.right: parent.right
	anchors.bottom: parent.bottom
	anchors.margins: 18
	text: "Adult access"
	flat: true
	onClicked: pinDialog.open()
    }

    Dialog {
	id: pinDialog
	title: "Adult access"
	modal: true
	anchors.centerIn: parent
	standardButtons: Dialog.Ok | Dialog.Cancel

	contentItem: TextField {
	    id: pinField
	    placeholderText: "Enter parent PIN"
	    echoMode: TextInput.Password
	    inputMethodHints: Qt.ImhDigitsOnly
	    onAccepted: pinDialog.accept()
	}

	onAccepted: {
	    if (pinField.text === "5807") {
		window.close()
	    } else {
		pinField.text = ""
	    }
	}

	onClosed: pinField.text = ""
    }
}

