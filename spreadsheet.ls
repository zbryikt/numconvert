onOpen = (e) ->
  SpreadsheetApp.get-ui!create-addon-menu!
    .add-item "轉換選取範圍 ( 中轉數 )", "_c2a"
    .add-item "轉換選取範圍 ( 數轉中/小寫 )", "_a2c"
    .add-item "轉換選取範圍 ( 數轉中/大寫 )", "_a2cCap"
    .add-item "轉換選取範圍 ( 小中轉大中  )", "_c2C"
    .add-item "轉換選取範圍 ( 大中轉小中  )", "_C2c"
    .add-to-ui!

onInstall = (e) -> onOpen e

_C2c = ->
  range = SpreadsheetApp.get-active-sheet!get-active-range!
  data = range.get-values!
  for i from 0 til data.length
    for j from 0 til data[i].length
      src = data[i][j].toString!
      data[i][j] = numconvert.C2c src, {dollar: true}
  range.setValues(data)

_c2C = ->
  range = SpreadsheetApp.get-active-sheet!get-active-range!
  data = range.get-values!
  for i from 0 til data.length
    for j from 0 til data[i].length
      src = data[i][j].toString!
      data[i][j] = numconvert.c2C src, {dollar: true}
  range.setValues(data)

_c2a = ->
  range = SpreadsheetApp.get-active-sheet!get-active-range!
  data = range.get-values!
  for i from 0 til data.length
    for j from 0 til data[i].length
      src = data[i][j].toString!
      data[i][j] = numconvert.c2a src, {dollar: true}
  range.setValues(data)

_a2c = (cap = false) ->
  range = SpreadsheetApp.get-active-sheet!get-active-range!
  data = range.get-values!
  for i from 0 til data.length
    for j from 0 til data[i].length
      src = data[i][j].toString!
      data[i][j] = numconvert.a2c src, {dollar: true, uppercase: cap}
  range.setValues(data)

_a2cCap = -> _a2c true

function a2C(value) => numconvert.a2c value, {dollar: true, uppercase: true}
function a2c(value) => numconvert.a2c value, {dollar: true, uppercase: false}
function c2a(value) => numconvert.c2a value, {dollar: true}
function c2C(value) => numconvert.c2C value, {dollar: true}
function C2c(value) => numconvert.C2c value, {dollar: true}
