(function(){"use strict";try{if(typeof document!="undefined"){var t=document.createElement("style");t.appendChild(document.createTextNode("*{outline:none!important}body{padding:0!important;word-break:break-word}html{margin:0!important;padding:0!important}sup{vertical-align:top!important}sub{vertical-align:bottom!important}img{max-width:100%!important}")),document.head.appendChild(t)}}catch(e){console.error("vite-plugin-css-injected-by-js",e)}})();
var G = {}, Vt = {
  get exports() {
    return G;
  },
  set exports(n) {
    G = n;
  }
};
(function(n) {
  (function() {
    function a(t, e, i) {
      return t.call.apply(t.bind, arguments);
    }
    function g(t, e, i) {
      if (!t)
        throw Error();
      if (2 < arguments.length) {
        var o = Array.prototype.slice.call(arguments, 2);
        return function() {
          var s = Array.prototype.slice.call(arguments);
          return Array.prototype.unshift.apply(s, o), t.apply(e, s);
        };
      }
      return function() {
        return t.apply(e, arguments);
      };
    }
    function r(t, e, i) {
      return r = Function.prototype.bind && Function.prototype.bind.toString().indexOf("native code") != -1 ? a : g, r.apply(null, arguments);
    }
    var l = Date.now || function() {
      return +new Date();
    };
    function u(t, e) {
      this.a = t, this.o = e || t, this.c = this.o.document;
    }
    var f = !!window.FontFace;
    function d(t, e, i, o) {
      if (e = t.c.createElement(e), i)
        for (var s in i)
          i.hasOwnProperty(s) && (s == "style" ? e.style.cssText = i[s] : e.setAttribute(s, i[s]));
      return o && e.appendChild(t.c.createTextNode(o)), e;
    }
    function c(t, e, i) {
      t = t.c.getElementsByTagName(e)[0], t || (t = document.documentElement), t.insertBefore(i, t.lastChild);
    }
    function m(t) {
      t.parentNode && t.parentNode.removeChild(t);
    }
    function T(t, e, i) {
      e = e || [], i = i || [];
      for (var o = t.className.split(/\s+/), s = 0; s < e.length; s += 1) {
        for (var h = !1, p = 0; p < o.length; p += 1)
          if (e[s] === o[p]) {
            h = !0;
            break;
          }
        h || o.push(e[s]);
      }
      for (e = [], s = 0; s < o.length; s += 1) {
        for (h = !1, p = 0; p < i.length; p += 1)
          if (o[s] === i[p]) {
            h = !0;
            break;
          }
        h || e.push(o[s]);
      }
      t.className = e.join(" ").replace(/\s+/g, " ").replace(/^\s+|\s+$/, "");
    }
    function H(t, e) {
      for (var i = t.className.split(/\s+/), o = 0, s = i.length; o < s; o++)
        if (i[o] == e)
          return !0;
      return !1;
    }
    function M(t) {
      return t.o.location.hostname || t.a.location.hostname;
    }
    function P(t, e, i) {
      function o() {
        y && s && h && (y(p), y = null);
      }
      e = d(t, "link", { rel: "stylesheet", href: e, media: "all" });
      var s = !1, h = !0, p = null, y = i || null;
      f ? (e.onload = function() {
        s = !0, o();
      }, e.onerror = function() {
        s = !0, p = Error("Stylesheet failed to load"), o();
      }) : setTimeout(function() {
        s = !0, o();
      }, 0), c(t, "head", e);
    }
    function E(t, e, i, o) {
      var s = t.c.getElementsByTagName("head")[0];
      if (s) {
        var h = d(t, "script", { src: e }), p = !1;
        return h.onload = h.onreadystatechange = function() {
          p || this.readyState && this.readyState != "loaded" && this.readyState != "complete" || (p = !0, i && i(null), h.onload = h.onreadystatechange = null, h.parentNode.tagName == "HEAD" && s.removeChild(h));
        }, s.appendChild(h), setTimeout(function() {
          p || (p = !0, i && i(Error("Script load timeout")));
        }, o || 5e3), h;
      }
      return null;
    }
    function _() {
      this.a = 0, this.c = null;
    }
    function Y(t) {
      return t.a++, function() {
        t.a--, $(t);
      };
    }
    function q(t, e) {
      t.c = e, $(t);
    }
    function $(t) {
      t.a == 0 && t.c && (t.c(), t.c = null);
    }
    function J(t) {
      this.a = t || "-";
    }
    J.prototype.c = function(t) {
      for (var e = [], i = 0; i < arguments.length; i++)
        e.push(arguments[i].replace(/[\W_]+/g, "").toLowerCase());
      return e.join(this.a);
    };
    function S(t, e) {
      this.c = t, this.f = 4, this.a = "n";
      var i = (e || "n4").match(/^([nio])([1-9])$/i);
      i && (this.a = i[1], this.f = parseInt(i[2], 10));
    }
    function Ct(t) {
      return Q(t) + " " + (t.f + "00") + " 300px " + K(t.c);
    }
    function K(t) {
      var e = [];
      t = t.split(/,\s*/);
      for (var i = 0; i < t.length; i++) {
        var o = t[i].replace(/['"]/g, "");
        o.indexOf(" ") != -1 || /^\d/.test(o) ? e.push("'" + o + "'") : e.push(o);
      }
      return e.join(",");
    }
    function C(t) {
      return t.a + t.f;
    }
    function Q(t) {
      var e = "normal";
      return t.a === "o" ? e = "oblique" : t.a === "i" && (e = "italic"), e;
    }
    function Et(t) {
      var e = 4, i = "n", o = null;
      return t && ((o = t.match(/(normal|oblique|italic)/i)) && o[1] && (i = o[1].substr(0, 1).toLowerCase()), (o = t.match(/([1-9]00|normal|bold)/i)) && o[1] && (/bold/i.test(o[1]) ? e = 7 : /[1-9]00/.test(o[1]) && (e = parseInt(o[1].substr(0, 1), 10)))), i + e;
    }
    function St(t, e) {
      this.c = t, this.f = t.o.document.documentElement, this.h = e, this.a = new J("-"), this.j = e.events !== !1, this.g = e.classes !== !1;
    }
    function At(t) {
      t.g && T(t.f, [t.a.c("wf", "loading")]), F(t, "loading");
    }
    function Z(t) {
      if (t.g) {
        var e = H(t.f, t.a.c("wf", "active")), i = [], o = [t.a.c("wf", "loading")];
        e || i.push(t.a.c("wf", "inactive")), T(t.f, i, o);
      }
      F(t, "inactive");
    }
    function F(t, e, i) {
      t.j && t.h[e] && (i ? t.h[e](i.c, C(i)) : t.h[e]());
    }
    function _t() {
      this.c = {};
    }
    function Ht(t, e, i) {
      var o = [], s;
      for (s in e)
        if (e.hasOwnProperty(s)) {
          var h = t.c[s];
          h && o.push(h(e[s], i));
        }
      return o;
    }
    function I(t, e) {
      this.c = t, this.f = e, this.a = d(this.c, "span", { "aria-hidden": "true" }, this.f);
    }
    function W(t) {
      c(t.c, "body", t.a);
    }
    function z(t) {
      return "display:block;position:absolute;top:-9999px;left:-9999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;white-space:nowrap;font-family:" + K(t.c) + ";" + ("font-style:" + Q(t) + ";font-weight:" + (t.f + "00") + ";");
    }
    function tt(t, e, i, o, s, h) {
      this.g = t, this.j = e, this.a = o, this.c = i, this.f = s || 3e3, this.h = h || void 0;
    }
    tt.prototype.start = function() {
      var t = this.c.o.document, e = this, i = l(), o = new Promise(function(p, y) {
        function v() {
          l() - i >= e.f ? y() : t.fonts.load(Ct(e.a), e.h).then(function(w) {
            1 <= w.length ? p() : setTimeout(v, 25);
          }, function() {
            y();
          });
        }
        v();
      }), s = null, h = new Promise(function(p, y) {
        s = setTimeout(y, e.f);
      });
      Promise.race([h, o]).then(function() {
        s && (clearTimeout(s), s = null), e.g(e.a);
      }, function() {
        e.j(e.a);
      });
    };
    function et(t, e, i, o, s, h, p) {
      this.v = t, this.B = e, this.c = i, this.a = o, this.s = p || "BESbswy", this.f = {}, this.w = s || 3e3, this.u = h || null, this.m = this.j = this.h = this.g = null, this.g = new I(this.c, this.s), this.h = new I(this.c, this.s), this.j = new I(this.c, this.s), this.m = new I(this.c, this.s), t = new S(this.a.c + ",serif", C(this.a)), t = z(t), this.g.a.style.cssText = t, t = new S(this.a.c + ",sans-serif", C(this.a)), t = z(t), this.h.a.style.cssText = t, t = new S("serif", C(this.a)), t = z(t), this.j.a.style.cssText = t, t = new S("sans-serif", C(this.a)), t = z(t), this.m.a.style.cssText = t, W(this.g), W(this.h), W(this.j), W(this.m);
    }
    var B = { D: "serif", C: "sans-serif" }, D = null;
    function nt() {
      if (D === null) {
        var t = /AppleWebKit\/([0-9]+)(?:\.([0-9]+))/.exec(window.navigator.userAgent);
        D = !!t && (536 > parseInt(t[1], 10) || parseInt(t[1], 10) === 536 && 11 >= parseInt(t[2], 10));
      }
      return D;
    }
    et.prototype.start = function() {
      this.f.serif = this.j.a.offsetWidth, this.f["sans-serif"] = this.m.a.offsetWidth, this.A = l(), it(this);
    };
    function ot(t, e, i) {
      for (var o in B)
        if (B.hasOwnProperty(o) && e === t.f[B[o]] && i === t.f[B[o]])
          return !0;
      return !1;
    }
    function it(t) {
      var e = t.g.a.offsetWidth, i = t.h.a.offsetWidth, o;
      (o = e === t.f.serif && i === t.f["sans-serif"]) || (o = nt() && ot(t, e, i)), o ? l() - t.A >= t.w ? nt() && ot(t, e, i) && (t.u === null || t.u.hasOwnProperty(t.a.c)) ? V(t, t.v) : V(t, t.B) : kt(t) : V(t, t.v);
    }
    function kt(t) {
      setTimeout(r(function() {
        it(this);
      }, t), 50);
    }
    function V(t, e) {
      setTimeout(r(function() {
        m(this.g.a), m(this.h.a), m(this.j.a), m(this.m.a), e(this.a);
      }, t), 0);
    }
    function U(t, e, i) {
      this.c = t, this.a = e, this.f = 0, this.m = this.j = !1, this.s = i;
    }
    var O = null;
    U.prototype.g = function(t) {
      var e = this.a;
      e.g && T(e.f, [e.a.c("wf", t.c, C(t).toString(), "active")], [e.a.c("wf", t.c, C(t).toString(), "loading"), e.a.c("wf", t.c, C(t).toString(), "inactive")]), F(e, "fontactive", t), this.m = !0, at(this);
    }, U.prototype.h = function(t) {
      var e = this.a;
      if (e.g) {
        var i = H(e.f, e.a.c("wf", t.c, C(t).toString(), "active")), o = [], s = [e.a.c("wf", t.c, C(t).toString(), "loading")];
        i || o.push(e.a.c("wf", t.c, C(t).toString(), "inactive")), T(e.f, o, s);
      }
      F(e, "fontinactive", t), at(this);
    };
    function at(t) {
      --t.f == 0 && t.j && (t.m ? (t = t.a, t.g && T(t.f, [t.a.c("wf", "active")], [t.a.c("wf", "loading"), t.a.c("wf", "inactive")]), F(t, "active")) : Z(t.a));
    }
    function rt(t) {
      this.j = t, this.a = new _t(), this.h = 0, this.f = this.g = !0;
    }
    rt.prototype.load = function(t) {
      this.c = new u(this.j, t.context || this.j), this.g = t.events !== !1, this.f = t.classes !== !1, Mt(this, new St(this.c, t), t);
    };
    function Rt(t, e, i, o, s) {
      var h = --t.h == 0;
      (t.f || t.g) && setTimeout(function() {
        var p = s || null, y = o || null || {};
        if (i.length === 0 && h)
          Z(e.a);
        else {
          e.f += i.length, h && (e.j = h);
          var v, w = [];
          for (v = 0; v < i.length; v++) {
            var b = i[v], x = y[b.c], A = e.a, N = b;
            if (A.g && T(A.f, [A.a.c("wf", N.c, C(N).toString(), "loading")]), F(A, "fontloading", N), A = null, O === null)
              if (window.FontFace) {
                var N = /Gecko.*Firefox\/(\d+)/.exec(window.navigator.userAgent), Dt = /OS X.*Version\/10\..*Safari/.exec(window.navigator.userAgent) && /Apple/.exec(window.navigator.vendor);
                O = N ? 42 < parseInt(N[1], 10) : !Dt;
              } else
                O = !1;
            O ? A = new tt(r(e.g, e), r(e.h, e), e.c, b, e.s, x) : A = new et(r(e.g, e), r(e.h, e), e.c, b, e.s, p, x), w.push(A);
          }
          for (v = 0; v < w.length; v++)
            w[v].start();
        }
      }, 0);
    }
    function Mt(t, e, i) {
      var s = [], o = i.timeout;
      At(e);
      var s = Ht(t.a, i, t.c), h = new U(t.c, e, o);
      for (t.h = s.length, e = 0, i = s.length; e < i; e++)
        s[e].load(function(p, y, v) {
          Rt(t, h, p, y, v);
        });
    }
    function st(t, e) {
      this.c = t, this.a = e;
    }
    st.prototype.load = function(t) {
      function e() {
        if (h["__mti_fntLst" + o]) {
          var p = h["__mti_fntLst" + o](), y = [], v;
          if (p)
            for (var w = 0; w < p.length; w++) {
              var b = p[w].fontfamily;
              p[w].fontStyle != null && p[w].fontWeight != null ? (v = p[w].fontStyle + p[w].fontWeight, y.push(new S(b, v))) : y.push(new S(b));
            }
          t(y);
        } else
          setTimeout(function() {
            e();
          }, 50);
      }
      var i = this, o = i.a.projectId, s = i.a.version;
      if (o) {
        var h = i.c.o;
        E(this.c, (i.a.api || "https://fast.fonts.net/jsapi") + "/" + o + ".js" + (s ? "?v=" + s : ""), function(p) {
          p ? t([]) : (h["__MonotypeConfiguration__" + o] = function() {
            return i.a;
          }, e());
        }).id = "__MonotypeAPIScript__" + o;
      } else
        t([]);
    };
    function lt(t, e) {
      this.c = t, this.a = e;
    }
    lt.prototype.load = function(t) {
      var e, i, o = this.a.urls || [], s = this.a.families || [], h = this.a.testStrings || {}, p = new _();
      for (e = 0, i = o.length; e < i; e++)
        P(this.c, o[e], Y(p));
      var y = [];
      for (e = 0, i = s.length; e < i; e++)
        if (o = s[e].split(":"), o[1])
          for (var v = o[1].split(","), w = 0; w < v.length; w += 1)
            y.push(new S(o[0], v[w]));
        else
          y.push(new S(o[0]));
      q(p, function() {
        t(y, h);
      });
    };
    function Ft(t, e) {
      t ? this.c = t : this.c = Nt, this.a = [], this.f = [], this.g = e || "";
    }
    var Nt = "https://fonts.googleapis.com/css";
    function Pt(t, e) {
      for (var i = e.length, o = 0; o < i; o++) {
        var s = e[o].split(":");
        s.length == 3 && t.f.push(s.pop());
        var h = "";
        s.length == 2 && s[1] != "" && (h = ":"), t.a.push(s.join(h));
      }
    }
    function Lt(t) {
      if (t.a.length == 0)
        throw Error("No fonts to load!");
      if (t.c.indexOf("kit=") != -1)
        return t.c;
      for (var e = t.a.length, i = [], o = 0; o < e; o++)
        i.push(t.a[o].replace(/ /g, "+"));
      return e = t.c + "?family=" + i.join("%7C"), 0 < t.f.length && (e += "&subset=" + t.f.join(",")), 0 < t.g.length && (e += "&text=" + encodeURIComponent(t.g)), e;
    }
    function It(t) {
      this.f = t, this.a = [], this.c = {};
    }
    var ct = { latin: "BESbswy", "latin-ext": "çöüğş", cyrillic: "йяЖ", greek: "αβΣ", khmer: "កខគ", Hanuman: "កខគ" }, Wt = { thin: "1", extralight: "2", "extra-light": "2", ultralight: "2", "ultra-light": "2", light: "3", regular: "4", book: "4", medium: "5", "semi-bold": "6", semibold: "6", "demi-bold": "6", demibold: "6", bold: "7", "extra-bold": "8", extrabold: "8", "ultra-bold": "8", ultrabold: "8", black: "9", heavy: "9", l: "3", r: "4", b: "7" }, zt = { i: "i", italic: "i", n: "n", normal: "n" }, Bt = /^(thin|(?:(?:extra|ultra)-?)?light|regular|book|medium|(?:(?:semi|demi|extra|ultra)-?)?bold|black|heavy|l|r|b|[1-9]00)?(n|i|normal|italic)?$/;
    function Ot(t) {
      for (var e = t.f.length, i = 0; i < e; i++) {
        var o = t.f[i].split(":"), s = o[0].replace(/\+/g, " "), h = ["n4"];
        if (2 <= o.length) {
          var p, y = o[1];
          if (p = [], y)
            for (var y = y.split(","), v = y.length, w = 0; w < v; w++) {
              var b;
              if (b = y[w], b.match(/^[\w-]+$/)) {
                var x = Bt.exec(b.toLowerCase());
                if (x == null)
                  b = "";
                else {
                  if (b = x[2], b = b == null || b == "" ? "n" : zt[b], x = x[1], x == null || x == "")
                    x = "4";
                  else
                    var A = Wt[x], x = A || (isNaN(x) ? "4" : x.substr(0, 1));
                  b = [b, x].join("");
                }
              } else
                b = "";
              b && p.push(b);
            }
          0 < p.length && (h = p), o.length == 3 && (o = o[2], p = [], o = o ? o.split(",") : p, 0 < o.length && (o = ct[o[0]]) && (t.c[s] = o));
        }
        for (t.c[s] || (o = ct[s]) && (t.c[s] = o), o = 0; o < h.length; o += 1)
          t.a.push(new S(s, h[o]));
      }
    }
    function ut(t, e) {
      this.c = t, this.a = e;
    }
    var jt = { Arimo: !0, Cousine: !0, Tinos: !0 };
    ut.prototype.load = function(t) {
      var e = new _(), i = this.c, o = new Ft(this.a.api, this.a.text), s = this.a.families;
      Pt(o, s);
      var h = new It(s);
      Ot(h), P(i, Lt(o), Y(e)), q(e, function() {
        t(h.a, h.c, jt);
      });
    };
    function gt(t, e) {
      this.c = t, this.a = e;
    }
    gt.prototype.load = function(t) {
      var e = this.a.id, i = this.c.o;
      e ? E(this.c, (this.a.api || "https://use.typekit.net") + "/" + e + ".js", function(o) {
        if (o)
          t([]);
        else if (i.Typekit && i.Typekit.config && i.Typekit.config.fn) {
          o = i.Typekit.config.fn;
          for (var s = [], h = 0; h < o.length; h += 2)
            for (var p = o[h], y = o[h + 1], v = 0; v < y.length; v++)
              s.push(new S(p, y[v]));
          try {
            i.Typekit.load({ events: !1, classes: !1, async: !0 });
          } catch {
          }
          t(s);
        }
      }, 2e3) : t([]);
    };
    function ft(t, e) {
      this.c = t, this.f = e, this.a = [];
    }
    ft.prototype.load = function(t) {
      var e = this.f.id, i = this.c.o, o = this;
      e ? (i.__webfontfontdeckmodule__ || (i.__webfontfontdeckmodule__ = {}), i.__webfontfontdeckmodule__[e] = function(s, h) {
        for (var p = 0, y = h.fonts.length; p < y; ++p) {
          var v = h.fonts[p];
          o.a.push(new S(v.name, Et("font-weight:" + v.weight + ";font-style:" + v.style)));
        }
        t(o.a);
      }, E(this.c, (this.f.api || "https://f.fontdeck.com/s/css/js/") + M(this.c) + "/" + e + ".js", function(s) {
        s && t([]);
      })) : t([]);
    };
    var k = new rt(window);
    k.a.c.custom = function(t, e) {
      return new lt(e, t);
    }, k.a.c.fontdeck = function(t, e) {
      return new ft(e, t);
    }, k.a.c.monotype = function(t, e) {
      return new st(e, t);
    }, k.a.c.typekit = function(t, e) {
      return new gt(e, t);
    }, k.a.c.google = function(t, e) {
      return new ut(e, t);
    };
    var ht = { load: r(k.load, k) };
    n.exports ? n.exports = ht : (window.WebFont = ht, window.WebFontConfig && k.load(window.WebFontConfig));
  })();
})(Vt);
const vt = G, wt = (n) => {
  for (let a of n)
    a.style.margin = "0px", a.style.padding = "0px", a.style.border = "none";
}, pt = (n) => {
  let a = n, g;
  for (; a.tagName && a.tagName.toLowerCase() !== "body" && a != bookContainer; ) {
    if (g) {
      var r = g;
      g = a.cloneNode(!1), g.className += " __Reader_NoEffects", g.appendChild(r);
    } else
      g = a.cloneNode(!0);
    a = a.parentNode;
  }
  var l = document.createElement("div");
  return l.className = "__Reader_Footnote_Content " + specificityClassName, l.appendChild(g), l.outerHTML;
}, dt = (n) => {
  var a = "";
  a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/default.css' />";
  var g = n.querySelectorAll("link, style"), r = document.createElement("div");
  for (let u = 0; u < g.length; u++) {
    var l = g[u];
    l.dataset.excludeFromFootnote || r.appendChild(l.cloneNode(!0));
  }
  return a += r.innerHTML, a += "<style type='text/css'>" + ReaderThemes.getCss() + "</style>", a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/footnote.css' />", a;
}, Ut = (n, a) => {
  if (n[0] == "#") {
    var g = document.getElementById(n.substring(1)) ? pt(document.getElementById(n.substring(1))) : "";
    a(dt(document) + g);
    return;
  }
  var r = n.indexOf("#"), l = n.substring(r), u = n.substring(0, r), f = new XMLHttpRequest();
  f.open("GET", u, !0), f.responseType = "document", f.onload = function() {
    if (f.status != 200) {
      console.error(
        'Failed to load footnote at "' + n + '": ' + f.statusText
      );
      return;
    }
    var d = f.responseXML;
    a(
      dt(d) + pt(d.getElementById(l.substring(1)))
    );
  }, f.send();
}, Gt = () => {
  var n = document.getElementsByTagName("switch");
  for (let l = 0; l < n.length; l++) {
    var a = n[l], g = a.getElementsByTagName("case");
    for (let u = 0; u < g.length; u++) {
      var r = g[u];
      r.parentNode.removeChild(r);
    }
  }
}, Xt = (n) => {
  try {
    if (n.cssRules == null)
      return !0;
  } catch {
    return !0;
  }
  return !1;
}, bt = (n) => {
  if (Xt(n))
    return { fonts: [], useWorkaround: !0 };
  var a = [], g = !1, r = n.cssRules;
  for (let d = 0; d < r.length; d++) {
    var l = r[d];
    if (l.styleSheet) {
      var u = bt(l.styleSheet);
      a.push.apply(a, u.fonts), g = g || u.useWorkaround;
      continue;
    }
    if (l.type == CSSRule.FONT_FACE_RULE) {
      var f = l.style.fontFamily;
      a.indexOf(f) == -1 && a.push(f);
    }
  }
  return { fonts: a, useWorkaround: g };
}, Yt = () => {
  const n = [];
  var a = {}, g = void 0, r = document.styleSheets;
  for (let E = 0; E < r.length; E++) {
    var l = r[E], u = bt(l);
    g = g || u.useWorkaround;
    var f = u.fonts;
    for (let _ = 0; _ < f.length; _++) {
      var d = f[_];
      a[d.toLowerCase()] = !0;
    }
    n.push.apply(n, u.fonts);
  }
  if (g) {
    var c = Array.prototype.slice.call(document.body.childNodes);
    for (let E = 0; E < c.length; E++) {
      var m = c[E];
      if (m.nodeType == Node.ELEMENT_NODE) {
        var T = window.getComputedStyle(m), H = T["font-family"].split(",");
        for (let _ = 0; _ < H.length; _++) {
          var M = H[_], P = M.toLowerCase();
          a[P] !== !0 && (a[P] = !0);
        }
        n.push.apply(n, H);
      }
    }
  }
  return n;
}, qt = (n) => {
  for (var a = {}, g = n.split(","), r = 0; r < g.length; ++r) {
    var l = g[r].split("="), u = l[0].trim(), f = l[1].trim();
    a[u] = f;
  }
  return a;
}, $t = (n) => {
  var a = "", g = 0;
  for (var r in n)
    g != 0 && (a += ","), a += r + "=" + n[r], g++;
  return a;
}, Tt = (n) => {
  var a = n.getBoundingClientRect();
  return pagedHorizontally ? Math.floor(
    (a.left + window.scrollX) / (pageWidth + pageHorizontalMargin)
  ) : Math.floor(
    (a.top + window.scrollY) / (pageHeight + pageVerticalMargin)
  );
}, Jt = (n) => {
  var a = {};
  for (var g in n) {
    var r = n[g], l = document.getElementById(r.substring(1));
    if (l)
      switch (globalThis.config.flowStyle) {
        case FLOW_PAGED:
          a[g] = Tt(l);
          break;
        case FLOW_SCROLLED:
          a[g] = l.offsetTop;
          break;
      }
  }
  return a;
}, xt = (n) => {
  if (!n.length) {
    ReaderApp.setAnchorPositions(null);
    return;
  }
  var a = [];
  for (var g in n) {
    var r = n[g], l = document.getElementById(r.substring(1));
    if (l)
      if (globalThis.config.flowStyle == FLOW_PAGED)
        a.push([r, Tt(l)]);
      else {
        var u = l.getBoundingClientRect(), f = u.top + window.scrollY;
        a.push([r, f]);
      }
  }
  ReaderApp.setAnchorPositions(JSON.stringify(a));
}, Kt = (n) => {
  bookContainer.innerHTML = bookContainer.firstChild.outerHTML;
  const a = globalThis.config.bookName ?? "", g = globalThis.config.chapterName ?? document.getElementsByTagName("title")[0].innerText;
  let r = window.innerWidth;
  for (let l = 0; l < n; l++) {
    const u = document.createElement("div");
    u.className = "ReaderApp-page-header", u.style.padding = "0", u.style.position = "absolute", u.style.top = globalThis.config.topExtraHeight + "px", u.style.left = r * l + "px", u.style.width = "100%", u.style.height = globalThis.config.infoBarHeight + "px", u.style.boxSizing = "border-box", u.style.fontSize = "13px", u.style.color = "#8d8d8d", u.style.padding = `0 ${globalThis.config.marginHorizontal}px`, u.style.display = "flex", u.style.alignItems = "flex-end", u.innerText = l == 0 ? a : g, bookContainer.appendChild(u);
    const f = document.createElement("div");
    f.className = "ReaderApp-page-footer", f.style.padding = "0", f.style.position = "absolute", f.style.bottom = globalThis.config.bottomExtraHeight + "px", f.style.left = r * l + "px", f.style.width = "100%", f.style.height = globalThis.config.infoBarHeight + "px", f.style.boxSizing = "border-box", f.style.fontSize = "13px", f.style.color = "#8d8d8d", f.style.padding = `0 ${globalThis.config.marginHorizontal}px`, f.style.display = "flex", f.style.alignItems = "flex-start", f.style.justifyContent = "flex-end", f.innerText = `${l + 1}/${n}`, bookContainer.appendChild(f);
  }
}, Qt = () => {
  if (!(globalThis.config.layoutStyle != LAYOUT_REFLOW || globalThis.config.flowStyle != FLOW_PAGED)) {
    if (!pageContainer) {
      bookContainer = document.createElement("div");
      var n = document.createElement("div");
      n.style.webkitMarginCollapse = "separate";
      var a = Array.prototype.slice.call(document.body.childNodes);
      for (let u = 0; u < a.length; u++) {
        var g = a[u];
        n.appendChild(g);
      }
      n.className = "collapse-wrapper", bookContainer.appendChild(n), pageContainer = document.createElement("div"), pageContainer.className = "book-wrapper", pageContainer.appendChild(bookContainer), document.body.appendChild(pageContainer), wt([pageContainer, bookContainer]);
    }
    pageHorizontalMargin = globalThis.config.marginHorizontal * 2, pageVerticalMargin = (globalThis.config.marginVertical + globalThis.config.infoBarHeight) * 2 + globalThis.config.topExtraHeight + globalThis.config.bottomExtraHeight, console.log("---><", pageHorizontalMargin, pageVerticalMargin), pageWidth = window.innerWidth - pageHorizontalMargin, pageHeight = window.innerHeight - pageVerticalMargin;
    var r = window.getComputedStyle(document.body), l = window.getComputedStyle(
      document.getElementsByTagName("html")[0]
    );
    pagedHorizontally = r.writingMode.indexOf("vertical") == -1 && l.writingMode.indexOf("vertical") == -1, bookContainer.style.width = pageWidth + "px", bookContainer.style.height = pageHeight + "px", bookContainer.style.webkitColumnWidth = (pagedHorizontally ? pageWidth : pageHeight) + "px", bookContainer.style.webkitColumnGap = (pagedHorizontally ? pageHorizontalMargin : pageVerticalMargin) + "px", endMarginStub.style.left = "0px", endMarginStub.style.top = "0px", pagedHorizontally ? (pageCount = Math.ceil(
      document.body.scrollWidth / (pageWidth + pageHorizontalMargin)
    ), endMarginStub.style.left = pageCount * (pageWidth + pageHorizontalMargin) - 1 + "px") : (pageCount = Math.ceil(
      document.body.scrollHeight / (pageHeight + pageVerticalMargin)
    ), endMarginStub.style.top = pageCount * (pageHeight + pageVerticalMargin) - 1 + "px"), xt(globalThis.config.tocAnchorList ?? []), Kt(pageCount), ReaderApp.onPagingSetup(
      pageHorizontalMargin / window.innerWidth,
      pageHorizontalMargin / window.innerHeight,
      pageCount,
      pagedHorizontally
    );
  }
}, L = () => {
  globalThis.config.flowStyle == FLOW_PAGED ? Qt() : xt(globalThis.config.tocAnchorList ?? []);
  var n = Jt(
    globalThis.config.paperPageToAnchorMap ?? []
  );
  ReaderApp.setPaperPageMap(JSON.stringify(n)), initialFlowWasDone = !0;
}, R = () => {
  initialFlowWasDone && L();
}, X = () => {
  console.log("use", globalThis.config.lineSpacing, globalThis.config.textAlign);
  var n = "line-height: " + globalThis.config.lineSpacing + " !important;";
  switch (globalThis.config.textAlign) {
    case 1:
      n += "text-align: initial !important;";
      break;
    case 2:
      n += "text-align: justify !important;";
      break;
  }
  console.log("???", styleElement, n), globalThis.styleElement.innerText = specificitySelector + " * { " + n + " }", console.log("useStyle", styleElement);
}, Zt = (n) => {
  console.log(n), X(), R();
}, te = (n) => {
  console.log(n, "setPtops");
}, ee = (n) => {
  document.body.style.margin = n, R();
}, ne = (n) => {
  marginPercent = n / 100, document.body.style.margin = n + "%", R();
}, mt = (n) => {
  globalThis.config.marginHorizontal = n, document.body.style.marginLeft = n + "px", document.body.style.marginRight = n + "px", R();
}, yt = (n) => {
  globalThis.config.marginVertical = n, document.body.style.marginBottom = globalThis.config.infoBarHeight + n + globalThis.config.bottomExtraHeight + "px", document.body.style.marginTop = globalThis.config.infoBarHeight + n + globalThis.config.topExtraHeight + "px", R();
}, oe = (n) => {
  console.log(n), X(), R();
}, j = (n, a, g, r) => "@font-face { font-family: '" + n + "';font-style: " + a + "; font-weight: " + g + ";src: url(file:///android_asset/fonts/" + r + "); }", ie = (n) => {
  var a = j(n.name, "normal", 400, n.regular) + (n.bold ? j(n.name, "normal", 700, n.bold) : "") + (n.italic ? j(n.name, "italic", 400, n.italic) : "") + (n.italic ? j(n.name, "italic", 700, n.boldItalic) : "");
  typefacesStyleElement.innerText = typefacesStyleElement.innerText + a, fontsInjected.push(n.name);
}, ae = (n) => {
  if (currentFont = n, !n) {
    fontStyleElement.innerText = "", initialFlowWasDone && setTimeout(function() {
      L();
    }, 60);
    return;
  }
  if (fontStyleElement.innerText = specificitySelector + " * { font-family: " + n.name + " !important; }", fontSetupInitialized) {
    var a = function() {
      fontsLoaded.push(n.name), initialFlowWasDone && L();
    };
    fontsLoaded.indexOf(n.name) > -1 ? a() : vt.load({
      custom: {
        families: [n.name]
      },
      classes: !1,
      active: a,
      inactive: function() {
        console.log("Failed to load font: " + n.name);
      },
      timeout: 1e3
    });
  }
  fontsInjected.indexOf(n.name) == -1 && ie(n);
}, re = (n, a) => {
  if (n.href.indexOf("javascript:") == 0) {
    a.stopPropagation();
    return;
  }
  a.preventDefault(), a.stopPropagation(), (n.getAttribute("epub:type") || n.getAttribute("epubu0003atype")) == "noteref" ? (a.preventDefault(), a.stopPropagation(), Ut(n.getAttribute("href"), function(r) {
    const l = n.getClientRects();
    let u;
    for (var f in l) {
      var d = l[f];
      if (a.clientX >= d.left && a.clientX <= d.right && a.clientY >= d.top && a.clientY <= d.bottom) {
        u = d;
        break;
      }
    }
    u = u || l[0];
    var c = (u.left + u.right) / 2, m = (u.top + u.bottom) / 2;
    ReaderApp.openFootNote(n.innerText.trim(), r, c, m);
  })) : ReaderApp.openLink(n.href);
}, se = (n, a) => {
  for (var g = n.parentNode; g; ) {
    if (g.tagName && g.tagName.toLowerCase() == "a" && g.getAttribute("href"))
      return;
    g = g.parentNode;
  }
  a.preventDefault(), a.stopPropagation();
  var r = n.getBoundingClientRect();
  ReaderApp.openImage(
    n.src,
    r.left,
    r.top,
    r.right - r.left,
    r.bottom - r.top
  ), showcasedImageElement = n;
};
function le() {
  globalThis.LAYOUT_REFLOW = 1, globalThis.LAYOUT_FIXED = 2, globalThis.FLOW_PAGED = 1, globalThis.FLOW_SCROLLED = 2, globalThis.bookContainer = void 0, globalThis.pageContainer = void 0, globalThis.endMarginStub = void 0, globalThis.pageWidth = void 0, globalThis.pageHeight = void 0, globalThis.pageHorizontalMargin = void 0, globalThis.pageVerticalMargin = void 0, globalThis.pageCount = void 0, globalThis.pagedHorizontally = void 0, globalThis.marginPercent = 0, globalThis.showcasedImageElement = void 0, globalThis.currentFont = void 0, globalThis.fontSetupInitialized = void 0, globalThis.initialFlowWasDone = void 0, globalThis.typefacesStyleElement = void 0, globalThis.fontStyleElement = void 0, globalThis.styleElement = void 0, globalThis.fontsInjected = [], globalThis.fontsLoaded = [], globalThis.specificityClassName = "", globalThis.specificitySelector = "", globalThis.config = {
    layoutStyle: 1,
    flowStyle: 1,
    marginHorizontal: 18,
    marginVertical: 30,
    infoBarHeight: 32,
    textAlign: 2,
    lineSpacing: 1.4,
    backgroundColor: "f7f1e8",
    textColor: "black",
    linkColor: "black",
    font: "",
    topExtraHeight: 0,
    bottomExtraHeight: 0,
    bookName: "",
    chapterName: ""
  };
}
const ce = () => {
  globalThis.ReaderApp = {}, navigator.userAgent.indexOf("ReaderJs/Client") > -1 ? (ReaderApp.notifySize = (...c) => window.flutter_inappwebview.callHandler("notifySize", ...c), ReaderApp.onTouchUp = (...c) => window.flutter_inappwebview.callHandler("onTouchUp", ...c), ReaderApp.setAnchorPositions = (...c) => window.flutter_inappwebview.callHandler("setAnchorPositions", ...c), ReaderApp.setPaperPageMap = (...c) => window.flutter_inappwebview.callHandler("setPaperPageMap", ...c), ReaderApp.onBookReady = (...c) => window.flutter_inappwebview.callHandler("onBookReady", ...c), ReaderApp.onPagingSetup = (...c) => window.flutter_inappwebview.callHandler("onPagingSetup", ...c), ReaderApp.openImage = (...c) => window.flutter_inappwebview.callHandler("openImage", ...c)) : (ReaderApp.notifySize = a, ReaderApp.onTouchUp = g, ReaderApp.setAnchorPositions = r, ReaderApp.setPaperPageMap = l, ReaderApp.onBookReady = u, ReaderApp.onPagingSetup = f, ReaderApp.openImage = d);
  function a(c, m) {
    console.log("notifySize", c, m);
  }
  function g(c, m) {
    console.log("onTouchUp", c, m);
  }
  function r(c, m) {
    console.log("setAnchorPositions", c, m);
  }
  function l(c, m) {
    console.log("setPaperPageMap," + c + "," + m);
  }
  function u(c, m) {
    console.log("onBookReady", c, m);
  }
  function f(c, m, T, H) {
    console.log("onPagingSetup", c, m, T, H);
  }
  function d(c, m) {
    console.log("openImage", c, m);
  }
};
globalThis.ReaderThemes = function() {
  var n = "-webkit-text-fill-color: currentcolor !important;";
  let a;
  function g() {
    const f = document.createElement("style");
    f.setAttribute("type", "text/css"), f.id = "__ReaderThemeStyle", document.head.appendChild(f), a = document.getElementById("__ReaderThemeStyle"), a.dataset.excludeFromFootnote = !0;
  }
  function r(f) {
    for (var d = f.toString(16); d.length < 6; )
      d = "0" + d;
    return d;
  }
  function l(f) {
    var d = "";
    f && (d += "body {", d += "background-color: #" + r(f.backgroundColor) + " !important;", d += "}", d += "* {", d += "background-color: transparent !important;", d += "color: #" + r(f.textColor) + " !important;" + n, d += "}", d += "a, a:link, a:visited, a:hover, a * {", d += "color: #" + r(f.linkColor) + " !important;" + n, d += "}"), a.innerText = d;
  }
  function u() {
    return a.innerText;
  }
  return document.addEventListener("DOMContentLoaded", function() {
    console.log("theme-init"), g();
  }), {
    set: l,
    getCss: u
  };
}();
ce();
globalThis.ReaderJs = (() => {
  le(), window.requestAnimationFrame || (window.requestAnimationFrame = function(r) {
    return setTimeout(r, 16), 0;
  });
  const n = () => {
    var d;
    const r = document.getElementsByTagName("meta");
    let l;
    for (let c = 0; c < r.length; c++) {
      var u = r[c];
      if (u.getAttribute("name") == "viewport") {
        l = u;
        break;
      }
    }
    const f = !!l;
    if (f && globalThis.config.layoutStyle == LAYOUT_FIXED) {
      const c = qt(
        l.getAttribute("content")
      ), m = parseInt(c.width);
      let T = 0;
      c.height && (T = parseInt(c.height));
      const M = document.getElementsByTagName("html")[0].getBoundingClientRect();
      T = Math.max(T, M.bottom - M.top), c.width = m, c.height = T, c["minimum-scale"] = 0, ReaderApp.setFixedViewport(m, T), l.setAttribute(
        "content",
        $t(c)
      );
    } else {
      f && ((d = l == null ? void 0 : l.parentNode) == null || d.removeChild(l));
      const c = document.createElement("meta");
      c.setAttribute("name", "viewport"), c.setAttribute("content", "width=device-width, user-scalable=no"), document.head.appendChild(c);
    }
    ReaderApp.notifySize(window.innerWidth, window.innerHeight), L(), window.onresize = function() {
      console.log("---onresize---"), ReaderApp.notifySize(window.innerWidth, window.innerHeight), L();
    }, ReaderApp.onBookReady(), setTimeout(function() {
      ReaderApp.notifySize(window.innerWidth, window.innerHeight);
    }, 300);
  }, a = () => {
    console.log("---init reader---");
    for (let c = 0; c < 16; c++) {
      let m = "__Reader_S_" + c;
      specificityClassName += " " + m, specificitySelector += "." + m;
    }
    document.body.className = document.body.className + specificityClassName, endMarginStub = document.createElement("div"), endMarginStub.style.position = "absolute", endMarginStub.style.top = "0px", endMarginStub.style.height = "1px", endMarginStub.style.width = "1px", wt([endMarginStub]), document.body.appendChild(endMarginStub), typefacesStyleElement = document.createElement("style"), typefacesStyleElement.setAttribute("type", "text/css"), document.head.appendChild(typefacesStyleElement), fontStyleElement = document.createElement("style"), fontStyleElement.setAttribute("type", "text/css"), document.head.appendChild(fontStyleElement), globalThis.styleElement = document.createElement("style"), globalThis.styleElement.setAttribute("type", "text/css"), document.head.appendChild(globalThis.styleElement);
    const r = document.getElementsByTagName("a");
    for (var l = 0; l < r.length; l++) {
      var u = r[l];
      u.getAttribute("href") && u.addEventListener("click", function(c) {
        re(this, c);
      });
    }
    const f = document.getElementsByTagName("img");
    for (let c = 0; c < f.length; c++) {
      var d = f[c];
      d.addEventListener("click", function(m) {
        se(this, m);
      });
    }
    document.addEventListener("click", function() {
      ReaderApp.onTouchUp();
    }), Gt();
  };
  return document.addEventListener("DOMContentLoaded", a), window.addEventListener("load", function() {
    if (globalThis.config.layoutStyle == LAYOUT_FIXED) {
      n();
      return;
    }
    var r = Yt();
    currentFont && r.indexOf(currentFont.name) == -1 && r.push(currentFont.name), fontSetupInitialized = !0, vt.load({
      custom: {
        families: r
      },
      classes: !1,
      active: function() {
        fontsLoaded.push.apply(fontsLoaded, r), n();
      },
      inactive: n,
      timeout: 1e3
    });
  }), {
    // jumpToAnchor: jumpToAnchor,
    // jumpToAnnotation: jumpToAnnotation,
    // jumpToSearchResult: jumpToSearchResult,
    // hideShowcasedImage: hideShowcasedImage,
    // restoreShowcasedImage: restoreShowcasedImage,
    reflowIfNecessary: R,
    setPageProperties: te,
    setMargin: ee,
    setMarginHorizontal: mt,
    setMarginVertical: yt,
    setMarginPercent: ne,
    setFont: ae,
    setLineSpacing: Zt,
    setTextAlign: oe,
    initConfig: (r) => {
      globalThis.config = Object.assign(globalThis.config, r), console.log("当前配置", globalThis.config), mt(r.marginHorizontal), yt(r.marginVertical), X(), R(), ReaderThemes.set({
        backgroundColor: r.backgroundColor,
        textColor: r.textColor,
        linkColor: r.linkColor
      });
    }
  };
})();
