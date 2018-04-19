import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

import IJHack.QtPass.UiSettings 1.0

ApplicationWindow {
    visible: true
    width: 800
    height: 600

    title: qsTr("QtPass")

    Shortcut {
        sequence: StandardKey.Quit
        onActivated: Qt.quit()
    }

    header: ToolBar {
        Rectangle {
            width: parent.width
            height: UiSettings.borderWidth

            color: UiSettings.borderColor

            anchors.bottom: parent.bottom
        }

        RowLayout {
            anchors.fill: parent
            spacing: 0

            ToolButton {
                text: qsTr("Add file")
                icon.name: "add_file"
            }
            ToolButton {
                text: qsTr("Add folder")
                icon.name: "add_folder"
            }

            Item { Layout.fillWidth: true }
            ToolButton {
                Layout.alignment: Qt.AlignRight

                text: qsTr("Users")
                icon.name: "users"
            }

            ToolSeparator {}
            ToolButton {
                Layout.alignment: Qt.AlignRight

                text: qsTr("Settings")
                icon.name: "settings"
            }
        }
    }

    footer: ToolBar {
        width: parent.width
        height: UiSettings.footerHeight

        Rectangle {
            width: parent.width
            height: UiSettings.borderWidth

            color: UiSettings.borderColor

            anchors.top: parent.top
        }

        RowLayout {
            height: parent.height
            anchors.left: parent.left
            anchors.right: parent.right
            anchors.margins: {
                left: UiSettings.externalMargins
                right: UiSettings.externalMargins
            }

            Label {
                id: statusText

                height: parent.height
            }

            Item { Layout.fillWidth: true }

            ToolButton {
                onClicked: Qt.openUrlExternally("https://qtpass.org/")

                icon.name: "logo"
                icon.color: "transparent"
                text: "QtPass"
            }
        }
    }

    Row {
        anchors.fill: parent

        ScrollView {
            id: passScrollView

            width: UiSettings.passwordScrollViewWidth
            height: parent.height

            ListView {
                width: parent.width
                model: 20
                delegate: ItemDelegate {
                    text: "Item " + (index + 1)
                    width: parent.width
                }
            }
        }

        // BORDER LEFT (WTF??)
        Rectangle {
            width: UiSettings.borderWidth
            height: parent.height
            color: UiSettings.borderColor
        }

        Rectangle {
            width: parent.width
            height: parent.height

            color: "#EEE"

            Text {
                text: qsTr("text")
            }
        }
    }
}
