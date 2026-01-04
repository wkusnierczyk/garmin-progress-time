using Toybox.Graphics;
using Toybox.WatchUi;

import Toybox.Lang;


/**
 * Primary watch face view that renders the progress-based time chart.
 * @description
 *  Loads the watch face layout, clears the screen each update, and draws a
 *  horizontal or vertical progress chart based on the stored layout setting.
 */
class ProgressView extends WatchUi.WatchFace {

    /**
     * Initialize the view and parent watch face state.
     */
    function initialize() {
        WatchFace.initialize();
    }

    /**
     * Set the layout for the view.
     * @param dc The draw context.
     */
    function onLayout(dc) {
        setLayout(Rez.Layouts.WatchFace(dc));
    }

    /**
     * Render the watch face for the current tick.
     * @param dc The draw context.
     */
    function onUpdate(dc) {

        dc.setColor(Graphics.COLOR_BLACK, Graphics.COLOR_WHITE);
        dc.fillRectangle(0, 0, dc.getWidth(), dc.getHeight());

        var clock = System.getClockTime();

        var layout = PropertyUtils.getPropertyElseDefault(LAYOUT_PROPERTY, LAYOUT_DEFAULT);
        var progress = (layout == 0) ? new HorizontalProgressChart() : new VerticalProgressChart();
        progress
            .forClock(clock)
            .draw(dc);

    }

}
