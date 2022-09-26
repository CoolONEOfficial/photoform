import 'package:flutter/widgets.dart';
import 'package:webviewx/webviewx.dart';

mixin Slide<T> {
  ValueSetter<T> get onFinished;
}

class CalendarSlide extends StatefulWidget with Slide<String> {
  const CalendarSlide(this.onFinished, {super.key});

  @override
  final ValueSetter<String> onFinished;

  @override
  State<CalendarSlide> createState() => _CalendarSlideState();
}

class _CalendarSlideState extends State<CalendarSlide> {
  late WebViewXController webviewController;

  Size get screenSize => MediaQuery.of(context).size;

  @override
  Widget build(BuildContext context) {
    return WebViewX(
      initialContent: '''
<div style="width:100%;height:100%;overflow:scroll" id="my-cal-inline"></div>
<script type="text/javascript">
(function (C, A, L) { let p = function (a, ar) { a.q.push(ar); }; let d = C.document; C.Cal = C.Cal || function () { let cal = C.Cal; let ar = arguments; if (!cal.loaded) { cal.ns = {}; cal.q = cal.q || []; d.head.appendChild(d.createElement("script")).src = A; cal.loaded = true; } if (ar[0] === L) { const api = function () { p(api, arguments); }; const namespace = ar[1]; api.q = api.q || []; typeof namespace === "string" ? (cal.ns[namespace] = api) && p(api, ar) : p(cal, ar); return; } p(cal, ar); }; })(window, "https://app.cal.com/embed/embed.js", "init");
Cal("init", {origin:"https://app.cal.com"});

Cal("inline", {
  elementOrSelector:"#my-cal-inline",
  calLink: "---------------dk7tkc/30min"
});

Cal("ui", {"theme":"light","styles":{"branding":{"brandColor":"#47738b"}}});


Cal("on", {
  action: "bookingSuccessful",
  callback: (e)=>{
    // `data` is properties for the event.
    // `type` is the name of the action(You can also call it type of the action.) This would be same as "ANY_ACTION_NAME" except when ANY_ACTION_NAME="*" which listens to all the events.
    // `namespace` tells you the Cal namespace for which the event is fired/
    DartCallback(e.detail.data.date)
  }
});
</script>
''',
      initialSourceType: SourceType.html,
      onWebViewCreated: (controller) => webviewController = controller,
      dartCallBacks: {
        DartCallback(
          name: 'DartCallback',
          callBack: (msg) => widget.onFinished(msg),
        )
      },
      width: screenSize.width,
      height: screenSize.height - 144,
    );
  }
}
