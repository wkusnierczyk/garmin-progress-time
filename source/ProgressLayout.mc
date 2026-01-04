using Toybox.System;

import Toybox.Lang;


class ProgressLayout {

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

    function at(atX as Number, atY as Number) as ProgressLayout {
        _atX = atX;
        _atY = atY;
        return self;
    }

    function withWidth(width as Number) as ProgressLayout {
        _width = width;
        return self;
    }

    function withHeight(width as Number) as ProgressLayout {
        _height = width;
        return self;
    }

    function withElapsedValues(values as Array<Number>) as ProgressLayout {
        _elapsed = values;
        _barCount = values.size();
        return self;
    }

    function withTotalValues(values as Array<Number>) as ProgressLayout {
        _totals = values;
        _barCount = values.size();
        return self;
    }

    function withDigitFormats(formats as Array<String>) as ProgressLayout {
        _formats = formats;
        _barCount = formats.size();
        return self;
    }

    function forClock(clock as System.ClockTime) as ProgressLayout {
        // TODO: add option for 12/24h time
        withTotalValues([12, 60, 60]);
        withElapsedValues([clock.hour % 12, clock.min, clock.sec]);
        _formats = ["%2d", "%02d", "%02d"];
        return self;
    }
    
    function draw(dc) as ProgressLayout {
        _withDigits = PropertyUtils.getPropertyElseDefault(SHOW_DIGITS_PROPERTY, SHOW_DIGITS_DEFAULT);
        return self;
    }

}

class HorizontalProgressLayout extends ProgressLayout {

    function initialize() {
        ProgressLayout.initialize();
    }

    function draw(dc) as ProgressLayout {

        ProgressLayout.draw(dc);

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

class VerticalProgressLayout extends ProgressLayout {

    function initialize() {
        ProgressLayout.initialize();
    }

    function draw(dc) as ProgressLayout {

        ProgressLayout.draw(dc);

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
