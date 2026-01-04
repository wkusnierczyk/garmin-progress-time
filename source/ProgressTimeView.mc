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

        var clock = System.getClockTime();

        var layout = PropertyUtils.getPropertyElseDefault(LAYOUT_PROPERTY, LAYOUT_DEFAULT);
        var progress = (layout == 0) ? new HorizontalProgressLayout() : new VerticalProgressLayout();
        progress
            .forClock(clock)
            .draw(dc);

    }

}