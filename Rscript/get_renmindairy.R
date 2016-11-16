library(RCurl)
# 昨晚实现了人民网2013年4个季度所有指标数据的抓取。虽然抓取结果能在R console中显示，但并没能保存在Excel或文本文档中，代码还有不少缺陷，仍需优化，也请各位指教。
for (i in 1:4) {
  base <- "http://vip.stock.finance.sina.com.cn/corp/go.php/vMS_MarketHistory/stockid/603000.phtml?year=2013&jidu="
  jidu <- i
  url <- paste(base,jidu,sep='')
  
  temp <- getURL(url)
  k=strsplit(temp,"\r\n")[[1]]    #以list形式展现，方便以下操作
  
  #抓取日期
  timeadr <- k[grep("<a target='_blank'",k)+1]  #第1行  日期  
  time=substring(timeadr,4,13) 
  print(unlist(strsplit(time," ")))
  
  #抓取  开盘价，最高价，收盘价，最低价
  for(j in 3:6)  #一个季度源代码中第3到6行  
  {
    
    xxx <- k[grep("<a target='_blank'",k)+j]  #   所需信息
    xx <- gregexpr(">\\d+",xxx)    #找出指定元素在本行第几位
    
    
    for(m in 1:length(xxx))
    {
      yy=xx[[m]]
      xxs=substring(xxx[m],yy+1,yy+attr(yy,'match.length')+3)  #3:6行+3  
      print(xxs)   #每次循环都输出该值  
    }
    
  }
  
  
  #抓取交易量
  xxx=k[grep("<a target='_blank'",k)+7]   #抓取路径下第7行   交易量
  xx=gregexpr(">\\d+",xxx)    #找出指定元素在本行第几位
  for(n in 1:length(xxx))
  {
    yy=xx[[n]]
    xxs=substring(xxx[n],yy+1,yy+attr(yy,'match.length')-1)  #3:6行+3  7行-1 8行-1
    print(xxs)   #每次循环都输出该值  
  }
  #抓取交易金额
  xxx=k[grep("<a target='_blank'",k)+8]   #抓取路径下第8行   交易金额
  xx=gregexpr(">\\d+",xxx)    #找出指定元素在本行第几位
  for(o in 1:length(xxx))
  {
    yy=xx[[o]]
    xxs=substring(xxx[o],yy+1,yy+attr(yy,'match.length')-1)  #3:6行+3  7行-1 8行-1
    print(xxs)   #每次循环都输出该值  
  }
  
}
