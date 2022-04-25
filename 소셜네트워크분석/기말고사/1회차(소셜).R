#2022-04-25 소셜네트워크분석 기말고사 1회차
getwd()
setwd('C:/Users/student/Documents/R_WS') #학교 강의실용 디렉터리
#setwd('C:/Users/User/Documents/WS') #집 컴퓨터용 디렉터리

#rvest 패키지 다루기

#패키지 로드
installed.packages("rvest")
library(rvest)


#응답 객체 HTML 변환
#read_html()
html<-read_html(x=res,encoding="EUC-KR")


#HTML 요소 추출
#html_node(),html_nodes()
item<-html_node(x=html,
                css='크롬 개발자도구에서 복사해온 CSS Selector',
                xpath='크롬 개발자 도구에서 복사해온 Xpath')

#데이터 추출 함수
#html_text(),html_table()
text<-html_text(x=item,trim=FALSE)
tbl<-html_table(x=item,fill=FALSE)

#파이프 연산자 사용
text<-res %>% 
  read_html(encoding = 'UTF-8') %>% 
  html_node(css='CSS Selector',xpath='XPath') %>% 
  html_text(trim=TRUE)


#HTML 속성 관련 함수
#html_attr(),html_attrs(),html_name()


#네이버 쇼핑 검색어 추출

#패키지 호출
library(httr)
library(dplyr)
library(readr)

#http 요청
res<-GET(url='https://datalab.naver.com')

#res 객체 출력
print(x=res)

#http 응답 상태코드 확인
status_code(x=res)

#res 객체에 포함된 HTML을 텍스트로 출력
#계층 구조 출력 위한 cat()함수 적용
content(x=res,as='text',encoding='UTF-8') %>% cat()

#HTTP응답 객체에서 HTML을 읽습니다
html<-read_html(x=res)

#HTML에서 CSS로 필요한 요소만 선택
span<-html_nodes(x=html,css='a.list_area')

#실시간 검색어만 출력
searchWords<-html_text(x=span)

#최종결과 출력하여 확인
print(x=searchWords)

#HTML에서 CSS로 필요한 요소만 선택
span<-html_nodes(x=html,css='a.list_area>span.title')
#실시간 검색어만 추출
searchWords<-html_text(x=span)
searchWords

#파이프 연산자 사용하여 정리
searchWords<-res %>% 
  read_html() %>% 
  html_nodes(css='a.list_area>span.title') %>% 
  html_text()

#span.title이 적용된 부분이 검색어 밖에 없으므로 위 아래 코드의 결과는 동일함
searchWords<-res %>% 
  read_html() %>% 
  html_nodes(css='span.title') %>% 
  html_text()


#한글 인코딩
#-한글 인코딩은 한글을 컴퓨터에 표시하는 방식
#-사람들의 문자를 컴퓨터가 이해가능하도록 16진수로 표기한것
#-대표적인 방식은 EUC-KR,UTF-8

#한글 인코딩 관련 R함수
#localeToCharset()
#Encoding(x='문자열')
#iconv(x='문자열',from='UTF-8',to='EUC-KR')
#guess_encoding(file='파일명')

#실습
#인코딩
localeToCharset()
text<-'안녕하세요?'
print(x=text)

Encoding(x=text)

Encoding(x=text)<-'UTF-8'
Encoding(x=text)

print(x=text)

Encoding(x=text)<-'CP949'
Encoding(x=text)

print(x=text)

#inconv
iconv(x=text,from='CP949',to='EUC-KR')
iconv(x=text,from='CP949',to='UTF-8')
iconv(x=text,from='CP949',to='ASCII')

#guess_encodings
readr::guess_encoding(file='https://www.naver.com/')
readr::guess_encoding(file='http://www.isuperpage.co.kr/')






