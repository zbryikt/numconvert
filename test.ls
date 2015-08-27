require! './index': numconvert

console.log numconvert.a2c 15030
console.log numconvert.a2c-dollar("15003元整", true)
console.log numconvert.c2a-dollar "5萬7千3百零二"
console.log numconvert.c2a-dollar "五萬七千三"
console.log numconvert.c2a-dollar "五萬七千零三元整"
