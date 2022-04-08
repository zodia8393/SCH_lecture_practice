#2022-03-15 시계열분석 3회차
#이론 및 실습 정리

시계열 패턴
1.추세(경향)
2.계절 (반복적인 패턴들)
3.순환  (순환에 해당하는 변동들은 대체로 제외시킨다 왜냐하면 통계적인 데이터의 양이 부족하기 때문)
4.불규칙한 성분 (1,2,3번 성분으로 설명이 불가능함,예측도 거의 불가능하다)

@계절변동은 1년단위인 경우가 많지만 순환변동은 장기간인 경우가 많다
1+2+3=>가법모형

getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

aus_production%>%
  filter(year(Quarter)>=1980)%>%
  autoplot(Electricity)+
  labs(y='GWh',title='Australian electricity production')

aus_production%>%
  autoplot(Bricks)+
  labs(y='million units',
       title="Australian clay brick production")

us_employment%>%
  filter(Title=="Retail Trade",year(Month)>=1980) %>% 
  autoplot(Employed/1e3)+
  labs(y='Million people',
       title="Retail employment, USA")

gafa_stock %>% 
  filter(Symbol=="AMZN",year(Date)>=2018) %>% 
  autoplot(Close)+
  labs(y="$US",
       title="Amazon closing stock price")

pelt %>% 
  autoplot(Lynx)+
  labs(y='Number trapped',
       title="Annual Canadian Lynx Trappings")
a10 %>% gg_season(total_cost,labels="both")+ #labels="both"는 주기(연,월,일 등)를 식별할수있는 라벨의 위치를 지정해주는것입니다
  labs(y="$ million",
       title="Seasonal plot : antidiabetic drug sales")

a10 %>% gg_subseries(total_cost)+ 
  labs(y='$million',
       title="Subseries plot : antidiabetic drug sales") #gg_subseries를 실행시켰을때 그래프의 파란선은 평균값을 의미합니다
beer<-aus_production %>% 
  select(Quarter,Beer) %>% 
  filter(year(Quarter)>=1992)

beer %>% autoplot(Beer)

beer %>% gg_season(Beer,labels="right")

beer %>% gg_subseries(Beer)

snowy<-tourism %>% 
  select(Quarter,Region,Trips) %>% 
  filter(Region=="Snowy Mountains")

snowy %>% autoplot(Trips)
snowy %>% gg_season(Trips)
snowy %>% gg_subseries(Trips)

t1<-tourism
