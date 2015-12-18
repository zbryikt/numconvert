<- $ document .ready

window.convert = ->
  value = $(\#input).val!
  value = value.replace /^(新臺幣|港幣|人民幣)/, ""
  tobig = $('#bigcheck input').prop(\checked)
  c2c = $('#c2c input').prop(\checked)
  map = [<[ntd 新臺幣]> <[rmb 人民幣]> <[hkd 港幣]>]
    .map -> [$("\##{it.0} input").prop(\checked), it.1]
    .filter(-> it.0).0
  if value == "" or !value? => return
  if /^[0-9元]+$/.exec value =>
    ret = numconvert.a2c value, {dollar: true, uppercase: !!tobig}
    $(\#c2c).add-class \disabled
    $(\#bigcheck).remove-class \disabled!
  else =>
    $(\#bigcheck).add-class \disabled
    $(\#c2c).remove-class \disabled
    if c2c =>
      if numconvert.re.numUc.exec value =>
        ret = numconvert.C2c value, {dollar: true, uppercase: !!tobig}
      else 
        ret = numconvert.c2C value, {dollar: true, uppercase: !!tobig}
    else =>
      ret = numconvert.c2a value, {dollar: true, uppercase: !!tobig}
  if map => ret = map.1 + ret
  if map and !(/元整$/.exec(ret)) => ret = ret.replace /元?$/, \元整
  if !map => ret = ret.replace /元整?$/, ""
  $(\#output).val ret

window.sel = (id) -> $("\##id").select!
window.check = (id,forced) -> 
  n = $("\##id input")
  if forced? => n.prop(\checked, forced)
  else n.prop(\checked, !!!(n.prop(\checked)))
  convert!

copybtn = '#copy'
clipboard = new Clipboard copybtn
clipboard.on \success, ->
  $(copybtn).tooltip({title: '複製完成！', trigger: 'click'}).tooltip('show')
  setTimeout((->$(copybtn).tooltip('hide')), 1000)
clipboard.on \error, ->
  $(copybtn).tooltip({title: '按 Ctrl+C 複製', trigger: 'click'}).tooltip('show')
  setTimeout((->$(copybtn).tooltip('hide')), 1000)
