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
if (typeof Node === "undefined") {
  var ELEMENT_NODE = 1;
  var TEXT_NODE = 3;
  var CDATA_SECTION_NODE = 4;
} else {
  var ELEMENT_NODE = Node.ELEMENT_NODE;
  var TEXT_NODE = Node.TEXT_NODE;
  var CDATA_SECTION_NODE = Node.CDATA_SECTION_NODE;
}
function cfiEscape(str) {
  return str.replace(/[\[\]\^,();]/g, "^$&");
}
function matchAll(str, regExp, add) {
  add = add || 0;
  var matches = [];
  var offset = 0;
  var m;
  do {
    m = str.match(regExp);
    if (!m)
      break;
    matches.push(m.index + add);
    offset += m.index + m.length;
    str = str.slice(m.index + m.length);
  } while (offset < str.length);
  return matches;
}
function closest(a, n) {
  var minDiff;
  var closest2;
  var i, diff;
  for (i = 0; i < a.length; i++) {
    diff = Math.abs(a[i] - n);
    if (!i || diff < minDiff) {
      diff = minDiff;
      closest2 = a[i];
    }
  }
  return closest2;
}
function calcSiblingCount(nodes, n, offset) {
  var count = 0;
  var lastWasElement;
  var prevOffset = 0;
  var firstNode = true;
  var i, node;
  for (i = 0; i < nodes.length; i++) {
    node = nodes[i];
    if (node.nodeType === ELEMENT_NODE) {
      if (lastWasElement || firstNode) {
        count += 2;
        firstNode = false;
      } else {
        count++;
      }
      if (n === node) {
        if (node.tagName.toLowerCase() === "img") {
          return { count, offset };
        } else {
          return { count };
        }
      }
      prevOffset = 0;
      lastWasElement = true;
    } else if (node.nodeType === TEXT_NODE || node.nodeType === CDATA_SECTION_NODE) {
      if (lastWasElement || firstNode) {
        count++;
        firstNode = false;
      }
      if (n === node) {
        return { count, offset: offset + prevOffset };
      }
      prevOffset += node.textContent.length;
      lastWasElement = false;
    } else {
      continue;
    }
  }
  throw new Error("The specified node was not found in the array of siblings");
}
function compareTemporal(a, b) {
  const isA = typeof a === "number";
  const isB = typeof b === "number";
  if (!isA && !isB)
    return 0;
  if (!isA && isB)
    return -1;
  if (isA && !isB)
    return 1;
  return (a || 0) - (b || 0);
}
function compareSpatial(a, b) {
  if (!a && !b)
    return 0;
  if (!a && b)
    return -1;
  if (a && !b)
    return 1;
  var diff = (a.y || 0) - (b.y || 0);
  if (diff)
    return diff;
  return (a.x || 0) - (b.x || 0);
}
class CFI {
  constructor(str, opts) {
    this.opts = Object.assign({
      // If CFI is a Simple Range, pretend it isn't
      // by parsing only the start of the range
      flattenRange: false,
      // Strip temporal, spatial, offset and textLocationAssertion
      // from places where they don't make sense
      stricter: true
    }, opts || {});
    this.cfi = str;
    const isCFI = new RegExp(/^epubcfi\((.*)\)$/);
    str = str.trim();
    var m = str.match(isCFI);
    if (!m)
      throw new Error("Not a valid CFI");
    if (m.length < 2)
      return;
    str = m[1];
    this.parts = [];
    var parsed, offset, newDoc;
    var subParts = [];
    var sawComma = 0;
    while (str.length) {
      ({ parsed, offset, newDoc } = this.parse(str));
      if (!parsed || offset === null)
        throw new Error("Parsing failed");
      if (sawComma && newDoc)
        throw new Error("CFI is a range that spans multiple documents. This is not allowed");
      subParts.push(parsed);
      if (newDoc || str.length - offset <= 0) {
        if (sawComma === 2) {
          this.to = subParts;
        } else {
          this.parts.push(subParts);
        }
        subParts = [];
      }
      str = str.slice(offset);
      if (str[0] === ",") {
        if (sawComma === 0) {
          if (subParts.length) {
            this.parts.push(subParts);
          }
          subParts = [];
        } else if (sawComma === 1) {
          if (subParts.length) {
            this.from = subParts;
          }
          subParts = [];
        }
        str = str.slice(1);
        sawComma++;
      }
    }
    if (this.from && this.from.length) {
      if (this.opts.flattenRange || !this.to || !this.to.length) {
        this.parts = this.parts.concat(this.from);
        delete this.from;
        delete this.to;
      } else {
        this.isRange = true;
      }
    }
    if (this.opts.stricter) {
      this.removeIllegalOpts();
    }
  }
  removeIllegalOpts(parts) {
    if (!parts) {
      if (this.from) {
        this.removeIllegalOpts(this.from);
        if (!this.to)
          return;
        parts = this.to;
      } else {
        parts = this.parts;
      }
    }
    var i, j, part, subpart;
    for (i = 0; i < parts.length; i++) {
      part = parts[i];
      for (j = 0; j < part.length - 1; j++) {
        subpart = part[j];
        delete subpart.temporal;
        delete subpart.spatial;
        delete subpart.offset;
        delete subpart.textLocationAssertion;
      }
    }
  }
  static generatePart(node, offset, extra) {
    var cfi = "";
    var o;
    var isSpineElement = node.parentNode.nodeName === "spine" ? true : false;
    while (node.parentNode) {
      o = calcSiblingCount(node.parentNode.childNodes, node, offset);
      if (!cfi && o.offset)
        cfi = ":" + o.offset;
      cfi = "/" + o.count + (node.id ? "[" + cfiEscape(node.id) + "]" : "") + cfi;
      node = node.parentNode;
      if (isSpineElement && node.nodeName === "package") {
        break;
      }
    }
    return cfi;
  }
  static generate(node, offset, extra) {
    var cfi;
    if (node instanceof Array) {
      var strs = [];
      for (let o of node) {
        strs.push(this.generatePart(o.node, o.offset));
      }
      cfi = strs.join("!");
    } else {
      cfi = this.generatePart(node, offset, extra);
    }
    if (extra)
      cfi += extra;
    return "epubcfi(" + cfi + ")";
  }
  static toParsed(cfi) {
    if (typeof cfi === "string")
      cif = new this(cfi);
    if (cfi.isRange) {
      return cfi.getFrom();
    } else {
      return cfi.get();
    }
  }
  // Takes two CFI paths and compares them
  static comparePath(a, b) {
    const max = Math.max(a.length, b.length);
    var i, cA, cB, diff;
    for (i = 0; i < max; i++) {
      cA = a[i];
      cB = b[i];
      if (!cA)
        return -1;
      if (!cB)
        return 1;
      diff = this.compareParts(cA, cB);
      if (diff)
        return diff;
    }
    return 0;
  }
  // Sort an array of CFI objects
  static sort(a) {
    a.sort((a2, b) => {
      return this.compare(a2, b);
    });
  }
  // Takes two CFI objects and compares them.
  static compare(a, b) {
    var oA = a.get();
    var oB = b.get();
    if (a.isRange || b.isRange) {
      if (a.isRange && b.isRange) {
        var diff = this.comparePath(oA.from, oB.from);
        if (diff)
          return diff;
        return this.comparePath(oA.to, oB.to);
      }
      if (a.isRange)
        oA = oA.from;
      if (b.isRange)
        oB = oB.from;
      return this.comparePath(oA, oB);
    } else {
      return this.comparePath(oA, oB);
    }
  }
  // Takes two parsed path parts (assuming path is split on '!') and compares them.
  static compareParts(a, b) {
    const max = Math.max(a.length, b.length);
    var i, cA, cB, diff;
    for (i = 0; i < max; i++) {
      cA = a[i];
      cB = b[i];
      if (!cA)
        return -1;
      if (!cB)
        return 1;
      diff = cA.nodeIndex - cB.nodeIndex;
      if (diff)
        return diff;
      if (cA.nodeIndex === 0) {
        return 0;
      }
      if (i < max - 1)
        continue;
      if (cA.nodeIndex % 2 === 0) {
        diff = compareTemporal(cA.temporal, cB.temporal);
        if (diff)
          return diff;
        diff = compareSpatial(cA.spatial, cB.spatial);
        if (diff)
          return diff;
      }
      diff = (cA.offset || 0) - (cB.offset || 0);
      if (diff)
        return diff;
    }
    return 0;
  }
  decodeEntities(dom, str) {
    try {
      const el = dom.createElement("textarea");
      el.innerHTML = str;
      return el.value;
    } catch (err) {
      return str;
    }
  }
  // decode HTML/XML entities and compute length
  trueLength(dom, str) {
    return this.decodeEntities(dom, str).length;
  }
  getFrom() {
    if (!this.isRange)
      throw new Error("Trying to get beginning of non-range CFI");
    if (!this.from) {
      return this.deepClone(this.parts);
    }
    const parts = this.deepClone(this.parts);
    parts[parts.length - 1] = parts[parts.length - 1].concat(this.from);
    return parts;
  }
  getTo() {
    if (!this.isRange)
      throw new Error("Trying to get end of non-range CFI");
    const parts = this.deepClone(this.parts);
    parts[parts.length - 1] = parts[parts.length - 1].concat(this.to);
    return parts;
  }
  get() {
    if (this.isRange) {
      return {
        from: this.getFrom(),
        to: this.getTo(),
        isRange: true
      };
    }
    return this.deepClone(this.parts);
  }
  parseSideBias(o, loc) {
    if (!loc)
      return;
    const m = loc.trim().match(/^(.*);s=([ba])$/);
    if (!m || m.length < 3) {
      if (typeof o.textLocationAssertion === "object") {
        o.textLocationAssertion.post = loc;
      } else {
        o.textLocationAssertion = loc;
      }
      return;
    }
    if (m[1]) {
      if (typeof o.textLocationAssertion === "object") {
        o.textLocationAssertion.post = m[1];
      } else {
        o.textLocationAssertion = m[1];
      }
    }
    if (m[2] === "a") {
      o.sideBias = "after";
    } else {
      o.sideBias = "before";
    }
  }
  parseSpatialRange(range) {
    if (!range)
      return void 0;
    const m = range.trim().match(/^([\d\.]+):([\d\.]+)$/);
    if (!m || m.length < 3)
      return void 0;
    const o = {
      x: parseInt(m[1]),
      y: parseInt(m[2])
    };
    if (typeof o.x !== "number" || typeof o.y !== "number") {
      return void 0;
    }
    return o;
  }
  parse(cfi) {
    var o = {};
    const isNumber = new RegExp(/[\d]/);
    var f;
    var state;
    var prevState;
    var cur, escape;
    var seenColon = false;
    var seenSlash = false;
    var i;
    for (i = 0; i <= cfi.length; i++) {
      if (i < cfi.length) {
        cur = cfi[i];
      } else {
        cur = "";
      }
      if (cur === "^" && !escape) {
        escape = true;
        continue;
      }
      if (state === "/") {
        if (cur.match(isNumber)) {
          if (!f) {
            f = cur;
          } else {
            f += cur;
          }
          escape = false;
          continue;
        } else {
          if (f) {
            o.nodeIndex = parseInt(f);
            f = null;
          }
          prevState = state;
          state = null;
        }
      }
      if (state === ":") {
        if (cur.match(isNumber)) {
          if (!f) {
            f = cur;
          } else {
            f += cur;
          }
          escape = false;
          continue;
        } else {
          if (f) {
            o.offset = parseInt(f);
            f = null;
          }
          prevState = state;
          state = null;
        }
      }
      if (state === "@") {
        let done = false;
        if (cur.match(isNumber) || cur === "." || cur === ":") {
          if (cur === ":") {
            if (!seenColon) {
              seenColon = true;
            } else {
              done = true;
            }
          }
        } else {
          done = true;
        }
        if (!done) {
          if (!f) {
            f = cur;
          } else {
            f += cur;
          }
          escape = false;
          continue;
        } else {
          prevState = state;
          state = null;
          if (f && seenColon)
            o.spatial = this.parseSpatialRange(f);
          f = null;
        }
      }
      if (state === "~") {
        if (cur.match(isNumber) || cur === ".") {
          if (!f) {
            f = cur;
          } else {
            f += cur;
          }
          escape = false;
          continue;
        } else {
          if (f) {
            o.temporal = parseFloat(f);
          }
          prevState = state;
          state = null;
          f = null;
        }
      }
      if (!state) {
        if (cur === "!") {
          i++;
          state = cur;
          break;
        }
        if (cur === ",") {
          break;
        }
        if (cur === "/") {
          if (seenSlash) {
            break;
          } else {
            seenSlash = true;
            prevState = state;
            state = cur;
            escape = false;
            continue;
          }
        }
        if (cur === ":" || cur === "~" || cur === "@") {
          if (this.opts.stricter) {
            if (cur === ":" && (typeof o.temporal !== "undefined" || typeof o.spatial !== "undefined")) {
              break;
            }
            if ((cur === "~" || cur === "@") && typeof o.offset !== "undefined") {
              break;
            }
          }
          prevState = state;
          state = cur;
          escape = false;
          seenColon = false;
          continue;
        }
        if (cur === "[" && !escape && prevState === ":") {
          prevState = state;
          state = "[";
          escape = false;
          continue;
        }
        if (cur === "[" && !escape && prevState === "/") {
          prevState = state;
          state = "nodeID";
          escape = false;
          continue;
        }
      }
      if (state === "[") {
        if (cur === "]" && !escape) {
          prevState = state;
          state = null;
          this.parseSideBias(o, f);
          f = null;
        } else if (cur === "," && !escape) {
          o.textLocationAssertion = {};
          if (f) {
            o.textLocationAssertion.pre = f;
          }
          f = null;
        } else {
          if (!f) {
            f = cur;
          } else {
            f += cur;
          }
        }
        escape = false;
        continue;
      }
      if (state === "nodeID") {
        if (cur === "]" && !escape) {
          prevState = state;
          state = null;
          o.nodeID = f;
          f = null;
        } else {
          if (!f) {
            f = cur;
          } else {
            f += cur;
          }
        }
        escape = false;
        continue;
      }
      escape = false;
    }
    if (!o.nodeIndex && o.nodeIndex !== 0)
      throw new Error("Missing child node index in CFI");
    return { parsed: o, offset: i, newDoc: state === "!" };
  }
  // The CFI counts child nodes differently from the DOM
  // Retrive the child of parentNode at the specified index
  // according to the CFI standard way of counting
  getChildNodeByCFIIndex(dom, parentNode, index, offset) {
    const children = parentNode.childNodes;
    if (!children.length)
      return { node: parentNode, offset: 0 };
    if (index <= 0) {
      return { node: children[0], relativeToNode: "before", offset: 0 };
    }
    var cfiCount = 0;
    var lastChild;
    var i, child;
    for (i = 0; i < children.length; i++) {
      child = children[i];
      switch (child.nodeType) {
        case ELEMENT_NODE:
          if (cfiCount % 2 === 0) {
            cfiCount += 2;
            if (cfiCount >= index) {
              if (child.tagName.toLowerCase() === "img" && offset) {
                return { node: child, offset };
              }
              return { node: child, offset: 0 };
            }
          } else {
            cfiCount += 1;
            if (cfiCount === index) {
              if (child.tagName.toLowerCase() === "img" && offset) {
                return { node: child, offset };
              }
              return { node: child, offset: 0 };
            } else if (cfiCount > index) {
              if (!lastChild) {
                return { node: parentNode, offset: 0 };
              }
              return { node: lastChild, offset: this.trueLength(dom, lastChild.textContent) };
            }
          }
          lastChild = child;
          break;
        case TEXT_NODE:
        case CDATA_SECTION_NODE:
          if (cfiCount === 0 || cfiCount % 2 === 0) {
            cfiCount += 1;
          }
          if (cfiCount === index) {
            let trueLength = this.trueLength(dom, child.textContent);
            if (offset >= trueLength) {
              offset -= trueLength;
            } else {
              return { node: child, offset };
            }
          }
          lastChild = child;
          break;
        default:
          continue;
      }
    }
    if (index > cfiCount) {
      var o = { relativeToNode: "after", offset: 0 };
      if (!lastChild) {
        o.node = parentNode;
      } else {
        o.node = lastChild;
      }
      if (this.isTextNode(o.node)) {
        o.offset = this.trueLength(dom, o.node.textContent.length);
      }
      return o;
    }
  }
  isTextNode(node) {
    if (!node)
      return false;
    if (node.nodeType === TEXT_NODE || node.nodeType === CDATA_SECTION_NODE) {
      return true;
    }
    return false;
  }
  // Use a Text Location Assertion to correct and offset
  correctOffset(dom, node, offset, assertion) {
    var curNode = node;
    if (typeof assertion === "string") {
      var matchStr = this.decodeEntities(dom, assertion);
    } else {
      assertion.pre = this.decodeEntities(dom, assertion.pre);
      assertion.post = this.decodeEntities(dom, assertion.post);
      var matchStr = assertion.pre + "." + assertion.post;
    }
    if (!this.isTextNode(node)) {
      return { node, offset: 0 };
    }
    while (this.isTextNode(curNode.previousSibling)) {
      curNode = curNode.previousSibling;
    }
    const startNode = curNode;
    var str;
    const nodeLengths = [];
    var txt = "";
    var i = 0;
    while (this.isTextNode(curNode)) {
      str = this.decodeEntities(dom, curNode.textContent);
      nodeLengths[i] = str.length;
      txt += str;
      if (!curNode.nextSibling)
        break;
      curNode = curNode.nextSibling;
      i++;
    }
    const matchOffset = assertion.pre ? assertion.pre.length : 0;
    const m = matchAll(txt, new RegExp(matchStr), matchOffset);
    if (!m.length)
      return { node, offset };
    var newOffset = closest(m, offset);
    if (curNode === node && newOffset === offset) {
      return { node, offset };
    }
    i = 0;
    curNode = startNode;
    while (newOffset >= nodeLengths[i]) {
      newOffset -= nodeLengths[i];
      if (newOffset < 0)
        return { node, offset };
      if (!curNode.nextSibling || i + 1 >= nodeOffsets.length)
        return { node, offset };
      i++;
      curNode = curNode.nextSibling;
    }
    return { node: curNode, offset: newOffset };
  }
  resolveNode(index, subparts, dom, opts) {
    opts = Object.assign({}, opts || {});
    if (!dom)
      throw new Error("Missing DOM argument");
    var startNode;
    if (index === 0) {
      startNode = dom.querySelector("package");
    }
    if (!startNode) {
      for (let n of dom.childNodes) {
        if (n.nodeType === ELEMENT_NODE) {
          startNode = n;
          break;
        }
      }
    }
    if (!startNode)
      throw new Error("Document incompatible with CFIs");
    var node = startNode;
    var startFrom = 0;
    var i, subpart;
    for (i = subparts.length - 1; i >= 0; i--) {
      subpart = subparts[i];
      if (!opts.ignoreIDs && subpart.nodeID && (node = dom.getElementById(subpart.nodeID))) {
        startFrom = i + 1;
        break;
      }
    }
    if (!node) {
      node = startNode;
    }
    var o = { node, offset: 0 };
    for (i = startFrom; i < subparts.length; i++) {
      subpart = subparts[i];
      o = this.getChildNodeByCFIIndex(dom, o.node, subpart.nodeIndex, subpart.offset);
      if (subpart.textLocationAssertion) {
        o = this.correctOffset(dom, o.node, subpart.offset, subpart.textLocationAssertion);
      }
    }
    return o;
  }
  // Each part of a CFI (as separated by '!')
  // references a separate HTML/XHTML/XML document.
  // This function takes an index specifying the part
  // of the CFI and the appropriate Document or XMLDocument
  // that is referenced by the specified part of the CFI
  // and returns the URI for the document referenced by
  // the next part of the CFI
  // If the opt `ignoreIDs` is true then IDs
  // will not be used while resolving
  resolveURI(index, dom, opts) {
    opts = opts || {};
    if (index < 0 || index > this.parts.length - 2) {
      throw new Error("index is out of bounds");
    }
    const subparts = this.parts[index];
    if (!subparts)
      throw new Error("Missing CFI part for index: " + index);
    var o = this.resolveNode(index, subparts, dom, opts);
    var node = o.node;
    const tagName = node.tagName.toLowerCase();
    if (tagName === "itemref" && node.parentNode.tagName.toLowerCase() === "spine") {
      const idref = node.getAttribute("idref");
      if (!idref)
        throw new Error("Referenced node had not 'idref' attribute");
      node = dom.getElementById(idref);
      if (!node)
        throw new Error("Specified node is missing from manifest");
      const href = node.getAttribute("href");
      if (!href)
        throw new Error("Manifest item is missing href attribute");
      return href;
    }
    if (tagName === "iframe" || tagName === "embed") {
      const src = node.getAttribute("src");
      if (!src)
        throw new Error(tagName + " element is missing 'src' attribute");
      return src;
    }
    if (tagName === "object") {
      const data = node.getAttribute("data");
      if (!data)
        throw new Error(tagName + " element is missing 'data' attribute");
      return data;
    }
    if (tagName === "image" || tagName === "use") {
      const href = node.getAttribute("xlink:href");
      if (!href)
        throw new Error(tagName + " element is missing 'xlink:href' attribute");
      return href;
    }
    throw new Error("No URI found");
  }
  deepClone(o) {
    return JSON.parse(JSON.stringify(o));
  }
  resolveLocation(dom, parts) {
    const index = parts.length - 1;
    const subparts = parts[index];
    if (!subparts)
      throw new Error("Missing CFI part for index: " + index);
    var o = this.resolveNode(index, subparts, dom);
    var lastpart = this.deepClone(subparts[subparts.length - 1]);
    delete lastpart.nodeIndex;
    if (!lastpart.offset)
      delete o.offset;
    Object.assign(lastpart, o);
    return lastpart;
  }
  // Takes the Document or XMLDocument for the final
  // document referenced by the CFI
  // and returns the node and offset into that node
  resolveLast(dom, opts) {
    opts = Object.assign({
      range: false
    }, opts || {});
    if (!this.isRange) {
      return this.resolveLocation(dom, this.parts);
    }
    if (opts.range) {
      const range = dom.createRange();
      const from = this.getFrom();
      if (from.relativeToNode === "before") {
        range.setStartBefore(from.node, from.offset);
      } else if (from.relativeToNode === "after") {
        range.setStartAfter(from.node, from.offset);
      } else {
        range.setStart(from.node, from.offset);
      }
      const to = this.getTo();
      if (to.relativeToNode === "before") {
        range.setEndBefore(to.node, to.offset);
      } else if (to.relativeToNode === "after") {
        range.setEndAfter(to.node, to.offset);
      } else {
        range.setEnd(to.node, to.offset);
      }
      return range;
    }
    return {
      from: this.resolveLocation(dom, this.getFrom()),
      to: this.resolveLocation(dom, this.getTo()),
      isRange: true
    };
  }
  async fetchAndParse(uri) {
    return new Promise((resolv, reject) => {
      const xhr = new XMLHttpRequest();
      xhr.open("GET", uri);
      xhr.responseType = "document";
      xhr.onload = function() {
        if (xhr.readyState === xhr.DONE) {
          if (xhr.status < 200 || xhr.status >= 300) {
            reject(new Error("Failed to get: " + uri));
            return;
          }
          resolv(xhr.responseXML);
        }
      };
      xhr.onerror = function() {
        reject(new Error("Failed to get: " + uri));
      };
      xhr.send();
    });
  }
  async resolve(uriOrDoc, fetchCB, opts) {
    if (typeof fetchCB !== "function") {
      opts = fetchCB;
      fetchCB = null;
    }
    if (!fetchCB) {
      if (typeof XMLHttpRequest === "undefined") {
        throw new Error("XMLHttpRequest not available. You must supply a function as the second argument.");
      }
      fetchCB = this.fetchAndParse;
    }
    var uri, doc;
    if (typeof uriOrDoc === "string") {
      uri = uriOrDoc;
    } else {
      doc = uriOrDoc;
    }
    var i, uri;
    for (i = 0; i < this.parts.length - 1; i++) {
      if (uri)
        doc = await fetchCB(uri);
      uri = this.resolveURI(i, doc, opts);
    }
    if (uri)
      doc = await fetchCB(uri);
    return this.resolveLast(doc, opts);
  }
}
var epubCfiResolver = CFI;
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
    document.getElementsByTagName("html")[0].style.background = "#" + config.backgroundColor;
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
    console.log("???", window.innerWidth + "px");
    windowWidth = window.innerWidth + "px";
    console.log("initDone", window.innerWidth, window.innerHeight);
    globalThis.JsBridge("initDone", window.innerWidth, window.innerHeight);
  }
  function updateReaderStyleElement() {
    var style = `display:flex;`;
    const infoStyle = ` .reader-app-page-info {color:#${config.infoColor} !important;}`;
    const bookTextStyle = `.book-container {color:#${config.textColor}}`;
    readerStyleElement.innerText = virtualReaderContainerSelector + " { " + style + " } " + bookTextStyle + infoStyle;
  }
  function getAlignText() {
    switch (config.textAlign) {
      case 0:
        return "initial;";
      case 1:
        return "justify;";
      case 2:
        return "end;";
      case 3:
        return "center;";
    }
    return "unset";
  }
  function getHeader(html) {
    const headerReg = /\<\/head\>/;
    const htmlReg = /\<html\>/;
    const bodyReg = /\<\/body\>/;
    const a = html.match(headerReg);
    console.log(a == null ? void 0 : a.index, "match");
    console.log("uedk", windowWidth);
    let styleString = `<style class="reader-style-x" type="text/css">${getReaderStyleText()}</style><style type="text/css">html{width:100vw !important;height:${getFullHeight()} !important;padding:0 !important;margin：0 !important;} .translate-img{height:1px;width:1px;position:absolute;top:0;}  body{width: ${windowWidth};overflow:hidden;
      padding: ${config.infoBarHeight + config.marginVertical + config.topExtraHeight + "px"} ${config.marginHorizontal + "px"} ${config.infoBarHeight + config.marginVertical + config.bottomExtraHeight + "px"} ${config.marginHorizontal + "px"} !important;
      height: ${getFullHeight()} !important;
      box-sizing:border-box !important;
      margin:0 !important;
      column-width: ${pageWidth}px;
      column-gap: ${config.marginHorizontal * 2}px !important;} img {
        max-width: 100% !important;
      }
    </style>`;
    if (a) {
      styleString = styleString + "</head>";
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
    const headerWrapper = document.createElement("div");
    headerWrapper.className = "header-wrapper";
    for (let i = 0; i < pages; i++) {
      const text = document.createElement("div");
      text.className = "info-text";
      text.innerText = i === 0 ? config.bookName : title;
      headerWrapper.appendChild(text);
      body.appendChild(headerWrapper);
    }
  }
  function setPageFooter(body, pages) {
    const footerWrapper = document.createElement("div");
    footerWrapper.className = "foot-wrapper";
    for (let i = 0; i < pages; i++) {
      const text = document.createElement("div");
      text.className = "info-text";
      text.innerText = `${i + 1} / ${pages}`;
      footerWrapper.appendChild(text);
      body.appendChild(footerWrapper);
    }
  }
  function getReaderStyleText() {
    const styleText = `html{background:#${config.backgroundColor};
  line-height:${config.lineHeight} !important;
  color:#${config.textColor};
  font-size:${config.fontSize * 100}%;
  text-align:${getAlignText()};
  }
  body > p,   
  body > div
  {
  line-height:${config.lineHeight} !important;
  font-size:${config.fontSize * 100}%;
  }
  body{
    background-size:cover !important;
  }
  .header-wrapper{
    left:0px;
    display:flex;
    height:${config.infoBarHeight}px;
    top:${config.topExtraHeight}px;
    box-sizing:border-box;
    padding-left:${config.marginHorizontal}px;
    position:absolute;
    font-size:13px;
    color:#${config.infoColor}; 
    align-items:flex-end;
  } .foot-wrapper{
    left:0px;
    display:flex;
    text-align:end;
    height:${config.infoBarHeight}px;
    bottom:${config.bottomExtraHeight}px;
    box-sizing:border-box;
    margin-left:-${config.marginHorizontal}px;
    position:absolute;
    font-size:13px;
    color:#${config.infoColor}; 
    align-items:flex-start;
  } .info-text{
    width:${pageWidth + config.marginHorizontal * 2}px;
  }
  `;
    return styleText;
  }
  function updateReaderStyle() {
    const styleText = getReaderStyleText();
    document.querySelectorAll("iframe").forEach((iframe) => {
      var _a;
      var html = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document);
      html.querySelector(".reader-style-x").innerText = styleText;
    });
  }
  function updateTheme(backgroundColor, textColor, infoColor) {
    console.log(backgroundColor, textColor, infoColor);
    config.backgroundColor = backgroundColor;
    config.textColor = textColor;
    config.infoColor = infoColor;
    updateReaderStyle();
  }
  function disableLongHit() {
    document.querySelectorAll("iframe").forEach((iframe) => {
      var _a, _b;
      var iframeBody = (_b = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document)) == null ? void 0 : _b.body;
      if (iframeBody)
        iframeBody.style.userSelect = "none";
    });
  }
  function enableLongHit() {
    document.querySelectorAll("iframe").forEach((iframe) => {
      var _a, _b;
      var iframeBody = (_b = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document)) == null ? void 0 : _b.body;
      if (iframeBody)
        iframeBody.style.userSelect = "unset";
    });
  }
  async function appendChapter(html, title) {
    html = getHeader(html);
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
      var iframeBody = (_b = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document)) == null ? void 0 : _b.body;
      iframeBody.parentElement.style.background = iframeBody.style.background;
      var img = iframeBody.querySelector("#translate-img");
      img.style.left = iframeBody.scrollWidth + "px";
      iframe.style.width = iframeBody.scrollWidth + config.marginHorizontal + "px";
      const pages = Math.round(iframeBody.scrollWidth / innerWidth);
      currentPages = pages;
      console.log(currentPages, title, "currentPagescurrentPages");
      globalThis.JsBridge("notifySize", pages);
      setPageHeader(iframeBody, title, pages);
      setPageFooter(iframeBody, pages);
    });
    chapterDiv.appendChild(iframe);
    virtualReader.appendChild(chapterDiv);
    function runLoop() {
      let intervalId;
      const promise = new Promise((res) => {
        intervalId = setInterval(() => {
          if (currentPages === 0)
            return;
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
  async function insertChapter(html, title) {
    html = getHeader(html);
    const chapterDiv = document.createElement("div");
    chapterDiv.style.breakInside = "avoid";
    const shadow = document.getElementById("shadow");
    const iframe = document.createElement("iframe");
    iframe.srcdoc = html;
    iframe.setAttribute(
      "style",
      `border:none;width:100vw;height:${getFullHeight()};display:block;`
    );
    let currentPages = 0;
    let scrollWidth = 0;
    iframe.addEventListener("load", (_) => {
      var _a, _b;
      var iframeBody = (_b = iframe.contentDocument || ((_a = iframe.contentWindow) == null ? void 0 : _a.document)) == null ? void 0 : _b.body;
      iframeBody.parentElement.style.background = iframeBody.style.background;
      var img = iframeBody.querySelector("#translate-img");
      img.style.left = iframeBody.scrollWidth + "px";
      iframe.style.width = iframeBody.scrollWidth + config.marginHorizontal + "px";
      const pages = Math.round(iframeBody.scrollWidth / innerWidth);
      currentPages = pages;
      console.log(currentPages, title, "currentPagescurrentPages");
      scrollWidth = iframeBody.scrollWidth;
      globalThis.JsBridge("notifySize", pages);
      setPageHeader(iframeBody, title, pages);
      setPageFooter(iframeBody, pages);
    });
    chapterDiv.appendChild(iframe);
    shadow.appendChild(chapterDiv);
    function runLoop() {
      let intervalId;
      const promise = new Promise((res) => {
        intervalId = setInterval(() => {
          if (currentPages === 0)
            return;
          clearInterval(intervalId);
          res(true);
        }, 50);
      });
      return promise;
    }
    await runLoop();
    virtualReader.insertBefore(shadow.firstChild, virtualReader.firstChild);
    window.scrollBy(scrollWidth + config.marginHorizontal, 0);
    console.log(currentPages, "当前页数");
    shadow.innerHTML = "";
    return currentPages;
  }
  async function refreshChapter(html, title) {
    virtualReader.innerHTML = "";
    return await appendChapter(html, title);
  }
  function setFontSize(size) {
    config.fontSize = size;
  }
  function getCFI() {
    const dx = config.marginHorizontal + 10;
    const dy = config.marginVertical + config.topExtraHeight + config.infoBarHeight + config.fontSize;
    const iframe = document.elementFromPoint(dx, dy);
    const diffVal = config.marginHorizontal + document.getElementsByTagName("html")[0].scrollLeft - iframe.offsetLeft;
    const dom = iframe.contentWindow.document.elementFromPoint(
      diffVal + 10,
      dy
    );
    return epubCfiResolver.generate(dom);
  }
  function jumpByCFI(str) {
    console.log(str);
    const cfi = new epubCfiResolver(str);
    const cfiArr = cfi.get();
    const cptCfi = cfiArr[cfiArr.length - 1];
    const doc = virtualReader.firstChild.firstChild.contentDocument;
    let target = doc;
    cptCfi.forEach((c) => {
      target = target.children[c.nodeIndex / 2 - 1];
    });
    const x = target.getBoundingClientRect().x;
    window.scrollTo(x - config.marginHorizontal, 0);
    const pageIndex = Math.floor(
      (x > 0 ? x - config.marginHorizontal : x) / (pageWidth + config.marginHorizontal * 2)
    );
    return pageIndex;
  }
  function setLineHeight(num) {
    config.lineHeight = num;
  }
  return {
    init,
    appendChapter,
    insertChapter,
    refreshChapter,
    setFontSize,
    updateTheme,
    getCFI,
    jumpByCFI,
    disableLongHit,
    enableLongHit,
    setLineHeight
  };
})();
window.addEventListener(
  "resize",
  () => globalThis.JsBridge("loadSuccess", true)
);
