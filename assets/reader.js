(function(){"use strict";try{if(typeof document!="undefined"){var t=document.createElement("style");t.appendChild(document.createTextNode("*{outline:none!important}body{padding:0!important;word-break:break-word}html{margin:0!important;padding:0!important}sup{vertical-align:top!important}sub{vertical-align:bottom!important}img{max-width:100%!important}")),document.head.appendChild(t)}}catch(e){console.error("vite-plugin-css-injected-by-js",e)}})();
var U = {}, Bt = {
  get exports() {
    return U;
  },
  set exports(n) {
    U = n;
  }
};
(function(n) {
  (function() {
    function a(t, e, o) {
      return t.call.apply(t.bind, arguments);
    }
    function l(t, e, o) {
      if (!t)
        throw Error();
      if (2 < arguments.length) {
        var i = Array.prototype.slice.call(arguments, 2);
        return function() {
          var r = Array.prototype.slice.call(arguments);
          return Array.prototype.unshift.apply(r, i), t.apply(e, r);
        };
      }
      return function() {
        return t.apply(e, arguments);
      };
    }
    function s(t, e, o) {
      return s = Function.prototype.bind && Function.prototype.bind.toString().indexOf("native code") != -1 ? a : l, s.apply(null, arguments);
    }
    var p = Date.now || function() {
      return +new Date();
    };
    function c(t, e) {
      this.a = t, this.o = e || t, this.c = this.o.document;
    }
    var u = !!window.FontFace;
    function h(t, e, o, i) {
      if (e = t.c.createElement(e), o)
        for (var r in o)
          o.hasOwnProperty(r) && (r == "style" ? e.style.cssText = o[r] : e.setAttribute(r, o[r]));
      return i && e.appendChild(t.c.createTextNode(i)), e;
    }
    function w(t, e, o) {
      t = t.c.getElementsByTagName(e)[0], t || (t = document.documentElement), t.insertBefore(o, t.lastChild);
    }
    function b(t) {
      t.parentNode && t.parentNode.removeChild(t);
    }
    function _(t, e, o) {
      e = e || [], o = o || [];
      for (var i = t.className.split(/\s+/), r = 0; r < e.length; r += 1) {
        for (var d = !1, f = 0; f < i.length; f += 1)
          if (e[r] === i[f]) {
            d = !0;
            break;
          }
        d || i.push(e[r]);
      }
      for (e = [], r = 0; r < i.length; r += 1) {
        for (d = !1, f = 0; f < o.length; f += 1)
          if (i[r] === o[f]) {
            d = !0;
            break;
          }
        d || e.push(i[r]);
      }
      t.className = e.join(" ").replace(/\s+/g, " ").replace(/^\s+|\s+$/, "");
    }
    function P(t, e) {
      for (var o = t.className.split(/\s+/), i = 0, r = o.length; i < r; i++)
        if (o[i] == e)
          return !0;
      return !1;
    }
    function B(t) {
      return t.o.location.hostname || t.a.location.hostname;
    }
    function k(t, e, o) {
      function i() {
        g && r && d && (g(f), g = null);
      }
      e = h(t, "link", { rel: "stylesheet", href: e, media: "all" });
      var r = !1, d = !0, f = null, g = o || null;
      u ? (e.onload = function() {
        r = !0, i();
      }, e.onerror = function() {
        r = !0, f = Error("Stylesheet failed to load"), i();
      }) : setTimeout(function() {
        r = !0, i();
      }, 0), w(t, "head", e);
    }
    function C(t, e, o, i) {
      var r = t.c.getElementsByTagName("head")[0];
      if (r) {
        var d = h(t, "script", { src: e }), f = !1;
        return d.onload = d.onreadystatechange = function() {
          f || this.readyState && this.readyState != "loaded" && this.readyState != "complete" || (f = !0, o && o(null), d.onload = d.onreadystatechange = null, d.parentNode.tagName == "HEAD" && r.removeChild(d));
        }, r.appendChild(d), setTimeout(function() {
          f || (f = !0, o && o(Error("Script load timeout")));
        }, i || 5e3), d;
      }
      return null;
    }
    function A() {
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
    function E(t, e) {
      this.c = t, this.f = 4, this.a = "n";
      var o = (e || "n4").match(/^([nio])([1-9])$/i);
      o && (this.a = o[1], this.f = parseInt(o[2], 10));
    }
    function Tt(t) {
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
    function x(t) {
      return t.a + t.f;
    }
    function K(t) {
      var e = "normal";
      return t.a === "o" ? e = "oblique" : t.a === "i" && (e = "italic"), e;
    }
    function xt(t) {
      var e = 4, o = "n", i = null;
      return t && ((i = t.match(/(normal|oblique|italic)/i)) && i[1] && (o = i[1].substr(0, 1).toLowerCase()), (i = t.match(/([1-9]00|normal|bold)/i)) && i[1] && (/bold/i.test(i[1]) ? e = 7 : /[1-9]00/.test(i[1]) && (e = parseInt(i[1].substr(0, 1), 10)))), o + e;
    }
    function Ct(t, e) {
      this.c = t, this.f = t.o.document.documentElement, this.h = e, this.a = new $("-"), this.j = e.events !== !1, this.g = e.classes !== !1;
    }
    function Et(t) {
      t.g && _(t.f, [t.a.c("wf", "loading")]), N(t, "loading");
    }
    function Q(t) {
      if (t.g) {
        var e = P(t.f, t.a.c("wf", "active")), o = [], i = [t.a.c("wf", "loading")];
        e || o.push(t.a.c("wf", "inactive")), _(t.f, o, i);
      }
      N(t, "inactive");
    }
    function N(t, e, o) {
      t.j && t.h[e] && (o ? t.h[e](o.c, x(o)) : t.h[e]());
    }
    function St() {
      this.c = {};
    }
    function At(t, e, o) {
      var i = [], r;
      for (r in e)
        if (e.hasOwnProperty(r)) {
          var d = t.c[r];
          d && i.push(d(e[r], o));
        }
      return i;
    }
    function R(t, e) {
      this.c = t, this.f = e, this.a = h(this.c, "span", { "aria-hidden": "true" }, this.f);
    }
    function W(t) {
      w(t.c, "body", t.a);
    }
    function I(t) {
      return "display:block;position:absolute;top:-9999px;left:-9999px;font-size:300px;width:auto;height:auto;line-height:normal;margin:0;padding:0;font-variant:normal;white-space:nowrap;font-family:" + J(t.c) + ";" + ("font-style:" + K(t) + ";font-weight:" + (t.f + "00") + ";");
    }
    function Z(t, e, o, i, r, d) {
      this.g = t, this.j = e, this.a = i, this.c = o, this.f = r || 3e3, this.h = d || void 0;
    }
    Z.prototype.start = function() {
      var t = this.c.o.document, e = this, o = p(), i = new Promise(function(f, g) {
        function m() {
          p() - o >= e.f ? g() : t.fonts.load(Tt(e.a), e.h).then(function(y) {
            1 <= y.length ? f() : setTimeout(m, 25);
          }, function() {
            g();
          });
        }
        m();
      }), r = null, d = new Promise(function(f, g) {
        r = setTimeout(g, e.f);
      });
      Promise.race([d, i]).then(function() {
        r && (clearTimeout(r), r = null), e.g(e.a);
      }, function() {
        e.j(e.a);
      });
    };
    function tt(t, e, o, i, r, d, f) {
      this.v = t, this.B = e, this.c = o, this.a = i, this.s = f || "BESbswy", this.f = {}, this.w = r || 3e3, this.u = d || null, this.m = this.j = this.h = this.g = null, this.g = new R(this.c, this.s), this.h = new R(this.c, this.s), this.j = new R(this.c, this.s), this.m = new R(this.c, this.s), t = new E(this.a.c + ",serif", x(this.a)), t = I(t), this.g.a.style.cssText = t, t = new E(this.a.c + ",sans-serif", x(this.a)), t = I(t), this.h.a.style.cssText = t, t = new E("serif", x(this.a)), t = I(t), this.j.a.style.cssText = t, t = new E("sans-serif", x(this.a)), t = I(t), this.m.a.style.cssText = t, W(this.g), W(this.h), W(this.j), W(this.m);
    }
    var O = { D: "serif", C: "sans-serif" }, D = null;
    function et() {
      if (D === null) {
        var t = /AppleWebKit\/([0-9]+)(?:\.([0-9]+))/.exec(window.navigator.userAgent);
        D = !!t && (536 > parseInt(t[1], 10) || parseInt(t[1], 10) === 536 && 11 >= parseInt(t[2], 10));
      }
      return D;
    }
    tt.prototype.start = function() {
      this.f.serif = this.j.a.offsetWidth, this.f["sans-serif"] = this.m.a.offsetWidth, this.A = p(), it(this);
    };
    function nt(t, e, o) {
      for (var i in O)
        if (O.hasOwnProperty(i) && e === t.f[O[i]] && o === t.f[O[i]])
          return !0;
      return !1;
    }
    function it(t) {
      var e = t.g.a.offsetWidth, o = t.h.a.offsetWidth, i;
      (i = e === t.f.serif && o === t.f["sans-serif"]) || (i = et() && nt(t, e, o)), i ? p() - t.A >= t.w ? et() && nt(t, e, o) && (t.u === null || t.u.hasOwnProperty(t.a.c)) ? V(t, t.v) : V(t, t.B) : _t(t) : V(t, t.v);
    }
    function _t(t) {
      setTimeout(s(function() {
        it(this);
      }, t), 50);
    }
    function V(t, e) {
      setTimeout(s(function() {
        b(this.g.a), b(this.h.a), b(this.j.a), b(this.m.a), e(this.a);
      }, t), 0);
    }
    function G(t, e, o) {
      this.c = t, this.a = e, this.f = 0, this.m = this.j = !1, this.s = o;
    }
    var z = null;
    G.prototype.g = function(t) {
      var e = this.a;
      e.g && _(e.f, [e.a.c("wf", t.c, x(t).toString(), "active")], [e.a.c("wf", t.c, x(t).toString(), "loading"), e.a.c("wf", t.c, x(t).toString(), "inactive")]), N(e, "fontactive", t), this.m = !0, ot(this);
    }, G.prototype.h = function(t) {
      var e = this.a;
      if (e.g) {
        var o = P(e.f, e.a.c("wf", t.c, x(t).toString(), "active")), i = [], r = [e.a.c("wf", t.c, x(t).toString(), "loading")];
        o || i.push(e.a.c("wf", t.c, x(t).toString(), "inactive")), _(e.f, i, r);
      }
      N(e, "fontinactive", t), ot(this);
    };
    function ot(t) {
      --t.f == 0 && t.j && (t.m ? (t = t.a, t.g && _(t.f, [t.a.c("wf", "active")], [t.a.c("wf", "loading"), t.a.c("wf", "inactive")]), N(t, "active")) : Q(t.a));
    }
    function at(t) {
      this.j = t, this.a = new St(), this.h = 0, this.f = this.g = !0;
    }
    at.prototype.load = function(t) {
      this.c = new c(this.j, t.context || this.j), this.g = t.events !== !1, this.f = t.classes !== !1, Mt(this, new Ct(this.c, t), t);
    };
    function Pt(t, e, o, i, r) {
      var d = --t.h == 0;
      (t.f || t.g) && setTimeout(function() {
        var f = r || null, g = i || null || {};
        if (o.length === 0 && d)
          Q(e.a);
        else {
          e.f += o.length, d && (e.j = d);
          var m, y = [];
          for (m = 0; m < o.length; m++) {
            var v = o[m], T = g[v.c], S = e.a, L = v;
            if (S.g && _(S.f, [S.a.c("wf", L.c, x(L).toString(), "loading")]), N(S, "fontloading", L), S = null, z === null)
              if (window.FontFace) {
                var L = /Gecko.*Firefox\/(\d+)/.exec(window.navigator.userAgent), jt = /OS X.*Version\/10\..*Safari/.exec(window.navigator.userAgent) && /Apple/.exec(window.navigator.vendor);
                z = L ? 42 < parseInt(L[1], 10) : !jt;
              } else
                z = !1;
            z ? S = new Z(s(e.g, e), s(e.h, e), e.c, v, e.s, T) : S = new tt(s(e.g, e), s(e.h, e), e.c, v, e.s, f, T), y.push(S);
          }
          for (m = 0; m < y.length; m++)
            y[m].start();
        }
      }, 0);
    }
    function Mt(t, e, o) {
      var r = [], i = o.timeout;
      Et(e);
      var r = At(t.a, o, t.c), d = new G(t.c, e, i);
      for (t.h = r.length, e = 0, o = r.length; e < o; e++)
        r[e].load(function(f, g, m) {
          Pt(t, d, f, g, m);
        });
    }
    function rt(t, e) {
      this.c = t, this.a = e;
    }
    rt.prototype.load = function(t) {
      function e() {
        if (d["__mti_fntLst" + i]) {
          var f = d["__mti_fntLst" + i](), g = [], m;
          if (f)
            for (var y = 0; y < f.length; y++) {
              var v = f[y].fontfamily;
              f[y].fontStyle != null && f[y].fontWeight != null ? (m = f[y].fontStyle + f[y].fontWeight, g.push(new E(v, m))) : g.push(new E(v));
            }
          t(g);
        } else
          setTimeout(function() {
            e();
          }, 50);
      }
      var o = this, i = o.a.projectId, r = o.a.version;
      if (i) {
        var d = o.c.o;
        C(this.c, (o.a.api || "https://fast.fonts.net/jsapi") + "/" + i + ".js" + (r ? "?v=" + r : ""), function(f) {
          f ? t([]) : (d["__MonotypeConfiguration__" + i] = function() {
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
      var e, o, i = this.a.urls || [], r = this.a.families || [], d = this.a.testStrings || {}, f = new A();
      for (e = 0, o = i.length; e < o; e++)
        k(this.c, i[e], X(f));
      var g = [];
      for (e = 0, o = r.length; e < o; e++)
        if (i = r[e].split(":"), i[1])
          for (var m = i[1].split(","), y = 0; y < m.length; y += 1)
            g.push(new E(i[0], m[y]));
        else
          g.push(new E(i[0]));
      Y(f, function() {
        t(g, d);
      });
    };
    function Ft(t, e) {
      t ? this.c = t : this.c = Nt, this.a = [], this.f = [], this.g = e || "";
    }
    var Nt = "https://fonts.googleapis.com/css";
    function Lt(t, e) {
      for (var o = e.length, i = 0; i < o; i++) {
        var r = e[i].split(":");
        r.length == 3 && t.f.push(r.pop());
        var d = "";
        r.length == 2 && r[1] != "" && (d = ":"), t.a.push(r.join(d));
      }
    }
    function kt(t) {
      if (t.a.length == 0)
        throw Error("No fonts to load!");
      if (t.c.indexOf("kit=") != -1)
        return t.c;
      for (var e = t.a.length, o = [], i = 0; i < e; i++)
        o.push(t.a[i].replace(/ /g, "+"));
      return e = t.c + "?family=" + o.join("%7C"), 0 < t.f.length && (e += "&subset=" + t.f.join(",")), 0 < t.g.length && (e += "&text=" + encodeURIComponent(t.g)), e;
    }
    function Ht(t) {
      this.f = t, this.a = [], this.c = {};
    }
    var lt = { latin: "BESbswy", "latin-ext": "çöüğş", cyrillic: "йяЖ", greek: "αβΣ", khmer: "កខគ", Hanuman: "កខគ" }, Rt = { thin: "1", extralight: "2", "extra-light": "2", ultralight: "2", "ultra-light": "2", light: "3", regular: "4", book: "4", medium: "5", "semi-bold": "6", semibold: "6", "demi-bold": "6", demibold: "6", bold: "7", "extra-bold": "8", extrabold: "8", "ultra-bold": "8", ultrabold: "8", black: "9", heavy: "9", l: "3", r: "4", b: "7" }, Wt = { i: "i", italic: "i", n: "n", normal: "n" }, It = /^(thin|(?:(?:extra|ultra)-?)?light|regular|book|medium|(?:(?:semi|demi|extra|ultra)-?)?bold|black|heavy|l|r|b|[1-9]00)?(n|i|normal|italic)?$/;
    function Ot(t) {
      for (var e = t.f.length, o = 0; o < e; o++) {
        var i = t.f[o].split(":"), r = i[0].replace(/\+/g, " "), d = ["n4"];
        if (2 <= i.length) {
          var f, g = i[1];
          if (f = [], g)
            for (var g = g.split(","), m = g.length, y = 0; y < m; y++) {
              var v;
              if (v = g[y], v.match(/^[\w-]+$/)) {
                var T = It.exec(v.toLowerCase());
                if (T == null)
                  v = "";
                else {
                  if (v = T[2], v = v == null || v == "" ? "n" : Wt[v], T = T[1], T == null || T == "")
                    T = "4";
                  else
                    var S = Rt[T], T = S || (isNaN(T) ? "4" : T.substr(0, 1));
                  v = [v, T].join("");
                }
              } else
                v = "";
              v && f.push(v);
            }
          0 < f.length && (d = f), i.length == 3 && (i = i[2], f = [], i = i ? i.split(",") : f, 0 < i.length && (i = lt[i[0]]) && (t.c[r] = i));
        }
        for (t.c[r] || (i = lt[r]) && (t.c[r] = i), i = 0; i < d.length; i += 1)
          t.a.push(new E(r, d[i]));
      }
    }
    function ct(t, e) {
      this.c = t, this.a = e;
    }
    var zt = { Arimo: !0, Cousine: !0, Tinos: !0 };
    ct.prototype.load = function(t) {
      var e = new A(), o = this.c, i = new Ft(this.a.api, this.a.text), r = this.a.families;
      Lt(i, r);
      var d = new Ht(r);
      Ot(d), k(o, kt(i), X(e)), Y(e, function() {
        t(d.a, d.c, zt);
      });
    };
    function ut(t, e) {
      this.c = t, this.a = e;
    }
    ut.prototype.load = function(t) {
      var e = this.a.id, o = this.c.o;
      e ? C(this.c, (this.a.api || "https://use.typekit.net") + "/" + e + ".js", function(i) {
        if (i)
          t([]);
        else if (o.Typekit && o.Typekit.config && o.Typekit.config.fn) {
          i = o.Typekit.config.fn;
          for (var r = [], d = 0; d < i.length; d += 2)
            for (var f = i[d], g = i[d + 1], m = 0; m < g.length; m++)
              r.push(new E(f, g[m]));
          try {
            o.Typekit.load({ events: !1, classes: !1, async: !0 });
          } catch {
          }
          t(r);
        }
      }, 2e3) : t([]);
    };
    function pt(t, e) {
      this.c = t, this.f = e, this.a = [];
    }
    pt.prototype.load = function(t) {
      var e = this.f.id, o = this.c.o, i = this;
      e ? (o.__webfontfontdeckmodule__ || (o.__webfontfontdeckmodule__ = {}), o.__webfontfontdeckmodule__[e] = function(r, d) {
        for (var f = 0, g = d.fonts.length; f < g; ++f) {
          var m = d.fonts[f];
          i.a.push(new E(m.name, xt("font-weight:" + m.weight + ";font-style:" + m.style)));
        }
        t(i.a);
      }, C(this.c, (this.f.api || "https://f.fontdeck.com/s/css/js/") + B(this.c) + "/" + e + ".js", function(r) {
        r && t([]);
      })) : t([]);
    };
    var M = new at(window);
    M.a.c.custom = function(t, e) {
      return new st(e, t);
    }, M.a.c.fontdeck = function(t, e) {
      return new pt(e, t);
    }, M.a.c.monotype = function(t, e) {
      return new rt(e, t);
    }, M.a.c.typekit = function(t, e) {
      return new ut(e, t);
    }, M.a.c.google = function(t, e) {
      return new ct(e, t);
    };
    var dt = { load: s(M.load, M) };
    n.exports ? n.exports = dt : (window.WebFont = dt, window.WebFontConfig && M.load(window.WebFontConfig));
  })();
})(Bt);
const gt = U, mt = (n) => {
  for (let a of n)
    a.style.margin = "0px", a.style.padding = "0px", a.style.border = "none";
}, ft = (n) => {
  let a = n, l;
  for (; a.tagName && a.tagName.toLowerCase() !== "body" && a != bookContainer; ) {
    if (l) {
      var s = l;
      l = a.cloneNode(!1), l.className += " __Reader_NoEffects", l.appendChild(s);
    } else
      l = a.cloneNode(!0);
    a = a.parentNode;
  }
  var p = document.createElement("div");
  return p.className = "__Reader_Footnote_Content " + specificityClassName, p.appendChild(l), p.outerHTML;
}, ht = (n) => {
  var a = "";
  a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/default.css' />";
  var l = n.querySelectorAll("link, style"), s = document.createElement("div");
  for (let c = 0; c < l.length; c++) {
    var p = l[c];
    p.dataset.excludeFromFootnote || s.appendChild(p.cloneNode(!0));
  }
  return a += s.innerHTML, a += "<style type='text/css'>" + ReaderThemes.getCss() + "</style>", a += "<link rel='stylesheet' type='text/css' href='file:///android_asset/css/footnote.css' />", a;
}, Dt = (n, a) => {
  if (n[0] == "#") {
    var l = document.getElementById(n.substring(1)) ? ft(document.getElementById(n.substring(1))) : "";
    a(ht(document) + l);
    return;
  }
  var s = n.indexOf("#"), p = n.substring(s), c = n.substring(0, s), u = new XMLHttpRequest();
  u.open("GET", c, !0), u.responseType = "document", u.onload = function() {
    if (u.status != 200) {
      console.error(
        'Failed to load footnote at "' + n + '": ' + u.statusText
      );
      return;
    }
    var h = u.responseXML;
    a(
      ht(h) + ft(h.getElementById(p.substring(1)))
    );
  }, u.send();
}, Vt = () => {
  var n = document.getElementsByTagName("switch");
  for (let p = 0; p < n.length; p++) {
    var a = n[p], l = a.getElementsByTagName("case");
    for (let c = 0; c < l.length; c++) {
      var s = l[c];
      s.parentNode.removeChild(s);
    }
  }
}, Gt = (n) => {
  try {
    if (n.cssRules == null)
      return !0;
  } catch {
    return !0;
  }
  return !1;
}, yt = (n) => {
  if (Gt(n))
    return { fonts: [], useWorkaround: !0 };
  var a = [], l = !1, s = n.cssRules;
  for (let h = 0; h < s.length; h++) {
    var p = s[h];
    if (p.styleSheet) {
      var c = yt(p.styleSheet);
      a.push.apply(a, c.fonts), l = l || c.useWorkaround;
      continue;
    }
    if (p.type == CSSRule.FONT_FACE_RULE) {
      var u = p.style.fontFamily;
      a.indexOf(u) == -1 && a.push(u);
    }
  }
  return { fonts: a, useWorkaround: l };
}, Ut = () => {
  const n = [];
  var a = {}, l = void 0, s = document.styleSheets;
  for (let C = 0; C < s.length; C++) {
    var p = s[C], c = yt(p);
    l = l || c.useWorkaround;
    var u = c.fonts;
    for (let A = 0; A < u.length; A++) {
      var h = u[A];
      a[h.toLowerCase()] = !0;
    }
    n.push.apply(n, c.fonts);
  }
  if (l) {
    var w = Array.prototype.slice.call(document.body.childNodes);
    for (let C = 0; C < w.length; C++) {
      var b = w[C];
      if (b.nodeType == Node.ELEMENT_NODE) {
        var _ = window.getComputedStyle(b), P = _["font-family"].split(",");
        for (let A = 0; A < P.length; A++) {
          var B = P[A], k = B.toLowerCase();
          a[k] !== !0 && (a[k] = !0);
        }
        n.push.apply(n, P);
      }
    }
  }
  return n;
}, Xt = (n) => {
  for (var a = {}, l = n.split(","), s = 0; s < l.length; ++s) {
    var p = l[s].split("="), c = p[0].trim(), u = p[1].trim();
    a[c] = u;
  }
  return a;
}, Yt = (n) => {
  var a = "", l = 0;
  for (var s in n)
    l != 0 && (a += ","), a += s + "=" + n[s], l++;
  return a;
}, vt = (n) => {
  var a = n.getBoundingClientRect();
  return pagedHorizontally ? Math.floor(
    (a.left + window.scrollX) / (pageWidth + pageHorizontalMargin)
  ) : Math.floor(
    (a.top + window.scrollY) / (pageHeight + pageVerticalMargin)
  );
}, qt = (n) => {
  var a = {};
  for (var l in n) {
    var s = n[l], p = document.getElementById(s.substring(1));
    if (p)
      switch (pageProperties.flowStyle) {
        case FLOW_PAGED:
          a[l] = vt(p);
          break;
        case FLOW_SCROLLED:
          a[l] = p.offsetTop;
          break;
      }
  }
  return a;
}, wt = (n) => {
  if (!n.length) {
    ReaderApp.setAnchorPositions(null);
    return;
  }
  var a = [];
  for (var l in n) {
    var s = n[l], p = document.getElementById(s.substring(1));
    if (p)
      if (pageProperties.flowStyle == FLOW_PAGED)
        a.push([s, vt(p)]);
      else {
        var c = p.getBoundingClientRect(), u = c.top + window.scrollY;
        a.push([s, u]);
      }
  }
  ReaderApp.setAnchorPositions(JSON.stringify(a));
}, $t = (n) => {
  bookContainer.innerHTML = bookContainer.firstChild.outerHTML;
  const a = pageProperties.bookName ?? "", l = pageProperties.chapterName ?? document.getElementsByTagName("title")[0].innerText;
  let s = window.innerWidth;
  for (let p = 0; p < n; p++) {
    const c = document.createElement("div");
    c.className = "ReaderApp-page-header", c.style.padding = "0", c.style.position = "absolute", c.style.top = pageProperties.topPos + "px", c.style.left = s * p + "px", c.style.width = "100%", c.style.height = "32px", c.style.boxSizing = "border-box", c.style.fontSize = "13px", c.style.color = "#8d8d8d", c.style.padding = `0 ${marginHorizontal}px`, c.style.display = "flex", c.style.alignItems = "flex-end", c.innerText = p == 0 ? a : l, bookContainer.appendChild(c);
    const u = document.createElement("div");
    u.className = "ReaderApp-page-footer", u.style.padding = "0", u.style.position = "absolute", u.style.bottom = pageProperties.bottomPos + "px", u.style.left = s * p + "px", u.style.width = "100%", u.style.height = "32px", u.style.boxSizing = "border-box", u.style.fontSize = "13px", u.style.color = "#8d8d8d", u.style.padding = `0 ${marginHorizontal}px`, u.style.display = "flex", u.style.alignItems = "flex-start", u.style.justifyContent = "flex-end", u.innerText = `${p + 1}/${n}`, bookContainer.appendChild(u);
  }
}, Jt = () => {
  if (!(pageProperties.layoutStyle != LAYOUT_REFLOW || pageProperties.flowStyle != FLOW_PAGED)) {
    if (!pageContainer) {
      bookContainer = document.createElement("div");
      var n = document.createElement("div");
      n.style.webkitMarginCollapse = "separate";
      var a = Array.prototype.slice.call(document.body.childNodes);
      for (let c = 0; c < a.length; c++) {
        var l = a[c];
        n.appendChild(l);
      }
      n.className = "collapse-wrapper", bookContainer.appendChild(n), pageContainer = document.createElement("div"), pageContainer.className = "book-wrapper", pageContainer.appendChild(bookContainer), document.body.appendChild(pageContainer), mt([pageContainer, bookContainer]);
    }
    pageHorizontalMargin = marginHorizontal * 2, pageVerticalMargin = marginVeitical * 2, console.log("---><", pageHorizontalMargin, pageVerticalMargin), pageWidth = window.innerWidth - pageHorizontalMargin, pageHeight = window.innerHeight - pageVerticalMargin;
    var s = window.getComputedStyle(document.body), p = window.getComputedStyle(
      document.getElementsByTagName("html")[0]
    );
    pagedHorizontally = s.writingMode.indexOf("vertical") == -1 && p.writingMode.indexOf("vertical") == -1, bookContainer.style.width = pageWidth + "px", bookContainer.style.height = pageHeight + "px", bookContainer.style.webkitColumnWidth = (pagedHorizontally ? pageWidth : pageHeight) + "px", bookContainer.style.webkitColumnGap = (pagedHorizontally ? pageHorizontalMargin : pageVerticalMargin) + "px", endMarginStub.style.left = "0px", endMarginStub.style.top = "0px", pagedHorizontally ? (pageCount = Math.ceil(
      document.body.scrollWidth / (pageWidth + pageHorizontalMargin)
    ), endMarginStub.style.left = pageCount * (pageWidth + pageHorizontalMargin) - 1 + "px") : (pageCount = Math.ceil(
      document.body.scrollHeight / (pageHeight + pageVerticalMargin)
    ), endMarginStub.style.top = pageCount * (pageHeight + pageVerticalMargin) - 1 + "px"), pageProperties.apiLevel < 21 && setTimeout(function() {
      endMarginStub.parentNode.removeChild(endMarginStub), pageContainer.appendChild(endMarginStub);
    }, 100), wt(pageProperties.tocAnchorList ?? []), $t(pageCount), ReaderApp.onPagingSetup(
      pageHorizontalMargin / window.innerWidth,
      pageHorizontalMargin / window.innerHeight,
      pageCount,
      pagedHorizontally
    );
  }
}, H = () => {
  pageProperties.flowStyle == FLOW_PAGED ? Jt() : wt(pageProperties.tocAnchorList);
  var n = qt(pageProperties.paperPageToAnchorMap);
  ReaderApp.setPaperPageMap(JSON.stringify(n)), initialFlowWasDone = !0;
}, F = () => {
  initialFlowWasDone && H();
}, bt = () => {
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
}, Kt = (n) => {
  lineSpacing = n, bt(), F();
}, Qt = (n) => {
  for (var a in n)
    pageProperties[a] = n[a];
}, Zt = (n) => {
  document.body.style.margin = n, F();
}, te = (n) => {
  marginPercent = n / 100, document.body.style.margin = n + "%", F();
}, ee = (n) => {
  marginHorizontal = n, document.body.style.marginLeft = n + "px", document.body.style.marginRight = n + "px", F();
}, ne = (n) => {
  marginVeitical = n, document.body.style.marginBottom = n + "px", document.body.style.marginTop = n + "px", F();
}, ie = (n) => {
  textAlign = n, bt(), F();
}, j = (n, a, l, s) => "@font-face { font-family: '" + n + "';font-style: " + a + "; font-weight: " + l + ";src: url(file:///android_asset/fonts/" + s + "); }", oe = (n) => {
  var a = j(n.name, "normal", 400, n.regular) + (n.bold ? j(n.name, "normal", 700, n.bold) : "") + (n.italic ? j(n.name, "italic", 400, n.italic) : "") + (n.italic ? j(n.name, "italic", 700, n.boldItalic) : "");
  typefacesStyleElement.innerText = typefacesStyleElement.innerText + a, fontsInjected.push(n.name);
}, ae = (n) => {
  if (currentFont = n, !n) {
    fontStyleElement.innerText = "", initialFlowWasDone && setTimeout(function() {
      H();
    }, 60);
    return;
  }
  if (fontStyleElement.innerText = specificitySelector + " * { font-family: " + n.name + " !important; }", fontSetupInitialized) {
    var a = function() {
      fontsLoaded.push(n.name), initialFlowWasDone && H();
    };
    fontsLoaded.indexOf(n.name) > -1 ? a() : gt.load({
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
  a.preventDefault(), a.stopPropagation(), (n.getAttribute("epub:type") || n.getAttribute("epubu0003atype")) == "noteref" ? (a.preventDefault(), a.stopPropagation(), Dt(n.getAttribute("href"), function(s) {
    const p = n.getClientRects();
    let c;
    for (var u in p) {
      var h = p[u];
      if (a.clientX >= h.left && a.clientX <= h.right && a.clientY >= h.top && a.clientY <= h.bottom) {
        c = h;
        break;
      }
    }
    c = c || p[0];
    var w = (c.left + c.right) / 2, b = (c.top + c.bottom) / 2;
    ReaderApp.openFootNote(n.innerText.trim(), s, w, b);
  })) : ReaderApp.openLink(n.href);
}, se = (n, a) => {
  for (var l = n.parentNode; l; ) {
    if (l.tagName && l.tagName.toLowerCase() == "a" && l.getAttribute("href"))
      return;
    l = l.parentNode;
  }
  a.preventDefault(), a.stopPropagation();
  var s = n.getBoundingClientRect();
  ReaderApp.openImage(
    n.src,
    s.left,
    s.top,
    s.right - s.left,
    s.bottom - s.top
  ), showcasedImageElement = n;
};
function le() {
  globalThis.LAYOUT_REFLOW = 1, globalThis.LAYOUT_FIXED = 2, globalThis.FLOW_PAGED = 1, globalThis.FLOW_SCROLLED = 2, globalThis.bookContainer = void 0, globalThis.pageContainer = void 0, globalThis.endMarginStub = void 0, globalThis.pageWidth = void 0, globalThis.pageHeight = void 0, globalThis.pageHorizontalMargin = void 0, globalThis.pageVerticalMargin = void 0, globalThis.pageCount = void 0, globalThis.pagedHorizontally = void 0, globalThis.pageProperties = {}, globalThis.marginPercent = 0, globalThis.marginHorizontal = 0, globalThis.marginVeitical = 0, globalThis.lineSpacing = void 0, globalThis.textAlign = void 0, globalThis.showcasedImageElement = void 0, globalThis.currentFont = void 0, globalThis.fontSetupInitialized = void 0, globalThis.initialFlowWasDone = void 0, globalThis.typefacesStyleElement = void 0, globalThis.fontStyleElement = void 0, globalThis.styleElement = void 0, globalThis.fontsInjected = [], globalThis.fontsLoaded = [], globalThis.specificityClassName = "", globalThis.specificitySelector = "";
}
const ce = () => {
  globalThis.ReaderApp = {}, ReaderApp.notifySize = (...n) => window.flutter_inappwebview.callHandler("notifySize", ...n), ReaderApp.onTouchUp = (...n) => window.flutter_inappwebview.callHandler("onTouchUp", ...n), ReaderApp.setAnchorPositions = (...n) => window.flutter_inappwebview.callHandler("setAnchorPositions", ...n), ReaderApp.setPaperPageMap = (...n) => window.flutter_inappwebview.callHandler("setPaperPageMap", ...n), ReaderApp.onBookReady = (...n) => window.flutter_inappwebview.callHandler("onBookReady", ...n), ReaderApp.onPagingSetup = (...n) => window.flutter_inappwebview.callHandler("onPagingSetup", ...n), ReaderApp.openImage = (...n) => window.flutter_inappwebview.callHandler("openImage", ...n);
};
globalThis.ReaderThemes = function() {
  var n = "-webkit-text-fill-color: currentcolor !important;";
  globalThis.styleElement = void 0;
  function a() {
    const c = document.createElement("style");
    c.setAttribute("type", "text/css"), c.id = "__ReaderThemeStyle", document.head.appendChild(c), styleElement = document.getElementById("__ReaderThemeStyle"), styleElement.dataset.excludeFromFootnote = !0;
  }
  function l(c) {
    for (var u = c.toString(16); u.length < 6; )
      u = "0" + u;
    return u;
  }
  function s(c) {
    var u = "";
    c && (u += "body {", u += "background-color: #" + l(c.backgroundColor) + " !important;", u += "}", u += "* {", u += "background-color: transparent !important;", u += "color: #" + l(c.textColor) + " !important;" + n, u += "}", u += "a, a:link, a:visited, a:hover, a * {", u += "color: #" + l(c.linkColor) + " !important;" + n, u += "}"), styleElement.innerText = u;
  }
  function p() {
    return styleElement.innerText;
  }
  return document.addEventListener("DOMContentLoaded", function() {
    console.log("theme-init"), a();
  }), {
    set: s,
    getCss: p
  };
}();
ce();
globalThis.ReaderJs = (() => {
  le(), window.requestAnimationFrame || (window.requestAnimationFrame = function(l) {
    return setTimeout(l, 16), 0;
  });
  const n = () => {
    var u;
    const l = document.getElementsByTagName("meta");
    let s;
    for (let h = 0; h < l.length; h++) {
      var p = l[h];
      if (p.getAttribute("name") == "viewport") {
        s = p;
        break;
      }
    }
    const c = !!s;
    if (c && pageProperties.layoutStyle == LAYOUT_FIXED) {
      const h = Xt(
        s.getAttribute("content")
      ), w = parseInt(h.width);
      let b = 0;
      h.height && (b = parseInt(h.height));
      const P = document.getElementsByTagName("html")[0].getBoundingClientRect();
      b = Math.max(b, P.bottom - P.top), h.width = w, h.height = b, h["minimum-scale"] = 0, ReaderApp.setFixedViewport(w, b), s.setAttribute(
        "content",
        Yt(h)
      );
    } else {
      c && ((u = s == null ? void 0 : s.parentNode) == null || u.removeChild(s));
      const h = document.createElement("meta");
      h.setAttribute("name", "viewport"), h.setAttribute("content", "width=device-width, user-scalable=no"), document.head.appendChild(h);
    }
    ReaderApp.notifySize(window.innerWidth, window.innerHeight), H(), window.onresize = function() {
      console.log("---onresize---"), ReaderApp.notifySize(window.innerWidth, window.innerHeight), H();
    }, ReaderApp.onBookReady(), setTimeout(function() {
      ReaderApp.notifySize(window.innerWidth, window.innerHeight);
    }, 300);
  }, a = () => {
    console.log("---init reader---"), console.log("---", pageProperties);
    for (let h = 0; h < 16; h++) {
      let w = "__Reader_S_" + h;
      specificityClassName += " " + w, specificitySelector += "." + w;
    }
    document.body.className = document.body.className + specificityClassName, endMarginStub = document.createElement("div"), endMarginStub.style.position = "absolute", endMarginStub.style.top = "0px", endMarginStub.style.height = "1px", endMarginStub.style.width = "1px", mt([endMarginStub]), document.body.appendChild(endMarginStub), typefacesStyleElement = document.createElement("style"), typefacesStyleElement.setAttribute("type", "text/css"), document.head.appendChild(typefacesStyleElement), fontStyleElement = document.createElement("style"), fontStyleElement.setAttribute("type", "text/css"), document.head.appendChild(fontStyleElement), styleElement = document.createElement("style"), styleElement.setAttribute("type", "text/css"), document.head.appendChild(styleElement);
    const l = document.getElementsByTagName("a");
    for (var s = 0; s < l.length; s++) {
      var p = l[s];
      p.getAttribute("href") && p.addEventListener("click", function(h) {
        re(this, h);
      });
    }
    const c = document.getElementsByTagName("img");
    for (let h = 0; h < c.length; h++) {
      var u = c[h];
      u.addEventListener("click", function(w) {
        se(this, w);
      });
    }
    document.addEventListener("click", function() {
      ReaderApp.onTouchUp();
    }), Vt();
  };
  return document.addEventListener("DOMContentLoaded", a), window.addEventListener("load", function() {
    if (pageProperties.layoutStyle == LAYOUT_FIXED) {
      n();
      return;
    }
    var l = Ut();
    currentFont && l.indexOf(currentFont.name) == -1 && l.push(currentFont.name), fontSetupInitialized = !0, gt.load({
      custom: {
        families: l
      },
      classes: !1,
      active: function() {
        fontsLoaded.push.apply(fontsLoaded, l), n();
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
    reflowIfNecessary: F,
    setPageProperties: Qt,
    setMargin: Zt,
    setMarginHorizontal: ee,
    setMarginVertical: ne,
    setMarginPercent: te,
    setFont: ae,
    setLineSpacing: Kt,
    setTextAlign: ie
  };
})();
