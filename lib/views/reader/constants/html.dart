// ignore_for_file: constant_identifier_names

const READER_APP = """
<!DOCTYPE html>
<html lang="en">

<head>
  <meta charset="UTF-8" />
  <meta name="referrer" content="never" />
  <script src="./reader.js"></script>
  <meta name="viewport" content="width=device-width, user-scalable=no" />
  <title>Reader App</title>
</head>

<body>
  <!-- <div id="reader"></div> -->
  <div id="virtual-wrapper">
    <div id="virtual-reader"></div>
  </div>
</body>


<script type='text/javascript'>
  globalThis.JsBridge('loadSuccess', true)
</script>

</html>
""";
