#2022-04-13 소셜네트워크분석 11회차

library(httr)
library(dplyr)

#Sys.setlocale(category = "LC_ALL",locale="ko_KR.UTF-8")

res<-GET(url="https://datalab.naver.com")

print(x=res)

status_code(x=res)

content(x=res,as='text',encoding = 'UTF-8') %>% cat()

html<-read_html(x=res)

span<-html_nodes(x=html,css='a.list_area')

searchWords<-html_text(x=span)

print(x=searchWords)

span<-html_nodes(x=html,css='a.list_area>span.title')
searchWords<-html_text(x=span)
searchWords
