// Generated by LiveScript 1.3.1
var numconvert, module;
numconvert = {
  base: [['京', 1e16], ['兆', 1e12], ['億', 1e8], ['萬', 1e4], ['千', 1e3], ['百', 1e2], ['十', 10], ['仟', 1e3], ['佰', 1e2], ['拾', 10]],
  isnum: function(it){
    if (this.re.num.exec(it)) {
      return true;
    } else {
      return false;
    }
  },
  re: {
    dollar: /[元圓]/,
    num: /^[零一二倆兩三四五六七八九十百千萬億兆京壹貳參肆伍陸柒捌玖拾佰仟0123456789]*$/,
    numUc: /[零壹貳倆兩參肆伍陸柒捌玖拾佰仟]/g,
    numLc: /[零一二三四五六七八九十百千]/g,
    numAc: /\d/g,
    arabic: /^\d*$/
  },
  map: {
    u2l: {
      uc: "零壹貳倆兩參肆伍陸柒捌玖拾佰仟",
      lc: "零一二二二三四五六七八九十百千",
      ac: "012223456789"
    },
    lc: "零一二三四五六七八九十百千",
    uc: "零壹貳參肆伍陸柒捌玖拾佰仟"
  },
  c2a: function(str, opt){
    var num, i$, to$, i, upper, rate, lower, this$ = this;
    opt == null && (opt = {});
    if (!str) {
      return 1;
    }
    if (opt.dollar && this.re.dollar.exec(str)) {
      str = str.split(this.re.dollar);
      if (str.length > 0) {
        num = this.c2a(str.splice(0, 1)[0], opt);
        return ([num + ""].concat(str)).join("元");
      }
    }
    if (!this.isnum(str)) {
      return str;
    }
    str = str.replace(this.re.numUc, function(a){
      return this$.map.u2l.lc.charAt(this$.map.u2l.uc.indexOf(a));
    });
    for (i$ = 0, to$ = this.base.length; i$ < to$; ++i$) {
      i = i$;
      if (str.indexOf(this.base[i][0]) >= 0) {
        str = str.split(this.base[i][0]);
        upper = this.c2a(str[0]);
        rate = this.base[i][1];
        lower = str[1] ? this.c2a(str[1]) : 0;
        if (rate > 10 && str[1].length < 2) {
          lower *= rate / 10;
        }
        return upper * rate + lower;
      }
    }
    return parseInt(str.replace(this.re.numLc, function(a){
      return this$.map.lc.indexOf(a);
    }));
  },
  l2u: function(it){
    var this$ = this;
    return it.replace(this.re.numLc, function(a){
      return this$.map.u2l.uc.charAt(this$.map.u2l.lc.indexOf(a));
    });
  },
  a2c: function(num, opt){
    var v, i$, to$, i, num2, num1, deco, ret;
    opt == null && (opt = {});
    if (opt.dollar && this.re.dollar.exec(num + "")) {
      num = (num + "").split(this.re.dollar);
      if (num.length > 0) {
        v = this.a2c(num.splice(0, 1)[0], opt);
        if (opt.uppercase) {
          v = this.l2u(v);
        }
        return ([v + ""].concat(num)).join("元");
      }
    }
    if (!this.re.arabic.exec(num + "")) {
      return num;
    }
    for (i$ = 0, to$ = this.base.length; i$ < to$; ++i$) {
      i = i$;
      if (num >= this.base[i][1]) {
        num2 = num % this.base[i][1];
        num1 = Math.floor(num / this.base[i][1]);
        deco = this.base[i][1] > 10 && num2 > 0 && num2 < 10 ? "零" : "";
        ret = this.a2c(num1, opt) + "" + this.base[i][0] + deco + this.a2c(num2, opt);
        if (opt.uppercase) {
          ret = this.l2u(ret);
        }
        return ret;
      }
    }
    if (num === 0) {
      return "";
    }
    ret = this.map.lc.charAt(num);
    if (opt.uppercase) {
      ret = this.l2u(ret);
    }
    return ret;
  },
  C2c: function(str, opt){
    var num, this$ = this;
    if (!str) {
      return "";
    }
    if (opt.dollar && this.re.dollar.exec(str)) {
      str = str.split(this.re.dollar);
      if (str.length > 0) {
        num = this.C2c(str.splice(0, 1)[0], opt);
        return ([num + ""].concat(str)).join("元");
      }
    }
    if (!this.isnum(str)) {
      return str;
    }
    str = str.replace(this.re.numUc, function(a){
      return this$.map.u2l.lc.charAt(this$.map.u2l.uc.indexOf(a));
    });
    str = str.replace(this.re.numAc, function(a){
      return this$.map.u2l.lc.charAt(this$.map.u2l.ac.indexOf(a));
    });
    return str;
  },
  c2C: function(str, opt){
    var num, this$ = this;
    if (!str) {
      return "";
    }
    if (opt.dollar && this.re.dollar.exec(str)) {
      str = str.split(this.re.dollar);
      if (str.length > 0) {
        num = this.c2C(str.splice(0, 1)[0], opt);
        return ([num + ""].concat(str)).join("元");
      }
    }
    if (!this.isnum(str)) {
      return str;
    }
    str = str.replace(this.re.numLc, function(a){
      return this$.map.u2l.uc.charAt(this$.map.u2l.lc.indexOf(a));
    });
    str = str.replace(this.re.numAc, function(a){
      return this$.map.u2l.uc.charAt(this$.map.u2l.ac.indexOf(a));
    });
    return str;
  }
};
if (typeof module == 'undefined' || module === null) {
  module = {};
}
module.exports = numconvert;
