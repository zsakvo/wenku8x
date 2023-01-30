(function(){"use strict";try{if(typeof document!="undefined"){var t=document.createElement("style");t.appendChild(document.createTextNode("*{outline:none!important}body{padding:0!important;word-break:break-word}html{margin:0!important;padding:0!important}sup{vertical-align:top!important}sub{vertical-align:bottom!important}img{max-width:100%!important}")),document.head.appendChild(t)}}catch(e){console.error("vite-plugin-css-injected-by-js",e)}})();
var $ = {}, Ut = {
  get exports() {
    return $;
  },
  set exports(n) {
    $ = n;
  }
};
(function(n) {
  (function() {
    function a(t, e, i) {
      return t.call.apply(t.bind, arguments);
    }
    function h(t, e, i) {
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
      return r = Function.prototype.bind && Function.prototype.bind.toString().indexOf("native code") != -1 ? a : h, r.apply(null, arguments);
    }
    var c = Date.now || function() {
      return +new Date();
    };
    function g(t, e) {
      this.a = t, this.o = e || t, this.c = this.o.document;
    }
    var d = !!window.FontFace;
    function p(t, e, i, o) {
      if (e = t.c.createElement(e), i)
        for (var l in i)
          i.hasOwnProperty(l) && (l == "style" ? e.style.cssText = i[l] : e.setAttribute(l, i[l]));
      return o && e.appendChild(t.c.createTextNode(o)), e;
    }
    function s(t, e, i) {
      t = t.c.getElementsByTagName(e)[0], t || (t = document.documentElement), t.insertBefore(i, t.lastChild);
    }
    function m(t) {
      t.parentNode && t.parentNode.removeChild(t);
    }
    function T(t, e, i) {
      e = e || [], i = i || [];
      for (var o = t.className.split(/\s+/), l = 0; l < e.length; l += 1) {
        for (var u = !1, f = 0; f < o.length; f += 1)
          if (e[l] === o[f]) {
            u = !0;
            break;
          }
        u || o.push(e[l]);
      }
      for (e = [], l = 0; l < o.length; l += 1) {
        for (u = !1, f = 0; f < i.length; f += 1)
          if (o[l] === i[f]) {
            u = !0;
            break;
          }
        u || e.push(o[l]);
      }
      t.className = e.join(" ").replace(/\s+/g, " ").replace(/^\s+|\s+$/, "");
    }
    function x(t, e) {
      for (var i = t.className.split(/\s+/), o = 0, l = i.length; o < l; o++)
        if (i[o] == e)
          return !0;
      return !1;
    }
    function M(t) {
      return t.o.location.hostname || t.a.location.hostname;
    }
    function F(t, e, i) {
      function o() {
        y && l && u && (y(f), y = null);
      }
      e = p(t, "link", { rel: "stylesheet", href: e, media: "all" });
      var l = !1, u = !0, f = null, y = i || null;
      d ? (e.onload = function() {
        l = !0, o();
      }, e.onerror = function() {
        l = !0, f = Error("Stylesheet failed to load"), o();
      }) : setTimeout(function() {
        l = !0, o();
      }, 0), s(t, "head", e);
    }
    function S(t, e, i, o) {
      var l = t.c.getElementsByTagName("head")[0];
      if (l) {
        var u = p(t, "script", { src: e }), f = !1;
        return u.onload = u.onreadystatechange = function() {
          f || this.readyState && this.readyState != "loaded" && this.readyState != "complete" || (f = !0, i && i(null), u.onload = u.onreadystatechange = null, u.parentNode.tagName == "HEAD" && l.removeChild(u));
        }, l.appendChild(u), setTimeout(function() {
          f || (f = !0, i && i(Error("Script load timeout")));
        }, o || 5e3), u;
      }
      return null;
    }
    function _() {
      this.a = 0, this.c = null;
    }
    function X(t) {
      return t.a++, function() {
        t.a--, Y(t);
      };
    }
    function q(t, e) {
      t.c = e, Y(t);
    }
    function Y(t) {
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
    function A(t, e) {
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
    function E(t) {
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
      t.g && T(t.f, [t.a.c("wf", "loading")]), P(t, "loading");
    }
    function Z(t) {
      if (t.g) {
        var e = x(t.f, t.a.c("wf", "active")), i = [], o = [t.a.c("wf", "loading")];
        e || i.push(t.a.c("wf", "inactive")), T(t.f, i, o);
      }
      P(t, "inactive");
    }
    function P(t, e, i) {
      t.j && t.h[e] && (i ? t.h[e](i.c, E(i)) : t.h[e]());
    }
    function _t() {
      this.c = {};
    }
    function Nt(t, e, i) {
      var o = [], l;
      for (l in e)
        if (e.hasOwnProperty(l)) {
          var u = t.c[l];
          u && o.push(u(e[l], i));
        }
      return o;
    }
    function z(t, e) {
      this.c = t, this.f = e, this.a = p(this.c, "span", { "aria-hidden": "true" }, this.f);
    }
    function W(t) {
      s(t.c, "body", t.a);
    }
    function B(t) {
      return "display:block;position:absolute;top:-9999px;left:-9999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;white-space:nowrap;font-family:" + K(t.c) + ";" + ("font-style:" + Q(t) + ";font-weight:" + (t.f + "00") + ";");
    }
    function tt(t, e, i, o, l, u) {
      this.g = t, this.j = e, this.a = o, this.c = i, this.f = l || 3e3, this.h = u || void 0;
    }
    tt.prototype.start = function() {
      var t = this.c.o.document, e = this, i = c(), o = new Promise(function(f, y) {
        function v() {
          c() - i >= e.f ? y() : t.fonts.load(Et(e.a), e.h).then(function(w) {
            1 <= w.length ? f() : setTimeout(v, 25);
          }, function() {
            y();
          });
        }
        v();
      }), l = null, u = new Promise(function(f, y) {
        l = setTimeout(y, e.f);
      });
      Promise.race([u, o]).then(function() {
        l && (clearTimeout(l), l = null), e.g(e.a);
      }, function() {
        e.j(e.a);
      });
    };
    function et(t, e, i, o, l, u, f) {
      this.v = t, this.B = e, this.c = i, this.a = o, this.s = f || "BESbswy", this.f = {}, this.w = l || 3e3, this.u = u || null, this.m = this.j = this.h = this.g = null, this.g = new z(this.c, this.s), this.h = new z(this.c, this.s), this.j = new z(this.c, this.s), this.m = new z(this.c, this.s), t = new A(this.a.c + ",serif", E(this.a)), t = B(t), this.g.a.style.cssText = t, t = new A(this.a.c + ",sans-serif", E(this.a)), t = B(t), this.h.a.style.cssText = t, t = new A("serif", E(this.a)), t = B(t), this.j.a.style.cssText = t, t = new A("sans-serif", E(this.a)), t = B(t), this.m.a.style.cssText = t, W(this.g), W(this.h), W(this.j), W(this.m);
    }
    var O = { D: "serif", C: "sans-serif" }, D = null;
    function nt() {
      if (D === null) {
        var t = /AppleWebKit\/([0-9]+)(?:\.([0-9]+))/.exec(window.navigator.userAgent);
        D = !!t && (536 > parseInt(t[1], 10) || parseInt(t[1], 10) === 536 && 11 >= parseInt(t[2], 10));
      }
      return D;
    }
    et.prototype.start = function() {
      this.f.serif = this.j.a.offsetWidth, this.f["sans-serif"] = this.m.a.offsetWidth, this.A = c(), it(this);
    };
    function ot(t, e, i) {
      for (var o in O)
        if (O.hasOwnProperty(o) && e === t.f[O[o]] && i === t.f[O[o]])
          return !0;
      return !1;
    }
    function it(t) {
      var e = t.g.a.offsetWidth, i = t.h.a.offsetWidth, o;
      (o = e === t.f.serif && i === t.f["sans-serif"]) || (o = nt() && ot(t, e, i)), o ? c() - t.A >= t.w ? nt() && ot(t, e, i) && (t.u === null || t.u.hasOwnProperty(t.a.c)) ? V(t, t.v) : V(t, t.B) : kt(t) : V(t, t.v);
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
    var I = null;
    U.prototype.g = function(t) {
      var e = this.a;
      e.g && T(e.f, [e.a.c("wf", t.c, E(t).toString(), "active")], [e.a.c("wf", t.c, E(t).toString(), "loading"), e.a.c("wf", t.c, E(t).toString(), "inactive")]), P(e, "fontactive", t), this.m = !0, at(this);
    }, U.prototype.h = function(t) {
      var e = this.a;
      if (e.g) {
        var i = x(e.f, e.a.c("wf", t.c, E(t).toString(), "active")), o = [], l = [e.a.c("wf", t.c, E(t).toString(), "loading")];
        i || o.push(e.a.c("wf", t.c, E(t).toString(), "inactive")), T(e.f, o, l);
      }
      P(e, "fontinactive", t), at(this);
    };
    function at(t) {
      --t.f == 0 && t.j && (t.m ? (t = t.a, t.g && T(t.f, [t.a.c("wf", "active")], [t.a.c("wf", "loading"), t.a.c("wf", "inactive")]), P(t, "active")) : Z(t.a));
    }
    function rt(t) {
      this.j = t, this.a = new _t(), this.h = 0, this.f = this.g = !0;
    }
    rt.prototype.load = function(t) {
      this.c = new g(this.j, t.context || this.j), this.g = t.events !== !1, this.f = t.classes !== !1, Pt(this, new At(this.c, t), t);
    };
    function Mt(t, e, i, o, l) {
      var u = --t.h == 0;
      (t.f || t.g) && setTimeout(function() {
        var f = l || null, y = o || null || {};
        if (i.length === 0 && u)
          Z(e.a);
        else {
          e.f += i.length, u && (e.j = u);
          var v, w = [];
          for (v = 0; v < i.length; v++) {
            var b = i[v], C = y[b.c], H = e.a, R = b;
            if (H.g && T(H.f, [H.a.c("wf", R.c, E(R).toString(), "loading")]), P(H, "fontloading", R), H = null, I === null)
              if (window.FontFace) {
                var R = /Gecko.*Firefox\/(\d+)/.exec(window.navigator.userAgent), Vt = /OS X.*Version\/10\..*Safari/.exec(window.navigator.userAgent) && /Apple/.exec(window.navigator.vendor);
                I = R ? 42 < parseInt(R[1], 10) : !Vt;
              } else
                I = !1;
            I ? H = new tt(r(e.g, e), r(e.h, e), e.c, b, e.s, C) : H = new et(r(e.g, e), r(e.h, e), e.c, b, e.s, f, C), w.push(H);
          }
          for (v = 0; v < w.length; v++)
            w[v].start();
        }
      }, 0);
    }
    function Pt(t, e, i) {
      var l = [], o = i.timeout;
      Ht(e);
      var l = Nt(t.a, i, t.c), u = new U(t.c, e, o);
      for (t.h = l.length, e = 0, i = l.length; e < i; e++)
        l[e].load(function(f, y, v) {
          Mt(t, u, f, y, v);
        });
    }
    function lt(t, e) {
      this.c = t, this.a = e;
    }
    lt.prototype.load = function(t) {
      function e() {
        if (u["__mti_fntLst" + o]) {
          var f = u["__mti_fntLst" + o](), y = [], v;
          if (f)
            for (var w = 0; w < f.length; w++) {
              var b = f[w].fontfamily;
              f[w].fontStyle != null && f[w].fontWeight != null ? (v = f[w].fontStyle + f[w].fontWeight, y.push(new A(b, v))) : y.push(new A(b));
            }
          t(y);
        } else
          setTimeout(function() {
            e();
          }, 50);
      }
      var i = this, o = i.a.projectId, l = i.a.version;
      if (o) {
        var u = i.c.o;
        S(this.c, (i.a.api || "https://fast.fonts.net/jsapi") + "/" + o + ".js" + (l ? "?v=" + l : ""), function(f) {
          f ? t([]) : (u["__MonotypeConfiguration__" + o] = function() {
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
      var e, i, o = this.a.urls || [], l = this.a.families || [], u = this.a.testStrings || {}, f = new _();
      for (e = 0, i = o.length; e < i; e++)
        F(this.c, o[e], X(f));
      var y = [];
      for (e = 0, i = l.length; e < i; e++)
        if (o = l[e].split(":"), o[1])
          for (var v = o[1].split(","), w = 0; w < v.length; w += 1)
            y.push(new A(o[0], v[w]));
        else
          y.push(new A(o[0]));
      q(f, function() {
        t(y, u);
      });
    };
    function Rt(t, e) {
      t ? this.c = t : this.c = Ft, this.a = [], this.f = [], this.g = e || "";
    }
    var Ft = "https://fonts.googleapis.com/css";
    function Lt(t, e) {
      for (var i = e.length, o = 0; o < i; o++) {
        var l = e[o].split(":");
        l.length == 3 && t.f.push(l.pop());
        var u = "";
        l.length == 2 && l[1] != "" && (u = ":"), t.a.push(l.join(u));
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
    function Wt(t) {
      this.f = t, this.a = [], this.c = {};
    }
    var ct = { latin: "BESbswy", "latin-ext": "çöüğş", cyrillic: "йяЖ", greek: "αβΣ", khmer: "កខគ", Hanuman: "កខគ" }, Bt = { thin: "1", extralight: "2", "extra-light": "2", ultralight: "2", "ultra-light": "2", light: "3", regular: "4", book: "4", medium: "5", "semi-bold": "6", semibold: "6", "demi-bold": "6", demibold: "6", bold: "7", "extra-bold": "8", extrabold: "8", "ultra-bold": "8", ultrabold: "8", black: "9", heavy: "9", l: "3", r: "4", b: "7" }, Ot = { i: "i", italic: "i", n: "n", normal: "n" }, It = /^(thin|(?:(?:extra|ultra)-?)?light|regular|book|medium|(?:(?:semi|demi|extra|ultra)-?)?bold|black|heavy|l|r|b|[1-9]00)?(n|i|normal|italic)?$/;
    function jt(t) {
      for (var e = t.f.length, i = 0; i < e; i++) {
        var o = t.f[i].split(":"), l = o[0].replace(/\+/g, " "), u = ["n4"];
        if (2 <= o.length) {
          var f, y = o[1];
          if (f = [], y)
            for (var y = y.split(","), v = y.length, w = 0; w < v; w++) {
              var b;
              if (b = y[w], b.match(/^[\w-]+$/)) {
                var C = It.exec(b.toLowerCase());
                if (C == null)
                  b = "";
                else {
                  if (b = C[2], b = b == null || b == "" ? "n" : Ot[b], C = C[1], C == null || C == "")
                    C = "4";
                  else
                    var H = Bt[C], C = H || (isNaN(C) ? "4" : C.substr(0, 1));
                  b = [b, C].join("");
                }
              } else
                b = "";
              b && f.push(b);
            }
          0 < f.length && (u = f), o.length == 3 && (o = o[2], f = [], o = o ? o.split(",") : f, 0 < o.length && (o = ct[o[0]]) && (t.c[l] = o));
        }
        for (t.c[l] || (o = ct[l]) && (t.c[l] = o), o = 0; o < u.length; o += 1)
          t.a.push(new A(l, u[o]));
      }
    }
    function ht(t, e) {
      this.c = t, this.a = e;
    }
    var Dt = { Arimo: !0, Cousine: !0, Tinos: !0 };
    ht.prototype.load = function(t) {
      var e = new _(), i = this.c, o = new Rt(this.a.api, this.a.text), l = this.a.families;
      Lt(o, l);
      var u = new Wt(l);
      jt(u), F(i, zt(o), X(e)), q(e, function() {
        t(u.a, u.c, Dt);
      });
    };
    function ut(t, e) {
      this.c = t, this.a = e;
    }
    ut.prototype.load = function(t) {
      var e = this.a.id, i = this.c.o;
      e ? S(this.c, (this.a.api || "https://use.typekit.net") + "/" + e + ".js", function(o) {
        if (o)
          t([]);
        else if (i.Typekit && i.Typekit.config && i.Typekit.config.fn) {
          o = i.Typekit.config.fn;
          for (var l = [], u = 0; u < o.length; u += 2)
            for (var f = o[u], y = o[u + 1], v = 0; v < y.length; v++)
              l.push(new A(f, y[v]));
          try {
            i.Typekit.load({ events: !1, classes: !1, async: !0 });
          } catch {
          }
          t(l);
        }
      }, 2e3) : t([]);
    };
    function gt(t, e) {
      this.c = t, this.f = e, this.a = [];
    }
    gt.prototype.load = function(t) {
      var e = this.f.id, i = this.c.o, o = this;
      e ? (i.__webfontfontdeckmodule__ || (i.__webfontfontdeckmodule__ = {}), i.__webfontfontdeckmodule__[e] = function(l, u) {
        for (var f = 0, y = u.fonts.length; f < y; ++f) {
          var v = u.fonts[f];
          o.a.push(new A(v.name, St("font-weight:" + v.weight + ";font-style:" + v.style)));
        }
        t(o.a);
      }, S(this.c, (this.f.api || "https://f.fontdeck.com/s/css/js/") + M(this.c) + "/" + e + ".js", function(l) {
        l && t([]);
      })) : t([]);
    };
    var N = new rt(window);
    N.a.c.custom = function(t, e) {
      return new st(e, t);
    }, N.a.c.fontdeck = function(t, e) {
      return new gt(e, t);
    }, N.a.c.monotype = function(t, e) {
      return new lt(e, t);
    }, N.a.c.typekit = function(t, e) {
      return new ut(e, t);
    }, N.a.c.google = function(t, e) {
      return new ht(e, t);
    };
    var pt = { load: r(N.load, N) };
    n.exports ? n.exports = pt : (window.WebFont = pt, window.WebFontConfig && N.load(window.WebFontConfig));
  })();
})(Ut);
const vt = $, wt = (n) => {
  for (let a of n)
    a.style.margin = "0px", a.style.padding = "0px", a.style.border = "none";
}, ft = (n) => {
  let a = n, h;
  for (; a.tagName && a.tagName.toLowerCase() !== "body" && a != bookContainer; ) {
    if (h) {
      var r = h;
      h = a.cloneNode(!1), h.className += " __Reader_NoEffects", h.appendChild(r);
    } else
      h = a.cloneNode(!0);
    a = a.parentNode;
  }
  var c = document.createElement("div");
  return c.className = "__Reader_Footnote_Content " + specificityClassName, c.appendChild(h), c.outerHTML;
}, dt = (n) => {
  var a = "";
  a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/default.css' />";
  var h = n.querySelectorAll("link, style"), r = document.createElement("div");
  for (let g = 0; g < h.length; g++) {
    var c = h[g];
    c.dataset.excludeFromFootnote || r.appendChild(c.cloneNode(!0));
  }
  return a += r.innerHTML, a += "<style type='text/css'>" + ReaderThemes.getCss() + "</style>", a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/footnote.css' />", a;
}, $t = (n, a) => {
  if (n[0] == "#") {
    var h = document.getElementById(n.substring(1)) ? ft(document.getElementById(n.substring(1))) : "";
    a(dt(document) + h);
    return;
  }
  var r = n.indexOf("#"), c = n.substring(r), g = n.substring(0, r), d = new XMLHttpRequest();
  d.open("GET", g, !0), d.responseType = "document", d.onload = function() {
    if (d.status != 200) {
      console.error(
        'Failed to load footnote at "' + n + '": ' + d.statusText
      );
      return;
    }
    var p = d.responseXML;
    a(
      dt(p) + ft(p.getElementById(c.substring(1)))
    );
  }, d.send();
}, Gt = () => {
  var n = document.getElementsByTagName("switch");
  for (let c = 0; c < n.length; c++) {
    var a = n[c], h = a.getElementsByTagName("case");
    for (let g = 0; g < h.length; g++) {
      var r = h[g];
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
  var a = [], h = !1, r = n.cssRules;
  for (let p = 0; p < r.length; p++) {
    var c = r[p];
    if (c.styleSheet) {
      var g = bt(c.styleSheet);
      a.push.apply(a, g.fonts), h = h || g.useWorkaround;
      continue;
    }
    if (c.type == CSSRule.FONT_FACE_RULE) {
      var d = c.style.fontFamily;
      a.indexOf(d) == -1 && a.push(d);
    }
  }
  return { fonts: a, useWorkaround: h };
}, qt = () => {
  const n = [];
  var a = {}, h = void 0, r = document.styleSheets;
  for (let S = 0; S < r.length; S++) {
    var c = r[S], g = bt(c);
    h = h || g.useWorkaround;
    var d = g.fonts;
    for (let _ = 0; _ < d.length; _++) {
      var p = d[_];
      a[p.toLowerCase()] = !0;
    }
    n.push.apply(n, g.fonts);
  }
  if (h) {
    var s = Array.prototype.slice.call(document.body.childNodes);
    for (let S = 0; S < s.length; S++) {
      var m = s[S];
      if (m.nodeType == Node.ELEMENT_NODE) {
        var T = window.getComputedStyle(m), x = T["font-family"].split(",");
        for (let _ = 0; _ < x.length; _++) {
          var M = x[_], F = M.toLowerCase();
          a[F] !== !0 && (a[F] = !0);
        }
        n.push.apply(n, x);
      }
    }
  }
  return n;
}, Yt = (n) => {
  for (var a = {}, h = n.split(","), r = 0; r < h.length; ++r) {
    var c = h[r].split("="), g = c[0].trim(), d = c[1].trim();
    a[g] = d;
  }
  return a;
}, Jt = (n) => {
  var a = "", h = 0;
  for (var r in n)
    h != 0 && (a += ","), a += r + "=" + n[r], h++;
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
  for (var h in n) {
    var r = n[h], c = document.getElementById(r.substring(1));
    if (c)
      switch (globalThis.config.flowStyle) {
        case FLOW_PAGED:
          a[h] = Tt(c);
          break;
        case FLOW_SCROLLED:
          a[h] = c.offsetTop;
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
  for (var h in n) {
    var r = n[h], c = document.getElementById(r.substring(1));
    if (c)
      if (globalThis.config.flowStyle == FLOW_PAGED)
        a.push([r, Tt(c)]);
      else {
        var g = c.getBoundingClientRect(), d = g.top + window.scrollY;
        a.push([r, d]);
      }
  }
  ReaderApp.setAnchorPositions(JSON.stringify(a));
}, Qt = () => {
  bookContainer.innerHTML = bookContainer.firstChild.outerHTML;
  const n = globalThis.config.bookName ?? "";
  let a = window.innerWidth, h = 0;
  for (let r = 0; r < globalThis.chapterPageArr.length; r++) {
    const c = globalThis.chapterPageArr[r], g = globalThis.chapterNameArr[r];
    for (let d = 0; d < c; d++) {
      const p = document.createElement("div");
      p.className = "reader-app-page-header", p.setAttribute(
        "style",
        `
          position: absolute;
          top: ${globalThis.config.topExtraHeight + "px"};
          left: ${a * h + "px"};
          width: 100%;
          height: ${globalThis.config.infoBarHeight + "px"};
          box-sizing: border-box;
          padding: 0px  ${globalThis.config.marginHorizontal}px;
          display: flex;
          align-items: flex-end;
          text-overflow: ellipsis;
          overflow: hidden;
          white-space: nowrap;
      `
      );
      const s = document.createElement("div");
      s.setAttribute(
        "style",
        `
        display: inline-block; 
        overflow: hidden;
        white-space: nowrap;
        text-overflow: ellipsis;
        font-size: 13px !important;
        color: rgb(141, 141, 141) !important;
      `
      ), s.innerText = d == 0 ? n : g, p.appendChild(s), bookContainer.appendChild(p);
      const m = document.createElement("div");
      m.className = "reader-app-page-footer", m.setAttribute(
        "style",
        `
          position: absolute;
          bottom: ${globalThis.config.bottomExtraHeight + "px"};
          left: ${a * h + "px"};
          width: 100%;
          height: ${globalThis.config.infoBarHeight + "px"};
          box-sizing: border-box;
          font-size: 13px !important;
          color: rgb(141, 141, 141) !important;
          padding: 0px ${globalThis.config.marginHorizontal}px;
          display: flex;
          align-items: flex-start;
          justify-content: flex-end;
      `
      ), m.innerText = `${d + 1}/${c}`, bookContainer.appendChild(m), h++;
    }
  }
}, Ct = () => {
  if (!(globalThis.config.layoutStyle != LAYOUT_REFLOW || globalThis.config.flowStyle != FLOW_PAGED)) {
    if (!pageContainer) {
      bookContainer = document.createElement("div");
      var n = document.createElement("div");
      n.style.webkitMarginCollapse = "separate";
      var a = Array.prototype.slice.call(document.body.childNodes);
      for (let g = 0; g < a.length; g++) {
        var h = a[g];
        n.appendChild(h);
      }
      n.className = "collapse-wrapper", bookContainer.appendChild(n), pageContainer = document.createElement("div"), pageContainer.className = "book-wrapper", pageContainer.appendChild(bookContainer), document.body.appendChild(pageContainer), wt([pageContainer, bookContainer]);
    }
    pageHorizontalMargin = globalThis.config.marginHorizontal * 2, pageVerticalMargin = (globalThis.config.marginVertical + globalThis.config.infoBarHeight) * 2 + globalThis.config.topExtraHeight + globalThis.config.bottomExtraHeight, console.log("---><", pageHorizontalMargin, pageVerticalMargin), pageWidth = window.innerWidth - pageHorizontalMargin, pageHeight = window.innerHeight - pageVerticalMargin;
    var r = window.getComputedStyle(document.body), c = window.getComputedStyle(
      document.getElementsByTagName("html")[0]
    );
    pagedHorizontally = r.writingMode.indexOf("vertical") == -1 && c.writingMode.indexOf("vertical") == -1, bookContainer.style.width = pageWidth + "px", bookContainer.style.height = pageHeight + "px", bookContainer.style.webkitColumnWidth = (pagedHorizontally ? pageWidth : pageHeight) + "px", bookContainer.style.webkitColumnGap = (pagedHorizontally ? pageHorizontalMargin : pageVerticalMargin) + "px", endMarginStub.style.left = "0px", endMarginStub.style.top = "0px", pagedHorizontally ? (pageCount = Math.ceil(
      document.body.scrollWidth / (pageWidth + pageHorizontalMargin)
    ), endMarginStub.style.left = pageCount * (pageWidth + pageHorizontalMargin) - 1 + "px") : (pageCount = Math.ceil(
      document.body.scrollHeight / (pageHeight + pageVerticalMargin)
    ), endMarginStub.style.top = pageCount * (pageHeight + pageVerticalMargin) - 1 + "px"), xt(globalThis.config.tocAnchorList ?? []), globalThis.chapterPageArr.push(pageCount - globalThis.currentChapterPages), globalThis.currentChapterPages += pageCount, globalThis.chapterNameArr.push(globalThis.currentChapterName), Qt(), ReaderApp.onPagingSetup(
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
}, k = () => {
  initialFlowWasDone && L();
}, G = () => {
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
  console.log(n), G(), k();
}, te = (n) => {
  console.log(n, "setPtops");
}, ee = (n) => {
  document.body.style.margin = n, k();
}, ne = (n) => {
  marginPercent = n / 100, document.body.style.margin = n + "%", k();
}, mt = (n) => {
  globalThis.config.marginHorizontal = n, document.body.style.marginLeft = n + "px", document.body.style.marginRight = n + "px", k();
}, yt = (n) => {
  globalThis.config.marginVertical = n, document.body.style.marginBottom = globalThis.config.infoBarHeight + n + globalThis.config.bottomExtraHeight + "px", document.body.style.marginTop = globalThis.config.infoBarHeight + n + globalThis.config.topExtraHeight + "px", k();
}, oe = (n) => {
  console.log(n), G(), k();
}, j = (n, a, h, r) => "@font-face { font-family: '" + n + "';font-style: " + a + "; font-weight: " + h + ";src: url(file:///android_asset/fonts/" + r + "); }", ie = (n) => {
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
  globalThis.currentChapterName = a ?? "";
  const h = document.createElement("div");
  h.className = "collapse-wrapper", h.innerHTML = n;
  const r = document.querySelector(".collapse-wrapper");
  let c = !0, g = r.children[r.children.length - 2];
  for (; c; ) {
    let x = g.children;
    x.length === 0 ? c = !1 : g = x[x.length - 1];
  }
  const { y: d, height: p } = g.getBoundingClientRect(), s = Math.floor(
    window.innerHeight - d - p - globalThis.config.infoBarHeight * 2
  ) + "px", m = "1px", T = document.createElement("div");
  T.style.width = m, T.style.height = s, r.appendChild(T);
  for (let x of h.children)
    r.appendChild(x.cloneNode(!0));
  Ct();
}, le = (n, a) => {
  if (n.href.indexOf("javascript:") == 0) {
    a.stopPropagation();
    return;
  }
  a.preventDefault(), a.stopPropagation(), (n.getAttribute("epub:type") || n.getAttribute("epubu0003atype")) == "noteref" ? (a.preventDefault(), a.stopPropagation(), $t(n.getAttribute("href"), function(r) {
    const c = n.getClientRects();
    let g;
    for (var d in c) {
      var p = c[d];
      if (a.clientX >= p.left && a.clientX <= p.right && a.clientY >= p.top && a.clientY <= p.bottom) {
        g = p;
        break;
      }
    }
    g = g || c[0];
    var s = (g.left + g.right) / 2, m = (g.top + g.bottom) / 2;
    ReaderApp.openFootNote(n.innerText.trim(), r, s, m);
  })) : ReaderApp.openLink(n.href);
}, se = (n, a) => {
  for (var h = n.parentNode; h; ) {
    if (h.tagName && h.tagName.toLowerCase() == "a" && h.getAttribute("href"))
      return;
    h = h.parentNode;
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
  }, globalThis.chapterPageArr = [], globalThis.currentChapterPages = 0, globalThis.currentChapterName = "", globalThis.chapterNameArr = [];
}
const he = () => {
  globalThis.ReaderApp = {}, navigator.userAgent.indexOf("ReaderJs/Client") > -1 ? (ReaderApp.notifySize = (...s) => window.flutter_inappwebview.callHandler("notifySize", ...s), ReaderApp.onTouchUp = (...s) => window.flutter_inappwebview.callHandler("onTouchUp", ...s), ReaderApp.setAnchorPositions = (...s) => window.flutter_inappwebview.callHandler("setAnchorPositions", ...s), ReaderApp.setPaperPageMap = (...s) => window.flutter_inappwebview.callHandler("setPaperPageMap", ...s), ReaderApp.onBookReady = (...s) => window.flutter_inappwebview.callHandler("onBookReady", ...s), ReaderApp.onPagingSetup = (...s) => window.flutter_inappwebview.callHandler("onPagingSetup", ...s), ReaderApp.openImage = (...s) => window.flutter_inappwebview.callHandler("openImage", ...s)) : (ReaderApp.notifySize = a, ReaderApp.onTouchUp = h, ReaderApp.setAnchorPositions = r, ReaderApp.setPaperPageMap = c, ReaderApp.onBookReady = g, ReaderApp.onPagingSetup = d, ReaderApp.openImage = p);
  function a(s, m) {
    console.log("notifySize", s, m);
  }
  function h(s, m) {
    console.log("onTouchUp", s, m);
  }
  function r(s, m) {
    console.log("setAnchorPositions", s, m);
  }
  function c(s, m) {
    console.log("setPaperPageMap," + s + "," + m);
  }
  function g(s, m) {
    console.log("onBookReady", s, m);
  }
  function d(s, m, T, x) {
    console.log("onPagingSetup", s, m, T, x);
  }
  function p(s, m) {
    console.log("openImage", s, m);
  }
};
globalThis.ReaderThemes = function() {
  var n = "-webkit-text-fill-color: currentcolor !important;";
  let a;
  function h() {
    const d = document.createElement("style");
    d.setAttribute("type", "text/css"), d.id = "__ReaderThemeStyle", document.head.appendChild(d), a = document.getElementById("__ReaderThemeStyle"), a.dataset.excludeFromFootnote = !0;
  }
  function r(d) {
    for (var p = d.toString(16); p.length < 6; )
      p = "0" + p;
    return p;
  }
  function c(d) {
    var p = "";
    d && (p += "body {", p += "background-color: #" + r(d.backgroundColor) + " !important;", p += "}", p += "* {", p += "background-color: transparent !important;", p += "color: #" + r(d.textColor) + " !important;" + n, p += "}", p += "a, a:link, a:visited, a:hover, a * {", p += "color: #" + r(d.linkColor) + " !important;" + n, p += "}"), a.innerText = p;
  }
  function g() {
    return a.innerText;
  }
  return document.addEventListener("DOMContentLoaded", function() {
    console.log("theme-init"), h();
  }), {
    set: c,
    getCss: g
  };
}();
he();
globalThis.ReaderJs = (() => {
  ce(), window.requestAnimationFrame || (window.requestAnimationFrame = function(r) {
    return setTimeout(r, 16), 0;
  });
  const n = () => {
    var p;
    const r = document.getElementsByTagName("meta");
    let c;
    for (let s = 0; s < r.length; s++) {
      var g = r[s];
      if (g.getAttribute("name") == "viewport") {
        c = g;
        break;
      }
    }
    const d = !!c;
    if (d && globalThis.config.layoutStyle == LAYOUT_FIXED) {
      const s = Yt(
        c.getAttribute("content")
      ), m = parseInt(s.width);
      let T = 0;
      s.height && (T = parseInt(s.height));
      const M = document.getElementsByTagName("html")[0].getBoundingClientRect();
      T = Math.max(T, M.bottom - M.top), s.width = m, s.height = T, s["minimum-scale"] = 0, ReaderApp.setFixedViewport(m, T), c.setAttribute(
        "content",
        Jt(s)
      );
    } else {
      d && ((p = c == null ? void 0 : c.parentNode) == null || p.removeChild(c));
      const s = document.createElement("meta");
      s.setAttribute("name", "viewport"), s.setAttribute("content", "width=device-width, user-scalable=no"), document.head.appendChild(s);
    }
    ReaderApp.notifySize(window.innerWidth, window.innerHeight), L(), window.onresize = function() {
      console.log("---onresize---"), ReaderApp.notifySize(window.innerWidth, window.innerHeight), L();
    }, ReaderApp.onBookReady(), setTimeout(function() {
      ReaderApp.notifySize(window.innerWidth, window.innerHeight);
    }, 300);
  }, a = () => {
    console.log("---init reader---");
    for (let s = 0; s < 16; s++) {
      let m = "__Reader_S_" + s;
      specificityClassName += " " + m, specificitySelector += "." + m;
    }
    document.body.className = document.body.className + specificityClassName, endMarginStub = document.createElement("div"), endMarginStub.style.position = "absolute", endMarginStub.style.top = "0px", endMarginStub.style.height = "1px", endMarginStub.style.width = "1px", wt([endMarginStub]), document.body.appendChild(endMarginStub), typefacesStyleElement = document.createElement("style"), typefacesStyleElement.setAttribute("type", "text/css"), document.head.appendChild(typefacesStyleElement), fontStyleElement = document.createElement("style"), fontStyleElement.setAttribute("type", "text/css"), document.head.appendChild(fontStyleElement), globalThis.styleElement = document.createElement("style"), globalThis.styleElement.setAttribute("type", "text/css"), document.head.appendChild(globalThis.styleElement);
    const r = document.getElementsByTagName("a");
    for (var c = 0; c < r.length; c++) {
      var g = r[c];
      g.getAttribute("href") && g.addEventListener("click", function(s) {
        le(this, s);
      });
    }
    const d = document.getElementsByTagName("img");
    for (let s = 0; s < d.length; s++) {
      var p = d[s];
      p.addEventListener("click", function(m) {
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
    var r = qt();
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
    reflowIfNecessary: k,
    setPageProperties: te,
    setMargin: ee,
    setMarginHorizontal: mt,
    setMarginVertical: yt,
    setMarginPercent: ne,
    setFont: ae,
    setLineSpacing: Zt,
    setTextAlign: oe,
    initConfig: (r) => {
      globalThis.config = Object.assign(globalThis.config, r), console.log("当前配置", globalThis.config), globalThis.currentChapterName = r.chapterName, mt(r.marginHorizontal), yt(r.marginVertical), G(), k(), ReaderThemes.set({
        backgroundColor: r.backgroundColor,
        textColor: r.textColor,
        linkColor: r.linkColor
      });
    },
    appendChapter: re
  };
})();
