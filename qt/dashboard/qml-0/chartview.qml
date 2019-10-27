import QtQuick 2.2
import QtQuick.Controls 2.0
import QtQuick.Layouts 1.3
import QtCharts 2.0

ApplicationWindow {
    visible: true
    width: 640
    height: 480
    title: qsTr("Hello World")

    ChartView{
        id: chart
        objectName: "chart"
        antialiasing: true
        legend.visible: false
        width: parent.width
        height: parent.height
        anchors.fill: parent
        theme: ChartView.ChartThemeBlueCerulean

        ValueAxis{
            id:axisY
            min:0
            max:100
        }
        DateTimeAxis{
            id:dateTime
            format: "hh:mm:ss"
            tickCount: 5
        }

        LineSeries{
            id:series1
            objectName: "series1"
            axisX: dateTime
            axisY: axisY
            useOpenGL: true
        }

        LineSeries{
            id: series2
            objectName: "series2"
            axisX: dateTime
            axisY: axisY
            useOpenGL: true
        }
    }
}
