onOpen = (e) ->
  SpreadsheetApp.get-ui!create-addon-menu!
    .add-item "轉換選取範圍 ( 中轉數 )", "c2a"
    .add-item "轉換選取範圍 ( 數轉中/小寫 )", "a2c"
    .add-item "轉換選取範圍 ( 數轉中/大寫 )", "a2cCap"
    .add-to-ui!

onInstall = (e) -> onOpen e

c2a = ->
  range = SpreadsheetApp.get-active-sheet!get-active-range!
  data = range.get-values!
  for i from 0 til data.length
    for j from 0 til data[i].length
      src = data[i][j].toString!
      data[i][j] = numconvert.c2a src, {dollar: true}
  range.setValues(data)

a2cCap = -> a2c true
a2c = (cap=false) ->
  range = SpreadsheetApp.get-active-sheet!get-active-range!
  data = range.get-values!
  for i from 0 til data.length
    for j from 0 til data[i].length
      src = data[i][j].toString!
      data[i][j] = numconvert.a2c src, {dollar: true, uppercase: cap}
  range.setValues(data)