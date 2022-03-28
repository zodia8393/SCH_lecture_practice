#2022-03-02
#소셜네트워크 분석 1회차

setwd('C:/Users/student/Documents/R_WS')
getwd()

#소셜네트워크 분석 내용 정리
install.packages("igraph")
library(igraph)

#igraph로 관계 그래프 시각화하기
g1<-graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6),directed=F) #directed=F 를 사용하면 방향성을 없앨수있다
plot(g1)
