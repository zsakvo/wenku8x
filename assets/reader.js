(function(){"use strict";try{if(typeof document!="undefined"){var t=document.createElement("style");t.appendChild(document.createTextNode("#virtual-wrapper{left:0;top:0;z-index:-1}#reader{z-index:99;display:flex;z-index:10}*{outline:none!important}body{padding:0!important;margin:0!important;word-break:break-word}html{margin:0!important;padding:0!important}sup{vertical-align:top!important}sub{vertical-align:bottom!important}img{max-width:100%!important}")),document.head.appendChild(t)}}catch(e){console.error("vite-plugin-css-injected-by-js",e)}})();
const ua = navigator.userAgent;
const isApp = ua.indexOf("ReaderJs") > -1;
console.log("isApp:", isApp);
if (isApp) {
  globalThis.JsBridge = (...args) => globalThis.flutter_inappwebview.callHandler("jsBridge", ...args);
} else {
  globalThis.JsBridge = (...args) => console.log(args);
}
const _default = "";
globalThis.ReaderJs = (() => {
  let config;
  let virtualReader;
  let readerStyleElement;
  let virtualReaderContainerClassName = "";
  let virtualReaderContainerSelector = "";
  let pageHorizontalMargin;
  let pageWidth;
  let windowWidth = "";
  const tanslateImg = `<img id="translate-img" class="translate-img" src="data:image/gif;base64,R0lGODlhAQABAIAAAP///wAAACH/C1hNUCBEYXRhWE1QPD94cGFja2V0IGJlZ2luPSLvu78iIGlkPSJXNU0wTXBDZWhpSHpyZVN6TlRjemtjOWQiPz4gPHg6eG1wbWV0YSB4bWxuczp4PSJhZG9iZTpuczptZXRhLyIgeDp4bXB0az0iQWRvYmUgWE1QIENvcmUgNS41LWMwMTQgNzkuMTUxNDgxLCAyMDEzLzAzLzEzLTEyOjA5OjE1ICAgICAgICAiPiA8cmRmOlJERiB4bWxuczpyZGY9Imh0dHA6Ly93d3cudzMub3JnLzE5OTkvMDIvMjItcmRmLXN5bnRheC1ucyMiPiA8cmRmOkRlc2NyaXB0aW9uIHJkZjphYm91dD0iIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtbG5zOnhtcE1NPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvbW0vIiB4bWxuczpzdFJlZj0iaHR0cDovL25zLmFkb2JlLmNvbS94YXAvMS4wL3NUeXBlL1Jlc291cmNlUmVmIyIgeG1wOkNyZWF0b3JUb29sPSJBZG9iZSBQaG90b3Nob3AgQ0MgKE1hY2ludG9zaCkiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6MjI2ODJCNzlCQTVCMTFFNDk4RTVBQjQ2RjYyOTA1QzgiIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6MjI2ODJCN0FCQTVCMTFFNDk4RTVBQjQ2RjYyOTA1QzgiPiA8eG1wTU06RGVyaXZlZEZyb20gc3RSZWY6aW5zdGFuY2VJRD0ieG1wLmlpZDoyMjY4MkI3N0JBNUIxMUU0OThFNUFCNDZGNjI5MDVDOCIgc3RSZWY6ZG9jdW1lbnRJRD0ieG1wLmRpZDoyMjY4MkI3OEJBNUIxMUU0OThFNUFCNDZGNjI5MDVDOCIvPiA8L3JkZjpEZXNjcmlwdGlvbj4gPC9yZGY6UkRGPiA8L3g6eG1wbWV0YT4gPD94cGFja2V0IGVuZD0iciI/PgH//v38+/r5+Pf29fTz8vHw7+7t7Ovq6ejn5uXk4+Lh4N/e3dzb2tnY19bV1NPS0dDPzs3My8rJyMfGxcTDwsHAv769vLu6ubi3trW0s7KxsK+urayrqqmop6alpKOioaCfnp2cm5qZmJeWlZSTkpGQj46NjIuKiYiHhoWEg4KBgH9+fXx7enl4d3Z1dHNycXBvbm1sa2ppaGdmZWRjYmFgX15dXFtaWVhXVlVUU1JRUE9OTUxLSklIR0ZFRENCQUA/Pj08Ozo5ODc2NTQzMjEwLy4tLCsqKSgnJiUkIyIhIB8eHRwbGhkYFxYVFBMSERAPDg0MCwoJCAcGBQQDAgEAACH5BAEAAAAALAAAAAABAAEAAAICRAEAOw==" />`;
  function init(cfg) {
    config = cfg;
    console.log(config);
    initValues();
    virtualReader = document.getElementById("virtual-reader");
    for (let i = 0; i < 8; i++) {
      let className = "__reader_x_" + i;
      virtualReaderContainerClassName += " " + className;
      virtualReaderContainerSelector += "." + className;
    }
    virtualReader.className = virtualReaderContainerClassName;
    readerStyleElement = document.createElement("style");
    readerStyleElement.setAttribute("type", "text/css");
    document.head.appendChild(readerStyleElement);
    updateReaderStyleElement();
    windowWidth = window.innerWidth + "px";
    globalThis.JsBridge("initDone", window.innerWidth, window.innerHeight);
  }
  function updateReaderStyleElement() {
    var style = `display:flex;`;
    const infoStyle = ` .reader-app-page-info {color:#${config.infoColor} !important;}`;
    const bookTextStyle = `.book-container {color:#${config.textColor}}`;
    readerStyleElement.innerText = virtualReaderContainerSelector + " { " + style + " } " + bookTextStyle + infoStyle;
  }
  function getBodyStyle() {
    var style = "line-height: " + config.lineSpacing + " !important;/*font-size: " + config.fontSize + "px !important;*/";
    const infoStyle = ` .reader-app-page-info {color:#${config.infoColor} !important;}`;
    const bookTextStyle = `.book-container {color:#${config.textColor} !important}`;
    return "body * { " + style + " } " + bookTextStyle + infoStyle;
  }
  function getHeader(html) {
    const headerReg = /\<head\>/;
    const htmlReg = /\<html\>/;
    const bodyReg = /\<\/body\>/;
    const a = html.match(headerReg);
    console.log(a == null ? void 0 : a.index, "match");
    console.log("uedk", windowWidth);
    let styleString = `<style id="reader-style-x" type="text/css">${getReaderStyleText()}</style><style type="text/css">html{width:100vw !important;height:${getFullHeight()} !important;padding:0 !important;margin：0 !important;} .translate-img{height:1px;width:1px;position:absolute;top:0;}  body{width: ${windowWidth};overflow:hidden;
      padding: ${config.infoBarHeight + config.marginVertical + config.topExtraHeight + "px"} ${config.marginHorizontal + "px"} ${config.infoBarHeight + config.marginVertical + config.bottomExtraHeight + "px"} ${config.marginHorizontal + "px"} !important;
      height: ${getFullHeight()} !important;
      box-sizing:border-box !important;
      margin:0 !important;
      column-width: ${pageWidth}px;
      column-gap: ${config.marginHorizontal * 2}px !important;} ${getBodyStyle()}</style>`;
    if (a) {
      styleString = "<head>" + styleString;
      html = html.replace(headerReg, styleString);
    } else {
      styleString = "<html><head>" + styleString + "</head>";
      html = html.replace(htmlReg, styleString);
    }
    html = html.replace(bodyReg, `${tanslateImg}</body>`);
    return html;
  }
  function initValues() {
    pageHorizontalMargin = config.marginHorizontal * 2;
    pageWidth = window.innerWidth - pageHorizontalMargin;
  }
  function getFullHeight() {
    return config.isIOS ? "100vh" : "100vh";
  }
  function setPageHeader(body, title, pages) {
    for (let i = 0; i < pages; i++) {
      const left = i * body.clientWidth;
      const headerWrapper = document.createElement("div");
      headerWrapper.style.left = left + "px";
      headerWrapper.style.height = config.infoBarHeight + "px";
      headerWrapper.style.width = body.clientWidth + "px";
      headerWrapper.style.top = config.topExtraHeight + "px";
      headerWrapper.style.boxSizing = "border-box";
      headerWrapper.style.paddingLeft = config.marginHorizontal + "px";
      headerWrapper.style.position = "absolute";
      headerWrapper.style.fontSize = "13px";
      headerWrapper.style.color = "#" + config.infoColor;
      headerWrapper.innerText = i === 0 ? config.bookName : title;
      headerWrapper.style.setProperty(
        "line-height",
        config.infoBarHeight + "px",
        "important"
      );
      body.appendChild(headerWrapper);
    }
  }
  function setPageFooter(body, pages) {
    for (let i = 0; i < pages; i++) {
      const left = i * body.clientWidth;
      const headerWrapper = document.createElement("div");
      headerWrapper.style.left = left + "px";
      headerWrapper.style.height = config.infoBarHeight + "px";
      headerWrapper.style.textAlign = "end";
      headerWrapper.style.width = body.clientWidth + "px";
      headerWrapper.style.bottom = config.bottomExtraHeight + "px";
      headerWrapper.style.boxSizing = "border-box";
      headerWrapper.style.paddingLeft = config.marginHorizontal + "px";
      headerWrapper.style.paddingRight = config.marginHorizontal + "px";
      headerWrapper.style.position = "absolute";
      headerWrapper.style.fontSize = "13px";
      headerWrapper.style.color = "#" + config.infoColor;
      headerWrapper.innerText = `${i + 1} / ${pages}`;
      headerWrapper.style.setProperty(
        "line-height",
        config.infoBarHeight + "px",
        "important"
      );
      body.appendChild(headerWrapper);
    }
  }
  function getReaderStyleText() {
    const styleText = `html{background:#${config.backgroundColor};
  font-size:${config.fontSize * 100}%
  }`;
    return styleText;
  }
  async function appendChapter(html, title, index) {
    html = getHeader(html);
    console.log("追加内容", title, html.length, index);
    const chapterDiv = document.createElement("div");
    chapterDiv.style.breakInside = "avoid";
    const iframe = document.createElement("iframe");
    iframe.srcdoc = html;
    iframe.setAttribute(
      "style",
      `border:none;width:100vw;height:${getFullHeight()};display:block;`
    );
    let currentPages = 0;
    iframe.addEventListener("load", (_) => {
      var _a, _b;
      var iframeDoc = (_b = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document)) == null ? void 0 : _b.body;
      var img = iframeDoc.querySelector("#translate-img");
      img.style.left = iframeDoc.scrollWidth + "px";
      console.log(iframeDoc == null ? void 0 : iframeDoc.scrollWidth);
      iframe.style.width = iframeDoc.scrollWidth + config.marginHorizontal + "px";
      const pages = Math.round(iframeDoc.scrollWidth / innerWidth);
      setPageHeader(iframeDoc, title, pages);
      setPageFooter(iframeDoc, pages);
      currentPages = pages;
    });
    chapterDiv.appendChild(iframe);
    virtualReader.appendChild(chapterDiv);
    function runLoop() {
      const imgs = iframe.getElementsByTagName("img");
      let intervalId;
      const promise = new Promise((res) => {
        intervalId = setInterval(() => {
          for (let img of imgs) {
            if (!img.complete)
              return;
          }
          clearInterval(intervalId);
          res(true);
        }, 50);
      });
      return promise;
    }
    await runLoop();
    console.log(currentPages, "当前页数");
    return currentPages;
  }
  async function insertChapter(html, title, index) {
    html = getHeader(html);
    console.log("插入内容", title, html.length, index);
    const chapterDiv = document.createElement("div");
    chapterDiv.style.breakInside = "avoid";
    const iframe = document.createElement("iframe");
    iframe.srcdoc = html;
    iframe.setAttribute(
      "style",
      `border:none;width:100vw;height:${getFullHeight()};display:block;`
    );
    let currentPages = 0;
    let jumpWidth = 0;
    iframe.addEventListener("load", (_) => {
      var _a, _b;
      var iframeDoc = (_b = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document)) == null ? void 0 : _b.body;
      var img = iframeDoc.querySelector("#translate-img");
      img.style.left = iframeDoc.scrollWidth + "px";
      console.log(iframeDoc == null ? void 0 : iframeDoc.scrollWidth);
      iframe.style.width = iframeDoc.scrollWidth + config.marginHorizontal + "px";
      const pages = Math.round(iframeDoc.scrollWidth / innerWidth);
      setPageHeader(iframeDoc, title, pages);
      setPageFooter(iframeDoc, pages);
      jumpWidth = iframeDoc.scrollWidth;
      window.scrollBy(jumpWidth + config.marginHorizontal, 0);
      currentPages = pages;
    });
    chapterDiv.appendChild(iframe);
    virtualReader.insertBefore(chapterDiv, virtualReader.firstChild);
    function runLoop() {
      const imgs = iframe.getElementsByTagName("img");
      let intervalId;
      const promise = new Promise((res) => {
        intervalId = setInterval(() => {
          console.log(currentPages, jumpWidth, "currentPagescurrentPages");
          for (let img of imgs) {
            if (!img.complete)
              return;
          }
          clearInterval(intervalId);
          res(true);
        }, 50);
      });
      return promise;
    }
    await runLoop();
    console.log(currentPages, jumpWidth, "当前页数");
    return currentPages;
  }
  async function refreshChapter(html, title, index) {
    virtualReader.innerHTML = "";
    return await appendChapter(html, title, index);
  }
  return { init, appendChapter, insertChapter, refreshChapter };
})();
