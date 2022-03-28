#4회차 실습 (소셜)
#setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리
installed.packages("igraph")
library(igraph)
library(RColorBrewer)
library(stringr)

result<-read.csv("stock.csv")
result$X<-NULL
g<-graph.data.frame(result,directed = FALSE)

g1<-delete.edges(g,E(g)[abs(weight)<0.6])
Isolated=which(degree(g1)==0) #연결이 안된 노드만 선택하기
g2<-delete.vertices(g1,Isolated) #연결 안된 노드 제거하기


#1 주식 그룹별 시각화

#주식별로 그루핑 되어있는 데이터 읽어오기
stock_code<-read.csv("stock_code.csv",encoding = "UTF-8")
colnames(stock_code)[1]<-'group' 

#Rownames: 행의 이름을 가져오거나 행의 이름을 설정할 때 사용함
rownames(stock_code)<-stock_code$stock #행 이름을 stock_code의 stock열값으로 지정

#색 저장 벡터 생성
color<-factor(stock_code[V(g2)$name,]$group)
plot.igraph(g2,layout=layout.auto,vertex.size=6,edge.width=1,edge.curved=TRUE,vertex.color=color,vertex.label=NA)

#label까지 표시하기
plot.igraph(g2,layout=layout.auto,vertex.size=10,edge.width=1,edge.curved=TRUE,vertex.color=color,vertex.label.size=8)

#색 추가하여 가독성 높이기
jColors<-brewer.pal(nlevels(color),name='Spectral')
V(g2)$type<-stock_code[V(g2)$name,]$group

#컬러별 그룹명 매칭
names(jColors)<-unique(stock_code$group)
jcolors<-jColors[V(g2)$type]
jcolors
plot.igraph(g2,layout=layout.fruchterman.reingold,vertex.size=10,edge.arrow=NA,edge.width=1,edge.curved=TRUE,vertex.label.size=8,vertex.color=jcolors)

#2 노드 특성에 따라 그래프 표현

#작업폴더 지정
setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

#데이터 읽어오기
g<-read.csv("군집분석.csv",encoding = "UTF-8")

#그래프로 데이터 구조 변경
g<-graph.data.frame(g,directed=T)

#시각화
plot(g)
plot(g,layout=layout.fruchterman.reingold,vertex.size=2,edge.arrow.size=0.5,vertex.color='green',vertex.label=NA)
plot(g,layout=layout.kamada.kawai,vertex.size=2,edge.arrow.size=0.5,vertex.label=NA)

#노드이름 출력
gubun1<-V(g)$name
gubun<-str_sub(gubun1,start=1,end=1)
print(gubun)

#조건식 설정
colors<-ifelse(gubun=='S','red','green')
sizes<-ifelse(gubun=="S",2,6)
print(sizes)
plot(g,layout=layout.fruchterman.reingold,vertex.size=sizes,edge.arrow.size=0.5,vertex.color=colors)
plot(g,layout=layout.fruchterman.reingold,vertex.size=sizes,edge.arrow.size=0.5,vertex.color=colors,vertex.label=NA)
