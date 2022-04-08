#2022-03-17 시계열분석 4회차
getwd()
#setwd("C:/Users/student/Documents") #학교 컴퓨터용 디렉토리

installed.packages("tidyverse") #유용한 기능 패키지
library(tidyverse)

installed.packages("fpp3") #시계열데이터 패키지
library(fpp3)

vic_elec

vic_elec %>% gg_season(Demand) #period가 지정되어있지 않으면 주기는 연단위가 기본값
vic_elec %>% gg_season(Demand,period="week") #주기를 주단위로 
vic_elec %>% gg_season(Demand,period="day") #주기를 일단위로 


holidays<-tourism %>% 
  filter(Purpose=="Holiday") %>% 
  group_by(State) %>% 
  summarise(Trips=sum(Trips))

holidays %>% autoplot(Trips)+
  labs(y='thousands of trips',
       title='Australian domestic holiday nights')

holidays %>% gg_season(Trips)+
  labs(y='thousands of trips',
       title='Australian domestic holiday nights')

holidays %>% gg_subseries(Trips)+
  labs(y='thousands of trips',
       title='Australian domestic holiday nights')

new_production<-aus_production %>% 
  filter(year(Quarter)>=1992)
new_production

new_production %>% gg_lag(Beer) #gg_lag -> 전체 데이터를 n개의 구간만큼 밀고 (n개의 NA값이 들어있는 데이터 생성) 직선그래프그리기

new_production %>% gg_lag(Beer,geom='point') ->gg_lag과 동일하지만 직선그래프가 아닌 산점도를 그린다

#lag의 개수에 따라서 산점도의 모양이 달라진다

#ACF = AutoCorrelation Function 
#ACF 그래프에서의 데이터들의 패턴을 파악하는것이 중요하다 + 파란선안쪽의 데이터의 상관계수는 0이다
#ACF는 데이터를 한칸 밀었을때의 데이터를 계산할때는 원본 데이터와 비교해서 빈칸이 있는곳을 없애고 나머지 값들과의 상관계수를 구한다
#ACF에서 Yt는 현재의 자신이고 왼쪽으로 갈수록 과거의 데이터이다

new_production %>% ACF(Beer,lag_max = 9) 
new_production %>% ACF(Beer,lag_max=9) %>% autoplot() #lag의 최대치를 9로 설정을하고 ACF함수를 적용시킨데이터를 시각화시킴
new_production %>% ACF(Beer) %>% autoplot()

retail<-us_employment %>% 
  filter(Title=="Retail Trade",year(Month)>=1980)
retail %>% autoplot(Employed)

retail %>% ACF(Employed,lag_max = 48) %>% 
  autoplot()

google_2015<-gafa_stock %>% 
  filter(Symbol=="GOOG",year(Date)==2015) %>% 
  select(Date,Close)
google_2015 %>% autoplot(Close)


google_2015<-google_2015 %>%
  mutate(trading_day=row_number()) %>% #기존데이터의 trading_day를 행번호로 바꿈
  update_tsibble(index=trading_day,regular=TRUE)  #인덱스를 trading_day로 지정하고 정규성이있다고 지정하여 tsibble데이터 업데이트
google_2015

google_2015 %>%
  ACF(Close,lag_max=100) %>% #lag의 최대치를 100으로 지정하고 상관계수 값을 구한 데이터를 시각화시킴
  autoplot()











