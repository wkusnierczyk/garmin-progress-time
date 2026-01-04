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

        _horizontal(dc);

    }

    private function _horizontal(dc) {

        // TODO: remove this hack!
        var withDigits = PropertyUtils.getPropertyElseDefault(SHOW_DIGITS_PROPERTY, SHOW_DIGITS_DEFAULT);

        var clockTime = System.getClockTime();

        var hour = clockTime.hour;
        var minutes = clockTime.min;
        var seconds = clockTime.sec;

        var width = dc.getWidth();
        var height = dc.getHeight();

        var boxSizeFactor = 0.65;
        var shape = System.getDeviceSettings().screenShape;
        if (shape == System.SCREEN_SHAPE_RECTANGLE) {
            boxSizeFactor = 0.9;
        }

        var boxAspectRatio = 0.8;

        var boxWidth = (boxSizeFactor * (width < height ? width : height)).toNumber();
        var boxHeight = (boxAspectRatio * boxWidth).toNumber();
        var boxX = (width - boxWidth) / 2;
        var boxY = (height - boxHeight) / 2;

        var gapHeight = boxHeight / 11;

        var progressWidth = boxWidth;
        var progressHeight = gapHeight * 3;

        new HorizontalProgressBar()

            .withLength(progressWidth)
            .withBreadth(progressHeight)
            .toggleDigits(withDigits)
            
            // hour
            .at(boxX, boxY)
            .withTotal(12)
            .withElapsed(hour % 12)
            .withDigitsFormat("%2d")
            .draw(dc)

            // minutes
            .at(boxX, boxY + progressHeight + gapHeight)
            .withTotal(60)
            .withElapsed(minutes)
            .withDigitsFormat("%02d")
            .draw(dc)

            // minutes
            .at(boxX, boxY + 2 * progressHeight + 2* gapHeight)
            .withElapsed(seconds)
            .draw(dc);

    }


}