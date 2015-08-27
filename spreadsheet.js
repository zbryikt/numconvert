function converts() {
  var range = SpreadsheetApp.getActiveSheet().getActiveRange();
  var data = range.getValues();
  var i,j,idx,src,srcs;
  for(i=0;i<data.length;i++) {
    for(j=0;j<data[i].length;j++) {
      src = data[i][j].toString();
      idx = src.indexOf("元");
      if(idx>=0) {
        srcs = src.split("元");
        src = srcs.splice(0,1)[0];
        src = [convert(src),"元"];
        data[i][j] = src.concat(srcs).join("");
      } else data[i][j] = convert(src);
    }
  }
  range.setValues(data);
}

