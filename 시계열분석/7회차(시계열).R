#2022-03-29 시계열분석 7회차

us_retail_employment<-us_employment %>% 
  filter(year(Month)>=1990, Title=="Retail Trade") %>% 
  select(-Series_ID)
us_retail_employment

us_retail_employment %>% 
  autoplot(Employed)+
  labs(y="Persons(thousands)",
       title="Total employment in US retail")

us_retail_employment %>% 
  model(stl=STL(Employed))

dcmp<-us_retail_employment %>% 
  model(stl=STL(Employed))
components(dcmp)

us_retail_employment %>% 
  autoplot(Employed,color='gray')+
  autolayer(components(dcmp),trend,color='#D55E00')+
  labs(y="Persons(thousands)",
       title="Total employment in US retail")

components(dcmp) %>% autoplot()
components(dcmp) %>% gg_subseries(season_year)



us_retail_employment %>% 
  autoplot(Employed,color='gray')+
  autolayer(components(dcmp),season_adjust,color='#0072B2')+
  labs(y="Persons(thousands)",
       title="Total employment in US retail")

us_retail_employment %>% 
  model(STL(Employed~season(window=9),robust=TRUE)) %>% 
  components() %>% autoplot()+
  labs(title="STL decomposition: US retail employment")

us_retail_employment %>% 
  model(STL(Employed~season(window="periodic")+trend(window=15),robust=TRUE)) %>% 
  components() %>% autoplot()+
  labs(title="STL decomposition: US retail employment")


us_retail_employment %>% 
  model(STL(Employed~season(window=5),robust=TRUE)) %>% 
  components() %>% autoplot()+
  labs(title="STL decomposition: US retail employment")
