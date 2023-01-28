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
    function a(t, e, o) {
      return t.call.apply(t.bind, arguments);
    }
    function p(t, e, o) {
      if (!t)
        throw Error();
      if (2 < arguments.length) {
        var i = Array.prototype.slice.call(arguments, 2);
        return function() {
          var s = Array.prototype.slice.call(arguments);
          return Array.prototype.unshift.apply(s, i), t.apply(e, s);
        };
      }
      return function() {
        return t.apply(e, arguments);
      };
    }
    function r(t, e, o) {
      return r = Function.prototype.bind && Function.prototype.bind.toString().indexOf("native code") != -1 ? a : p, r.apply(null, arguments);
    }
    var c = Date.now || function() {
      return +new Date();
    };
    function l(t, e) {
      this.a = t, this.o = e || t, this.c = this.o.document;
    }
    var u = !!window.FontFace;
    function v(t, e, o, i) {
      if (e = t.c.createElement(e), o)
        for (var s in o)
          o.hasOwnProperty(s) && (s == "style" ? e.style.cssText = o[s] : e.setAttribute(s, o[s]));
      return i && e.appendChild(t.c.createTextNode(i)), e;
    }
    function f(t, e, o) {
      t = t.c.getElementsByTagName(e)[0], t || (t = document.documentElement), t.insertBefore(o, t.lastChild);
    }
    function d(t) {
      t.parentNode && t.parentNode.removeChild(t);
    }
    function T(t, e, o) {
      e = e || [], o = o || [];
      for (var i = t.className.split(/\s+/), s = 0; s < e.length; s += 1) {
        for (var g = !1, h = 0; h < i.length; h += 1)
          if (e[s] === i[h]) {
            g = !0;
            break;
          }
        g || i.push(e[s]);
      }
      for (e = [], s = 0; s < i.length; s += 1) {
        for (g = !1, h = 0; h < o.length; h += 1)
          if (i[s] === o[h]) {
            g = !0;
            break;
          }
        g || e.push(i[s]);
      }
      t.className = e.join(" ").replace(/\s+/g, " ").replace(/^\s+|\s+$/, "");
    }
    function k(t, e) {
      for (var o = t.className.split(/\s+/), i = 0, s = o.length; i < s; i++)
        if (o[i] == e)
          return !0;
      return !1;
    }
    function M(t) {
      return t.o.location.hostname || t.a.location.hostname;
    }
    function P(t, e, o) {
      function i() {
        m && s && g && (m(h), m = null);
      }
      e = v(t, "link", { rel: "stylesheet", href: e, media: "all" });
      var s = !1, g = !0, h = null, m = o || null;
      u ? (e.onload = function() {
        s = !0, i();
      }, e.onerror = function() {
        s = !0, h = Error("Stylesheet failed to load"), i();
      }) : setTimeout(function() {
        s = !0, i();
      }, 0), f(t, "head", e);
    }
    function E(t, e, o, i) {
      var s = t.c.getElementsByTagName("head")[0];
      if (s) {
        var g = v(t, "script", { src: e }), h = !1;
        return g.onload = g.onreadystatechange = function() {
          h || this.readyState && this.readyState != "loaded" && this.readyState != "complete" || (h = !0, o && o(null), g.onload = g.onreadystatechange = null, g.parentNode.tagName == "HEAD" && s.removeChild(g));
        }, s.appendChild(g), setTimeout(function() {
          h || (h = !0, o && o(Error("Script load timeout")));
        }, i || 5e3), g;
      }
      return null;
    }
    function _() {
      this.a = 0, this.c = null;
    }
    function X(t) {
      return t.a++, function() {
        t.a--, q(t);
      };
    }
    function Y(t, e) {
      t.c = e, q(t);
    }
    function q(t) {
      t.a == 0 && t.c && (t.c(), t.c = null);
    }
    function $(t) {
      this.a = t || "-";
    }
    $.prototype.c = function(t) {
      for (var e = [], o = 0; o < arguments.length; o++)
        e.push(arguments[o].replace(/[\W_]+/g, "").toLowerCase());
      return e.join(this.a);
    };
    function S(t, e) {
      this.c = t, this.f = 4, this.a = "n";
      var o = (e || "n4").match(/^([nio])([1-9])$/i);
      o && (this.a = o[1], this.f = parseInt(o[2], 10));
    }
    function Ct(t) {
      return K(t) + " " + (t.f + "00") + " 300px " + J(t.c);
    }
    function J(t) {
      var e = [];
      t = t.split(/,\s*/);
      for (var o = 0; o < t.length; o++) {
        var i = t[o].replace(/['"]/g, "");
        i.indexOf(" ") != -1 || /^\d/.test(i) ? e.push("'" + i + "'") : e.push(i);
      }
      return e.join(",");
    }
    function C(t) {
      return t.a + t.f;
    }
    function K(t) {
      var e = "normal";
      return t.a === "o" ? e = "oblique" : t.a === "i" && (e = "italic"), e;
    }
    function Et(t) {
      var e = 4, o = "n", i = null;
      return t && ((i = t.match(/(normal|oblique|italic)/i)) && i[1] && (o = i[1].substr(0, 1).toLowerCase()), (i = t.match(/([1-9]00|normal|bold)/i)) && i[1] && (/bold/i.test(i[1]) ? e = 7 : /[1-9]00/.test(i[1]) && (e = parseInt(i[1].substr(0, 1), 10)))), o + e;
    }
    function St(t, e) {
      this.c = t, this.f = t.o.document.documentElement, this.h = e, this.a = new $("-"), this.j = e.events !== !1, this.g = e.classes !== !1;
    }
    function At(t) {
      t.g && T(t.f, [t.a.c("wf", "loading")]), F(t, "loading");
    }
    function Q(t) {
      if (t.g) {
        var e = k(t.f, t.a.c("wf", "active")), o = [], i = [t.a.c("wf", "loading")];
        e || o.push(t.a.c("wf", "inactive")), T(t.f, o, i);
      }
      F(t, "inactive");
    }
    function F(t, e, o) {
      t.j && t.h[e] && (o ? t.h[e](o.c, C(o)) : t.h[e]());
    }
    function _t() {
      this.c = {};
    }
    function kt(t, e, o) {
      var i = [], s;
      for (s in e)
        if (e.hasOwnProperty(s)) {
          var g = t.c[s];
          g && i.push(g(e[s], o));
        }
      return i;
    }
    function I(t, e) {
      this.c = t, this.f = e, this.a = v(this.c, "span", { "aria-hidden": "true" }, this.f);
    }
    function W(t) {
      f(t.c, "body", t.a);
    }
    function z(t) {
      return "display:block;position:absolute;top:-9999px;left:-9999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;white-space:nowrap;font-family:" + J(t.c) + ";" + ("font-style:" + K(t) + ";font-weight:" + (t.f + "00") + ";");
    }
    function Z(t, e, o, i, s, g) {
      this.g = t, this.j = e, this.a = i, this.c = o, this.f = s || 3e3, this.h = g || void 0;
    }
    Z.prototype.start = function() {
      var t = this.c.o.document, e = this, o = c(), i = new Promise(function(h, m) {
        function y() {
          c() - o >= e.f ? m() : t.fonts.load(Ct(e.a), e.h).then(function(w) {
            1 <= w.length ? h() : setTimeout(y, 25);
          }, function() {
            m();
          });
        }
        y();
      }), s = null, g = new Promise(function(h, m) {
        s = setTimeout(m, e.f);
      });
      Promise.race([g, i]).then(function() {
        s && (clearTimeout(s), s = null), e.g(e.a);
      }, function() {
        e.j(e.a);
      });
    };
    function tt(t, e, o, i, s, g, h) {
      this.v = t, this.B = e, this.c = o, this.a = i, this.s = h || "BESbswy", this.f = {}, this.w = s || 3e3, this.u = g || null, this.m = this.j = this.h = this.g = null, this.g = new I(this.c, this.s), this.h = new I(this.c, this.s), this.j = new I(this.c, this.s), this.m = new I(this.c, this.s), t = new S(this.a.c + ",serif", C(this.a)), t = z(t), this.g.a.style.cssText = t, t = new S(this.a.c + ",sans-serif", C(this.a)), t = z(t), this.h.a.style.cssText = t, t = new S("serif", C(this.a)), t = z(t), this.j.a.style.cssText = t, t = new S("sans-serif", C(this.a)), t = z(t), this.m.a.style.cssText = t, W(this.g), W(this.h), W(this.j), W(this.m);
    }
    var B = { D: "serif", C: "sans-serif" }, D = null;
    function et() {
      if (D === null) {
        var t = /AppleWebKit\/([0-9]+)(?:\.([0-9]+))/.exec(window.navigator.userAgent);
        D = !!t && (536 > parseInt(t[1], 10) || parseInt(t[1], 10) === 536 && 11 >= parseInt(t[2], 10));
      }
      return D;
    }
    tt.prototype.start = function() {
      this.f.serif = this.j.a.offsetWidth, this.f["sans-serif"] = this.m.a.offsetWidth, this.A = c(), it(this);
    };
    function nt(t, e, o) {
      for (var i in B)
        if (B.hasOwnProperty(i) && e === t.f[B[i]] && o === t.f[B[i]])
          return !0;
      return !1;
    }
    function it(t) {
      var e = t.g.a.offsetWidth, o = t.h.a.offsetWidth, i;
      (i = e === t.f.serif && o === t.f["sans-serif"]) || (i = et() && nt(t, e, o)), i ? c() - t.A >= t.w ? et() && nt(t, e, o) && (t.u === null || t.u.hasOwnProperty(t.a.c)) ? V(t, t.v) : V(t, t.B) : Ht(t) : V(t, t.v);
    }
    function Ht(t) {
      setTimeout(r(function() {
        it(this);
      }, t), 50);
    }
    function V(t, e) {
      setTimeout(r(function() {
        d(this.g.a), d(this.h.a), d(this.j.a), d(this.m.a), e(this.a);
      }, t), 0);
    }
    function U(t, e, o) {
      this.c = t, this.a = e, this.f = 0, this.m = this.j = !1, this.s = o;
    }
    var O = null;
    U.prototype.g = function(t) {
      var e = this.a;
      e.g && T(e.f, [e.a.c("wf", t.c, C(t).toString(), "active")], [e.a.c("wf", t.c, C(t).toString(), "loading"), e.a.c("wf", t.c, C(t).toString(), "inactive")]), F(e, "fontactive", t), this.m = !0, ot(this);
    }, U.prototype.h = function(t) {
      var e = this.a;
      if (e.g) {
        var o = k(e.f, e.a.c("wf", t.c, C(t).toString(), "active")), i = [], s = [e.a.c("wf", t.c, C(t).toString(), "loading")];
        o || i.push(e.a.c("wf", t.c, C(t).toString(), "inactive")), T(e.f, i, s);
      }
      F(e, "fontinactive", t), ot(this);
    };
    function ot(t) {
      --t.f == 0 && t.j && (t.m ? (t = t.a, t.g && T(t.f, [t.a.c("wf", "active")], [t.a.c("wf", "loading"), t.a.c("wf", "inactive")]), F(t, "active")) : Q(t.a));
    }
    function at(t) {
      this.j = t, this.a = new _t(), this.h = 0, this.f = this.g = !0;
    }
    at.prototype.load = function(t) {
      this.c = new l(this.j, t.context || this.j), this.g = t.events !== !1, this.f = t.classes !== !1, Mt(this, new St(this.c, t), t);
    };
    function Rt(t, e, o, i, s) {
      var g = --t.h == 0;
      (t.f || t.g) && setTimeout(function() {
        var h = s || null, m = i || null || {};
        if (o.length === 0 && g)
          Q(e.a);
        else {
          e.f += o.length, g && (e.j = g);
          var y, w = [];
          for (y = 0; y < o.length; y++) {
            var b = o[y], x = m[b.c], A = e.a, N = b;
            if (A.g && T(A.f, [A.a.c("wf", N.c, C(N).toString(), "loading")]), F(A, "fontloading", N), A = null, O === null)
              if (window.FontFace) {
                var N = /Gecko.*Firefox\/(\d+)/.exec(window.navigator.userAgent), Dt = /OS X.*Version\/10\..*Safari/.exec(window.navigator.userAgent) && /Apple/.exec(window.navigator.vendor);
                O = N ? 42 < parseInt(N[1], 10) : !Dt;
              } else
                O = !1;
            O ? A = new Z(r(e.g, e), r(e.h, e), e.c, b, e.s, x) : A = new tt(r(e.g, e), r(e.h, e), e.c, b, e.s, h, x), w.push(A);
          }
          for (y = 0; y < w.length; y++)
            w[y].start();
        }
      }, 0);
    }
    function Mt(t, e, o) {
      var s = [], i = o.timeout;
      At(e);
      var s = kt(t.a, o, t.c), g = new U(t.c, e, i);
      for (t.h = s.length, e = 0, o = s.length; e < o; e++)
        s[e].load(function(h, m, y) {
          Rt(t, g, h, m, y);
        });
    }
    function rt(t, e) {
      this.c = t, this.a = e;
    }
    rt.prototype.load = function(t) {
      function e() {
        if (g["__mti_fntLst" + i]) {
          var h = g["__mti_fntLst" + i](), m = [], y;
          if (h)
            for (var w = 0; w < h.length; w++) {
              var b = h[w].fontfamily;
              h[w].fontStyle != null && h[w].fontWeight != null ? (y = h[w].fontStyle + h[w].fontWeight, m.push(new S(b, y))) : m.push(new S(b));
            }
          t(m);
        } else
          setTimeout(function() {
            e();
          }, 50);
      }
      var o = this, i = o.a.projectId, s = o.a.version;
      if (i) {
        var g = o.c.o;
        E(this.c, (o.a.api || "https://fast.fonts.net/jsapi") + "/" + i + ".js" + (s ? "?v=" + s : ""), function(h) {
          h ? t([]) : (g["__MonotypeConfiguration__" + i] = function() {
            return o.a;
          }, e());
        }).id = "__MonotypeAPIScript__" + i;
      } else
        t([]);
    };
    function st(t, e) {
      this.c = t, this.a = e;
    }
    st.prototype.load = function(t) {
      var e, o, i = this.a.urls || [], s = this.a.families || [], g = this.a.testStrings || {}, h = new _();
      for (e = 0, o = i.length; e < o; e++)
        P(this.c, i[e], X(h));
      var m = [];
      for (e = 0, o = s.length; e < o; e++)
        if (i = s[e].split(":"), i[1])
          for (var y = i[1].split(","), w = 0; w < y.length; w += 1)
            m.push(new S(i[0], y[w]));
        else
          m.push(new S(i[0]));
      Y(h, function() {
        t(m, g);
      });
    };
    function Ft(t, e) {
      t ? this.c = t : this.c = Nt, this.a = [], this.f = [], this.g = e || "";
    }
    var Nt = "https://fonts.googleapis.com/css";
    function Pt(t, e) {
      for (var o = e.length, i = 0; i < o; i++) {
        var s = e[i].split(":");
        s.length == 3 && t.f.push(s.pop());
        var g = "";
        s.length == 2 && s[1] != "" && (g = ":"), t.a.push(s.join(g));
      }
    }
    function Lt(t) {
      if (t.a.length == 0)
        throw Error("No fonts to load!");
      if (t.c.indexOf("kit=") != -1)
        return t.c;
      for (var e = t.a.length, o = [], i = 0; i < e; i++)
        o.push(t.a[i].replace(/ /g, "+"));
      return e = t.c + "?family=" + o.join("%7C"), 0 < t.f.length && (e += "&subset=" + t.f.join(",")), 0 < t.g.length && (e += "&text=" + encodeURIComponent(t.g)), e;
    }
    function It(t) {
      this.f = t, this.a = [], this.c = {};
    }
    var lt = { latin: "BESbswy", "latin-ext": "çöüğş", cyrillic: "йяЖ", greek: "αβΣ", khmer: "កខគ", Hanuman: "កខគ" }, Wt = { thin: "1", extralight: "2", "extra-light": "2", ultralight: "2", "ultra-light": "2", light: "3", regular: "4", book: "4", medium: "5", "semi-bold": "6", semibold: "6", "demi-bold": "6", demibold: "6", bold: "7", "extra-bold": "8", extrabold: "8", "ultra-bold": "8", ultrabold: "8", black: "9", heavy: "9", l: "3", r: "4", b: "7" }, zt = { i: "i", italic: "i", n: "n", normal: "n" }, Bt = /^(thin|(?:(?:extra|ultra)-?)?light|regular|book|medium|(?:(?:semi|demi|extra|ultra)-?)?bold|black|heavy|l|r|b|[1-9]00)?(n|i|normal|italic)?$/;
    function Ot(t) {
      for (var e = t.f.length, o = 0; o < e; o++) {
        var i = t.f[o].split(":"), s = i[0].replace(/\+/g, " "), g = ["n4"];
        if (2 <= i.length) {
          var h, m = i[1];
          if (h = [], m)
            for (var m = m.split(","), y = m.length, w = 0; w < y; w++) {
              var b;
              if (b = m[w], b.match(/^[\w-]+$/)) {
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
              b && h.push(b);
            }
          0 < h.length && (g = h), i.length == 3 && (i = i[2], h = [], i = i ? i.split(",") : h, 0 < i.length && (i = lt[i[0]]) && (t.c[s] = i));
        }
        for (t.c[s] || (i = lt[s]) && (t.c[s] = i), i = 0; i < g.length; i += 1)
          t.a.push(new S(s, g[i]));
      }
    }
    function ct(t, e) {
      this.c = t, this.a = e;
    }
    var jt = { Arimo: !0, Cousine: !0, Tinos: !0 };
    ct.prototype.load = function(t) {
      var e = new _(), o = this.c, i = new Ft(this.a.api, this.a.text), s = this.a.families;
      Pt(i, s);
      var g = new It(s);
      Ot(g), P(o, Lt(i), X(e)), Y(e, function() {
        t(g.a, g.c, jt);
      });
    };
    function ut(t, e) {
      this.c = t, this.a = e;
    }
    ut.prototype.load = function(t) {
      var e = this.a.id, o = this.c.o;
      e ? E(this.c, (this.a.api || "https://use.typekit.net") + "/" + e + ".js", function(i) {
        if (i)
          t([]);
        else if (o.Typekit && o.Typekit.config && o.Typekit.config.fn) {
          i = o.Typekit.config.fn;
          for (var s = [], g = 0; g < i.length; g += 2)
            for (var h = i[g], m = i[g + 1], y = 0; y < m.length; y++)
              s.push(new S(h, m[y]));
          try {
            o.Typekit.load({ events: !1, classes: !1, async: !0 });
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
      var e = this.f.id, o = this.c.o, i = this;
      e ? (o.__webfontfontdeckmodule__ || (o.__webfontfontdeckmodule__ = {}), o.__webfontfontdeckmodule__[e] = function(s, g) {
        for (var h = 0, m = g.fonts.length; h < m; ++h) {
          var y = g.fonts[h];
          i.a.push(new S(y.name, Et("font-weight:" + y.weight + ";font-style:" + y.style)));
        }
        t(i.a);
      }, E(this.c, (this.f.api || "https://f.fontdeck.com/s/css/js/") + M(this.c) + "/" + e + ".js", function(s) {
        s && t([]);
      })) : t([]);
    };
    var H = new at(window);
    H.a.c.custom = function(t, e) {
      return new st(e, t);
    }, H.a.c.fontdeck = function(t, e) {
      return new ft(e, t);
    }, H.a.c.monotype = function(t, e) {
      return new rt(e, t);
    }, H.a.c.typekit = function(t, e) {
      return new ut(e, t);
    }, H.a.c.google = function(t, e) {
      return new ct(e, t);
    };
    var pt = { load: r(H.load, H) };
    n.exports ? n.exports = pt : (window.WebFont = pt, window.WebFontConfig && H.load(window.WebFontConfig));
  })();
})(Vt);
const yt = G, vt = (n) => {
  for (let a of n)
    a.style.margin = "0px", a.style.padding = "0px", a.style.border = "none";
}, gt = (n) => {
  let a = n, p;
  for (; a.tagName && a.tagName.toLowerCase() !== "body" && a != bookContainer; ) {
    if (p) {
      var r = p;
      p = a.cloneNode(!1), p.className += " __Reader_NoEffects", p.appendChild(r);
    } else
      p = a.cloneNode(!0);
    a = a.parentNode;
  }
  var c = document.createElement("div");
  return c.className = "__Reader_Footnote_Content " + specificityClassName, c.appendChild(p), c.outerHTML;
}, ht = (n) => {
  var a = "";
  a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/default.css' />";
  var p = n.querySelectorAll("link, style"), r = document.createElement("div");
  for (let l = 0; l < p.length; l++) {
    var c = p[l];
    c.dataset.excludeFromFootnote || r.appendChild(c.cloneNode(!0));
  }
  return a += r.innerHTML, a += "<style type='text/css'>" + ReaderThemes.getCss() + "</style>", a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/footnote.css' />", a;
}, Ut = (n, a) => {
  if (n[0] == "#") {
    var p = document.getElementById(n.substring(1)) ? gt(document.getElementById(n.substring(1))) : "";
    a(ht(document) + p);
    return;
  }
  var r = n.indexOf("#"), c = n.substring(r), l = n.substring(0, r), u = new XMLHttpRequest();
  u.open("GET", l, !0), u.responseType = "document", u.onload = function() {
    if (u.status != 200) {
      console.error(
        'Failed to load footnote at "' + n + '": ' + u.statusText
      );
      return;
    }
    var v = u.responseXML;
    a(
      ht(v) + gt(v.getElementById(c.substring(1)))
    );
  }, u.send();
}, Gt = () => {
  var n = document.getElementsByTagName("switch");
  for (let c = 0; c < n.length; c++) {
    var a = n[c], p = a.getElementsByTagName("case");
    for (let l = 0; l < p.length; l++) {
      var r = p[l];
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
}, wt = (n) => {
  if (Xt(n))
    return { fonts: [], useWorkaround: !0 };
  var a = [], p = !1, r = n.cssRules;
  for (let v = 0; v < r.length; v++) {
    var c = r[v];
    if (c.styleSheet) {
      var l = wt(c.styleSheet);
      a.push.apply(a, l.fonts), p = p || l.useWorkaround;
      continue;
    }
    if (c.type == CSSRule.FONT_FACE_RULE) {
      var u = c.style.fontFamily;
      a.indexOf(u) == -1 && a.push(u);
    }
  }
  return { fonts: a, useWorkaround: p };
}, Yt = () => {
  const n = [];
  var a = {}, p = void 0, r = document.styleSheets;
  for (let E = 0; E < r.length; E++) {
    var c = r[E], l = wt(c);
    p = p || l.useWorkaround;
    var u = l.fonts;
    for (let _ = 0; _ < u.length; _++) {
      var v = u[_];
      a[v.toLowerCase()] = !0;
    }
    n.push.apply(n, l.fonts);
  }
  if (p) {
    var f = Array.prototype.slice.call(document.body.childNodes);
    for (let E = 0; E < f.length; E++) {
      var d = f[E];
      if (d.nodeType == Node.ELEMENT_NODE) {
        var T = window.getComputedStyle(d), k = T["font-family"].split(",");
        for (let _ = 0; _ < k.length; _++) {
          var M = k[_], P = M.toLowerCase();
          a[P] !== !0 && (a[P] = !0);
        }
        n.push.apply(n, k);
      }
    }
  }
  return n;
}, qt = (n) => {
  for (var a = {}, p = n.split(","), r = 0; r < p.length; ++r) {
    var c = p[r].split("="), l = c[0].trim(), u = c[1].trim();
    a[l] = u;
  }
  return a;
}, $t = (n) => {
  var a = "", p = 0;
  for (var r in n)
    p != 0 && (a += ","), a += r + "=" + n[r], p++;
  return a;
}, bt = (n) => {
  var a = n.getBoundingClientRect();
  return pagedHorizontally ? Math.floor(
    (a.left + window.scrollX) / (pageWidth + pageHorizontalMargin)
  ) : Math.floor(
    (a.top + window.scrollY) / (pageHeight + pageVerticalMargin)
  );
}, Jt = (n) => {
  var a = {};
  for (var p in n) {
    var r = n[p], c = document.getElementById(r.substring(1));
    if (c)
      switch (globalThis.config.flowStyle) {
        case FLOW_PAGED:
          a[p] = bt(c);
          break;
        case FLOW_SCROLLED:
          a[p] = c.offsetTop;
          break;
      }
  }
  return a;
}, Tt = (n) => {
  if (!n.length) {
    ReaderApp.setAnchorPositions(null);
    return;
  }
  var a = [];
  for (var p in n) {
    var r = n[p], c = document.getElementById(r.substring(1));
    if (c)
      if (globalThis.config.flowStyle == FLOW_PAGED)
        a.push([r, bt(c)]);
      else {
        var l = c.getBoundingClientRect(), u = l.top + window.scrollY;
        a.push([r, u]);
      }
  }
  ReaderApp.setAnchorPositions(JSON.stringify(a));
}, Kt = (n) => {
  bookContainer.innerHTML = bookContainer.firstChild.outerHTML;
  const a = globalThis.config.bookName ?? "", p = globalThis.config.chapterName ?? document.getElementsByTagName("title")[0].innerText;
  let r = window.innerWidth;
  for (let c = 0; c < n; c++) {
    const l = document.createElement("div");
    l.className = "ReaderApp-page-header", l.style.padding = "0", l.style.position = "absolute", l.style.top = globalThis.config.topExtraHeight + "px", l.style.left = r * c + "px", l.style.width = "100%", l.style.height = globalThis.config.infoBarHeight + "px", l.style.boxSizing = "border-box", l.style.fontSize = "13px", l.style.color = "#8d8d8d", l.style.padding = `0 ${globalThis.config.marginHorizontal}px`, l.style.display = "flex", l.style.alignItems = "flex-end", l.innerText = c == 0 ? a : p, bookContainer.appendChild(l);
    const u = document.createElement("div");
    u.className = "ReaderApp-page-footer", u.style.padding = "0", u.style.position = "absolute", u.style.bottom = globalThis.config.bottomExtraHeight + "px", u.style.left = r * c + "px", u.style.width = "100%", u.style.height = globalThis.config.infoBarHeight + "px", u.style.boxSizing = "border-box", u.style.fontSize = "13px", u.style.color = "#8d8d8d", u.style.padding = `0 ${globalThis.config.marginHorizontal}px`, u.style.display = "flex", u.style.alignItems = "flex-start", u.style.justifyContent = "flex-end", u.innerText = `${c + 1}/${n}`, bookContainer.appendChild(u);
  }
}, Qt = () => {
  if (!(globalThis.config.layoutStyle != LAYOUT_REFLOW || globalThis.config.flowStyle != FLOW_PAGED)) {
    if (!pageContainer) {
      bookContainer = document.createElement("div");
      var n = document.createElement("div");
      n.style.webkitMarginCollapse = "separate";
      var a = Array.prototype.slice.call(document.body.childNodes);
      for (let l = 0; l < a.length; l++) {
        var p = a[l];
        n.appendChild(p);
      }
      n.className = "collapse-wrapper", bookContainer.appendChild(n), pageContainer = document.createElement("div"), pageContainer.className = "book-wrapper", pageContainer.appendChild(bookContainer), document.body.appendChild(pageContainer), vt([pageContainer, bookContainer]);
    }
    pageHorizontalMargin = globalThis.config.marginHorizontal * 2, pageVerticalMargin = (globalThis.config.marginVertical + globalThis.config.infoBarHeight + globalThis.config.bottomExtraHeight) * 2, console.log("---><", pageHorizontalMargin, pageVerticalMargin), pageWidth = window.innerWidth - pageHorizontalMargin, pageHeight = window.innerHeight - pageVerticalMargin;
    var r = window.getComputedStyle(document.body), c = window.getComputedStyle(
      document.getElementsByTagName("html")[0]
    );
    pagedHorizontally = r.writingMode.indexOf("vertical") == -1 && c.writingMode.indexOf("vertical") == -1, bookContainer.style.width = pageWidth + "px", bookContainer.style.height = pageHeight + "px", bookContainer.style.webkitColumnWidth = (pagedHorizontally ? pageWidth : pageHeight) + "px", bookContainer.style.webkitColumnGap = (pagedHorizontally ? pageHorizontalMargin : pageVerticalMargin) + "px", endMarginStub.style.left = "0px", endMarginStub.style.top = "0px", pagedHorizontally ? (pageCount = Math.ceil(
      document.body.scrollWidth / (pageWidth + pageHorizontalMargin)
    ), endMarginStub.style.left = pageCount * (pageWidth + pageHorizontalMargin) - 1 + "px") : (pageCount = Math.ceil(
      document.body.scrollHeight / (pageHeight + pageVerticalMargin)
    ), endMarginStub.style.top = pageCount * (pageHeight + pageVerticalMargin) - 1 + "px"), Tt(globalThis.config.tocAnchorList ?? []), Kt(pageCount), ReaderApp.onPagingSetup(
      pageHorizontalMargin / window.innerWidth,
      pageHorizontalMargin / window.innerHeight,
      pageCount,
      pagedHorizontally
    );
  }
}, L = () => {
  globalThis.config.flowStyle == FLOW_PAGED ? Qt() : Tt(globalThis.config.tocAnchorList ?? []);
  var n = Jt(
    globalThis.config.paperPageToAnchorMap ?? []
  );
  ReaderApp.setPaperPageMap(JSON.stringify(n)), initialFlowWasDone = !0;
}, R = () => {
  initialFlowWasDone && L();
}, xt = () => {
  var n = "line-height: " + lineSpacing + " !important;";
  switch (textAlign) {
    case 1:
      n += "text-align: initial !important;";
      break;
    case 2:
      n += "text-align: justify !important;";
      break;
  }
  styleElement.innerText = specificitySelector + " * { " + n + " }";
}, Zt = (n) => {
  lineSpacing = n, xt(), R();
}, te = (n) => {
  console.log(n, "setPtops");
}, ee = (n) => {
  document.body.style.margin = n, R();
}, ne = (n) => {
  marginPercent = n / 100, document.body.style.margin = n + "%", R();
}, dt = (n) => {
  globalThis.config.marginHorizontal = n, document.body.style.marginLeft = n + "px", document.body.style.marginRight = n + "px", R();
}, mt = (n) => {
  globalThis.config.marginVertical = n, document.body.style.marginBottom = globalThis.config.infoBarHeight + n + "px", document.body.style.marginTop = globalThis.config.infoBarHeight + n + "px", R();
}, ie = (n) => {
  textAlign = n, xt(), R();
}, j = (n, a, p, r) => "@font-face { font-family: '" + n + "';font-style: " + a + "; font-weight: " + p + ";src: url(file:///android_asset/fonts/" + r + "); }", oe = (n) => {
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
    fontsLoaded.indexOf(n.name) > -1 ? a() : yt.load({
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
  fontsInjected.indexOf(n.name) == -1 && oe(n);
}, re = (n, a) => {
  if (n.href.indexOf("javascript:") == 0) {
    a.stopPropagation();
    return;
  }
  a.preventDefault(), a.stopPropagation(), (n.getAttribute("epub:type") || n.getAttribute("epubu0003atype")) == "noteref" ? (a.preventDefault(), a.stopPropagation(), Ut(n.getAttribute("href"), function(r) {
    const c = n.getClientRects();
    let l;
    for (var u in c) {
      var v = c[u];
      if (a.clientX >= v.left && a.clientX <= v.right && a.clientY >= v.top && a.clientY <= v.bottom) {
        l = v;
        break;
      }
    }
    l = l || c[0];
    var f = (l.left + l.right) / 2, d = (l.top + l.bottom) / 2;
    ReaderApp.openFootNote(n.innerText.trim(), r, f, d);
  })) : ReaderApp.openLink(n.href);
}, se = (n, a) => {
  for (var p = n.parentNode; p; ) {
    if (p.tagName && p.tagName.toLowerCase() == "a" && p.getAttribute("href"))
      return;
    p = p.parentNode;
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
  globalThis.ReaderApp = {}, navigator.userAgent.indexOf("ReaderJs/Client") > -1 ? (ReaderApp.notifySize = (...f) => window.flutter_inappwebview.callHandler("notifySize", ...f), ReaderApp.onTouchUp = (...f) => window.flutter_inappwebview.callHandler("onTouchUp", ...f), ReaderApp.setAnchorPositions = (...f) => window.flutter_inappwebview.callHandler("setAnchorPositions", ...f), ReaderApp.setPaperPageMap = (...f) => window.flutter_inappwebview.callHandler("setPaperPageMap", ...f), ReaderApp.onBookReady = (...f) => window.flutter_inappwebview.callHandler("onBookReady", ...f), ReaderApp.onPagingSetup = (...f) => window.flutter_inappwebview.callHandler("onPagingSetup", ...f), ReaderApp.openImage = (...f) => window.flutter_inappwebview.callHandler("openImage", ...f)) : (ReaderApp.notifySize = a, ReaderApp.onTouchUp = p, ReaderApp.setAnchorPositions = r, ReaderApp.setPaperPageMap = c, ReaderApp.onBookReady = l, ReaderApp.onPagingSetup = u, ReaderApp.openImage = v);
  function a(f, d) {
    console.log("notifySize", f, d);
  }
  function p(f, d) {
    console.log("onTouchUp", f, d);
  }
  function r(f, d) {
    console.log("setAnchorPositions", f, d);
  }
  function c(f, d) {
    console.log("setPaperPageMap," + f + "," + d);
  }
  function l(f, d) {
    console.log("onBookReady", f, d);
  }
  function u(f, d, T, k) {
    console.log("onPagingSetup", f, d, T, k);
  }
  function v(f, d) {
    console.log("openImage", f, d);
  }
};
globalThis.ReaderThemes = function() {
  var n = "-webkit-text-fill-color: currentcolor !important;";
  globalThis.styleElement = void 0;
  function a() {
    const l = document.createElement("style");
    l.setAttribute("type", "text/css"), l.id = "__ReaderThemeStyle", document.head.appendChild(l), styleElement = document.getElementById("__ReaderThemeStyle"), styleElement.dataset.excludeFromFootnote = !0;
  }
  function p(l) {
    for (var u = l.toString(16); u.length < 6; )
      u = "0" + u;
    return u;
  }
  function r(l) {
    var u = "";
    l && (u += "body {", u += "background-color: #" + p(l.backgroundColor) + " !important;", u += "}", u += "* {", u += "background-color: transparent !important;", u += "color: #" + p(l.textColor) + " !important;" + n, u += "}", u += "a, a:link, a:visited, a:hover, a * {", u += "color: #" + p(l.linkColor) + " !important;" + n, u += "}"), styleElement.innerText = u;
  }
  function c() {
    return styleElement.innerText;
  }
  return document.addEventListener("DOMContentLoaded", function() {
    console.log("theme-init"), a();
  }), {
    set: r,
    getCss: c
  };
}();
ce();
globalThis.ReaderJs = (() => {
  le(), window.requestAnimationFrame || (window.requestAnimationFrame = function(r) {
    return setTimeout(r, 16), 0;
  });
  const n = () => {
    var v;
    const r = document.getElementsByTagName("meta");
    let c;
    for (let f = 0; f < r.length; f++) {
      var l = r[f];
      if (l.getAttribute("name") == "viewport") {
        c = l;
        break;
      }
    }
    const u = !!c;
    if (u && globalThis.config.layoutStyle == LAYOUT_FIXED) {
      const f = qt(
        c.getAttribute("content")
      ), d = parseInt(f.width);
      let T = 0;
      f.height && (T = parseInt(f.height));
      const M = document.getElementsByTagName("html")[0].getBoundingClientRect();
      T = Math.max(T, M.bottom - M.top), f.width = d, f.height = T, f["minimum-scale"] = 0, ReaderApp.setFixedViewport(d, T), c.setAttribute(
        "content",
        $t(f)
      );
    } else {
      u && ((v = c == null ? void 0 : c.parentNode) == null || v.removeChild(c));
      const f = document.createElement("meta");
      f.setAttribute("name", "viewport"), f.setAttribute("content", "width=device-width, user-scalable=no"), document.head.appendChild(f);
    }
    ReaderApp.notifySize(window.innerWidth, window.innerHeight), L(), window.onresize = function() {
      console.log("---onresize---"), ReaderApp.notifySize(window.innerWidth, window.innerHeight), L();
    }, ReaderApp.onBookReady(), setTimeout(function() {
      ReaderApp.notifySize(window.innerWidth, window.innerHeight);
    }, 300);
  }, a = () => {
    console.log("---init reader---");
    for (let f = 0; f < 16; f++) {
      let d = "__Reader_S_" + f;
      specificityClassName += " " + d, specificitySelector += "." + d;
    }
    document.body.className = document.body.className + specificityClassName, endMarginStub = document.createElement("div"), endMarginStub.style.position = "absolute", endMarginStub.style.top = "0px", endMarginStub.style.height = "1px", endMarginStub.style.width = "1px", vt([endMarginStub]), document.body.appendChild(endMarginStub), typefacesStyleElement = document.createElement("style"), typefacesStyleElement.setAttribute("type", "text/css"), document.head.appendChild(typefacesStyleElement), fontStyleElement = document.createElement("style"), fontStyleElement.setAttribute("type", "text/css"), document.head.appendChild(fontStyleElement), styleElement = document.createElement("style"), styleElement.setAttribute("type", "text/css"), document.head.appendChild(styleElement);
    const r = document.getElementsByTagName("a");
    for (var c = 0; c < r.length; c++) {
      var l = r[c];
      l.getAttribute("href") && l.addEventListener("click", function(f) {
        re(this, f);
      });
    }
    const u = document.getElementsByTagName("img");
    for (let f = 0; f < u.length; f++) {
      var v = u[f];
      v.addEventListener("click", function(d) {
        se(this, d);
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
    currentFont && r.indexOf(currentFont.name) == -1 && r.push(currentFont.name), fontSetupInitialized = !0, yt.load({
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
    setMarginHorizontal: dt,
    setMarginVertical: mt,
    setMarginPercent: ne,
    setFont: ae,
    setLineSpacing: Zt,
    setTextAlign: ie,
    initConfig: (r) => {
      globalThis.config = Object.assign(globalThis.config, r), console.log("当前配置", globalThis.config), dt(r.marginHorizontal), mt(r.marginVertical), ReaderThemes.set({
        backgroundColor: r.backgroundColor,
        textColor: r.textColor,
        linkColor: r.linkColor
      });
    }
  };
})();
