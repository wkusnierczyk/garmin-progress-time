# Garmin Progress Time

A minimalist, elegant, nerdy, typography-focused Garmin Connect IQ watch face that displays the current time as progress bars.

![Progress Time](resources/graphics/ProgressTimeHero-small.png)

Available from [Garmin Connect IQ Developer portal](https://apps.garmin.com/apps/{blank:app-id}) or through the Connect IQ mobile app.

> **Note**  
> Progress Time is part of a [collection of unconventional Garmin watch faces](https://github.com/wkusnierczyk/garmin-watch-faces). It has been developed for fun, as a proof of concept, and as a learning experience.
> It is shared _as is_ as an open source project, with no commitment to long term maintenance and further feature development.
>
> Please use [issues](https://github.com/wkusnierczyk/garmin-progress-time/issues) to provide bug reports or feature requests.  
> Please use [discussions](https://github.com/wkusnierczyk/garmin-progress-time/discussions) for any other comments.
>
> All feedback is wholeheartedly welcome.

## Contents

* [Progress time](#progress-time)
* [Features](#features)
* [Fonts](#fonts)
* [Build, test, deploy](#build-test-deploy)

## Progress time

Progress Time displays the curent time as three progress bars, one for each of the hour, minutes, and seconds.
The bars are vertically stacked above each other, with the hour at the top and seconds at the bottom.
The bars show progress of time as a colored stripe, representing the fraction of time that passed withing the specific part of the time (hour out of 12, minutes out of 60, seconds out of 60).
The stripe is trailed by a stripe in a different, dimmer color, representing the remaining time.


## Features

The Progress Time watch face supports the following features:

|Screenshot|Description|
|-|:-|
|![](resources/graphics/ProgressTime2.png)| **Progress bars**<br/> Three progress bars indicating the passage of time.|
|![](resources/graphics/ProgressTime1.png)| **Time digits**<br/> The progress bars may be complemented with digits showing the hour, minutes, and seconds, superimposed over the right end of each bar. A customization setting allows the user to toggle the digits on and off.|


## Fonts

In the initial release, Progress Time uses the builtin `FONT_SMALL` font.
Future releases may include custom fonts.


## Build, test, deploy

To modify and build the sources, you need to have installed:

* [Visual Studio Code](https://code.visualstudio.com/) with [Monkey C extension](https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension/).
* [Garmin Connect IQ SDK](https://developer.garmin.com/connect-iq/sdk/).

Consult [Monkey C Visual Studio Code Extension](https://developer.garmin.com/connect-iq/reference-guides/visual-studio-code-extension/) for how to execute commands such as `build` and `test` to the Monkey C runtime.

You can use the included `Makefile` to conveniently trigger some of the actions from the command line.

```bash
# build binaries from sources
make build

# run unit tests -- note: requires the simulator to be running
make test

# run the simulation
make run

# clean up the project directory
make clean
```

To sideload your application to your Garmin watch, see [developer.garmin.com/connect-iq/connect-iq-basics/your-first-app](https://developer.garmin.com/connect-iq/connect-iq-basics/your-first-app/).
