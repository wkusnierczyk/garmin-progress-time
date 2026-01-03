using Toybox.Application.Properties;
using Toybox.Graphics;
using Toybox.WatchUi;

import Toybox.Lang;


class ProgressTimeView extends WatchUi.WatchFace {

    function initialize() {
        WatchFace.initialize();
    }

    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    function onUpdate(dc) {

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        var clockTime = System.getClockTime();

        var hour = clockTime.hour;
        var minutes = clockTime.min;
        var seconds = clockTime.sec;

        new Progress()
            .withTotal(60)
            .withElapsed(seconds)
            .draw(dc);

    }

}