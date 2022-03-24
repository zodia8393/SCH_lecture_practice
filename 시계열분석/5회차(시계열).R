#2022-03-22 시계열 분석 5회차
getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

set.seed(30)
wn<-tsibble(t=1:50,y=rnorm(50),index=t)
wn %>% autoplot(y)

wm<-tsibble(t=1:100,y=rnorm(100),index=t)
wm %>% ACF(lag_max = 50) %>% autoplot()

wm<-tsibble(t=1:200,y=rnorm(200),index=t)
wm %>% ACF(lag_max = 50) %>% autoplot()

pigs<-aus_livestock %>% 
  filter(State=='Victoria',Animal=='Pigs',
         year(Month)>=2014)

pigs %>% autoplot(Count/1e3)+
  labs(y="Thousands",
       title="Number of pigs slaughtered in Victoria")

pigs %>% ACF(Count) %>% autoplot()

dgoog<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)>=2018) %>% 
  mutate(trading_day=row_number()) %>% 
  update_tsibble(index=trading_day,regular=TRUE) 
dgoog %>% autoplot()
dgoog %>% ACF ()%>% autoplot()


dgoog2<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)>=2018) %>% 
  mutate(trading_day=row_number()) %>% 
  update_tsibble(index=trading_day,regular=TRUE) %>% 
mutate(diff=difference(Close))
dgoog2 %>% autoplot(diff)
dgoog2 %>% ACF(diff)%>% autoplot()
