(function(){"use strict";try{if(typeof document!="undefined"){var e=document.createElement("style");e.appendChild(document.createTextNode("/*! normalize.css v8.0.1 | MIT License | github.com/necolas/normalize.css */html{line-height:1.15;-webkit-text-size-adjust:100%}body{margin:0}main{display:block}h1{font-size:2em;margin:.67em 0}hr{box-sizing:content-box;height:0;overflow:visible}pre{font-family:monospace,monospace;font-size:1em}a{background-color:transparent}abbr[title]{border-bottom:none;text-decoration:underline;text-decoration:underline dotted}b,strong{font-weight:bolder}code,kbd,samp{font-family:monospace,monospace;font-size:1em}small{font-size:80%}sub,sup{font-size:75%;line-height:0;position:relative;vertical-align:baseline}sub{bottom:-.25em}sup{top:-.5em}img{border-style:none}button,input,optgroup,select,textarea{font-family:inherit;font-size:100%;line-height:1.15;margin:0}button,input{overflow:visible}button,select{text-transform:none}button,[type=button],[type=reset],[type=submit]{-webkit-appearance:button}button::-moz-focus-inner,[type=button]::-moz-focus-inner,[type=reset]::-moz-focus-inner,[type=submit]::-moz-focus-inner{border-style:none;padding:0}button:-moz-focusring,[type=button]:-moz-focusring,[type=reset]:-moz-focusring,[type=submit]:-moz-focusring{outline:1px dotted ButtonText}fieldset{padding:.35em .75em .625em}legend{box-sizing:border-box;color:inherit;display:table;max-width:100%;padding:0;white-space:normal}progress{vertical-align:baseline}textarea{overflow:auto}[type=checkbox],[type=radio]{box-sizing:border-box;padding:0}[type=number]::-webkit-inner-spin-button,[type=number]::-webkit-outer-spin-button{height:auto}[type=search]{-webkit-appearance:textfield;outline-offset:-2px}[type=search]::-webkit-search-decoration{-webkit-appearance:none}::-webkit-file-upload-button{-webkit-appearance:button;font:inherit}details{display:block}summary{display:list-item}template{display:none}[hidden]{display:none}#virtual-wrapper{position:fixed;left:0;top:0;opacity:0;z-index:-1}#reader{z-index:99;display:flex;z-index:10}*{outline:none!important}body{padding:0!important;word-break:break-word}html{margin:0!important;padding:0!important}sup{vertical-align:top!important}sub{vertical-align:bottom!important}img{max-width:100%!important}")),document.head.appendChild(e)}}catch(t){console.error("vite-plugin-css-injected-by-js",t)}})();
const normalize = "";
globalThis.readerContainerClassName = "";
globalThis.readerContainerSelector = "";
const _default = "";
var NEWTON_ITERATIONS = 4;
var NEWTON_MIN_SLOPE = 1e-3;
var SUBDIVISION_PRECISION = 1e-7;
var SUBDIVISION_MAX_ITERATIONS = 10;
var kSplineTableSize = 11;
var kSampleStepSize = 1 / (kSplineTableSize - 1);
var float32ArraySupported = typeof Float32Array === "function";
function A(aA1, aA2) {
  return 1 - 3 * aA2 + 3 * aA1;
}
function B(aA1, aA2) {
  return 3 * aA2 - 6 * aA1;
}
function C(aA1) {
  return 3 * aA1;
}
function calcBezier(aT, aA1, aA2) {
  return ((A(aA1, aA2) * aT + B(aA1, aA2)) * aT + C(aA1)) * aT;
}
function getSlope(aT, aA1, aA2) {
  return 3 * A(aA1, aA2) * aT * aT + 2 * B(aA1, aA2) * aT + C(aA1);
}
function binarySubdivide(aX, aA, aB, mX1, mX2) {
  var currentX, currentT, i = 0;
  do {
    currentT = aA + (aB - aA) / 2;
    currentX = calcBezier(currentT, mX1, mX2) - aX;
    if (currentX > 0) {
      aB = currentT;
    } else {
      aA = currentT;
    }
  } while (Math.abs(currentX) > SUBDIVISION_PRECISION && ++i < SUBDIVISION_MAX_ITERATIONS);
  return currentT;
}
function newtonRaphsonIterate(aX, aGuessT, mX1, mX2) {
  for (var i = 0; i < NEWTON_ITERATIONS; ++i) {
    var currentSlope = getSlope(aGuessT, mX1, mX2);
    if (currentSlope === 0) {
      return aGuessT;
    }
    var currentX = calcBezier(aGuessT, mX1, mX2) - aX;
    aGuessT -= currentX / currentSlope;
  }
  return aGuessT;
}
function LinearEasing(x) {
  return x;
}
var src = function bezier(mX1, mY1, mX2, mY2) {
  if (!(0 <= mX1 && mX1 <= 1 && 0 <= mX2 && mX2 <= 1)) {
    throw new Error("bezier x values must be in [0, 1] range");
  }
  if (mX1 === mY1 && mX2 === mY2) {
    return LinearEasing;
  }
  var sampleValues = float32ArraySupported ? new Float32Array(kSplineTableSize) : new Array(kSplineTableSize);
  for (var i = 0; i < kSplineTableSize; ++i) {
    sampleValues[i] = calcBezier(i * kSampleStepSize, mX1, mX2);
  }
  function getTForX(aX) {
    var intervalStart = 0;
    var currentSample = 1;
    var lastSample = kSplineTableSize - 1;
    for (; currentSample !== lastSample && sampleValues[currentSample] <= aX; ++currentSample) {
      intervalStart += kSampleStepSize;
    }
    --currentSample;
    var dist = (aX - sampleValues[currentSample]) / (sampleValues[currentSample + 1] - sampleValues[currentSample]);
    var guessForT = intervalStart + dist * kSampleStepSize;
    var initialSlope = getSlope(guessForT, mX1, mX2);
    if (initialSlope >= NEWTON_MIN_SLOPE) {
      return newtonRaphsonIterate(aX, guessForT, mX1, mX2);
    } else if (initialSlope === 0) {
      return guessForT;
    } else {
      return binarySubdivide(aX, intervalStart, intervalStart + kSampleStepSize, mX1, mX2);
    }
  }
  return function BezierEasing(x) {
    if (x === 0) {
      return 0;
    }
    if (x === 1) {
      return 1;
    }
    return calcBezier(getTForX(x), mY1, mY2);
  };
};
const resetStyles = (elements) => {
  for (let element of elements) {
    element.style.margin = "0px";
    element.style.padding = "0px";
    element.style.border = "none";
  }
};
const jumpToPage = (page) => {
  document.getElementsByTagName("html")[0].scrollTo(window.innerWidth * page, 0);
  return setTimeout(() => true);
};
function disableLongHit() {
  document.body.style.userSelect = "none";
}
function enableLongHit() {
  document.body.style.userSelect = "unset";
}
const ua = navigator.userAgent;
const isApp = ua.indexOf("ReaderJs") > -1;
console.log("xxx", isApp);
if (isApp) {
  globalThis.JsBridge = (...args) => globalThis.flutter_inappwebview.callHandler("jsBridge", ...args);
} else {
  globalThis.JsBridge = (...args) => console.log(args);
}
globalThis.ReaderJs = (() => {
  let currentPage = 0;
  let touchStartX = 0;
  let touchEndX = 0;
  let currentX = 0;
  let currentTs = 0;
  let DURATION = 300;
  let pageContainer;
  let bookContainer;
  let pageHorizontalMargin;
  let pageVerticalMargin;
  let pageWidth;
  let pageHeight;
  let pagedHorizontally;
  let virtualPageCount;
  function init(config) {
    console.log("---init---");
    console.log("当前配置", config);
    globalThis.config = config;
    const virtualReaderContainer = document.getElementById("virtual-reader");
    for (let i = 0; i < 8; i++) {
      let className = "__reader_x_" + i;
      readerContainerClassName += " " + className;
      readerContainerSelector += "." + className;
    }
    virtualReaderContainer.className = readerContainerClassName;
    globalThis.typefacesStyleElement = document.createElement("style");
    globalThis.typefacesStyleElement.setAttribute("type", "text/css");
    document.head.appendChild(globalThis.typefacesStyleElement);
    globalThis.fontStyleElement = document.createElement("style");
    globalThis.fontStyleElement.setAttribute("type", "text/css");
    document.head.appendChild(globalThis.fontStyleElement);
    globalThis.readerStyleElement = document.createElement("style");
    globalThis.readerStyleElement.setAttribute("type", "text/css");
    document.head.appendChild(globalThis.readerStyleElement);
    initReaderContainerStyle(config);
    globalThis.JsBridge("initDone", window.innerWidth, window.innerHeight);
  }
  function initEvent() {
    const reader = document.getElementById("reader");
    reader.addEventListener("touchstart", (e) => {
      const touch = e.targetTouches[0];
      touchStartX = touch.pageX;
    });
    reader.addEventListener("touchmove", (e) => {
      const touch = e.targetTouches[0];
      touchEndX = touch.pageX;
      const distance = (touchEndX - touchStartX) * 1;
      reader.style.transform = `translateX(${currentX + distance}px)  translateZ(0)`;
    });
    reader.addEventListener("touchend", () => {
      const _currentX = currentX;
      currentX = parseFloat(
        reader.style.transform.replace("translateX(", "").replace("px)", "")
      );
      currentTs = window.performance.now();
      const endTs = currentTs + DURATION;
      const destX = (_currentX < currentX ? --currentPage : ++currentPage) * window.innerWidth * -1;
      const allDistance = destX - currentX;
      var easing = src(0, 0, 1, 0);
      const animeHandler = () => {
        requestAnimationFrame(() => {
          const cts = window.performance.now();
          if (cts < endTs) {
            const percent = (cts - currentTs) / DURATION;
            const distance = easing(percent) * allDistance;
            reader.style.transform = `translateX(${currentX + distance}px) translateZ(0)`;
            animeHandler();
          } else {
            reader.style.transform = `translateX(${destX}px) translateZ(0)`;
            currentX = destX;
          }
        });
      };
      animeHandler();
    });
  }
  async function setupPaging(index) {
    var _a;
    console.log("--->", bookContainer);
    if (!pageContainer) {
      bookContainer = document.createElement("div");
      bookContainer.className = "book-container";
      var collapseWrapper = document.createElement("div");
      collapseWrapper.style.webkitMarginCollapse = "separate";
      const virtualReader2 = document.getElementById("virtual-reader");
      for (var node of virtualReader2.childNodes) {
        collapseWrapper.appendChild(node.cloneNode(true));
      }
      bookContainer.appendChild(collapseWrapper);
      pageContainer = document.createElement("div");
      pageContainer.className = "page-container";
      pageContainer.appendChild(bookContainer);
      pageContainer.style.position = "relative";
      pageContainer.setAttribute("data-cpt", index.toString());
      virtualReader2.replaceChildren(pageContainer);
      resetStyles([pageContainer, bookContainer]);
    }
    const virtualReader = document.getElementById("virtual-reader");
    pageHorizontalMargin = globalThis.config.marginHorizontal * 2;
    pageVerticalMargin = (globalThis.config.marginVertical + globalThis.config.infoBarHeight) * 2 + globalThis.config.topExtraHeight + globalThis.config.bottomExtraHeight;
    pageWidth = window.innerWidth - pageHorizontalMargin;
    pageHeight = window.innerHeight - pageVerticalMargin;
    var bodyComputed = window.getComputedStyle(virtualReader);
    var htmlComputed = window.getComputedStyle(
      document.getElementsByTagName("html")[0]
    );
    pagedHorizontally = bodyComputed.writingMode.indexOf("vertical") == -1 && htmlComputed.writingMode.indexOf("vertical") == -1;
    bookContainer.style.width = pageWidth + "px";
    bookContainer.style.height = pageHeight + "px";
    bookContainer.style.webkitColumnWidth = (pagedHorizontally ? pageWidth : pageHeight) + "px";
    bookContainer.style.webkitColumnGap = (pagedHorizontally ? pageHorizontalMargin : pageVerticalMargin) + "px";
    bookContainer.style.textIndent = ((_a = globalThis.config) == null ? void 0 : _a.textIndent) + "px";
    let endSpacer = getVirtualSpacer();
    const imgs = pageContainer.getElementsByTagName("img");
    function runLoop() {
      let intervalId;
      const promise = new Promise((res) => {
        intervalId = setInterval(() => {
          for (let img of imgs) {
            if (!img.complete)
              return;
          }
          clearInterval(intervalId);
          res(true);
        }, 500);
      });
      return promise;
    }
    await runLoop();
    virtualReader.appendChild(endSpacer);
  }
  function getVirtualSpacer() {
    let endSpacer = document.getElementById("virtual-reader-spacer");
    if (!endSpacer) {
      endSpacer = document.createElement("div");
      endSpacer.id = "virtual-reader-spacer";
      endSpacer.className = "spacer";
      endSpacer.setAttribute(
        "style",
        `
          position:absolute;
          top:0;
          height:1px;
          width:1px;
        `
      );
    }
    return endSpacer;
  }
  async function setupFlow(index) {
    await setupPaging(index);
  }
  async function initReader(index) {
    await setupFlow(index);
  }
  function setupPageInfos(chapterName, insert = false) {
    const virtualReader = document.getElementById("virtual-reader");
    let pages = 0;
    let endSpacer = getVirtualSpacer();
    if (globalThis.config.horizontal) {
      pages = Math.ceil(
        virtualReader.scrollWidth / (pageWidth + pageHorizontalMargin)
      );
      if (insert)
        currentPage += virtualPageCount;
      endSpacer.style.left = pages * (pageWidth + pageHorizontalMargin) - 1 + "px";
    }
    let width = window.innerWidth;
    for (let i = 0; i < pages; i++) {
      const headerElem = document.createElement("div");
      headerElem.className = "reader-app-page-header reader-app-page-info";
      headerElem.setAttribute(
        "style",
        `
          position: absolute;
          top: ${-// globalThis.config!.topExtraHeight +
        (globalThis.config.infoBarHeight + globalThis.config.marginVertical) + "px"};
          left: ${width * i + "px"};
          width: 100%;
          height: ${globalThis.config.infoBarHeight + "px"};
          box-sizing: border-box;
          display: flex;
          align-items: flex-end;
          text-overflow: ellipsis;
          overflow: hidden;
          white-space: nowrap;
      `
      );
      const headerLeftElem = document.createElement("div");
      headerLeftElem.setAttribute(
        "style",
        `
        display: inline-block; 
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        font-size: 13px !important;
        // color: #${globalThis.config.infoColor} !important;
      `
      );
      headerLeftElem.innerText = i == 0 ? globalThis.config.bookName : chapterName;
      headerElem.appendChild(headerLeftElem);
      pageContainer.appendChild(headerElem);
      const footerElem = document.createElement("div");
      footerElem.className = "reader-app-page-footer reader-app-page-info";
      footerElem.setAttribute(
        "style",
        `
          position: absolute;
          bottom: ${-// globalThis.config!.bottomExtraHeight +
        (globalThis.config.infoBarHeight + globalThis.config.marginVertical) + "px"};
          left: ${width * i + "px"};
          width: 100%;
          height: ${globalThis.config.infoBarHeight + "px"};
          box-sizing: border-box;
          font-size: 13px !important;
          // color: #${globalThis.config.infoColor} !important;
          display: flex;
          align-items: flex-start;
          justify-content: flex-end;
      `
      );
      footerElem.innerText = `${i + 1}/${pages}`;
      pageContainer.appendChild(footerElem);
    }
    pageContainer == null ? void 0 : pageContainer.setAttribute("data-pages", pages.toString());
    pageContainer == null ? void 0 : pageContainer.setAttribute("data-name", chapterName);
    return Math.round(pages);
  }
  function initReaderContainerStyle(config) {
    document.body.style.backgroundColor = `#${config.backgroundColor}`;
    const virtualReaderContainer = document.getElementById("virtual-reader");
    virtualReaderContainer.style.paddingLeft = config.marginHorizontal + "px";
    virtualReaderContainer.style.paddingRight = config.marginHorizontal + "px";
    virtualReaderContainer.style.paddingBottom = config.infoBarHeight + config.marginVertical + config.bottomExtraHeight + "px";
    virtualReaderContainer.style.paddingTop = config.infoBarHeight + config.marginVertical + config.topExtraHeight + "px";
    virtualReaderContainer.style.left = "0";
    virtualReaderContainer.style.top = "0";
    updateReaderStyleElement();
  }
  function updateReaderStyleElement() {
    var style = "line-height: " + globalThis.config.lineSpacing + " !important;font-size: " + globalThis.config.fontSize + "px !important;";
    switch (globalThis.config.textAlign) {
      case 0:
        style += "text-align: initial !important;";
        break;
      case 1:
        style += "text-align: justify !important;";
        break;
      case 2:
        style += "text-align: end !important;";
        break;
      case 3:
        style += "text-align: center !important;";
        break;
    }
    const infoStyle = ` .reader-app-page-info {color:#${globalThis.config.infoColor} !important;}`;
    const bookTextStyle = `.book-container {color:#${globalThis.config.textColor}}`;
    globalThis.readerStyleElement.innerText = globalThis.readerContainerSelector + " * { " + style + " } " + bookTextStyle + infoStyle;
  }
  function updateReaderPage() {
    var _a;
    let width = window.innerWidth;
    const reader = document.getElementById("reader");
    const pageContainers = reader.querySelectorAll(".page-container");
    let endSpacer = document.getElementById("reader-spacer");
    let allPages = 0;
    let tmpPage = 0;
    let pageMap = {};
    for (let pageContainer2 of pageContainers) {
      const cpt = pageContainer2.getAttribute("data-cpt");
      pageContainer2.style.marginLeft = (tmpPage === 0 ? 0 : width * (tmpPage - 1) + 2 * ((_a = globalThis.config) == null ? void 0 : _a.marginHorizontal)) + "px";
      tmpPage = updatePageInfos(pageContainer2);
      pageMap[cpt] = tmpPage;
      allPages += tmpPage;
    }
    endSpacer.style.left = allPages * width - 1 + 0 * globalThis.config.marginHorizontal + "px";
    console.log("xxxx", pageMap);
    return pageMap;
  }
  function updatePageInfos(pageContainer2) {
    const chapterName = pageContainer2.getAttribute("data-name");
    let width = window.innerWidth;
    let pages = 0;
    pageContainer2.querySelectorAll(".reader-app-page-info").forEach((e) => {
      e.remove();
    });
    if (globalThis.config.horizontal) {
      pages = Math.ceil(
        pageContainer2.scrollWidth / (pageWidth + pageHorizontalMargin)
      );
    }
    pageContainer2 == null ? void 0 : pageContainer2.setAttribute("data-pages", pages.toString());
    for (let i = 0; i < pages; i++) {
      const headerElem = document.createElement("div");
      headerElem.className = "reader-app-page-header reader-app-page-info";
      headerElem.setAttribute(
        "style",
        `
            position: absolute;
            top: ${-// globalThis.config!.topExtraHeight +
        (globalThis.config.infoBarHeight + globalThis.config.marginVertical) + "px"};
            left: ${width * i + "px"};
            width: 100%;
            height: ${globalThis.config.infoBarHeight + "px"};
            box-sizing: border-box;
            display: flex;
            align-items: flex-end;
            text-overflow: ellipsis;
            overflow: hidden;
            white-space: nowrap;
        `
      );
      const headerLeftElem = document.createElement("div");
      headerLeftElem.setAttribute(
        "style",
        `
          display: inline-block; 
          overflow: hidden;
          white-space: nowrap;
          text-overflow: ellipsis;
          font-size: 13px !important;
          // color: #${globalThis.config.infoColor} !important;
        `
      );
      headerLeftElem.innerText = i == 0 ? globalThis.config.bookName : chapterName;
      headerElem.appendChild(headerLeftElem);
      pageContainer2.appendChild(headerElem);
      const footerElem = document.createElement("div");
      footerElem.className = "reader-app-page-footer reader-app-page-info";
      footerElem.setAttribute(
        "style",
        `
            position: absolute;
            bottom: ${-// globalThis.config!.bottomExtraHeight +
        (globalThis.config.infoBarHeight + globalThis.config.marginVertical) + "px"};
            left: ${width * i + "px"};
            width: 100%;
            height: ${globalThis.config.infoBarHeight + "px"};
            box-sizing: border-box;
            font-size: 13px !important;
            // color: #${globalThis.config.infoColor} !important;
            display: flex;
            align-items: flex-start;
            justify-content: flex-end;
        `
      );
      footerElem.innerText = `${i + 1}/${pages}`;
      pageContainer2.appendChild(footerElem);
    }
    pageContainer2 == null ? void 0 : pageContainer2.setAttribute("data-pages", pages.toString());
    pageContainer2 == null ? void 0 : pageContainer2.setAttribute("data-name", chapterName);
    return Math.round(pages);
  }
  function applyRealReader(insert = false) {
    var _a, _b, _c;
    const reader = document.getElementById("reader");
    const virtualReader = document.getElementById("virtual-reader");
    console.log("追加内容", reader, insert);
    if (reader) {
      const newNode = virtualReader.children[0].cloneNode(true);
      const endSpacer = document.getElementById("reader-spacer");
      const vEndSpacer = getVirtualSpacer();
      if (!insert) {
        const pages = document.querySelectorAll(".page-container");
        const tmpPageContainer = pages[pages.length - 2];
        newNode.style.cssText += `margin-left: ${tmpPageContainer.scrollWidth - pageWidth + 2 * ((_a = globalThis.config) == null ? void 0 : _a.marginHorizontal)}px;`;
        console.log("!!!!!", newNode.style.cssText);
        reader.appendChild(newNode);
        endSpacer.style.left = parseFloat(endSpacer.style.left.replace("px", "")) + parseFloat(vEndSpacer.style.left.replace("px", "")) + 0 * ((_b = globalThis.config) == null ? void 0 : _b.marginHorizontal) + "px";
      } else {
        newNode.style.cssText += `margin-left: 0px;`;
        console.log("!!!", newNode.style.cssText);
        reader.insertBefore(newNode, reader.firstChild);
        const newSpacer = document.getElementById("virtual-reader-spacer");
        endSpacer.style.left = parseFloat(endSpacer.style.left.replace("px", "")) + parseFloat(newSpacer.style.left.replace("px", "")) + 0 * ((_c = globalThis.config) == null ? void 0 : _c.marginHorizontal) + "px";
        const children = reader.children;
        let tmpMl = parseFloat(newSpacer.style.left.replace("px", "")) - pageWidth + "px";
        for (let i = 1; i < children.length; i++) {
          const elem = children[i];
          if (elem.id === "reader-spacer")
            continue;
          elem.style.marginLeft = i === 1 ? tmpMl : elem.style.marginLeft;
        }
        const offset = parseFloat(newSpacer.style.left.replace("px", ""));
        if (globalThis.config.enableScroll) {
          reader.style.transform = `translateX(-${newSpacer.style.left})`;
        } else {
          document.querySelector("html").scrollLeft += offset;
        }
        currentX = -offset;
      }
    } else {
      const virtualWrapper = document.getElementById("virtual-wrapper");
      document.body.insertBefore(virtualReader.cloneNode(true), virtualWrapper);
      document.body.children[0].id = "reader";
      document.querySelector(".spacer").id = "reader-spacer";
      if (globalThis.config.enableScroll) {
        initEvent();
        document.getElementById("reader").style.position = "fixed";
      }
    }
  }
  async function appendChapter(body, title, index) {
    const div = document.createElement("div");
    div.innerHTML = body;
    pageContainer = void 0;
    const shadow = document.getElementById("virtual-reader");
    shadow.innerHTML = "";
    if (globalThis.config.extraTitle) {
      const titleWrapprer = document.createElement("div");
      titleWrapprer.className = "title-wrapper";
      titleWrapprer.innerText = title;
      titleWrapprer.setAttribute(
        "style",
        `
        text-indent: 0;
        margin-top: 32px;
        margin-bottom: 48px;
        font-weight: bold;
        text-align: start !important;
        font-size: ${globalThis.config.fontSize + 2}px !important;
      `
      );
      shadow.appendChild(titleWrapprer);
    }
    for (let child of div.children) {
      shadow.appendChild(child.cloneNode(true));
    }
    await initReader(index);
    const pageNum = setupPageInfos(title);
    globalThis.JsBridge("notifySize", pageNum);
    applyRealReader();
    console.log(pageNum, "appendCpt");
    return Math.round(pageNum);
  }
  async function insertChapter(body, title, index) {
    const div = document.createElement("div");
    div.innerHTML = body;
    pageContainer = void 0;
    const shadow = document.getElementById("virtual-reader");
    shadow.innerHTML = "";
    for (let child of div.children) {
      shadow.appendChild(child.cloneNode(true));
    }
    await initReader(index);
    const pageNum = setupPageInfos(title, true);
    globalThis.JsBridge("notifySize", pageNum);
    applyRealReader(true);
    console.log(pageNum, "insertCpt");
    return Math.round(pageNum);
  }
  async function refreshChapter(body, title, index) {
    var _a;
    (_a = document.getElementById("reader")) == null ? void 0 : _a.remove();
    document.getElementById("virtual-reader").innerHTML = "";
    return await appendChapter(body, title, index);
  }
  function setFontSize(fontSize) {
    globalThis.config.fontSize = fontSize;
    updateReaderStyleElement();
    return updateReaderPage();
  }
  function setLineSpacing(lineSpacing) {
    globalThis.config.lineSpacing = lineSpacing;
    updateReaderStyleElement();
    return updateReaderPage();
  }
  function setTextAlign(textAlign) {
    globalThis.config.textAlign = textAlign;
    updateReaderStyleElement();
  }
  function setBackgroundColor(color) {
    globalThis.config.backgroundColor = color;
    const c = color[0] === "#" ? color : "#" + color;
    document.body.style.backgroundColor = `${c}`;
  }
  function setTextColor(color) {
    globalThis.config.textColor = color;
    updateReaderStyleElement();
  }
  function setInfoColor(color) {
    globalThis.config.infoColor = color;
    updateReaderStyleElement();
  }
  function setLinkColor(color) {
    globalThis.config.linkColor = color;
    document.body.style.backgroundColor = color;
  }
  function setTextIndent(indent) {
    globalThis.config.textIndent = indent;
    bookContainer.style.textIndent = indent;
  }
  function updateTheme(backgroundColor, textColor, infoColor, linkColor) {
    try {
      setBackgroundColor(backgroundColor);
      setTextColor(textColor);
      setInfoColor(infoColor);
      setLinkColor(`#${linkColor}`);
      return true;
    } catch (err) {
      return false;
    }
  }
  return {
    init,
    appendChapter,
    insertChapter,
    refreshChapter,
    setFontSize,
    setLineSpacing,
    setTextAlign,
    setBackgroundColor,
    setTextColor,
    setInfoColor,
    setTextIndent,
    jumpToPage,
    updateTheme,
    disableLongHit,
    enableLongHit
  };
})();
