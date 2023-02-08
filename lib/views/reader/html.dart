// ignore_for_file: constant_identifier_names

const READER_APP = """
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <script src="./reader.js"></script>
  <script type='text/javascript'>
    document.addEventListener('DOMContentLoaded', function () {
      console.log("demo")
      setTimeout(() => {
        ReaderJs.init({
          bookName: '狼与香辛料',
          horizontal: true,
          marginHorizontal: 18,
          marginVertical: 18,
          fontSize:18,
          textAlign: 1, //0 start,1 justify,2 end,3 center
          lineSpacing: 1.4,
          backgroundColor: 'fffffbff',
          textColor: '000000',
          linkColor: '000000',
          topExtraHeight: 20,
          bottomExtraHeight: 30,
          infoBarHeight: 32,
          enableJsBridge:true,
          enableScroll:false
        })
        console.log("init success",window.devicePixelRatio)
        // window.flutter_inappwebview.callHandler('jsBridge', 'initDone')
      })
    })
  </script>
  <!-- <script src="./src/demo.ts" defer></script> -->
  <link rel="icon" type="image/svg+xml" href="/vite.svg" />
  <meta name="viewport" content="width=device-width, user-scalable=no" />
  <title>Reader App</title>
</head>

<body>
  <!-- <div id="reader"></div> -->
  <div id="virtual-wrapper">
    <div id="virtual-reader"></div>
  </div>
</body>

</html>
""";
