(function(){"use strict";try{if(typeof document!="undefined"){var t=document.createElement("style");t.appendChild(document.createTextNode("*{outline:none!important}body{padding:0!important;word-break:break-word}html{margin:0!important;padding:0!important}sup{vertical-align:top!important}sub{vertical-align:bottom!important}img{max-width:100%!important}")),document.head.appendChild(t)}}catch(e){console.error("vite-plugin-css-injected-by-js",e)}})();
var G = {}, Ut = {
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
    function c(t, e, i) {
      if (!t)
        throw Error();
      if (2 < arguments.length) {
        var o = Array.prototype.slice.call(arguments, 2);
        return function() {
          var l = Array.prototype.slice.call(arguments);
          return Array.prototype.unshift.apply(l, o), t.apply(e, l);
        };
      }
      return function() {
        return t.apply(e, arguments);
      };
    }
    function r(t, e, i) {
      return r = Function.prototype.bind && Function.prototype.bind.toString().indexOf("native code") != -1 ? a : c, r.apply(null, arguments);
    }
    var s = Date.now || function() {
      return +new Date();
    };
    function g(t, e) {
      this.a = t, this.o = e || t, this.c = this.o.document;
    }
    var f = !!window.FontFace;
    function d(t, e, i, o) {
      if (e = t.c.createElement(e), i)
        for (var l in i)
          i.hasOwnProperty(l) && (l == "style" ? e.style.cssText = i[l] : e.setAttribute(l, i[l]));
      return o && e.appendChild(t.c.createTextNode(o)), e;
    }
    function u(t, e, i) {
      t = t.c.getElementsByTagName(e)[0], t || (t = document.documentElement), t.insertBefore(i, t.lastChild);
    }
    function m(t) {
      t.parentNode && t.parentNode.removeChild(t);
    }
    function w(t, e, i) {
      e = e || [], i = i || [];
      for (var o = t.className.split(/\s+/), l = 0; l < e.length; l += 1) {
        for (var h = !1, p = 0; p < o.length; p += 1)
          if (e[l] === o[p]) {
            h = !0;
            break;
          }
        h || o.push(e[l]);
      }
      for (e = [], l = 0; l < o.length; l += 1) {
        for (h = !1, p = 0; p < i.length; p += 1)
          if (o[l] === i[p]) {
            h = !0;
            break;
          }
        h || e.push(o[l]);
      }
      t.className = e.join(" ").replace(/\s+/g, " ").replace(/^\s+|\s+$/, "");
    }
    function _(t, e) {
      for (var i = t.className.split(/\s+/), o = 0, l = i.length; o < l; o++)
        if (i[o] == e)
          return !0;
      return !1;
    }
    function N(t) {
      return t.o.location.hostname || t.a.location.hostname;
    }
    function P(t, e, i) {
      function o() {
        y && l && h && (y(p), y = null);
      }
      e = d(t, "link", { rel: "stylesheet", href: e, media: "all" });
      var l = !1, h = !0, p = null, y = i || null;
      f ? (e.onload = function() {
        l = !0, o();
      }, e.onerror = function() {
        l = !0, p = Error("Stylesheet failed to load"), o();
      }) : setTimeout(function() {
        l = !0, o();
      }, 0), u(t, "head", e);
    }
    function E(t, e, i, o) {
      var l = t.c.getElementsByTagName("head")[0];
      if (l) {
        var h = d(t, "script", { src: e }), p = !1;
        return h.onload = h.onreadystatechange = function() {
          p || this.readyState && this.readyState != "loaded" && this.readyState != "complete" || (p = !0, i && i(null), h.onload = h.onreadystatechange = null, h.parentNode.tagName == "HEAD" && l.removeChild(h));
        }, l.appendChild(h), setTimeout(function() {
          p || (p = !0, i && i(Error("Script load timeout")));
        }, o || 5e3), h;
      }
      return null;
    }
    function H() {
      this.a = 0, this.c = null;
    }
    function q(t) {
      return t.a++, function() {
        t.a--, $(t);
      };
    }
    function Y(t, e) {
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
    function Et(t) {
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
    function St(t) {
      var e = 4, i = "n", o = null;
      return t && ((o = t.match(/(normal|oblique|italic)/i)) && o[1] && (i = o[1].substr(0, 1).toLowerCase()), (o = t.match(/([1-9]00|normal|bold)/i)) && o[1] && (/bold/i.test(o[1]) ? e = 7 : /[1-9]00/.test(o[1]) && (e = parseInt(o[1].substr(0, 1), 10)))), i + e;
    }
    function At(t, e) {
      this.c = t, this.f = t.o.document.documentElement, this.h = e, this.a = new J("-"), this.j = e.events !== !1, this.g = e.classes !== !1;
    }
    function Ht(t) {
      t.g && w(t.f, [t.a.c("wf", "loading")]), R(t, "loading");
    }
    function Z(t) {
      if (t.g) {
        var e = _(t.f, t.a.c("wf", "active")), i = [], o = [t.a.c("wf", "loading")];
        e || i.push(t.a.c("wf", "inactive")), w(t.f, i, o);
      }
      R(t, "inactive");
    }
    function R(t, e, i) {
      t.j && t.h[e] && (i ? t.h[e](i.c, C(i)) : t.h[e]());
    }
    function _t() {
      this.c = {};
    }
    function kt(t, e, i) {
      var o = [], l;
      for (l in e)
        if (e.hasOwnProperty(l)) {
          var h = t.c[l];
          h && o.push(h(e[l], i));
        }
      return o;
    }
    function z(t, e) {
      this.c = t, this.f = e, this.a = d(this.c, "span", { "aria-hidden": "true" }, this.f);
    }
    function B(t) {
      u(t.c, "body", t.a);
    }
    function W(t) {
      return "display:block;position:absolute;top:-9999px;left:-9999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;white-space:nowrap;font-family:" + K(t.c) + ";" + ("font-style:" + Q(t) + ";font-weight:" + (t.f + "00") + ";");
    }
    function tt(t, e, i, o, l, h) {
      this.g = t, this.j = e, this.a = o, this.c = i, this.f = l || 3e3, this.h = h || void 0;
    }
    tt.prototype.start = function() {
      var t = this.c.o.document, e = this, i = s(), o = new Promise(function(p, y) {
        function v() {
          s() - i >= e.f ? y() : t.fonts.load(Et(e.a), e.h).then(function(b) {
            1 <= b.length ? p() : setTimeout(v, 25);
          }, function() {
            y();
          });
        }
        v();
      }), l = null, h = new Promise(function(p, y) {
        l = setTimeout(y, e.f);
      });
      Promise.race([h, o]).then(function() {
        l && (clearTimeout(l), l = null), e.g(e.a);
      }, function() {
        e.j(e.a);
      });
    };
    function et(t, e, i, o, l, h, p) {
      this.v = t, this.B = e, this.c = i, this.a = o, this.s = p || "BESbswy", this.f = {}, this.w = l || 3e3, this.u = h || null, this.m = this.j = this.h = this.g = null, this.g = new z(this.c, this.s), this.h = new z(this.c, this.s), this.j = new z(this.c, this.s), this.m = new z(this.c, this.s), t = new S(this.a.c + ",serif", C(this.a)), t = W(t), this.g.a.style.cssText = t, t = new S(this.a.c + ",sans-serif", C(this.a)), t = W(t), this.h.a.style.cssText = t, t = new S("serif", C(this.a)), t = W(t), this.j.a.style.cssText = t, t = new S("sans-serif", C(this.a)), t = W(t), this.m.a.style.cssText = t, B(this.g), B(this.h), B(this.j), B(this.m);
    }
    var I = { D: "serif", C: "sans-serif" }, D = null;
    function nt() {
      if (D === null) {
        var t = /AppleWebKit\/([0-9]+)(?:\.([0-9]+))/.exec(window.navigator.userAgent);
        D = !!t && (536 > parseInt(t[1], 10) || parseInt(t[1], 10) === 536 && 11 >= parseInt(t[2], 10));
      }
      return D;
    }
    et.prototype.start = function() {
      this.f.serif = this.j.a.offsetWidth, this.f["sans-serif"] = this.m.a.offsetWidth, this.A = s(), it(this);
    };
    function ot(t, e, i) {
      for (var o in I)
        if (I.hasOwnProperty(o) && e === t.f[I[o]] && i === t.f[I[o]])
          return !0;
      return !1;
    }
    function it(t) {
      var e = t.g.a.offsetWidth, i = t.h.a.offsetWidth, o;
      (o = e === t.f.serif && i === t.f["sans-serif"]) || (o = nt() && ot(t, e, i)), o ? s() - t.A >= t.w ? nt() && ot(t, e, i) && (t.u === null || t.u.hasOwnProperty(t.a.c)) ? V(t, t.v) : V(t, t.B) : Mt(t) : V(t, t.v);
    }
    function Mt(t) {
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
      e.g && w(e.f, [e.a.c("wf", t.c, C(t).toString(), "active")], [e.a.c("wf", t.c, C(t).toString(), "loading"), e.a.c("wf", t.c, C(t).toString(), "inactive")]), R(e, "fontactive", t), this.m = !0, at(this);
    }, U.prototype.h = function(t) {
      var e = this.a;
      if (e.g) {
        var i = _(e.f, e.a.c("wf", t.c, C(t).toString(), "active")), o = [], l = [e.a.c("wf", t.c, C(t).toString(), "loading")];
        i || o.push(e.a.c("wf", t.c, C(t).toString(), "inactive")), w(e.f, o, l);
      }
      R(e, "fontinactive", t), at(this);
    };
    function at(t) {
      --t.f == 0 && t.j && (t.m ? (t = t.a, t.g && w(t.f, [t.a.c("wf", "active")], [t.a.c("wf", "loading"), t.a.c("wf", "inactive")]), R(t, "active")) : Z(t.a));
    }
    function rt(t) {
      this.j = t, this.a = new _t(), this.h = 0, this.f = this.g = !0;
    }
    rt.prototype.load = function(t) {
      this.c = new g(this.j, t.context || this.j), this.g = t.events !== !1, this.f = t.classes !== !1, Rt(this, new At(this.c, t), t);
    };
    function Nt(t, e, i, o, l) {
      var h = --t.h == 0;
      (t.f || t.g) && setTimeout(function() {
        var p = l || null, y = o || null || {};
        if (i.length === 0 && h)
          Z(e.a);
        else {
          e.f += i.length, h && (e.j = h);
          var v, b = [];
          for (v = 0; v < i.length; v++) {
            var T = i[v], x = y[T.c], A = e.a, F = T;
            if (A.g && w(A.f, [A.a.c("wf", F.c, C(F).toString(), "loading")]), R(A, "fontloading", F), A = null, O === null)
              if (window.FontFace) {
                var F = /Gecko.*Firefox\/(\d+)/.exec(window.navigator.userAgent), Vt = /OS X.*Version\/10\..*Safari/.exec(window.navigator.userAgent) && /Apple/.exec(window.navigator.vendor);
                O = F ? 42 < parseInt(F[1], 10) : !Vt;
              } else
                O = !1;
            O ? A = new tt(r(e.g, e), r(e.h, e), e.c, T, e.s, x) : A = new et(r(e.g, e), r(e.h, e), e.c, T, e.s, p, x), b.push(A);
          }
          for (v = 0; v < b.length; v++)
            b[v].start();
        }
      }, 0);
    }
    function Rt(t, e, i) {
      var l = [], o = i.timeout;
      Ht(e);
      var l = kt(t.a, i, t.c), h = new U(t.c, e, o);
      for (t.h = l.length, e = 0, i = l.length; e < i; e++)
        l[e].load(function(p, y, v) {
          Nt(t, h, p, y, v);
        });
    }
    function lt(t, e) {
      this.c = t, this.a = e;
    }
    lt.prototype.load = function(t) {
      function e() {
        if (h["__mti_fntLst" + o]) {
          var p = h["__mti_fntLst" + o](), y = [], v;
          if (p)
            for (var b = 0; b < p.length; b++) {
              var T = p[b].fontfamily;
              p[b].fontStyle != null && p[b].fontWeight != null ? (v = p[b].fontStyle + p[b].fontWeight, y.push(new S(T, v))) : y.push(new S(T));
            }
          t(y);
        } else
          setTimeout(function() {
            e();
          }, 50);
      }
      var i = this, o = i.a.projectId, l = i.a.version;
      if (o) {
        var h = i.c.o;
        E(this.c, (i.a.api || "https://fast.fonts.net/jsapi") + "/" + o + ".js" + (l ? "?v=" + l : ""), function(p) {
          p ? t([]) : (h["__MonotypeConfiguration__" + o] = function() {
            return i.a;
          }, e());
        }).id = "__MonotypeAPIScript__" + o;
      } else
        t([]);
    };
    function st(t, e) {
      this.c = t, this.a = e;
    }
    st.prototype.load = function(t) {
      var e, i, o = this.a.urls || [], l = this.a.families || [], h = this.a.testStrings || {}, p = new H();
      for (e = 0, i = o.length; e < i; e++)
        P(this.c, o[e], q(p));
      var y = [];
      for (e = 0, i = l.length; e < i; e++)
        if (o = l[e].split(":"), o[1])
          for (var v = o[1].split(","), b = 0; b < v.length; b += 1)
            y.push(new S(o[0], v[b]));
        else
          y.push(new S(o[0]));
      Y(p, function() {
        t(y, h);
      });
    };
    function Ft(t, e) {
      t ? this.c = t : this.c = Pt, this.a = [], this.f = [], this.g = e || "";
    }
    var Pt = "https://fonts.googleapis.com/css";
    function Lt(t, e) {
      for (var i = e.length, o = 0; o < i; o++) {
        var l = e[o].split(":");
        l.length == 3 && t.f.push(l.pop());
        var h = "";
        l.length == 2 && l[1] != "" && (h = ":"), t.a.push(l.join(h));
      }
    }
    function zt(t) {
      if (t.a.length == 0)
        throw Error("No fonts to load!");
      if (t.c.indexOf("kit=") != -1)
        return t.c;
      for (var e = t.a.length, i = [], o = 0; o < e; o++)
        i.push(t.a[o].replace(/ /g, "+"));
      return e = t.c + "?family=" + i.join("%7C"), 0 < t.f.length && (e += "&subset=" + t.f.join(",")), 0 < t.g.length && (e += "&text=" + encodeURIComponent(t.g)), e;
    }
    function Bt(t) {
      this.f = t, this.a = [], this.c = {};
    }
    var ct = { latin: "BESbswy", "latin-ext": "çöüğş", cyrillic: "йяЖ", greek: "αβΣ", khmer: "កខគ", Hanuman: "កខគ" }, Wt = { thin: "1", extralight: "2", "extra-light": "2", ultralight: "2", "ultra-light": "2", light: "3", regular: "4", book: "4", medium: "5", "semi-bold": "6", semibold: "6", "demi-bold": "6", demibold: "6", bold: "7", "extra-bold": "8", extrabold: "8", "ultra-bold": "8", ultrabold: "8", black: "9", heavy: "9", l: "3", r: "4", b: "7" }, It = { i: "i", italic: "i", n: "n", normal: "n" }, Ot = /^(thin|(?:(?:extra|ultra)-?)?light|regular|book|medium|(?:(?:semi|demi|extra|ultra)-?)?bold|black|heavy|l|r|b|[1-9]00)?(n|i|normal|italic)?$/;
    function jt(t) {
      for (var e = t.f.length, i = 0; i < e; i++) {
        var o = t.f[i].split(":"), l = o[0].replace(/\+/g, " "), h = ["n4"];
        if (2 <= o.length) {
          var p, y = o[1];
          if (p = [], y)
            for (var y = y.split(","), v = y.length, b = 0; b < v; b++) {
              var T;
              if (T = y[b], T.match(/^[\w-]+$/)) {
                var x = Ot.exec(T.toLowerCase());
                if (x == null)
                  T = "";
                else {
                  if (T = x[2], T = T == null || T == "" ? "n" : It[T], x = x[1], x == null || x == "")
                    x = "4";
                  else
                    var A = Wt[x], x = A || (isNaN(x) ? "4" : x.substr(0, 1));
                  T = [T, x].join("");
                }
              } else
                T = "";
              T && p.push(T);
            }
          0 < p.length && (h = p), o.length == 3 && (o = o[2], p = [], o = o ? o.split(",") : p, 0 < o.length && (o = ct[o[0]]) && (t.c[l] = o));
        }
        for (t.c[l] || (o = ct[l]) && (t.c[l] = o), o = 0; o < h.length; o += 1)
          t.a.push(new S(l, h[o]));
      }
    }
    function ut(t, e) {
      this.c = t, this.a = e;
    }
    var Dt = { Arimo: !0, Cousine: !0, Tinos: !0 };
    ut.prototype.load = function(t) {
      var e = new H(), i = this.c, o = new Ft(this.a.api, this.a.text), l = this.a.families;
      Lt(o, l);
      var h = new Bt(l);
      jt(h), P(i, zt(o), q(e)), Y(e, function() {
        t(h.a, h.c, Dt);
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
          for (var l = [], h = 0; h < o.length; h += 2)
            for (var p = o[h], y = o[h + 1], v = 0; v < y.length; v++)
              l.push(new S(p, y[v]));
          try {
            i.Typekit.load({ events: !1, classes: !1, async: !0 });
          } catch {
          }
          t(l);
        }
      }, 2e3) : t([]);
    };
    function ft(t, e) {
      this.c = t, this.f = e, this.a = [];
    }
    ft.prototype.load = function(t) {
      var e = this.f.id, i = this.c.o, o = this;
      e ? (i.__webfontfontdeckmodule__ || (i.__webfontfontdeckmodule__ = {}), i.__webfontfontdeckmodule__[e] = function(l, h) {
        for (var p = 0, y = h.fonts.length; p < y; ++p) {
          var v = h.fonts[p];
          o.a.push(new S(v.name, St("font-weight:" + v.weight + ";font-style:" + v.style)));
        }
        t(o.a);
      }, E(this.c, (this.f.api || "https://f.fontdeck.com/s/css/js/") + N(this.c) + "/" + e + ".js", function(l) {
        l && t([]);
      })) : t([]);
    };
    var k = new rt(window);
    k.a.c.custom = function(t, e) {
      return new st(e, t);
    }, k.a.c.fontdeck = function(t, e) {
      return new ft(e, t);
    }, k.a.c.monotype = function(t, e) {
      return new lt(e, t);
    }, k.a.c.typekit = function(t, e) {
      return new gt(e, t);
    }, k.a.c.google = function(t, e) {
      return new ut(e, t);
    };
    var ht = { load: r(k.load, k) };
    n.exports ? n.exports = ht : (window.WebFont = ht, window.WebFontConfig && k.load(window.WebFontConfig));
  })();
})(Ut);
const vt = G, wt = (n) => {
  for (let a of n)
    a.style.margin = "0px", a.style.padding = "0px", a.style.border = "none";
}, pt = (n) => {
  let a = n, c;
  for (; a.tagName && a.tagName.toLowerCase() !== "body" && a != bookContainer; ) {
    if (c) {
      var r = c;
      c = a.cloneNode(!1), c.className += " __Reader_NoEffects", c.appendChild(r);
    } else
      c = a.cloneNode(!0);
    a = a.parentNode;
  }
  var s = document.createElement("div");
  return s.className = "__Reader_Footnote_Content " + specificityClassName, s.appendChild(c), s.outerHTML;
}, dt = (n) => {
  var a = "";
  a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/default.css' />";
  var c = n.querySelectorAll("link, style"), r = document.createElement("div");
  for (let g = 0; g < c.length; g++) {
    var s = c[g];
    s.dataset.excludeFromFootnote || r.appendChild(s.cloneNode(!0));
  }
  return a += r.innerHTML, a += "<style type='text/css'>" + ReaderThemes.getCss() + "</style>", a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/footnote.css' />", a;
}, Gt = (n, a) => {
  if (n[0] == "#") {
    var c = document.getElementById(n.substring(1)) ? pt(document.getElementById(n.substring(1))) : "";
    a(dt(document) + c);
    return;
  }
  var r = n.indexOf("#"), s = n.substring(r), g = n.substring(0, r), f = new XMLHttpRequest();
  f.open("GET", g, !0), f.responseType = "document", f.onload = function() {
    if (f.status != 200) {
      console.error(
        'Failed to load footnote at "' + n + '": ' + f.statusText
      );
      return;
    }
    var d = f.responseXML;
    a(
      dt(d) + pt(d.getElementById(s.substring(1)))
    );
  }, f.send();
}, Xt = () => {
  var n = document.getElementsByTagName("switch");
  for (let s = 0; s < n.length; s++) {
    var a = n[s], c = a.getElementsByTagName("case");
    for (let g = 0; g < c.length; g++) {
      var r = c[g];
      r.parentNode.removeChild(r);
    }
  }
}, qt = (n) => {
  try {
    if (n.cssRules == null)
      return !0;
  } catch {
    return !0;
  }
  return !1;
}, bt = (n) => {
  if (qt(n))
    return { fonts: [], useWorkaround: !0 };
  var a = [], c = !1, r = n.cssRules;
  for (let d = 0; d < r.length; d++) {
    var s = r[d];
    if (s.styleSheet) {
      var g = bt(s.styleSheet);
      a.push.apply(a, g.fonts), c = c || g.useWorkaround;
      continue;
    }
    if (s.type == CSSRule.FONT_FACE_RULE) {
      var f = s.style.fontFamily;
      a.indexOf(f) == -1 && a.push(f);
    }
  }
  return { fonts: a, useWorkaround: c };
}, Yt = () => {
  const n = [];
  var a = {}, c = void 0, r = document.styleSheets;
  for (let E = 0; E < r.length; E++) {
    var s = r[E], g = bt(s);
    c = c || g.useWorkaround;
    var f = g.fonts;
    for (let H = 0; H < f.length; H++) {
      var d = f[H];
      a[d.toLowerCase()] = !0;
    }
    n.push.apply(n, g.fonts);
  }
  if (c) {
    var u = Array.prototype.slice.call(document.body.childNodes);
    for (let E = 0; E < u.length; E++) {
      var m = u[E];
      if (m.nodeType == Node.ELEMENT_NODE) {
        var w = window.getComputedStyle(m), _ = w["font-family"].split(",");
        for (let H = 0; H < _.length; H++) {
          var N = _[H], P = N.toLowerCase();
          a[P] !== !0 && (a[P] = !0);
        }
        n.push.apply(n, _);
      }
    }
  }
  return n;
}, $t = (n) => {
  for (var a = {}, c = n.split(","), r = 0; r < c.length; ++r) {
    var s = c[r].split("="), g = s[0].trim(), f = s[1].trim();
    a[g] = f;
  }
  return a;
}, Jt = (n) => {
  var a = "", c = 0;
  for (var r in n)
    c != 0 && (a += ","), a += r + "=" + n[r], c++;
  return a;
}, Tt = (n) => {
  var a = n.getBoundingClientRect();
  return pagedHorizontally ? Math.floor(
    (a.left + window.scrollX) / (pageWidth + pageHorizontalMargin)
  ) : Math.floor(
    (a.top + window.scrollY) / (pageHeight + pageVerticalMargin)
  );
}, Kt = (n) => {
  var a = {};
  for (var c in n) {
    var r = n[c], s = document.getElementById(r.substring(1));
    if (s)
      switch (globalThis.config.flowStyle) {
        case FLOW_PAGED:
          a[c] = Tt(s);
          break;
        case FLOW_SCROLLED:
          a[c] = s.offsetTop;
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
  for (var c in n) {
    var r = n[c], s = document.getElementById(r.substring(1));
    if (s)
      if (globalThis.config.flowStyle == FLOW_PAGED)
        a.push([r, Tt(s)]);
      else {
        var g = s.getBoundingClientRect(), f = g.top + window.scrollY;
        a.push([r, f]);
      }
  }
  ReaderApp.setAnchorPositions(JSON.stringify(a));
}, Qt = (n) => {
  bookContainer.innerHTML = bookContainer.firstChild.outerHTML;
  const a = globalThis.config.bookName ?? "", c = globalThis.config.chapterName ?? document.getElementsByTagName("title")[0].innerText;
  let r = window.innerWidth;
  for (let s = 0; s < n; s++) {
    const g = document.createElement("div");
    g.className = "reader-app-page-header", g.style.position = "absolute", g.style.top = globalThis.config.topExtraHeight + "px", g.style.left = r * s + "px", g.style.width = "100%", g.style.height = globalThis.config.infoBarHeight + "px", g.style.boxSizing = "border-box", g.style.setProperty("font-size", "13px", "important"), g.style.setProperty("color", "#8d8d8d", "important"), g.style.padding = `0 ${globalThis.config.marginHorizontal}px`, g.style.display = "flex", g.style.alignItems = "flex-end", g.innerText = s == 0 ? a : c, bookContainer.appendChild(g);
    const f = document.createElement("div");
    f.className = "reader-app-page-footer", f.style.position = "absolute", f.style.bottom = globalThis.config.bottomExtraHeight + "px", f.style.left = r * s + "px", f.style.width = "100%", f.style.height = globalThis.config.infoBarHeight + "px", f.style.boxSizing = "border-box", f.style.setProperty("font-size", "13px", "important"), f.style.setProperty("color", "#8d8d8d", "important"), f.style.padding = `0 ${globalThis.config.marginHorizontal}px`, f.style.display = "flex", f.style.alignItems = "flex-start", f.style.justifyContent = "flex-end", f.innerText = `${s + 1}/${n}`, bookContainer.appendChild(f);
  }
}, Ct = () => {
  if (!(globalThis.config.layoutStyle != LAYOUT_REFLOW || globalThis.config.flowStyle != FLOW_PAGED)) {
    if (!pageContainer) {
      bookContainer = document.createElement("div");
      var n = document.createElement("div");
      n.style.webkitMarginCollapse = "separate";
      var a = Array.prototype.slice.call(document.body.childNodes);
      for (let g = 0; g < a.length; g++) {
        var c = a[g];
        n.appendChild(c);
      }
      n.className = "collapse-wrapper", bookContainer.appendChild(n), pageContainer = document.createElement("div"), pageContainer.className = "book-wrapper", pageContainer.appendChild(bookContainer), document.body.appendChild(pageContainer), wt([pageContainer, bookContainer]);
    }
    pageHorizontalMargin = globalThis.config.marginHorizontal * 2, pageVerticalMargin = (globalThis.config.marginVertical + globalThis.config.infoBarHeight) * 2 + globalThis.config.topExtraHeight + globalThis.config.bottomExtraHeight, console.log("---><", pageHorizontalMargin, pageVerticalMargin), pageWidth = window.innerWidth - pageHorizontalMargin, pageHeight = window.innerHeight - pageVerticalMargin;
    var r = window.getComputedStyle(document.body), s = window.getComputedStyle(
      document.getElementsByTagName("html")[0]
    );
    pagedHorizontally = r.writingMode.indexOf("vertical") == -1 && s.writingMode.indexOf("vertical") == -1, bookContainer.style.width = pageWidth + "px", bookContainer.style.height = pageHeight + "px", bookContainer.style.webkitColumnWidth = (pagedHorizontally ? pageWidth : pageHeight) + "px", bookContainer.style.webkitColumnGap = (pagedHorizontally ? pageHorizontalMargin : pageVerticalMargin) + "px", endMarginStub.style.left = "0px", endMarginStub.style.top = "0px", pagedHorizontally ? (pageCount = Math.ceil(
      document.body.scrollWidth / (pageWidth + pageHorizontalMargin)
    ), endMarginStub.style.left = pageCount * (pageWidth + pageHorizontalMargin) - 1 + "px") : (pageCount = Math.ceil(
      document.body.scrollHeight / (pageHeight + pageVerticalMargin)
    ), endMarginStub.style.top = pageCount * (pageHeight + pageVerticalMargin) - 1 + "px"), xt(globalThis.config.tocAnchorList ?? []), Qt(pageCount), ReaderApp.onPagingSetup(
      pageHorizontalMargin / window.innerWidth,
      pageHorizontalMargin / window.innerHeight,
      pageCount,
      pagedHorizontally
    );
  }
}, L = () => {
  globalThis.config.flowStyle == FLOW_PAGED ? Ct() : xt(globalThis.config.tocAnchorList ?? []);
  var n = Kt(
    globalThis.config.paperPageToAnchorMap ?? []
  );
  ReaderApp.setPaperPageMap(JSON.stringify(n)), initialFlowWasDone = !0;
}, M = () => {
  initialFlowWasDone && L();
}, X = () => {
  console.log("use", globalThis.config.lineSpacing, globalThis.config.textAlign);
  var n = "line-height: " + globalThis.config.lineSpacing + " !important;";
  switch (n += "font-size: " + globalThis.config.fontSize + "px !important;", globalThis.config.textAlign) {
    case 1:
      n += "text-align: initial !important;";
      break;
    case 2:
      n += "text-align: justify !important;";
      break;
  }
  console.log("???", styleElement, n), globalThis.styleElement.innerText = specificitySelector + " * { " + n + " }", console.log("useStyle", styleElement);
}, Zt = (n) => {
  console.log(n), X(), M();
}, te = (n) => {
  console.log(n, "setPtops");
}, ee = (n) => {
  document.body.style.margin = n, M();
}, ne = (n) => {
  marginPercent = n / 100, document.body.style.margin = n + "%", M();
}, mt = (n) => {
  globalThis.config.marginHorizontal = n, document.body.style.marginLeft = n + "px", document.body.style.marginRight = n + "px", M();
}, yt = (n) => {
  globalThis.config.marginVertical = n, document.body.style.marginBottom = globalThis.config.infoBarHeight + n + globalThis.config.bottomExtraHeight + "px", document.body.style.marginTop = globalThis.config.infoBarHeight + n + globalThis.config.topExtraHeight + "px", M();
}, oe = (n) => {
  console.log(n), X(), M();
}, j = (n, a, c, r) => "@font-face { font-family: '" + n + "';font-style: " + a + "; font-weight: " + c + ";src: url(file:///android_asset/fonts/" + r + "); }", ie = (n) => {
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
}, re = (n) => {
  const a = document.createElement("div");
  a.className = "collapse-wrapper", a.innerHTML = n;
  const c = document.querySelector(".collapse-wrapper");
  let r = !0, s = c.children[c.children.length - 2];
  for (; r; ) {
    let w = s.children;
    w.length === 0 ? r = !1 : s = w[w.length - 1];
  }
  const { y: g, height: f } = s.getBoundingClientRect(), d = Math.floor(
    window.innerHeight - g - f - globalThis.config.infoBarHeight * 2
  ) + "px", u = "1px", m = document.createElement("div");
  m.style.width = u, m.style.height = d, c.appendChild(m);
  for (let w of a.children)
    c.appendChild(w.cloneNode(!0));
  Ct();
}, le = (n, a) => {
  if (n.href.indexOf("javascript:") == 0) {
    a.stopPropagation();
    return;
  }
  a.preventDefault(), a.stopPropagation(), (n.getAttribute("epub:type") || n.getAttribute("epubu0003atype")) == "noteref" ? (a.preventDefault(), a.stopPropagation(), Gt(n.getAttribute("href"), function(r) {
    const s = n.getClientRects();
    let g;
    for (var f in s) {
      var d = s[f];
      if (a.clientX >= d.left && a.clientX <= d.right && a.clientY >= d.top && a.clientY <= d.bottom) {
        g = d;
        break;
      }
    }
    g = g || s[0];
    var u = (g.left + g.right) / 2, m = (g.top + g.bottom) / 2;
    ReaderApp.openFootNote(n.innerText.trim(), r, u, m);
  })) : ReaderApp.openLink(n.href);
}, se = (n, a) => {
  for (var c = n.parentNode; c; ) {
    if (c.tagName && c.tagName.toLowerCase() == "a" && c.getAttribute("href"))
      return;
    c = c.parentNode;
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
function ce() {
  globalThis.LAYOUT_REFLOW = 1, globalThis.LAYOUT_FIXED = 2, globalThis.FLOW_PAGED = 1, globalThis.FLOW_SCROLLED = 2, globalThis.bookContainer = void 0, globalThis.pageContainer = void 0, globalThis.endMarginStub = void 0, globalThis.pageWidth = void 0, globalThis.pageHeight = void 0, globalThis.pageHorizontalMargin = void 0, globalThis.pageVerticalMargin = void 0, globalThis.pageCount = void 0, globalThis.pagedHorizontally = void 0, globalThis.marginPercent = 0, globalThis.showcasedImageElement = void 0, globalThis.currentFont = void 0, globalThis.fontSetupInitialized = void 0, globalThis.initialFlowWasDone = void 0, globalThis.typefacesStyleElement = void 0, globalThis.fontStyleElement = void 0, globalThis.styleElement = void 0, globalThis.fontsInjected = [], globalThis.fontsLoaded = [], globalThis.specificityClassName = "", globalThis.specificitySelector = "", globalThis.config = {
    layoutStyle: 1,
    flowStyle: 1,
    marginHorizontal: 18,
    marginVertical: 30,
    infoBarHeight: 32,
    fontSize: 18,
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
const ue = () => {
  globalThis.ReaderApp = {}, navigator.userAgent.indexOf("ReaderJs/Client") > -1 ? (ReaderApp.notifySize = (...u) => window.flutter_inappwebview.callHandler("notifySize", ...u), ReaderApp.onTouchUp = (...u) => window.flutter_inappwebview.callHandler("onTouchUp", ...u), ReaderApp.setAnchorPositions = (...u) => window.flutter_inappwebview.callHandler("setAnchorPositions", ...u), ReaderApp.setPaperPageMap = (...u) => window.flutter_inappwebview.callHandler("setPaperPageMap", ...u), ReaderApp.onBookReady = (...u) => window.flutter_inappwebview.callHandler("onBookReady", ...u), ReaderApp.onPagingSetup = (...u) => window.flutter_inappwebview.callHandler("onPagingSetup", ...u), ReaderApp.openImage = (...u) => window.flutter_inappwebview.callHandler("openImage", ...u)) : (ReaderApp.notifySize = a, ReaderApp.onTouchUp = c, ReaderApp.setAnchorPositions = r, ReaderApp.setPaperPageMap = s, ReaderApp.onBookReady = g, ReaderApp.onPagingSetup = f, ReaderApp.openImage = d);
  function a(u, m) {
    console.log("notifySize", u, m);
  }
  function c(u, m) {
    console.log("onTouchUp", u, m);
  }
  function r(u, m) {
    console.log("setAnchorPositions", u, m);
  }
  function s(u, m) {
    console.log("setPaperPageMap," + u + "," + m);
  }
  function g(u, m) {
    console.log("onBookReady", u, m);
  }
  function f(u, m, w, _) {
    console.log("onPagingSetup", u, m, w, _);
  }
  function d(u, m) {
    console.log("openImage", u, m);
  }
};
globalThis.ReaderThemes = function() {
  var n = "-webkit-text-fill-color: currentcolor !important;";
  let a;
  function c() {
    const f = document.createElement("style");
    f.setAttribute("type", "text/css"), f.id = "__ReaderThemeStyle", document.head.appendChild(f), a = document.getElementById("__ReaderThemeStyle"), a.dataset.excludeFromFootnote = !0;
  }
  function r(f) {
    for (var d = f.toString(16); d.length < 6; )
      d = "0" + d;
    return d;
  }
  function s(f) {
    var d = "";
    f && (d += "body {", d += "background-color: #" + r(f.backgroundColor) + " !important;", d += "}", d += "* {", d += "background-color: transparent !important;", d += "color: #" + r(f.textColor) + " !important;" + n, d += "}", d += "a, a:link, a:visited, a:hover, a * {", d += "color: #" + r(f.linkColor) + " !important;" + n, d += "}"), a.innerText = d;
  }
  function g() {
    return a.innerText;
  }
  return document.addEventListener("DOMContentLoaded", function() {
    console.log("theme-init"), c();
  }), {
    set: s,
    getCss: g
  };
}();
ue();
globalThis.ReaderJs = (() => {
  ce(), window.requestAnimationFrame || (window.requestAnimationFrame = function(r) {
    return setTimeout(r, 16), 0;
  });
  const n = () => {
    var d;
    const r = document.getElementsByTagName("meta");
    let s;
    for (let u = 0; u < r.length; u++) {
      var g = r[u];
      if (g.getAttribute("name") == "viewport") {
        s = g;
        break;
      }
    }
    const f = !!s;
    if (f && globalThis.config.layoutStyle == LAYOUT_FIXED) {
      const u = $t(
        s.getAttribute("content")
      ), m = parseInt(u.width);
      let w = 0;
      u.height && (w = parseInt(u.height));
      const N = document.getElementsByTagName("html")[0].getBoundingClientRect();
      w = Math.max(w, N.bottom - N.top), u.width = m, u.height = w, u["minimum-scale"] = 0, ReaderApp.setFixedViewport(m, w), s.setAttribute(
        "content",
        Jt(u)
      );
    } else {
      f && ((d = s == null ? void 0 : s.parentNode) == null || d.removeChild(s));
      const u = document.createElement("meta");
      u.setAttribute("name", "viewport"), u.setAttribute("content", "width=device-width, user-scalable=no"), document.head.appendChild(u);
    }
    ReaderApp.notifySize(window.innerWidth, window.innerHeight), L(), window.onresize = function() {
      console.log("---onresize---"), ReaderApp.notifySize(window.innerWidth, window.innerHeight), L();
    }, ReaderApp.onBookReady(), setTimeout(function() {
      ReaderApp.notifySize(window.innerWidth, window.innerHeight);
    }, 300);
  }, a = () => {
    console.log("---init reader---");
    for (let u = 0; u < 16; u++) {
      let m = "__Reader_S_" + u;
      specificityClassName += " " + m, specificitySelector += "." + m;
    }
    document.body.className = document.body.className + specificityClassName, endMarginStub = document.createElement("div"), endMarginStub.style.position = "absolute", endMarginStub.style.top = "0px", endMarginStub.style.height = "1px", endMarginStub.style.width = "1px", wt([endMarginStub]), document.body.appendChild(endMarginStub), typefacesStyleElement = document.createElement("style"), typefacesStyleElement.setAttribute("type", "text/css"), document.head.appendChild(typefacesStyleElement), fontStyleElement = document.createElement("style"), fontStyleElement.setAttribute("type", "text/css"), document.head.appendChild(fontStyleElement), globalThis.styleElement = document.createElement("style"), globalThis.styleElement.setAttribute("type", "text/css"), document.head.appendChild(globalThis.styleElement);
    const r = document.getElementsByTagName("a");
    for (var s = 0; s < r.length; s++) {
      var g = r[s];
      g.getAttribute("href") && g.addEventListener("click", function(u) {
        le(this, u);
      });
    }
    const f = document.getElementsByTagName("img");
    for (let u = 0; u < f.length; u++) {
      var d = f[u];
      d.addEventListener("click", function(m) {
        se(this, m);
      });
    }
    document.addEventListener("click", function() {
      ReaderApp.onTouchUp();
    }), Xt();
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
    reflowIfNecessary: M,
    setPageProperties: te,
    setMargin: ee,
    setMarginHorizontal: mt,
    setMarginVertical: yt,
    setMarginPercent: ne,
    setFont: ae,
    setLineSpacing: Zt,
    setTextAlign: oe,
    initConfig: (r) => {
      globalThis.config = Object.assign(globalThis.config, r), console.log("当前配置", globalThis.config), mt(r.marginHorizontal), yt(r.marginVertical), X(), M(), ReaderThemes.set({
        backgroundColor: r.backgroundColor,
        textColor: r.textColor,
        linkColor: r.linkColor
      });
    },
    appendChapter: re
  };
})();
