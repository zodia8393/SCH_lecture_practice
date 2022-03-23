#2022-03-23 소셜네트워크분석 5회차

#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

installed.packages("igraph")
library(igraph)
library(dplyr)
library(RColorBrewer)

L=matrix(c(0,0,0,1,0,0,0,0,0,
           0,0,0,1,0,0,0,0,0,
           0,0,0,1,0,0,0,0,0,
           1,1,1,0,1,0,0,0,0,
           0,0,0,1,0,1,0,0,0,
           0,0,0,0,1,0,1,0,0,
           0,0,0,0,0,1,0,1,0,
           0,0,0,0,0,0,1,0,1,
           0,0,0,0,0,0,0,1,0), byrow=T,nrow=9)

g<-graph_from_adjacency_matrix(L)
plot(g)

plot(g,edge.arrow.size=0.5)

centr_degree(g,mode='all')

#$res
#[1] 2 2 2 8 4 4 4 4 2 각 노드의 in/out degree를 구한것

#$centralization 네트워크 수준의 값을 계산한것으로 네트워크 수준을 다룰때
#[1] 0.3125

#$theoretical_max
#[1] 128

#근접 중심성 계산하기
closeness(g,mode='all')

#중개 중심성
estimate_betweenness(g,vids=V(g),directed = TRUE,cutoff=10,weights=NULL) #cutoff = 사이중앙성 계산시 고려하는 최대 패스 길이
#betweenness(g) 도 사용가능

#Eigenvector Centrality
eigen_centrality(g)
which.max(eigen_centrality(g)$vector)

sort(degree(g1),decreasing = TRUE)
sort(closeness(g1,mode='all'),decreasing = TRUE)
sort(betweenness(g1),decreasing = TRUE)
eigen_centrality(g1)

reciprocity(g)
dyad_census(g)

#$mut 상호 주고 받는 관계
#[1] 8
#
#$asym #한쪽으로만 가는 관계
#[1] 0
#
#$null #edge가 없는 node 쌍
#[1] 28


2*dyad.census(g)$mut/ecount(g)
ecount(g) #그래프의 edge count



