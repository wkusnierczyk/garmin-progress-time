using Toybox.Application;
using Toybox.WatchUi;


class ProgressTimeApp extends Application.AppBase {

    function initialize() {
        AppBase.initialize();
    }

    function getInitialView() {
        return [ new ProgressTimeView() ];
    }

    function onSettingsChanged() as Void {
        WatchUi.requestUpdate();
    }

    function getSettingsView() {
        return [ new ProgressTimeMenu(), new ProgressTimeDelegate() ];
    }

}