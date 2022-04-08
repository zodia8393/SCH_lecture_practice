#2022-03-22 시계열 분석 5회차
#실습 정리

getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

set.seed(30)
wn<-tsibble(t=1:50,y=rnorm(50),index=t) #x축을 1부터 50까지로 지정하고 y값은 1~50까지의 정규분포에서 무작위로 지정하고 인덱스를 참으로 지정한값을 시계열데이터로 변환
wn %>% autoplot(y)

wm<-tsibble(t=1:100,y=rnorm(100),index=t) #x,y축의 값만 변경
wm %>% ACF(lag_max = 50) %>% autoplot() #ACF함수 적용시켜서 자기상관계수 구하고 시각화

wm<-tsibble(t=1:200,y=rnorm(200),index=t) #마찬가지로 x,y값만 변경
wm %>% ACF(lag_max = 50) %>% autoplot() #ACF 함수 적용시켜 자기상관계수 구하고 시각화

pigs<-aus_livestock %>% 
  filter(State=='Victoria',Animal=='Pigs', #데이터에서 State값이 Victoria이고 Animal값이 Pigs이고 2014년 이후의 월별데이터를 pigs로 지정
         year(Month)>=2014)

pigs %>% autoplot(Count/1e3)+ #y축 이름과 제목을 지정하고 Count값을 100으로 나눈 데이터를 시각화
  labs(y="Thousands",
       title="Number of pigs slaughtered in Victoria")

pigs %>% ACF(Count) %>% autoplot() #Count의 자기상관계수를 구하고 그 데이터를 시각화

dgoog<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)>=2018) %>%  #Symbol 값이 GOOG이고 일단위데이터가 2018년이후 인값들 중에서 trading_day를 행번호로 변환하고 
  mutate(trading_day=row_number()) %>%          #인덱스를 trading_day로 지정하고 정규성이 있다고 지정한후 시계열데이터를 업데이트함
  update_tsibble(index=trading_day,regular=TRUE) 
dgoog %>% autoplot() #시각화
dgoog %>% ACF ()%>% autoplot() #자기상관계수 시각화


dgoog2<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)>=2018) %>% 
  mutate(trading_day=row_number()) %>% 
  update_tsibble(index=trading_day,regular=TRUE) %>%  #위와 동일과정이지만 diff를 Close의 차이로 변환한 데이터와 자기상관함수를 적용한 데이터를 시각화
mutate(diff=difference(Close))
dgoog2 %>% autoplot(diff)
dgoog2 %>% ACF(diff)%>% autoplot()
