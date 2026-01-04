using Toybox.System;

import Toybox.Lang;


/**
 * Base builder for rendering a multi-bar progress chart.
 * @description
 *  Provides fluent setters for position, size, values, and digit formatting.
 *  Subclasses implement layout-specific drawing behavior in draw().
 * @example
 *  var chart = new HorizontalProgressChart()
 *      .withTotalValues([12, 60, 60])
 *      .withElapsedValues([hour, min, sec])
 *      .withDigitFormats(["%2d", "%02d", "%02d"])
 *      .at(10, 10)
 *      .withWidth(200)
 *      .withHeight(120)
 *      .draw(dc);
 */
class ProgressChart {

    private static const DEFAULT_BAR_COUNT = 0;
    private static const ROUND_SCREEN_BOX_SIZE_FACTOR = 0.65;
    private static const RECTANGULAR_SCREEN_BOX_SIZE_FACTOR = 0.9;
    private static const DEFAULT_BOX_SIZE_FACTOR = ROUND_SCREEN_BOX_SIZE_FACTOR;
    private static const DEFAULT_BOX_ASPECT_RATIO = 0.8;
    hidden static const DEFAULT_BAR_TO_GAP_RATIO = 3;
    private static const DEFAULT_DIGIT_FORMAT = "%d";

    hidden var _atX as Number;
    hidden var _atY as Number;
    hidden var _width as Number;
    hidden var _height as Number;
    hidden var _barCount as Number = DEFAULT_BAR_COUNT;
    hidden var _totals as Array<Number> = [];
    hidden var _elapsed as Array<Number> = [];
    hidden var _withDigits as Boolean = SHOW_DIGITS_DEFAULT;
    hidden var _formats as Array<String> = [DEFAULT_DIGIT_FORMAT];

    /**
     * Initialize default dimensions based on device shape and size.
     * @return ProgressChart self for chaining.
     */
    function initialize() {
        var settings = System.getDeviceSettings();
        var boxSizeFactor = DEFAULT_BOX_SIZE_FACTOR;
        var shape = settings.screenShape;
        if (shape == System.SCREEN_SHAPE_RECTANGLE) {
            boxSizeFactor = RECTANGULAR_SCREEN_BOX_SIZE_FACTOR;
        }
        var boxAspectRatio = DEFAULT_BOX_ASPECT_RATIO;
        var width = settings.screenWidth;
        var height = settings.screenHeight;
        _width = (boxSizeFactor * (width < height ? width : height)).toNumber();
        _height = (boxAspectRatio * _width).toNumber();
        _atX = (width - _width) / 2;
        _atY = (height - _height) / 2;
    }

    /**
     * Set chart origin.
     * @param Number atX Left coordinate.
     * @param Number atY Top coordinate.
     * @return ProgressChart self for chaining.
     */
    function at(atX as Number, atY as Number) as ProgressChart {
        _atX = atX;
        _atY = atY;
        return self;
    }

    /**
     * Set chart width.
     * @param Number width Width in pixels.
     * @return ProgressChart self for chaining.
     */
    function withWidth(width as Number) as ProgressChart {
        _width = width;
        return self;
    }

    /**
     * Set chart height.
     * @param Number width Height in pixels.
     * @return ProgressChart self for chaining.
     */
    function withHeight(width as Number) as ProgressChart {
        _height = width;
        return self;
    }

    /**
     * Set elapsed values for each bar.
     * @param Array<Number> values Elapsed values per bar.
     * @return ProgressChart self for chaining.
     */
    function withElapsedValues(values as Array<Number>) as ProgressChart {
        _elapsed = values;
        _barCount = values.size();
        return self;
    }

    /**
     * Set total values for each bar.
     * @param Array<Number> values Total values per bar.
     * @return ProgressChart self for chaining.
     */
    function withTotalValues(values as Array<Number>) as ProgressChart {
        _totals = values;
        _barCount = values.size();
        return self;
    }

    /**
     * Set digit format strings per bar.
     * @param Array<String> formats Format strings (e.g. "%02d").
     * @return ProgressChart self for chaining.
     */
    function withDigitFormats(formats as Array<String>) as ProgressChart {
        _formats = formats;
        _barCount = formats.size();
        return self;
    }

    /**
     * Configure chart for a clock-time display (hour/min/sec).
     * @param System.ClockTime clock Current clock time.
     * @return ProgressChart self for chaining.
     */
    function forClock(clock as System.ClockTime) as ProgressChart {
        // TODO: add option for 12/24h time
        withTotalValues([12, 60, 60]);
        withElapsedValues([clock.hour % 12, clock.min, clock.sec]);
        _formats = ["%2d", "%02d", "%02d"];
        return self;
    }
    
    /**
     * Prepare draw-time settings shared by subclasses.
     * @param dc Draw context (Toybox.Graphics.Dc).
     * @return ProgressChart self for chaining.
     */
    function draw(dc) as ProgressChart {
        _withDigits = PropertyUtils.getPropertyElseDefault(SHOW_DIGITS_PROPERTY, SHOW_DIGITS_DEFAULT);
        return self;
    }

}

/**
 * Horizontal layout that stacks progress bars top-to-bottom.
 */
class HorizontalProgressChart extends ProgressChart {

    /**
     * Initialize base sizing from ProgressChart.
     * @return HorizontalProgressChart self for chaining.
     */
    function initialize() {
        ProgressChart.initialize();
    }

    /**
     * Draw all bars using a horizontal progress bar renderer.
     * @param dc Draw context (Toybox.Graphics.Dc).
     * @return ProgressChart self for chaining.
     */
    function draw(dc) as ProgressChart {

        ProgressChart.draw(dc);

        var gapCount = (DEFAULT_BAR_TO_GAP_RATIO + 1) * _barCount - 1;
        var gapHeight = _height / gapCount;

        var progressWidth = _width;
        var progressHeight = gapHeight * DEFAULT_BAR_TO_GAP_RATIO;

        var progressBar = new HorizontalProgressBar()
            .withLength(progressWidth)
            .withBreadth(progressHeight)
            .toggleDigits(_withDigits);

        for (var i = 0; i < _barCount; ++i) {
            progressBar
                .at(_atX, _atY + i * (progressHeight + gapHeight))
                .withTotal(_totals[i])
                .withElapsed(_elapsed[i])
                .withDigitsFormat(_formats[i % _formats.size()])
                .draw(dc);
        }
            
        return self;

    }

}

class VerticalProgressChart extends ProgressChart {

    function initialize() {
        ProgressChart.initialize();
    }

    function draw(dc) as ProgressChart {

        ProgressChart.draw(dc);

        var gapCount = (DEFAULT_BAR_TO_GAP_RATIO + 1) * _barCount - 1;
        var gapWidth = _width / gapCount;

        var progressHeight = _height;
        var progressWidth =  gapWidth * DEFAULT_BAR_TO_GAP_RATIO;
        
        var progressBar = new VerticalProgressBar()
            .withLength(progressHeight)
            .withBreadth(progressWidth)
            .toggleDigits(_withDigits);
        
        for (var i = 0; i < _barCount; ++i) {
            progressBar
                .at(_atX + i * (progressWidth + gapWidth), _atY)
                .withTotal(_totals[i])
                .withElapsed(_elapsed[i])
                .withDigitsFormat(_formats[i % _formats.size()])
                .draw(dc);
        }
            
        return self;

    }

}
