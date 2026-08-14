import QtQuick

Item {
  property var bar
  property string moduleName
  property var settings

  readonly property bool vertical: bar ? bar.vertical : false
  readonly property int barSize: bar ? bar.barSize : 26
  readonly property color green: "#9ece6a"

  implicitWidth: vertical ? barSize : label.implicitWidth + 15
  implicitHeight: barSize

  Text {
    id: label
    anchors.centerIn: parent
    text: "\ue900"
    color: parent.green
    font.family: "omarchy"
    font.pixelSize: 14
    renderType: Text.NativeRendering
    horizontalAlignment: Text.AlignHCenter
    verticalAlignment: Text.AlignVCenter
  }

  MouseArea {
    anchors.fill: parent
    acceptedButtons: Qt.LeftButton | Qt.RightButton
    hoverEnabled: true
    cursorShape: Qt.PointingHandCursor
    onClicked: function(mouse) {
      if (!parent.bar) return
      if (mouse.button === Qt.RightButton) parent.bar.run("xdg-terminal-exec")
      else parent.bar.run("omarchy-shell shell toggle omarchy.menu '{\"menu\":\"root\"}'")
    }
  }
}
