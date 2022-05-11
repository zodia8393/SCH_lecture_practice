#2022-05-09 소셜네트워크분석 기말 4회차

getwd()
#setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리
setwd('C:/Users/student/Documents/R_WS')#학교 강의실용 디렉터리

library(urltools)
library(stringr)
library(httr)
library(rvest)
library(tidyverse)
library(jsonlite)


ref<-'https://section.blog.naver.com/BlogHome.nhn'

res<-GET(url='https://section.blog.naver.com/BlogHome.nhn',
         query=list(directorySeq='0',
                    pageNo='1'),
         add_headers(referer=ref))

print(x=res)

res %>% as.character() %>% fromJSON()

res %>% content(as='text') %>% str_sub(start=1,end=100) %>% cat()

json <- res %>% 
  as.character() %>% 
  str_remove(pattern = "\\)\\]\\}\\',") %>% 
  fromJSON()

blog<-json$result$postList
print(x=blog)
str(blog)

#10페이지까지 
for (i in 1:10){
  res<-GET(url='https://section.blog.naver.com/BlogHome.nhn',
           query=list(directorySeq='0',
                      pageNo=i),
           add_headers(referer=ref))
}


