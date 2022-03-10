#2022-03-10 시계열분석 2회차
#실습
getwd()
setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

install.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

install.packages("fpp3") #시계열데이터 패키지
library(fpp3)

global_economy
tourism

mydata<-tibble(
  year = 2012:2016,
  y=c(123,39,78,52,110) #tibble데이터 만들기
  )%>%
  as_tsibble(index=year) #tsibble 데이터로 변환 (시간개념이 추가된 index값이 추가됨)

mydata

z<-tibble(
  Month=c("2019 Jan","2019 Feb","2019 Mar","2019 Apr","2019 May"),
  Observation=c(50,23,34,30,25))

z

z%>%
  mutate(Month=yearmonth(Month))%>%
  as_tsibble(index=Month)
  
prison<-readr::read_csv("https://OTexts.com/fpp3/extrafiles/prison_population.csv")%>%mutate(Quarter=yearquarter(Date))%>%select(-Date)%>%as_tsibble(
  index=Quarter,
  key=c(state,gender,legal,indigenous)
)
PBS

PBS%>%
  filter(ATC2=="A10")%>%
  select(Month,Concession,Type,Cost)%>%
  summarise(total_cost=sum(Cost))%>%
  mutate(total_cost=total_cost/1e6)->a10

autoplot(a10, total_cost)+
  labs(y="$(millions)",
       title="Australian antidiabetic drug sales")

