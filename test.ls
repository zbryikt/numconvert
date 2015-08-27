require! './index': numconvert

console.log numconvert.a2c 15030
console.log numconvert.a2c("15003元整", {dollar: true, uppercase: true})
console.log numconvert.c2a "5萬7千3百零二", {dollar: true}
console.log numconvert.c2a "五萬七千三", {dollar: true}
console.log numconvert.c2a "五萬七千零三元整", {dollar: true}
