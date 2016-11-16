## 绘制莆田医院分布地图
##获取数据
raw = readLines("http://news.ifeng.com/mainland/special/ptxyy/",
                encoding = "UTF-8")
rawHospital = raw[123 : 238]
## 数据整理
extFun = function(x){
  split = strsplit(x, "','")
  out = strsplit(split[[1]][2], "<br/>")
  return(out)
}
extFun(rawHospital[1])
hosList = sapply(rawHospital,extFun)
hospital = c()
for(i in 1:length(hosList)) hospital = append(hospital, hosList[[i]])
## 获取经纬度
library(baidumap)
blackHospital = getCoordinate(hospital, formatted = T)
blackHospital = na.omit(blackHospital)
plotdata = data.frame(lon = blackHospital[,1],
                      lat = blackHospital[,2],
                      city = rownames(blackHospital))
## 绘制地图
library(REmap)
remapB(markPointData = data.frame(plotdata$city),
       markPointTheme = markPointControl(symbol = "pin",
                                         effect=F,
                                         symbolSize = 5,
                                         color="red"),
       geoData = plotdata)