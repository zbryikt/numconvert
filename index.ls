numconvert = do
  base: [
    [\京,1e16], [\兆,1e12], [\億,1e8],
    [\萬,1e4],  [\千,1e3],  [\百,1e2],
    [\十,10],   [\仟,1e3],  [\佰,1e2], [\拾,10]
  ]
  isnum: -> if @re.num.exec(it) => return true else false
  re: do
    dollar: /[元圓]/
    num: /^[零一二倆兩三四五六七八九十百千萬億兆京壹貳參肆伍陸柒捌玖拾佰仟0123456789]*$/
    num-uc: /[零壹貳倆兩參肆伍陸柒捌玖拾佰仟]/g
    num-lc: /[零一二三四五六七八九十百千]/g
    arabic: /^\d*$/
  map:
    u2l:
      uc: "零壹貳倆兩參肆伍陸柒捌玖拾佰仟"
      lc: "零一二二二三四五六七八九十百千"
    lc: "零一二三四五六七八九十百千"
    uc: "零壹貳參肆伍陸柒捌玖拾佰仟"

  c2a: (str)->
    if !str => return 1
    if !@isnum(str) => return str
    str = str.replace(@re.num-uc, (a) ~> @map.u2l.lc.charAt(@map.u2l.uc.indexOf(a)))
    for i from 0 til @base.length
      if str.indexOf(@base[i].0) >= 0 =>
        str = str.split @base[i].0
        upper = @c2a(str.0)
        rate = @base[i].1
        lower = (if str.1 => @c2a(str.1) else 0)
        if rate > 10 and str.1.length < 2 => lower *= rate/10
        return upper * rate + lower
        #return @c2a(str.0) * @base[i].1 + (if str.1 => @c2a(str.1) else 0)
    return parseInt(str.replace(@re.num-lc, ((a) ~> return @map.lc.indexOf(a))))

  c2a-dollar: (str) ->
    if @re.dollar.exec(str) =>
      str = str.split(@re.dollar)
      if str.length > 0 =>
        num = @c2a(str.splice 0,1 .0)
        return (["#num"] ++ str).join("元")
    else return @c2a(str)

  l2u: -> it.replace(@re.num-lc, (a) ~> @map.u2l.uc.charAt(@map.u2l.lc.indexOf(a)))
  a2c: (num, isUpper = false) ->
    if !@re.arabic.exec("#num") => return num
    for i from 0 til @base.length =>
      if num >=  @base[i].1 =>
        num2 = num % @base[i].1
        num1 = Math.floor(num / @base[i].1)
        deco = if @base[i].1 > 10 and num2 > 0 and num2 < 10 => "零" else ""
        ret = "#{@a2c(num1, isUpper)}#{@base[i].0}#deco#{@a2c(num2, isUpper)}"
        if isUpper => ret = @l2u(ret)
        return ret
    if num == 0 => return ""
    ret = @map.lc.charAt(num)
    if isUpper => ret = @l2u(ret)
    ret

  a2c-dollar: (str, isUpper = false) ->
    if @re.dollar.exec(str) =>
      str = str.split(@re.dollar)
      if str.length > 0 =>
        num = @a2c(str.splice(0,1).0, isUpper)
        return (["#num"] ++ str).join("元")
    else return @a2c(str, isUpper)

module.exports = numconvert