require! <[fs LiveScript]>

main = (fs.read-file-sync \index.ls .toString!)
spreadsheet = (fs.read-file-sync \spreadsheet.ls .toString!)
result = LiveScript.compile(main + spreadsheet,{bare:true})
fs.write-file-sync \dist/Code.gs, result

result = LiveScript.compile(main, {bare:true})
fs.write-file-sync \web/numconvert.js, result

