#2022-03-10 시계열분석 2회차
#이론 및 실습 정리

데이터 분석 절차
문제정의->정보수집->예비분석->모델선택 및 적용 -> 예측모델활용 및 평가

tsibble 데이터 
=> 시간정보가 포함된 INDEX와 측정값인 Measured variables ,각각의 데이터를 식별해주는 key로 구성되어있는 시계열 데이터

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

#tsibble데이터에서 많이 사용하는 주기
Annual (1년 단위) ->start:end
Quarterly (분기단위) ->yearquarter()
Monthly (월 단위) ->yearmonth()
Weekly (주 단위) ->yearweek()
Daily (일 단위) ->as_date(),ymd()
Sub-daily (시간 단위) ->as_datetime() 
#거의 대부분 Sub-daily 를 제외한 나머지 주기를 사용한다

z%>%
  mutate(Month=yearmonth(Month))%>%
  as_tsibble(index=Month)
  
prison<-readr::read_csv("https://OTexts.com/fpp3/extrafiles/prison_population.csv")
    %>%mutate(Quarter=yearquarter(Date))
    %>%select(-Date)
    %>%as_tsibble(index=Quarter,
                  key=c(state,gender,legal,indigenous)) 
#데이터를 읽어오고 주기를 Date에서 분기단위로 변경, Date열 제외하고 모든 열 선택 -> 인덱스와 키를 지정하고 tsibble 데이터로 변경 

PBS

PBS%>%
  filter(ATC2=="A10")%>%
  select(Month,Concession,Type,Cost)%>%
  summarise(total_cost=sum(Cost))%>%
  mutate(total_cost=total_cost/1e6)->a10
#ATC가 A10인 데이터를 필터링하고 Month , Concession, Type, Cost 열을 선택하고 
 #total_cost를 Cost의 합으로 지정하고 그 값을 1e6으로 나눈값을 total_cost로 재지정한값을 a10으로 지정

autoplot(a10, total_cost)+
  labs(y="$(millions)",
       title="Australian antidiabetic drug sales")
#a10과 total_cost를 y축이름과 타이틀을 지정해서 시각화시킴
