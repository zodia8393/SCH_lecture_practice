#소셜 실습 연습 1

#igraph 기본기능
installed.packages("igraph")
library(igraph)

#관계도 : 서로 연관이 있는 데이터들을 연결해서 표현해주는 그래프
#서로 관련성을 가지는 노드를 정의하고 그래프로 생성

#ex) 
g1<-graph(c(1,2, 2,3, 2,4, 1,4, 5,5, 3,6))
plot(g1)


#igraph 시각화 응용

#주식 네트워크 생성
#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

result<-read.csv("stock.csv")
result$X<-NULL
g<-graph.data.frame(result,directed = FALSE)
print(g)

#주식 네트워크 시각화
plot.igraph(g)
g1<-delete.edges(g,E(g)[weight<0.6]) #상관계수(weight)가 0.6이하인경우 edge 제거하기
plot.igraph(g1,layout=layout.auto,vertex.size=2,vertex.label=NA,edge.arrow=NA,edge.width=1)

#Layout변경하여 시각화:노드 사이즈 변경, 노드 이름표시, 노드라벨 최적화
plot.igraph(g1,layout=layout.auto,vertex.size=4,vertex.label=NA,edge.arrow=NA,edge.width=1) #노드 사이즈 키우기
plot.igraph(g1,layout=layout.auto,vertex.size=4,edge.arrow=NA,edge.width=1) #노드 이름 표시
g1<-delete.edges(g,E(g)[abs(weight)<0.6])
Isolated=which(degree(g1)==0) #연결이 안된 노드만 선택하기
g2<-delete.vertices(g1,Isolated) #연결 안된 노드 제거하기
plot.igraph(g2,layout=layout.auto,vertex.size=4,edge.arrow=NA,edge.width=1)
plot.igraph(g2,layout=layout.auto,vertex.size=4,edge.arrow=NA,edge.width=1,edge.curved=TRUE,vertex.label.dist=2) #링크 곡선으로 변경

#Interactive chart로 그리기 : tkplot(g),결과로는 별도의 팝업 창 생성
tkplot(g2,vertex.size=0,edge.arrow=NA,edge.width=1,edge.curved=TRUE) 

#상사-부하직원 쌍 만들기 : 두개의 벡터를 각 컬럼으로 데이터프레임 생성(emp)
junior<-c('유지영 대표','일지매 부장','김유신 과장','이순신 부장','유관순 과장','신사임당 대리','강감찬 부장','광개토 과장','정몽주 대리')
senior<-c('유지영 대표','유지영 대표','일지매 부장','김유신 과장','김유신 과장','이순신 부장','유관순 과장','강감찬 부장','광개토 과장')
emp<-data.frame(이름=junior,상사이름=senior) #데이터프레임 지정
emp

#데이터프레임으로부터 그래프 객체 생성 (graph,data.frame(emp,directed=T)
g<-graph.data.frame(emp,directed = T) 
print(g)
plot(g,layout=layout.fruchterman.reingold,vertex.size=8,edge.arrow.size=0.5)
plot(g,layout=layout.fruchterman.reingold,vertex.size=8,edge.arrow.size=0.5,vertex.label=NA)


