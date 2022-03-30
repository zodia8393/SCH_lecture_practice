네트워크 구조 분석

2자간 : dyad,Reciprocity
3자간 : Triad,transitivity
Sub Group : component,#of component, component size
네트워크

2자간->3자간->Sub group->네트워크

네트워크 모양의 의미
네트워크 형성 모양의 중요성
  -조밀하고 연결성 높은 네트워크는 그 안에서 흐름성이 좋다
  
  -연결성은 개인 측면에서도 중요하다
  
  -네트워크 전체관점에서 중요 (자원/정보의 흐름을 엿볼수있음)
  
  -네트워크 사이즈와 얼마나 조밀하게 연결되어 있는지로 알수있는것
    -작은 Sub Group들을 합쳐도 큰 그룹을 설명할수없음
    -같은 집단이라도 연결모양에 따라 네트워크 응집성과 네트워크에서 발생하는 현상들이 다르게 나타난다
  
네트워크 특성
  밀도(Density) : 고립되어 있는지,연결되어 있는지를 측정 (실제 연결선수 / 가능한 연결선 수)
  상호 호혜성(Reprocity) : 2자의 관계에서 링크가 서로 주고받는 관계로 구성되면 안정성 가짐
  
#2자간 구조분석 실습  
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
plot(g,edge.arrow.size=0.5)

reciprocity(g)
dyad.census(g)

#$mut 상호 주고 받는 관계
#[1] 8
#
#$asym 한쪽으로만 가는 관계
#[1] 0
#
#$null #edge가 없는 node 쌍
#[1] 28

2*dyad_census(g)$mut/ecount(g)
ecount(g)

3자간 구조분석(Bottom-up 방식 네트워크 분석)

추이성(Transitivity)
  3자의 관계
    -두개의 노드로 만들어지는 관계 : 관계여부로 나온다
    -세개의 노드로 만들어지는 관계 : no ties,one tie,two ties,all three ties
    -Isolation,Couples Only,Structural Holes,Clusters 의 구조 중 서로 연결 가능한 또는 균형잡힌 관계형태로 구성되는것 
    
    #모르겠으면 6회차 네트워크 구조분석 16p 참고
    
  연결성 있다 -> 정보의 중복


Clustering Coefficient
  네트워크를 구성하는 세 노드가 얼마나 삼각형 구조를 형성하고있는지
  네트워크가 조밀하게 연결되어있는지를 나타내는 척도이자 얼마나 안정적인 구조인지를 나타내는 측정치
  
  삼각형이 완성된 연결선 수(삼각형 개수)/ 삼각형을 형성할수있는 연결선 수
    
    
#3자간 구조분석 실습
l<-matrix(c(0,1,1,1,
            1,0,1,0,
            1,1,0,1,
            1,0,1,0),nrow=4)

g1<-graph_from_adjacency_matrix(l,mode="directed")
transitivity(g1)

#주식데이터 응용
result<-read.csv("stock.csv")
result$X<-NULL
g<-graph.data.frame(result,directed = FALSE)

g1<-delete.edges(g,E(g)[abs(weight)<0.6])
Isolated=which(degree(g1)==0) #연결이 안된 노드만 선택하기
g2<-delete.vertices(g1,Isolated) #연결 안된 노드 제거하기

length(V(g2)) #노드 개수 
length(E(g2)) #링크 개수

edge_density(g2) #링크 밀도 구하기
transitivity(g2) #추이성 구하기 (Clustering Coefficient)


Sub-Group 수준의 네트워크 분석
  사회는 Sub-Group의 연합체
  부그룹을 나타내는 것
    -Component (상호 도달 가능한 노드들의 집합) 
    -Clique (직접 연결가능한 노드들의 집합)
    
    @각 노드를 그룹화하여 부그룹으로 보는것 -> 전체 네트워크가 어떻게 행동할지를 가늠해볼수있게하는 역할
    
컴포넌트 사이즈 통계
components(g2)

Clique
  완전연결체,모든노드들이 상호 직접 연결되어있는 Sub Group
  클리크가 모이면 컴포넌트 구성
  
#실습
cliques(g2) #완전체에 포함된 노드수와 완전체 이루는 노드 그룹별 노드리스트 출력
head(cliques(g2))
sort(sapply(cliques(g2),length),decreasing = TRUE) #clique 길이가 큰것 순으로 출력
largest_cliques(g2) #가장 많은 구성원 가진 클리크 추출

    
    












